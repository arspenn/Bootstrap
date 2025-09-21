#!/bin/sh
set -euo pipefail

# Script: create-requirements.sh
# Purpose: Create a numbered requirements document
# Usage: ./.claude/scripts/create-requirements.sh [feature_name]
# Note: Called by AI agent during /determine command

FEATURE_NAME="${1:-feature}"
REQ_DIR=".sdlc/requirements"
TEMPLATE_DIR=".claude/templates"
TEMPLATE_FILE="${TEMPLATE_DIR}/requirements.template.md"
DATE=$(date +%Y-%m-%d)

# Ensure requirements directory exists
mkdir -p "$REQ_DIR"

# Check if template exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Template file not found: $TEMPLATE_FILE"
    echo "Please ensure Bootstrap templates are installed"
    exit 1
fi

# Find next number (with zero padding)
NEXT_NUM=1
for file in "$REQ_DIR"/*.md; do
    if [ -f "$file" ]; then
        basename_file=$(basename "$file" .md)
        num=${basename_file%%-*}
        if [ "$num" -eq "$num" ] 2>/dev/null; then
            if [ "$num" -ge "$NEXT_NUM" ]; then
                NEXT_NUM=$((num + 1))
            fi
        fi
    fi
done

# Format with zero padding
PADDED_NUM=$(printf "%03d" "$NEXT_NUM")
KEBAB_NAME=$(echo "$FEATURE_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
REQ_FILE="${REQ_DIR}/${PADDED_NUM}-${KEBAB_NAME}.md"

# Copy template to requirements file
cp "$TEMPLATE_FILE" "$REQ_FILE"

# Replace placeholders using square bracket syntax
sed -i.bak \
    -e "s/\[FEATURE_NAME\]/$FEATURE_NAME/g" \
    -e "s/\[DOCUMENT_ID\]/REQ-$PADDED_NUM/g" \
    -e "s/\[NUMBER\]/$PADDED_NUM/g" \
    -e "s/\[CREATED_DATE\]/$DATE/g" \
    -e "s/\[DATE\]/$DATE/g" \
    "$REQ_FILE"
rm -f "${REQ_FILE}.bak"

echo "✓ Created requirements document: $REQ_FILE"
echo "  ID: REQ-$PADDED_NUM"
echo "  Feature: $FEATURE_NAME"