# Rule: Changelog Update

## Instructions

### Rule Metadata
- ID: project/changelog-update
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation

### Rule Configuration
```yaml
trigger: ["git commit", "task complete"]
conditions:
  - significant_change: true
  - changelog_worthy:
      - new_feature: true
      - breaking_change: true
      - bug_fix: true
      - deprecation: true
actions:
  - check_changelog_updated: true
  - suggest_entry_if_missing: true
  - suggest_template: ".claude/templates/changelog-entry.template"
  - remind_on_pr: true
validations:
  - entry_exists_or_acknowledged: true
```

---

📚 **Full Documentation**: [docs/rules/project/changelog-update.md](../../../docs/rules/project/changelog-update.md)