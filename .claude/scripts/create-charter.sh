#!/bin/sh
set -euo pipefail

# Script: create-charter.sh
# Purpose: Create a CHARTER.md template based on mode
# Usage: ./.claude/scripts/create-charter.sh [mode] [project_name]
# Note: Called by AI agent during /init command

MODE="${1:-prototype}"
PROJECT_NAME="${2:-Unnamed Project}"
CHARTER_FILE="CHARTER.md"
TEMPLATE_DIR=".claude/templates"
DATE=$(date +%Y-%m-%d)

# Check if charter already exists
if [ -f "$CHARTER_FILE" ]; then
    echo "⚠ CHARTER.md already exists"
    echo "Move existing charter to .sdlc/amendments/archive/ if you want to create a new one"
    exit 0
fi

# Determine template file based on mode
case "$MODE" in
    prototype)
        TEMPLATE_FILE="${TEMPLATE_DIR}/charter-prototype.template.md"
        ;;
    draft)
        TEMPLATE_FILE="${TEMPLATE_DIR}/charter-draft.template.md"
        ;;
    ratified)
        TEMPLATE_FILE="${TEMPLATE_DIR}/charter-ratified.template.md"
        ;;
    *)
        echo "Error: Unknown mode '$MODE'. Use: prototype, draft, or ratified"
        exit 1
        ;;
esac

# Check if template exists
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Template file not found: $TEMPLATE_FILE"
    echo "Please ensure Bootstrap templates are installed in .claude/templates/"
    exit 1
fi

# Copy template to charter file
cp "$TEMPLATE_FILE" "$CHARTER_FILE"

# Replace placeholders using square bracket syntax
sed -i.bak \
    -e "s/\[DATE\]/$DATE/g" \
    -e "s/\[PROJECT_NAME\]/$PROJECT_NAME/g" \
    -e "s/\[CREATED_DATE\]/$DATE/g" \
    -e "s/\[MODIFIED_DATE\]/$DATE/g" \
    -e "s/\[RATIFIED_DATE\]/$DATE/g" \
    "$CHARTER_FILE"
rm -f "${CHARTER_FILE}.bak"

echo "✓ Created CHARTER.md in $MODE mode for '$PROJECT_NAME'"
echo "  Location: $CHARTER_FILE"
echo "  Template: $(basename $TEMPLATE_FILE)"