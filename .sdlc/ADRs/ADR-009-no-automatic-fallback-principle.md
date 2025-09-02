# ADR-009: No Automatic Fallback Principle

## Status
Accepted

## Context

When git-safe operations fail (e.g., `git rm` fails because a file isn't tracked), we need to decide how Claude should behave:
1. Automatically fall back to unsafe operations (`rm`)
2. Stop and require explicit user instruction

The natural developer instinct might be to "make it work" by falling back to regular file operations when git operations fail. However, this could mask important issues and lead to data loss.

## Decision

Claude will NEVER automatically fall back from safe to unsafe operations. When a git operation fails, Claude will:
1. Stop execution
2. Report the specific failure
3. Suggest troubleshooting steps
4. Wait for explicit user instruction

Example flow:
```bash
# Attempting: git rm file.txt
# Result: fatal: pathspec 'file.txt' did not match any files
# 
# ERROR: git rm failed. Possible reasons:
# - File is not tracked by git
# - File has already been deleted
# - Path is incorrect
#
# To investigate: git status file.txt
# To force removal: rm file.txt --force-unsafe
```

## Consequences

### Positive
- Prevents accidental use of unsafe operations
- Makes issues visible rather than hiding them
- Educates users about git states
- Maintains explicit control flow
- Reduces risk of data loss

### Negative
- May interrupt workflow when git commands fail
- Requires user intervention for edge cases
- Could be frustrating for experienced users

### Neutral
- Changes the default behavior from "make it work" to "fail safely"
- Requires clear error messages and guidance
- Shifts responsibility to user for unsafe operations