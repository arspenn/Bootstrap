# Git-Safe File Operations Documentation

## Overview
Prevents accidental data loss by checking git status before file operations.

## Rule Definition
```yaml
trigger: "bash command execution"
conditions:
  - command_starts_with: ["rm", "rmdir", "mv"]
  - not_force_unsafe: true
actions:
  - check_git_repository: true
  - check_path_status: true
  - block_if_unsafe: true
  - suggest_alternatives: true
validations:
  - no_uncommitted_changes: true
  - no_untracked_files_in_deletion: true
  - prefer_git_commands: true
error_handling:
  - show_git_status: true
  - provide_solutions: true
  - no_automatic_fallback: true
```

## Description
This rule intercepts potentially destructive file operations (rm, rmdir, mv) and ensures they won't result in loss of uncommitted changes or untracked files.

## Rationale
- Discovered during diagram migration when `rmdir` was used on folders with uncommitted files
- Direct file operations bypass git's safety mechanisms
- Users often forget to check git status before destructive operations

## Examples

### Good Practices
```bash
# Check status first
git status src/old-module/
# If clean, use git rm
git rm -r src/old-module/

# Or commit changes first
git add src/old-module/
git commit -m "Save work before deletion"
rm -rf src/old-module/
```

### Bad Practices  
```bash
# DANGEROUS - No status check
rm -rf src/module/

# DANGEROUS - Might lose uncommitted work
rmdir old-folder/
```

## Common Scenarios

### Scenario 1: Deleting with uncommitted changes
```bash
$ rm -rf src/utils/
ERROR: Cannot remove 'src/utils/': uncommitted changes detected

Affected files:
  M src/utils/helpers.py
  ? src/utils/new_module.py

To proceed safely:
  1. Commit changes: git add src/utils/ && git commit -m "Save work"
  2. Or stash changes: git stash push -m "Temporary" src/utils/
  3. Or force removal (DANGEROUS): rm -rf src/utils/ --force-unsafe
```

### Scenario 2: Moving tracked files
```bash
$ mv src/old.py src/new.py
WARNING: 'src/old.py' is tracked by git

Recommended: git mv src/old.py src/new.py
This preserves git history.

To proceed anyway: mv src/old.py src/new.py --force-unsafe
```

## User Preferences

Disable this rule in `.claude/rules/config/user-preferences.yaml`:
```yaml
git:
  rules:
    git-safe-file-operations: disabled
```

## Related Rules
- git-add-safety: Prevents unsafe staging
- git-push-validation: Pre-push safety checks

## Troubleshooting

If git commands fail:
1. Check git status manually
2. Resolve any repo issues
3. Never use --force-unsafe without understanding consequences

## References
- Git documentation: https://git-scm.com/docs/git-rm
- Design document: designs/007-feature-git-safe-file-operations/design.md