# Rule: Git Branch Naming

## Instructions

### Rule Metadata
- ID: git/git-branch-naming
- Status: Active
- Security Level: Low
- Token Impact: ~25 tokens per operation
- Priority: 300
- Dependencies: []

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
  - pattern: "{{config.git.branch_pattern:^(feature|fix|docs|refactor|test|chore)/.+-[a-f0-9]{7}$}}"
  - allowed_types: "{{config.git.allowed_types:[feature,fix,docs,refactor,test,chore]}}"
  - lowercase_only: true
  - use_hyphens: true
  - include_base_commit: true
```

### Behavior
- Enforces branch naming conventions
- Pattern: {type}/{description}-{commit-hash}
- Requires lowercase with hyphens
- Auto-appends base commit hash
- Uses branch name template

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-branch-naming.md](../../docs/rules/git/git-branch-naming.md)