# Rule: Git Pull Strategy

## Instructions

### Rule Metadata
- ID: git/git-pull-strategy
- Status: Active
- Security Level: Medium
- Token Impact: ~35 tokens per operation
- Priority: 500
- Dependencies: []

### Rule Configuration
```yaml
trigger: "git pull"
conditions:
  - command_contains: ["pull", "fetch"]
actions:
  - recommend_fetch_first: true
  - prefer_rebase: "{{config.git.prefer_rebase:true}}"
  - detect_conflicts_early: true
  - preserve_local_changes: true
validations:
  - check_working_directory: "{{config.git.check_working_directory:clean}}"
  - verify_current_branch: true
  - conflict_resolution_strategy: "{{config.git.conflict_resolution_strategy:manual}}"
  - default_strategy: "{{config.git.default_pull_strategy:--rebase}}"
  - protect_uncommitted_changes: true
```

### Behavior
- Recommends fetch before pull for safety
- Prefers rebase strategy (configurable)
- Protects uncommitted changes
- Detects conflicts early
- Ensures clean working directory

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-pull-strategy.md](../../docs/rules/git/git-pull-strategy.md)