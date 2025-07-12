# Rule: Git Branch Naming

## Instructions

### Rule Metadata
- ID: git/git-branch-naming
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per branch operation

### Rule Configuration
```yaml
trigger: ["git branch", "git checkout -b"]
conditions:
  - command_contains: ["branch", "checkout -b"]
actions:
  - enforce_naming_pattern: true
  - auto_append_base_version: true
  - use_template: ".claude/templates/branch-name.template"
validations:
  - pattern: "^(feature|fix|docs|refactor|test|chore)/.+-[a-f0-9]{7}$"
  - allowed_types: [feature, fix, docs, refactor, test, chore]
  - lowercase_only: true
  - use_hyphens: true
  - include_base_commit: true
```

### Template Reference
Uses template: `.claude/templates/branch-name.template`

---

📚 **Full Documentation**: [docs/rules/git/git-branch-naming.md](../../../docs/rules/git/git-branch-naming.md)