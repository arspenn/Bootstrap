#!/bin/sh
set -euo pipefail

# Script: bootstrap-export.sh
# Purpose: Export minimal Bootstrap framework for distribution
# Usage: ./.claude/scripts/bootstrap-export.sh [output_dir]
# Note: Creates a minimal bootstrap package for new projects

OUTPUT_DIR="${1:-bootstrap-framework}"
DATE=$(date +%Y-%m-%d)
VERSION=$(grep "version:" .claude/config.yaml 2>/dev/null | cut -d: -f2 | tr -d ' ' || echo "unknown")

echo "Exporting Bootstrap framework v$VERSION..."

# Create output directory
if [ -d "$OUTPUT_DIR" ]; then
    echo "Error: Output directory already exists: $OUTPUT_DIR"
    echo "Remove it first or specify a different directory"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

# Essential framework files (minimum needed to bootstrap)
ESSENTIAL_FILES="
CLAUDE.md
.claude/MASTER_IMPORTS.md
.claude/config.yaml
"

# Essential directories to copy (including ALL rules)
ESSENTIAL_DIRS="
.claude/templates
.claude/scripts
.claude/commands
.claude/rules
"

# Copy essential files
echo "Copying essential files..."
for file in $ESSENTIAL_FILES; do
    if [ -f "$file" ]; then
        # Create parent directory if needed
        parent_dir=$(dirname "$file")
        mkdir -p "$OUTPUT_DIR/$parent_dir"
        cp "$file" "$OUTPUT_DIR/$file"
        echo "  ✓ $file"
    else
        echo "  ⚠ Missing: $file"
    fi
done

# Copy essential directories
echo "Copying essential directories..."
for dir in $ESSENTIAL_DIRS; do
    if [ -d "$dir" ]; then
        mkdir -p "$OUTPUT_DIR/$(dirname $dir)"
        cp -r "$dir" "$OUTPUT_DIR/$dir"
        echo "  ✓ $dir/"
    else
        echo "  ⚠ Missing: $dir/"
    fi
done

# Create minimal README for the export
cat > "$OUTPUT_DIR/README.md" << EOF
# Bootstrap Framework

Version: $VERSION
Exported: $DATE

## Installation

1. Copy all contents of this directory to your project root
2. Make scripts executable: \`chmod +x .claude/scripts/*.sh\`
3. Open project in your AI coding assistant
4. Run: \`/init\` to start

## Contents

- **CLAUDE.md** - Core AI behavior configuration
- **.claude/templates/** - Document templates
- **.claude/scripts/** - Automation scripts
- **.claude/commands/** - Command definitions
- **.claude/rules/** - All framework rules

## Commands

- \`/init\` - Initialize project charter
- \`/determine\` - Gather requirements
- \`/design\` - Create architecture
- \`/define\` - Generate implementation plans
- \`/do\` - Execute implementation

---
_Bootstrap Framework v$VERSION_
EOF

# Create manifest file
cat > "$OUTPUT_DIR/manifest.json" << EOF
{
  "name": "Bootstrap Framework",
  "version": "$VERSION",
  "exported": "$DATE",
  "type": "minimal",
  "files": $(find "$OUTPUT_DIR" -type f | wc -l),
  "size": "$(du -sh "$OUTPUT_DIR" | cut -f1)"
}
EOF

# Summary
echo ""
echo "✅ Export complete: $OUTPUT_DIR/"
echo ""
echo "Package contents:"
find "$OUTPUT_DIR" -type f | wc -l | tr -d ' ' | xargs echo "  Files:"
du -sh "$OUTPUT_DIR" | cut -f1 | xargs echo "  Size:"
echo ""
echo "To install in a new project:"
echo "  1. Copy contents of $OUTPUT_DIR/ to your project root"
echo "  2. Make scripts executable: chmod +x .claude/scripts/*.sh"
echo "  3. Open in AI assistant and run: /init"