# Migration Guide: Git-Safe File Operations

## Overview

This guide helps migrate Claude's behavior and project documentation to use git-safe file operations by default. PRPs remain unchanged as historical records.

## What Needs Migration

### 1. Claude's Default Behavior
- Claude now uses `git rm`, `git mv` by default for tracked files
- The rule is automatically loaded via MASTER_IMPORTS.md
- No changes needed - this is automatic

### 2. Project Documentation
Search and update references to file operations in:
- `/docs/**/*.md` - Documentation files
- `/templates/**/*` - Template files
- `/features/**/*.md` - Feature descriptions
- `/designs/**/design.md` - Design documents
- `PLANNING.md` - Project planning
- `README.md` - Project readme

### 3. Template Files
Update any templates that contain file operation examples:

#### Before:
```bash
# Clean up old files
rm old-config.json
mv config.json config.backup.json
```

#### After:
```bash
# Clean up old files (using git-safe operations)
git rm old-config.json
git mv config.json config.backup.json
```

## Migration Process

### Step 1: Find Files to Update

```bash
# Find documentation with rm commands
grep -r "rm " docs/ templates/ --include="*.md" --include="*.txt"

# Find documentation with rmdir commands  
grep -r "rmdir " docs/ templates/ --include="*.md" --include="*.txt"

# Find documentation with mv commands
grep -r "mv " docs/ templates/ --include="*.md" --include="*.txt"
```

### Step 2: Update Documentation Examples

When updating documentation:
1. Keep examples that specifically demonstrate non-git operations
2. Update general file operation examples to use git commands
3. Add notes about when to use git vs non-git commands

### Step 3: Update Templates

For template files that generate code or scripts:
1. Default to git-safe operations
2. Include comments about when git operations are appropriate
3. Show both options with clear documentation

## Example Updates

### Documentation Example

#### Original (in docs/development/cleanup.md):
```markdown
## Cleaning Build Artifacts
Run these commands to clean up:
```bash
rm -rf build/
rm -rf dist/
```
```

#### Updated:
```markdown
## Cleaning Build Artifacts
Run these commands to clean up:
```bash
# For tracked directories
git rm -rf build/
git rm -rf dist/

# For untracked build artifacts (like those in .gitignore)
rm -rf build/
rm -rf dist/
```
```

### Template Example

#### Original (in templates/scripts/cleanup.sh):
```bash
#!/bin/bash
# Cleanup script
rm -f *.log
rm -rf temp/
```

#### Updated:
```bash
#!/bin/bash
# Cleanup script with git-safe operations

# Remove tracked files
for file in *.log; do
    if git ls-files --error-unmatch "$file" 2>/dev/null; then
        git rm "$file"
    else
        rm -f "$file"
    fi
done

# Remove directory
if git ls-files --error-unmatch temp/ 2>/dev/null; then
    git rm -rf temp/
else
    rm -rf temp/
fi
```

## What NOT to Migrate

### 1. PRPs (Process Realization Plans)
- Leave all existing PRPs unchanged
- They are historical execution records
- Future PRPs will automatically use git-safe operations

### 2. System/Tool Operations
Keep non-git operations for:
- `/tmp` directory operations
- System file operations
- Build artifact cleanup (often in .gitignore)
- Package manager operations

### 3. Explicit Non-Git Examples
Keep examples that specifically show:
- How to work outside git repositories
- System administration tasks
- Performance-critical operations

## Validation

After migration, verify:

1. **Documentation Clarity**
   - Examples clearly show when to use git vs non-git
   - Safety considerations are documented

2. **Template Functionality**
   - Templates still work correctly
   - Generated code handles both tracked and untracked files

3. **No Breaking Changes**
   - Existing workflows still function
   - Users can override when needed

## Future Considerations

### For New Documentation
- Default to git-safe operations in examples
- Document exceptions clearly
- Include safety notes for destructive operations

### For New Templates
- Generate git-safe operations by default
- Include checks for git repository presence
- Handle both tracked and untracked files gracefully

## Quick Reference

| Operation | Unsafe Command | Git-Safe Command |
|-----------|----------------|------------------|
| Remove file | `rm file.txt` | `git rm file.txt` |
| Remove directory | `rmdir dir/` or `rm -rf dir/` | `git rm -r dir/` |
| Move file | `mv old.txt new.txt` | `git mv old.txt new.txt` |
| Force remove | `rm -f file.txt` | `git rm -f file.txt` |

## Getting Help

- Rule documentation: `/docs/rules/git/git-safe-file-operations.md`
- Design document: `/designs/007-feature-git-safe-file-operations/design.md`
- Integration logic: `/docs/rules/git/git-safe-file-operations-integration.md`