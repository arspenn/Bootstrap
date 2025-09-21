#!/bin/sh
set -euo pipefail

# Script: git-safe-add.sh
# Purpose: Safely add files to git, blocking sensitive patterns
# Usage: ./.claude/scripts/git-safe-add.sh [--dry-run] [files...]
# Note: Called by AI agent during git operations

# Check for dry-run mode
DRY_RUN=0
if [ "${1:-}" = "--dry-run" ]; then
    DRY_RUN=1
    shift
    echo "DRY RUN MODE - No files will actually be added"
    echo ""
fi

# Define blocked patterns
BLOCKED_PATTERNS="
.env
.env.local
.env.production
.env.development
.env.test
*.key
*.pem
*.p12
*.pfx
*.cer
*.crt
id_rsa
id_dsa
id_ecdsa
id_ed25519
.aws
.ssh
credentials
secrets.json
secrets.yaml
secrets.yml
config.secret
*.sqlite
*.db
*.sqlite3
.DS_Store
Thumbs.db
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.vscode/settings.json
.idea/
"

# Track blocked files for gitignore suggestion
BLOCKED_FILES=""
ADDED_COUNT=0
BLOCKED_COUNT=0

# Check if .gitignore exists
GITIGNORE_EXISTS=0
if [ -f ".gitignore" ]; then
    GITIGNORE_EXISTS=1
fi

# Function to check if pattern is in .gitignore
is_in_gitignore() {
    if [ $GITIGNORE_EXISTS -eq 1 ] && grep -q "^$1\$" .gitignore 2>/dev/null; then
        return 0
    fi
    return 1
}

# Process each file
for file in "$@"; do
    # Skip if file doesn't exist
    if [ ! -e "$file" ]; then
        echo "⚠ File not found: $file"
        continue
    fi

    # Check against blocked patterns
    BLOCKED=0
    MATCHED_PATTERN=""
    for pattern in $BLOCKED_PATTERNS; do
        # Skip empty patterns
        [ -z "$pattern" ] && continue

        # Check if file matches pattern
        case "$file" in
            $pattern)
                BLOCKED=1
                MATCHED_PATTERN="$pattern"
                break
                ;;
        esac

        # Also check if filename (without path) matches
        basename_file=$(basename "$file")
        case "$basename_file" in
            $pattern)
                BLOCKED=1
                MATCHED_PATTERN="$pattern"
                break
                ;;
        esac
    done

    # Handle blocked files
    if [ $BLOCKED -eq 1 ]; then
        echo "✗ BLOCKED: $file (matches pattern: $MATCHED_PATTERN)"
        BLOCKED_FILES="${BLOCKED_FILES}${file}\n"
        BLOCKED_COUNT=$((BLOCKED_COUNT + 1))

        # Check if pattern is in .gitignore
        if ! is_in_gitignore "$MATCHED_PATTERN"; then
            echo "  💡 Consider adding '$MATCHED_PATTERN' to .gitignore"
        fi
    else
        # Add the file (or simulate in dry-run mode)
        if [ $DRY_RUN -eq 1 ]; then
            echo "✓ Would add: $file"
        else
            git add "$file"
            echo "✓ Added: $file"
        fi
        ADDED_COUNT=$((ADDED_COUNT + 1))
    fi
done

# Summary
echo ""
echo "Summary:"
echo "  Added: $ADDED_COUNT file(s)"
echo "  Blocked: $BLOCKED_COUNT file(s)"

# Suggest .gitignore updates if files were blocked
if [ $BLOCKED_COUNT -gt 0 ]; then
    echo ""
    echo "⚠ Security Notice:"
    echo "  Sensitive files were blocked from being added to git."

    if [ $GITIGNORE_EXISTS -eq 0 ]; then
        echo "  💡 No .gitignore found. Consider creating one with:"
        echo "     echo '# Sensitive files' > .gitignore"
        for pattern in $BLOCKED_PATTERNS; do
            [ -z "$pattern" ] && continue
            echo "     echo '$pattern' >> .gitignore"
        done | head -10
    else
        echo "  💡 Review .gitignore to ensure all sensitive patterns are included"
    fi
fi

# Exit with error if all files were blocked
if [ $ADDED_COUNT -eq 0 ] && [ $BLOCKED_COUNT -gt 0 ]; then
    exit 1
fi

exit 0