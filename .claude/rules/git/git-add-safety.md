# Rule: Git Add Safety

## Instructions

### Rule Metadata
- ID: git/git-add-safety
- Status: Active
- Security Level: High
- Token Impact: ~50 tokens per git add operation

### Rule Configuration
```yaml
trigger: "git add"
conditions:
  - command_contains: ["add", "stage"]
actions:
  - require_status_check: true
  - forbid_commands: ["git add .", "git add -A", "git add --all"]
  - require_explicit_paths: true
  - check_file_patterns:
      - "*.env"
      - "*.key"
      - "*.pem"
      - "*_secret*"
      - "*password*"
validations:
  - max_file_size: 10MB
  - warn_on_binary: true
  - require_diff_review: true
```

---

📚 **Full Documentation**: [docs/rules/git/git-add-safety.md](../../../docs/rules/git/git-add-safety.md)