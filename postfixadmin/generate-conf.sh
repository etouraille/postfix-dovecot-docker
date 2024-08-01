#!/bin/bash

TEMPLATE_FILE="/config.local.php"
OUTPUT_FILE="/var/www/postfixadmin/config.local.php"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ db_name }}/${db_name}/g" \
    -e "s/{{ db_host }}/${db_host}/g" \
    -e "s/{{ db_port }}/${db_port}/g" \
    -e "s/{{ db_password }}/${db_password}/g" \
    -e "s/{{ db_user }}/${db_user}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/postfixadmin.conf"
OUTPUT_FILE="/etc/nginx/conf.d/postfixadmin.conf"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ domain }}/${domain}/g" \
    -e "s/{{ subdomain }}/${subdomain}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/mysql_virtual_alias_domain_catchall_maps.cf"
OUTPUT_FILE="/etc/postfix/sql/mysql_virtual_alias_domain_catchall_maps.cf"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ db_name }}/${db_name}/g" \
    -e "s/{{ db_host }}/${db_host}/g" \
    -e "s/{{ db_password }}/${db_password}/g" \
    -e "s/{{ db_user }}/${db_user}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/mysql_virtual_alias_domain_mailbox_maps.cf"
OUTPUT_FILE="/etc/postfix/sql/mysql_virtual_alias_domain_mailbox_maps.cf"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ db_name }}/${db_name}/g" \
    -e "s/{{ db_host }}/${db_host}/g" \
    -e "s/{{ db_password }}/${db_password}/g" \
    -e "s/{{ db_user }}/${db_user}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/mysql_virtual_alias_maps.cf"
OUTPUT_FILE="/etc/postfix/sql/mysql_virtual_alias_maps.cf"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ db_name }}/${db_name}/g" \
    -e "s/{{ db_host }}/${db_host}/g" \
    -e "s/{{ db_password }}/${db_password}/g" \
    -e "s/{{ db_user }}/${db_user}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/mysql_virtual_domains_maps.cf"
OUTPUT_FILE="/etc/postfix/sql/mysql_virtual_domains_maps.cf"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ db_name }}/${db_name}/g" \
    -e "s/{{ db_host }}/${db_host}/g" \
    -e "s/{{ db_password }}/${db_password}/g" \
    -e "s/{{ db_user }}/${db_user}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/mysql_virtual_mailbox_maps.cf"
OUTPUT_FILE="/etc/postfix/sql/mysql_virtual_mailbox_maps.cf"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ db_name }}/${db_name}/g" \
    -e "s/{{ db_host }}/${db_host}/g" \
    -e "s/{{ db_password }}/${db_password}/g" \
    -e "s/{{ db_user }}/${db_user}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/mysql_virtual_alias_domain_maps.cf"
OUTPUT_FILE="/etc/postfix/sql/mysql_virtual_alias_domain_maps.cf"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ db_name }}/${db_name}/g" \
    -e "s/{{ db_host }}/${db_host}/g" \
    -e "s/{{ db_password }}/${db_password}/g" \
    -e "s/{{ db_user }}/${db_user}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/10-auth.conf"
OUTPUT_FILE="/etc/dovecot/conf.d/10-auth.conf"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ domain }}/${domain}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/dovecot-sql.conf.ext"
OUTPUT_FILE="/etc/dovecot/dovecot-sql.conf.ext"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ db_name }}/${db_name}/g" \
    -e "s/{{ db_host }}/${db_host}/g" \
    -e "s/{{ db_password }}/${db_password}/g" \
    -e "s/{{ db_user }}/${db_user}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"