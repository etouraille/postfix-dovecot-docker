#!/bin/bash


TEMPLATE_FILE="/main.cf"
OUTPUT_FILE="/etc/postfix/main.cf"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ domain }}/${domain}/g" \
    -e "s/{{ subdomain }}/${subdomain}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/10-ssl.conf"
OUTPUT_FILE="/etc/dovecot/conf.d/10-ssl.conf"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ domain }}/${domain}/g" \
    -e "s/{{ subdomain }}/${subdomain}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"


