# Rule: Version Management

## Instructions

### Rule Metadata
- ID: project/version-management
- Status: Active
- Security Level: Medium
- Token Impact: ~35 tokens per operation

### Rule Configuration
```yaml
trigger: ["version bump", "release prepare"]
conditions:
  - on_main_branch: true
  - changelog_updated: true
strategy:
  - versioning: "semver"
  - bump_rules:
      - breaking_change: "major"
      - new_feature: "minor"
      - bug_fix: "patch"
actions:
  - update_version_file: true
  - move_unreleased_to_version: true
  - create_version_tag: true
  - update_changelog_links: true
validations:
  - changelog_has_unreleased_content: true
  - version_not_duplicate: true
  - tests_passing: true
```

---

📚 **Full Documentation**: [.claude/docs/rules/project/version-management.md](../../docs/rules/project/version-management.md)