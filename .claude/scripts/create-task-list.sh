#!/bin/sh
set -euo pipefail

# Script: create-task-list.sh
# Purpose: Create or recreate TASK.md file
# Usage: ./.claude/scripts/create-task-list.sh [mode]
#   mode: create (only if doesn't exist) or recreate (force new)
# Note: Called by AI agent during /define command

MODE="${1:-create}"
TASK_FILE="TASK.md"
TEMPLATE_DIR=".claude/templates"
TASK_TEMPLATE="${TEMPLATE_DIR}/task.template.md"
DATE=$(date +%Y-%m-%d)

# Check mode
if [ "$MODE" = "create" ] && [ -f "$TASK_FILE" ]; then
    echo "• TASK.md already exists (use 'recreate' to force new)"
    exit 0
fi

if [ "$MODE" = "recreate" ] && [ -f "$TASK_FILE" ]; then
    # Archive old TASK.md
    ARCHIVE_DIR=".sdlc/archive"
    mkdir -p "$ARCHIVE_DIR"
    TIMESTAMP=$(date +%Y%m%d-%H%M%S)
    mv "$TASK_FILE" "${ARCHIVE_DIR}/TASK-${TIMESTAMP}.md"
    echo "• Archived existing TASK.md to ${ARCHIVE_DIR}/TASK-${TIMESTAMP}.md"
fi

# Create new TASK.md
if [ -f "$TASK_TEMPLATE" ]; then
    cp "$TASK_TEMPLATE" "$TASK_FILE"
    sed -i.bak \
        -e "s/\[DATE\]/$DATE/g" \
        -e "s/\[CREATED_DATE\]/$DATE/g" \
        "$TASK_FILE"
    rm -f "${TASK_FILE}.bak"
    echo "✓ Created TASK.md from template"
else
    # Fallback to basic structure
    cat > "$TASK_FILE" << 'EOF'
# Project Tasks

## Active Implementation

## Completed

## Discovered Tasks

---
_Task tracking for Bootstrap project_
EOF
    echo "✓ Created TASK.md with basic structure"
fi