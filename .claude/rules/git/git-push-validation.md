# Rule: Git Push Validation

## Instructions

### Rule Metadata
- ID: git/git-push-validation
- Status: Active
- Security Level: High
- Token Impact: ~70 tokens per push operation

### Rule Configuration
```yaml
trigger: "git push"
conditions:
  - command_contains: ["push"]
actions:
  - check_remote_state: true
  - validate_branch_protection: true
  - prevent_force_push_to: ["main", "master", "develop", "release/*"]
  - require_upstream_check: true
validations:
  - forbid_force_push_main: true
  - check_commit_signatures: recommended
  - verify_no_large_files: true
  - max_file_size: 10MB
  - warn_on_divergence: true
  - suggest_pull_before_push: true
```

---

📚 **Full Documentation**: [docs/rules/git/git-push-validation.md](../../../docs/rules/git/git-push-validation.md)