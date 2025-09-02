# FEATURE: Git-Safe File Operations

## CONTEXT

**CRITICAL ISSUE**: We have discovered that our current implementation uses direct file operations (`mkdir`, `rm`, `mv`) without checking git status first. This can lead to:
- Loss of uncommitted changes
- Accidental deletion of tracked files
- Breaking git history
- Potential data loss during migrations

This issue was discovered during the diagram migration when we used `rmdir` on folders that might have contained uncommitted files.

## FEATURE

- Implement git-safe wrappers as the DEFAULT for all file operations
- Claude should ALWAYS use git-safe operations unless explicitly overridden
- Check git status before any destructive operations
- Warn about uncommitted changes before proceeding
- Create a rule that can be disabled by advanced users when necessary
- Ensure Claude doesn't fall back to unsafe operations if git commands fail

## EXAMPLES

### Current Dangerous Patterns:
```bash
# DANGEROUS - No git status check
rm -rf some-folder/
mv file.txt new-location/
rmdir old-folder/
```

### Proposed Safe Patterns (DEFAULT):
```bash
# SAFE - Check git status first
git status --porcelain some-folder/ | grep -q . && echo "WARNING: Uncommitted changes" && exit 1
git rm -r some-folder/  # Use git rm instead of rm
git mv file.txt new-location/  # Already safe
```

### Rule Behavior:
```yaml
default_behavior: "Always use git-safe operations"
fallback_behavior: "FAIL if git operations fail - do NOT use unsafe alternatives"
override_mechanism: "User can disable rule in preferences if needed"
```

### Example Implementation:
```python
def remove_file(path, force_unsafe=False):
    """Remove a file or directory safely"""
    if not force_unsafe and git_safe_operations_enabled():
        # Check for uncommitted changes
        if has_uncommitted_changes(path):
            raise SafetyError("Uncommitted changes detected. Use force_unsafe=True to override")
        
        # Use git rm
        result = git_rm(path)
        if not result.success:
            # DO NOT FALL BACK TO rm -rf
            raise GitOperationError("Git rm failed. Check git status and resolve issues")
    else:
        # Only if explicitly requested
        os.remove(path)
```

## DOCUMENTATION

- Git documentation on safe operations: https://git-scm.com/docs/git-rm
- Git best practices for file operations: https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository
- Similar tools: git-safe, git-extras safety features

## OTHER CONSIDERATIONS

### Priority: HIGH
This should be implemented soon to prevent data loss, but with proper override mechanisms.

### Advanced User Override:
- Rule can be disabled in user preferences
- Individual operations can be forced with explicit flags
- Advanced users can still use direct file operations when needed
- Override should require explicit action (not automatic fallback)

### Key Principle:
**Claude should NEVER automatically fall back to unsafe operations if git commands fail.** Instead, it should:
1. Report the git command failure
2. Ask for user guidance
3. Suggest checking git status
4. Only use unsafe operations if explicitly instructed

### Implementation Strategy:
1. Create `.claude/rules/git/git-safe-file-operations.md`
2. Set security level to "Medium" (not "High") to allow override
3. Implement clear error messages when git operations fail
4. Provide documentation on when/how to override

### Example Error Handling:
```bash
# If git mv fails:
echo "ERROR: git mv failed. Possible reasons:"
echo "- File not tracked by git"
echo "- Uncommitted changes in target location"
echo "- Git repository issues"
echo ""
echo "Run 'git status' to investigate"
echo "To force unsafe move: mv --force (NOT RECOMMENDED)"
# DO NOT automatically run 'mv' as fallback
```