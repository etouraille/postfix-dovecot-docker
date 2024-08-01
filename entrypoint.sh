#!/bin/bash
mkdir -p "/etc/letsencrypt/live/${subdomain}.${domain}"

adduser dovecot mail


chown -R root:root /etc/postfix
chown -R root:root /etc/dovecot
chmod 700 /etc/postfix/dynamicmaps.cf

chown root:root "/etc/letsencrypt/live/${domain}/fullchain.pem" "/etc/letsencrypt/live/${domain}/privkey.pem"
chmod 600 "/etc/letsencrypt/live/${domain}/privkey.pem"

service php8.1-fpm start
service syslog-ng start
service postfix start
service dovecot start
service opendkim start
service nginx start
service journalctl start

tail -f /var/log/mail.log