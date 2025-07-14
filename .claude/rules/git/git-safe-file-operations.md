# Rule: Git-Safe File Operations

## Instructions

### Rule Metadata
- ID: git/git-safe-file-operations
- Status: Active  
- Security Level: Medium
- Token Impact: ~75 tokens per file operation

### Rule Configuration
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

### Safety Checks
- Check if in git repository
- Run path-specific git status
- Block if uncommitted changes detected
- Suggest git alternatives for tracked files

---

📚 **Full Documentation**: [docs/rules/git/git-safe-file-operations.md](../../../docs/rules/git/git-safe-file-operations.md)