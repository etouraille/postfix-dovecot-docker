#!/bin/bash
mkdir -p "/etc/letsencrypt/live/${subdomain}.${domain}"

adduser dovecot mail


chown -R root:root /etc/postfix
chown -R root:root /etc/dovecot


chown root:root "/etc/letsencrypt/live/${domain}/fullchain.pem" "/etc/letsencrypt/live/${domain}/privkey.pem"
chmod 600 "/etc/letsencrypt/live/${domain}/privkey.pem"

service syslog-ng start
service postfix start
service dovecot start
service opendkim start
service journalctl start

tail -f /var/log/mail.log