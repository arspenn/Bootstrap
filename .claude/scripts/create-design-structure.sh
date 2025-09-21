#!/bin/sh
set -euo pipefail

# Script: create-design-structure.sh
# Purpose: Create a design folder structure with templates
# Usage: ./.claude/scripts/create-design-structure.sh [type] [name]
# Note: Called by AI agent during /design command

DESIGN_TYPE="${1:-feature}"
DESIGN_NAME="${2:-unnamed}"
DESIGN_DIR=".sdlc/designs"
TEMPLATE_DIR=".claude/templates"
DATE=$(date +%Y-%m-%d)

# Ensure designs directory exists
mkdir -p "$DESIGN_DIR"

# Find next number
NEXT_NUM=1
for dir in "$DESIGN_DIR"/*; do
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
KEBAB_NAME=$(echo "$DESIGN_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
DESIGN_PATH="${DESIGN_DIR}/${PADDED_NUM}-${DESIGN_TYPE}-${KEBAB_NAME}"

# Create design structure
mkdir -p "${DESIGN_PATH}"
mkdir -p "${DESIGN_PATH}/adrs"
mkdir -p "${DESIGN_PATH}/diagrams"
mkdir -p "${DESIGN_PATH}/phases"

# Copy design template if it exists
DESIGN_TEMPLATE="${TEMPLATE_DIR}/design.template.md"
if [ -f "$DESIGN_TEMPLATE" ]; then
    cp "$DESIGN_TEMPLATE" "${DESIGN_PATH}/design.md"

    # Replace placeholders using square brackets
    sed -i.bak \
        -e "s/\[DESIGN_NAME\]/$DESIGN_NAME/g" \
        -e "s/\[DOCUMENT_ID\]/DESIGN-$PADDED_NUM/g" \
        -e "s/\[DESIGN_ID\]/$PADDED_NUM/g" \
        -e "s/\[DESIGN_TYPE\]/$DESIGN_TYPE/g" \
        -e "s/\[CREATED_DATE\]/$DATE/g" \
        -e "s/\[DATE\]/$DATE/g" \
        "${DESIGN_PATH}/design.md"
    rm -f "${DESIGN_PATH}/design.md.bak"
    echo "✓ Created design.md from template"
else
    echo "⚠ Design template not found, creating empty design.md"
    echo "# Design: $DESIGN_NAME" > "${DESIGN_PATH}/design.md"
fi

echo "✓ Created design structure: $DESIGN_PATH"
echo "  ├── design.md"
echo "  ├── adrs/"
echo "  ├── diagrams/"
echo "  └── phases/"