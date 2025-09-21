#!/bin/sh
set -euo pipefail

# Script: add-tasks.sh
# Purpose: Add multiple tasks to TASK.md from arguments
# Usage: ./.claude/scripts/add-tasks.sh "task 1" "task 2" "task 3" ...
# Note: Called by AI agent to add multiple tasks at once

TASK_FILE="TASK.md"

# Check if TASK.md exists
if [ ! -f "$TASK_FILE" ]; then
    echo "Error: TASK.md not found. Run create-task-list.sh first"
    exit 1
fi

# Check if any tasks provided
if [ $# -eq 0 ]; then
    echo "Error: No tasks provided"
    echo "Usage: $0 \"task 1\" \"task 2\" \"task 3\" ..."
    exit 1
fi

# Create temporary file with all new tasks
TEMP_FILE=$(mktemp)
for task in "$@"; do
    echo "- [ ] $task" >> "$TEMP_FILE"
done

# Find the main tasks section and insert all tasks at once
# Look for either "# Implementation Tasks" or "## Discovered Tasks"
awk -v tempfile="$TEMP_FILE" '
/^# Implementation Tasks/ || /^## Active/ {
    print
    getline
    if ($0 ~ /^$/) print
    while ((getline line < tempfile) > 0) {
        print line
    }
    close(tempfile)
    next
}
{print}
' "$TASK_FILE" > "${TASK_FILE}.tmp" && mv "${TASK_FILE}.tmp" "$TASK_FILE"

# Clean up
rm -f "$TEMP_FILE"

# Report results
echo "✓ Added $# tasks to TASK.md:"
for task in "$@"; do
    echo "  - [ ] $task"
done