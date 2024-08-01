#MX RECORDS ON DNS :
#300 @ IN MX 10 mail.developpeur-web-france.fr
#mail 300 IN A 141.94.173.211

#AJOUTER LE PTR ( Reverse ),
#dans OVH, aller sur bar metal, puis network, IP
FROM ubuntu:22.04

ARG domain
ARG subdomain

ENV domain $domain
ENV subdomain $subdomain

WORKDIR '/'


#SPF FOR INCOMMING EMAILS AND DKIM

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt-get install -y systemd

RUN echo "postfix postfix/main_mailer_type select no_configuration" | debconf-set-selections

RUN apt-get install -y postfix mailutils
RUN uname -n > /etc/mailname

RUN apt-get update && \
    apt-get install -y \
    postfix-policyd-spf-python \
    opendkim opendkim-tools \
    && apt-get clean

RUN gpasswd -a postfix opendkim

COPY opendekim.conf /etc/opendekim.conf

RUN mkdir -p /etc/opendkim/keys
RUN chown -R opendkim:opendkim /etc/opendkim
RUN chmod go-rw /etc/opendkim/keys
COPY signing.table /signing.table
COPY key.table /key.table
COPY trusted.hosts /trusted.hosts
COPY opendkim.sh /opendkim.sh
COPY generate-conf-opendkim.sh /generate-conf-opendkim.sh
RUN chmod +x /generate-conf-opendkim.sh
RUN chmod +x /opendkim.sh
COPY opendkim /etc/default/opendkim

RUN mkdir -p /var/spool/postfix/opendkim
RUN chown opendkim:postfix /var/spool/postfix/opendkim
RUN ./generate-conf-opendkim.sh
RUN ./opendkim.sh


# changer le fichier postfix-preseed.txt
RUN apt-get update && \
    apt-get install -y \
    syslog-ng-core \
    syslog-ng \
    dovecot-core \
    dovecot-imapd \
    dovecot-lmtpd \
    systemd \
    systemd-sysv \
    vim \
    && apt-get clean \

RUN adduser dovecot mail

COPY postfix /etc/postfix/

COPY dovecot /etc/dovecot/

COPY generate-conf.sh /generate-conf.sh

RUN chmod +x /generate-conf.sh

COPY main.cf /main.cf

COPY 10-ssl.conf /10-ssl.conf

COPY aliases /etc/aliases

RUN chown root:root /etc/aliases

RUN ./generate-conf.sh

RUN newaliases

COPY openssl.cnf /etc/ssl/openssl.cnf

COPY entrypoint.sh /entrypoint.sh

COPY create.sh /create.sh

RUN chmod +x /create.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]