# Rule: Git Push Validation

## Instructions

### Rule Metadata
- ID: git/git-push-validation
- Status: Active
- Security Level: High
- Token Impact: ~40 tokens per operation
- Priority: 700
- Dependencies: []

### Rule Configuration
```yaml
trigger: "git push"
conditions:
  - command_contains: ["push"]
actions:
  - check_remote_state: true
  - validate_branch_protection: true
  - prevent_force_push_to: "{{config.git.forbid_force_push_to:[main,master,develop,release/*]}}"
  - require_upstream_check: "{{config.git.require_upstream_check:true}}"
validations:
  - forbid_force_push_main: "{{config.git.force_push_protection:true}}"
  - check_commit_signatures: recommended
  - verify_no_large_files: true
  - max_file_size: "{{config.git.max_file_size:10MB}}"
  - warn_on_divergence: true
  - suggest_pull_before_push: true
```

### Behavior
- Validates push operations for safety
- Prevents force push to protected branches
- Checks for large files before push
- Warns about branch divergence
- Suggests pull before push when needed

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-push-validation.md](../../docs/rules/git/git-push-validation.md)