#!/bin/bash
TEMPLATE_FILE="/signing.table"
OUTPUT_FILE="/etc/opendkim/signing.table"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ domain }}/${domain}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/key.table"
OUTPUT_FILE="/etc/opendkim/key.table"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ domain }}/${domain}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

TEMPLATE_FILE="/trusted.hosts"
OUTPUT_FILE="/etc/opendkim/trusted.hosts"

# Use sed to replace placeholders with environment variables
sed -e "s/{{ domain }}/${domain}/g" \
    "$TEMPLATE_FILE" > "$OUTPUT_FILE"

