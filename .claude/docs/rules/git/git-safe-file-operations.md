# Git Rule: Safe File Operations

## Overview
Prevents accidental data loss by checking Git status before file operations like rm, rmdir, and mv, ensuring uncommitted changes are protected.

## Trigger Conditions
- Commands starting with `rm`, `rmdir`, or `mv`
- Bash command execution on tracked files

## Actions

### What the Rule Does
1. Checks if in Git repository
2. Verifies file/directory Git status
3. Blocks operations on uncommitted changes
4. Suggests Git alternatives (git rm, git mv)
5. Provides clear error messages with solutions

### Configuration Options
| Setting | Default | Config Path | Description |
|---------|---------|-------------|-------------|
| require_git_check | true | git.require_git_check | Check Git status before operations |
| block_if_uncommitted | true | git.block_if_uncommitted | Block if uncommitted changes exist |

## Examples

### Good Practices
```bash
# ✅ Check status first
git status src/old-module/
git rm -r src/old-module/

# ✅ Commit changes first
git add src/old-module/
git commit -m "Save work before deletion"
rm -rf src/old-module/

# ✅ Use Git commands for tracked files
git mv src/old.py src/new.py
```

### Prevented Patterns
```bash
# ❌ No status check
rm -rf src/module/

# ❌ Might lose uncommitted work
rmdir old-folder/

# ❌ Direct move of tracked files
mv src/old.py src/new.py  # Use git mv instead
```

## Common Scenarios

### Deleting with uncommitted changes
```bash
$ rm -rf src/utils/
ERROR: Cannot remove 'src/utils/': uncommitted changes detected

Affected files:
  M src/utils/helpers.py
  ? src/utils/new_module.py

To proceed safely:
  1. Commit changes: git add src/utils/ && git commit -m "Save work"
  2. Or stash changes: git stash push -m "Temporary" src/utils/
  3. Or use git rm: git rm -r src/utils/
```

### Moving tracked files
```bash
$ mv src/old.py src/new.py
WARNING: 'src/old.py' is tracked by git

Recommended: git mv src/old.py src/new.py
This preserves git history.
```

## Troubleshooting

### Common Issues
- **Issue**: "Cannot remove: uncommitted changes"
  - **Solution**: Commit or stash changes first
  - Use `git rm` for tracked files
  - Check `git status` to see changes

- **Issue**: "File is tracked by Git"
  - **Solution**: Use `git mv` instead of `mv`
  - Use `git rm` instead of `rm`
  - Preserves Git history

- **Issue**: "Not in Git repository"
  - **Solution**: Operations allowed outside Git repos
  - Initialize Git if needed
  - Check current directory

## Security Considerations
- Prevents accidental loss of work
- Maintains Git history integrity
- Enforces proper version control workflow
- Protects against destructive operations

## Related Rules
- [git-add-safety](git-add-safety.md) - Safe staging practices
- [git-push-validation](git-push-validation.md) - Push safety checks
- [git-commit-format](git-commit-format.md) - Commit standards