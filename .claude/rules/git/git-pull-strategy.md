# Rule: Git Pull Strategy

## Instructions

### Rule Metadata
- ID: git/git-pull-strategy
- Status: Active
- Security Level: Medium
- Token Impact: ~60 tokens per pull operation

### Rule Configuration
```yaml
trigger: "git pull"
conditions:
  - command_contains: ["pull", "fetch"]
actions:
  - recommend_fetch_first: true
  - prefer_rebase: true
  - detect_conflicts_early: true
  - preserve_local_changes: true
validations:
  - check_working_directory: clean
  - verify_current_branch: true
  - conflict_resolution_strategy: manual
  - default_strategy: "--rebase"
  - protect_uncommitted_changes: true
```

---

📚 **Full Documentation**: [docs/rules/git/git-pull-strategy.md](../../../docs/rules/git/git-pull-strategy.md)