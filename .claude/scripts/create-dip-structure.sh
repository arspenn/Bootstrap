#!/bin/sh
set -euo pipefail

# Script: create-dip-structure.sh
# Purpose: Create implementation folder for DIPs
# Usage: ./.claude/scripts/create-dip-structure.sh [feature_name]
# Note: Called by AI agent during /define command

FEATURE_NAME="${1:-feature}"
IMPL_DIR=".sdlc/implementation"
TEMPLATE_DIR=".claude/templates"
DIP_TEMPLATE="${TEMPLATE_DIR}/dip.template.md"
DATE=$(date +%Y-%m-%d)

# Ensure implementation directory exists
mkdir -p "$IMPL_DIR"

# Check if template exists
if [ ! -f "$DIP_TEMPLATE" ]; then
    echo "Error: DIP template not found: $DIP_TEMPLATE"
    echo "Please ensure Bootstrap templates are installed"
    exit 1
fi

# Find next number
NEXT_NUM=1
for dir in "$IMPL_DIR"/*; do
    if [ -d "$dir" ]; then
        basename_dir=$(basename "$dir")
        num=${basename_dir%%-*}
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
IMPL_PATH="${IMPL_DIR}/${PADDED_NUM}-${KEBAB_NAME}"

# Create implementation structure
mkdir -p "${IMPL_PATH}"

# Copy DIP template
cp "$DIP_TEMPLATE" "${IMPL_PATH}/dip.md"

# Replace placeholders using square bracket syntax
sed -i.bak \
    -e "s/\[FEATURE_NAME\]/$FEATURE_NAME/g" \
    -e "s/\[DIP_ID\]/DIP-$PADDED_NUM/g" \
    -e "s/\[NUMBER\]/$PADDED_NUM/g" \
    -e "s/\[CREATED_DATE\]/$DATE/g" \
    -e "s/\[DATE\]/$DATE/g" \
    "${IMPL_PATH}/dip.md"
rm -f "${IMPL_PATH}/dip.md.bak"

echo "✓ Created implementation structure: $IMPL_PATH"
echo "  ID: DIP-$PADDED_NUM"
echo "  Feature: $FEATURE_NAME"