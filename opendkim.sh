#!/bin/bash
mkdir -p "/etc/opendkim/keys/${domain}"
opendkim-genkey -b 2048 -d "${domain}" -D "/etc/opendkim/keys/${domain}" -s default -v
chown opendkim:opendkim "/etc/opendkim/keys/${domain}/default.private"
chmod 600 "/etc/opendkim/keys/${domain}/default.private"