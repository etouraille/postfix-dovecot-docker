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


RUN apt install -y php8.1-fpm \
    php8.1-imap \
    php8.1-mbstring \
    php8.1-mysql \
    php8.1-curl \
    php8.1-zip \
    php8.1-xml \
    php8.1-bz2 \
    php8.1-intl \
    php8.1-gmp \
    php8.1-redis


# INSTALLATION OF POSTFIX-ADMIN
RUN apt update && apt install -y wget acl nginx && apt-get clean
RUN wget https://github.com/postfixadmin/postfixadmin/archive/postfixadmin-3.3.11.tar.gz
RUN mkdir -p /var/www/
RUN tar xvf postfixadmin-3.3.11.tar.gz -C /var/www/
RUN mv /var/www/postfixadmin-postfixadmin-3.3.11 /var/www/postfixadmin
RUN mkdir -p /var/www/postfixadmin/templates_c
RUN setfacl -R -m u:www-data:rwx /var/www/postfixadmin/templates_c/
RUN mkdir -p /etc/letsencrypt/live
RUN mkdir -p /etc/letsencrypt/archive/
RUN setfacl -R -m u:www-data:rx /etc/letsencrypt/live/ /etc/letsencrypt/archive/
COPY postfixadmin/config.local.php /config.local.php
COPY postfixadmin/generate-conf.sh /generate-conf-postfixadmin.sh
COPY postfixadmin/postfixadmin.conf postfixadmin.conf

ARG db_user
ARG db_password
ARG db_port
ARG db_host
ARG db_name


ENV db_user $db_user
ENV db_password $db_password
ENV db_port $db_port
ENV db_host $db_host
ENV db_name $db_name

RUN mkdir /etc/postfix/sql/
COPY postfixadmin/mysql_virtual_alias_domain_catchall_maps.cf /mysql_virtual_alias_domain_catchall_maps.cf
COPY postfixadmin/mysql_virtual_alias_domain_mailbox_maps.cf /mysql_virtual_alias_domain_mailbox_maps.cf
COPY postfixadmin/mysql_virtual_alias_maps.cf /mysql_virtual_alias_maps.cf
COPY postfixadmin/mysql_virtual_domains_maps.cf /mysql_virtual_domains_maps.cf
COPY postfixadmin/mysql_virtual_mailbox_maps.cf /mysql_virtual_mailbox_maps.cf
COPY postfixadmin/mysql_virtual_alias_domain_maps.cf /mysql_virtual_alias_domain_maps.cf
COPY 10-auth.conf /10-auth.conf
COPY postfixadmin/dovecot-sql.conf.ext /dovecot-sql.conf.ext
RUN chmod +x /generate-conf-postfixadmin.sh
RUN /generate-conf-postfixadmin.sh

RUN chmod 0640 /etc/postfix/sql/*
RUN setfacl -R -m u:postfix:rx /etc/postfix/sql/

RUN adduser vmail --system --group --uid 2000 --disabled-login --no-create-home
RUN mkdir /var/vmail/
RUN chown vmail:vmail /var/vmail/ -R

RUN apt update && apt install postfix-mysql dovecot-mysql && apt-get clean

#PHP

RUN gpasswd -a www-data dovecot
#RUN setfacl -R -m u:www-data:rwx /var/run/dovecot/stats-reader /var/run/dovecot/stats-writer

COPY entrypoint.sh /entrypoint.sh

COPY create.sh /create.sh

RUN chmod +x /create.sh

RUN chmod +x /entrypoint.sh


ENTRYPOINT ["/entrypoint.sh"]