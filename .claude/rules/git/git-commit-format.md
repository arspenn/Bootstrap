# Rule: Git Commit Format

## Instructions

### Rule Metadata
- ID: git/git-commit-format
- Status: Active
- Security Level: Medium
- Token Impact: ~40 tokens per commit operation

### Rule Configuration
```yaml
trigger: "git commit"
conditions:
  - command_contains: ["commit"]
actions:
  - enforce_format: "conventional_commits"
  - use_template: ".claude/templates/commit-message.template"
validations:
  - format: "<type>(<scope>): <subject>"
  - subject_max_length: 250
  - body_line_length: 72
  - allowed_types: [feat, fix, docs, style, refactor, test, chore, perf, ci, build]
  - require_body_for: ["feat", "fix", "refactor"]
```

### Template Reference
Uses template: `.claude/templates/commit-message.template`

---

📚 **Full Documentation**: [docs/rules/git/git-commit-format.md](../../../docs/rules/git/git-commit-format.md)
