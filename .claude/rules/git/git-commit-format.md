# Rule: Git Commit Format

## Instructions

### Rule Metadata
- ID: git/git-commit-format
- Status: Active
- Security Level: Medium
- Token Impact: ~30 tokens per operation
- Priority: 400
- Dependencies: []

### Rule Configuration
```yaml
trigger: "git commit"
conditions:
  - command_contains: ["commit"]
actions:
  - enforce_format: "{{config.git.commit_format:conventional}}"
  - use_template: ".claude/templates/commit-message.template"
validations:
  - format: "<type>(<scope>): <subject>"
  - subject_max_length: "{{config.git.subject_max_length:250}}"
  - body_line_length: "{{config.git.body_line_length:72}}"
  - allowed_types: "{{config.git.commit_types:[feat,fix,docs,style,refactor,test,chore,perf,ci,build]}}"
  - require_body_for: "{{config.git.require_body_for:[feat,fix,refactor]}}"
```

### Behavior
- Enforces conventional commit format
- Validates commit message structure
- Limits subject line length (default: 250 chars)
- Requires body for significant changes
- Uses commit message template

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-commit-format.md](../../docs/rules/git/git-commit-format.md)