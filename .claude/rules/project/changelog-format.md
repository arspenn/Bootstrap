# Rule: Changelog Format

## Instructions

### Rule Metadata
- ID: project/changelog-format
- Status: Active
- Security Level: Low
- Token Impact: ~25 tokens per operation

### Rule Configuration
```yaml
trigger: "changelog edit"
conditions:
  - file_path: "CHANGELOG.md"
standards:
  - format: "keep_a_changelog_1.1.0"
  - sections_required: ["Unreleased"]
  - valid_categories: ["Added", "Changed", "Deprecated", "Removed", "Fixed", "Security"]
actions:
  - validate_format: true
  - suggest_corrections: true
  - check_version_format: "semver"
validations:
  - markdown_valid: true
  - categories_valid: true
  - version_format_valid: true
```

---

📚 **Full Documentation**: [docs/rules/project/changelog-format.md](../../../docs/rules/project/changelog-format.md)