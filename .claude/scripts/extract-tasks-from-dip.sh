#!/bin/sh
set -euo pipefail

# Script: extract-tasks-from-dip.sh
# Purpose: Extract task names from DIP and create simple TASK.md checklist
# Usage: ./.claude/scripts/extract-tasks-from-dip.sh [dip_file]
# Note: Extracts "### Task N: [NAME]" headers from DIP

DIP_FILE="${1:-}"
TASK_FILE="TASK.md"

# Check arguments
if [ -z "$DIP_FILE" ]; then
    echo "Error: DIP file path required"
    echo "Usage: $0 path/to/dip.md"
    exit 1
fi

if [ ! -f "$DIP_FILE" ]; then
    echo "Error: DIP file not found: $DIP_FILE"
    exit 1
fi

# Get DIP name for the header
DIP_NAME=$(basename "$(dirname "$DIP_FILE")")
DATE=$(date +%Y-%m-%d)

# Create simple TASK.md structure
cat > "$TASK_FILE" << EOF
# Implementation Tasks

_Generated from: $DIP_NAME on ${DATE}_

EOF

# Extract task names from "### Task N: " headers in the DIP
# and add them as simple checkboxes
grep "^### Task [0-9]:" "$DIP_FILE" | while read -r line; do
    # Remove the "### Task N: " prefix to get just the task name
    task_name=$(echo "$line" | sed 's/^### Task [0-9]*: //')
    # Add as checkbox (remove any [PLACEHOLDERS] for cleaner output)
    clean_name=$(echo "$task_name" | sed 's/\[.*\]//g' | tr -s ' ')
    if [ -n "$clean_name" ]; then
        echo "- [ ] $clean_name" >> "$TASK_FILE"
    fi
done

# Add discovered tasks section at bottom
cat >> "$TASK_FILE" << 'EOF'

## Discovered Tasks

_Add any new tasks found during implementation_

EOF

# Count tasks added
TASK_COUNT=$(grep -c "^- \[ \]" "$TASK_FILE" || echo "0")

echo "✓ Created TASK.md with $TASK_COUNT tasks from $DIP_NAME"