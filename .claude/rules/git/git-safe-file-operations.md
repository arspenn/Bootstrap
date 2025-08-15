# Rule: Git-Safe File Operations

## Instructions

### Rule Metadata
- ID: git/git-safe-file-operations
- Status: Active
- Security Level: Medium
- Token Impact: ~40 tokens per operation
- Priority: 650
- Dependencies: []

### Rule Configuration
```yaml
trigger: "bash command execution"
conditions:
  - command_starts_with: ["rm", "rmdir", "mv"]
  - not_force_unsafe: true
actions:
  - check_git_repository: "{{config.git.require_git_check:true}}"
  - check_path_status: true
  - block_if_unsafe: "{{config.git.block_if_uncommitted:true}}"
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

### Behavior
- Checks Git status before file operations
- Blocks unsafe operations on tracked files
- Suggests Git alternatives (git rm, git mv)
- Protects uncommitted changes
- Shows clear error messages with solutions

---

📚 **Full Documentation**: [docs/rules/git/git-safe-file-operations.md](../../../docs/rules/git/git-safe-file-operations.md)