#!/bin/sh
set -euo pipefail

# Script: create-amendment.sh
# Purpose: Create a charter amendment document
# Usage: ./.claude/scripts/create-amendment.sh [amendment_title]
# Note: Called by AI agent when charter needs modification

AMENDMENT_TITLE="${1:-Amendment}"
AMENDMENTS_DIR=".sdlc/amendments"
TEMPLATE_DIR=".claude/templates"
TEMPLATE_FILE="${TEMPLATE_DIR}/amendment.template.md"
DATE=$(date +%Y-%m-%d)

# Ensure amendments directory exists
mkdir -p "$AMENDMENTS_DIR"

# Check if template exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Amendment template not found: $TEMPLATE_FILE"
    echo "Please ensure Bootstrap templates are installed"
    exit 1
fi

# Find next amendment number
NEXT_NUM=1
for file in "$AMENDMENTS_DIR"/amendment-*.md; do
    if [ -f "$file" ]; then
        basename_file=$(basename "$file" .md)
        num=${basename_file#amendment-}
        if [ "$num" -eq "$num" ] 2>/dev/null; then
            if [ "$num" -ge "$NEXT_NUM" ]; then
                NEXT_NUM=$((num + 1))
            fi
        fi
    fi
done

# Format with zero padding
PADDED_NUM=$(printf "%03d" "$NEXT_NUM")
KEBAB_TITLE=$(echo "$AMENDMENT_TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
AMENDMENT_FILE="${AMENDMENTS_DIR}/amendment-${PADDED_NUM}-${KEBAB_TITLE}.md"

# Copy template
cp "$TEMPLATE_FILE" "$AMENDMENT_FILE"

# Replace placeholders using square bracket syntax
sed -i.bak \
    -e "s/\[AMENDMENT_NUMBER\]/$PADDED_NUM/g" \
    -e "s/\[AMENDMENT_TITLE\]/$AMENDMENT_TITLE/g" \
    -e "s/\[DATE\]/$DATE/g" \
    -e "s/\[CREATED_DATE\]/$DATE/g" \
    -e "s/\[PROPOSED_DATE\]/$DATE/g" \
    "$AMENDMENT_FILE"
rm -f "${AMENDMENT_FILE}.bak"

echo "✓ Created amendment: $AMENDMENT_FILE"
echo "  Number: $PADDED_NUM"
echo "  Title: $AMENDMENT_TITLE"
echo ""
echo "Next steps:"
echo "  1. Fill in the amendment details"
echo "  2. Update status when ratified"
echo "  3. Apply changes to CHARTER.md"