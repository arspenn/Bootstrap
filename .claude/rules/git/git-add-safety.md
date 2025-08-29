# Rule: Git Add Safety

## Instructions

### Rule Metadata
- ID: git/git-add-safety
- Status: Active
- Security Level: High
- Token Impact: ~35 tokens per operation
- Priority: 750
- Dependencies: []

### Rule Configuration
```yaml
trigger: "git add"
conditions:
  - command_contains: ["add", "stage"]
actions:
  - require_status_check: true
  - forbid_commands: ["git add .", "git add -A", "git add --all"]
  - require_explicit_paths: true
  - check_file_patterns: "{{config.git.forbidden_patterns:[*.env,*.key,*.pem,*_secret*,*password*]}}"
validations:
  - max_file_size: "{{config.git.max_file_size:10MB}}"
  - warn_on_binary: "{{config.git.warn_on_binary:true}}"
  - require_diff_review: true
```

### Behavior
- Prevents accidental staging of sensitive files
- Blocks wildcard staging commands (git add ., git add -A)
- Checks file size before staging (default: 10MB max)
- Warns when binary files are staged
- Requires explicit file paths for safety

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-add-safety.md](../../docs/rules/git/git-add-safety.md)