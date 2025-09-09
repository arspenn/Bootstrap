# Changelog Update Rule Documentation

## Overview

The `changelog-update` rule ensures that significant changes to the codebase are documented in the project's CHANGELOG.md file. It operates on a reminder-based system, prompting developers to update the changelog when meaningful changes are made while avoiding interruption for routine maintenance tasks.

## Rationale

Maintaining an accurate changelog is crucial for:
- **User Communication**: Users need to know what changed between versions
- **Team Awareness**: Developers can track project evolution
- **Release Planning**: Clear record of what's ready for release
- **Debugging**: Historical context for when issues were introduced

## When This Rule Triggers

The rule activates on:
1. **Git commits** containing significant changes
2. **Task completion** in TASK.md for feature tasks
3. **Pull request creation** with notable changes

### Significant Changes Include:
- New features (`feat:` commits)
- Bug fixes (`fix:` commits)
- Breaking changes (`!` modifier)
- Deprecations
- Security updates
- Performance improvements

### Ignored Changes:
- Style changes (`style:`)
- Documentation updates (`docs:`)
- Test additions (`test:`)
- Build process changes (`build:`)
- CI/CD updates (`ci:`)
- Routine maintenance (`chore:`)

## Examples

### Example 1: Feature Addition
```bash
$ git commit -m "feat: add dark mode toggle to settings"

⚠️ Changelog Reminder:
This appears to be a significant change. Please update CHANGELOG.md:

Suggested entry for "### Added":
- Dark mode toggle in application settings

Use template: .claude/templates/changelog-entry.template
```

### Example 2: Bug Fix
```bash
$ git commit -m "fix: resolve memory leak in data processor"

⚠️ Changelog Reminder:
This bug fix should be documented. Please update CHANGELOG.md:

Suggested entry for "### Fixed":
- Memory leak in data processor that affected large datasets

Use template: .claude/templates/changelog-entry.template
```

### Example 3: Breaking Change
```bash
$ git commit -m "feat!: redesign API authentication flow"

⚠️ Changelog Reminder:
BREAKING CHANGE detected! This must be documented in CHANGELOG.md:

Suggested entries:
### Added
- New token-based authentication system

### Changed
- BREAKING: API authentication now requires Bearer tokens instead of API keys

### Removed
- BREAKING: Legacy API key authentication

Use template: .claude/templates/changelog-entry.template
```

## Best Practices

### 1. Update Immediately
Update the changelog as part of your commit workflow:
```bash
# Make your changes
$ git add src/feature.py
$ git add CHANGELOG.md
$ git commit -m "feat: add export functionality"
```

### 2. Write User-Focused Entries
❌ **Don't**: "Updated processData() in utils.py"
✅ **Do**: "Fixed data processing error for CSV files larger than 100MB"

### 3. Group Related Changes
When making multiple related changes:
```markdown
### Added
- Export functionality with support for:
  - CSV format with custom delimiters
  - JSON with pretty-printing option
  - Excel with multiple sheets
```

### 4. Link to Issues/PRs in Extended Description
While not in the changelog entry itself, commit messages can reference issues:
```bash
$ git commit -m "fix: resolve data export timeout

Fixes #123. The export process now streams data instead of
loading everything into memory at once."
```

## Configuration

### User Preferences
Users can configure the reminder behavior in `.claude/user-preferences.yaml`:

```yaml
project:
  rules:
    changelog-update: enabled  # or disabled
  config:
    changelog_reminder_level: "suggest"  # Options: suggest, warn, require
    ignore_patterns:
      - "WIP:*"              # Ignore work-in-progress commits
      - "*[skip-changelog]*" # Skip if commit message contains marker
```

### Environment Variables
```bash
# Temporarily disable changelog reminders
export CLAUDE_SKIP_CHANGELOG_CHECK=1

# Change reminder level for session
export CLAUDE_CHANGELOG_LEVEL=warn
```

## Common Scenarios

### Scenario 1: Multiple Commits for One Feature
When developing a feature across multiple commits:

1. Use conventional commits for tracking:
   ```bash
   $ git commit -m "feat(export): add base export class [skip-changelog]"
   $ git commit -m "feat(export): implement CSV exporter [skip-changelog]"
   $ git commit -m "feat(export): add Excel support"  # This triggers the reminder
   ```

2. Update changelog once when feature is complete

### Scenario 2: Emergency Hotfix
For critical fixes that need immediate deployment:

```bash
$ git commit -m "fix!: patch critical security vulnerability

[skip-changelog] Will update after deployment"

# After deployment:
$ git commit -m "docs: update changelog for security patch"
```

### Scenario 3: Refactoring
For refactoring that doesn't change functionality:

```bash
$ git commit -m "refactor: reorganize export module structure"
# No changelog reminder - internal change only
```

## Troubleshooting

### Issue: Too Many Reminders
**Symptom**: Getting reminded for every small commit

**Solution**: 
1. Adjust your commit strategy - batch related changes
2. Use `[skip-changelog]` marker for WIP commits
3. Configure to only remind on PR creation

### Issue: Reminder Not Appearing
**Symptom**: Made significant change but no reminder

**Check**:
1. Commit message format - ensure using conventional commits
2. Rule is enabled in preferences
3. Not in a excluded branch (e.g., experimental branches)

### Issue: Suggested Entry Incorrect
**Symptom**: The suggested changelog entry doesn't match the change

**Solution**:
1. Ignore the suggestion and write custom entry
2. Ensure commit message accurately describes the change
3. Use extended commit description for context

## Integration with Other Rules

### With Git Commit Format Rule
The changelog-update rule reads conventional commit types:
- `feat:` → "Added" section
- `fix:` → "Fixed" section  
- `feat!:` or `fix!:` → "Changed" section with breaking note
- `perf:` → "Changed" section
- `security:` → "Security" section

### With Version Management Rule
When preparing a release:
1. Changelog-update ensures all changes are documented
2. Version-management moves entries from Unreleased to version section

### With Git Push Validation
Push validation can check:
```yaml
validations:
  - if_breaking_change_then_changelog_updated: true
```

## Template Integration

The rule references `.claude/templates/changelog-entry.template` which provides:
- Category templates with examples
- Writing guidelines
- Good/bad entry examples
- Quick checklist

When reminded, developers can:
```bash
# Open the template
$ cat .claude/templates/changelog-entry.template

# Copy relevant sections to CHANGELOG.md
$ code CHANGELOG.md
```

## Advanced Usage

### Custom Triggers
Add custom triggers in project configuration:

```yaml
custom_triggers:
  - pattern: "DEPLOYS:*"
    suggests: "Add deployment note to changelog"
  - pattern: "MIGRATES:*"  
    suggests: "Document migration in changelog"
```

### Automated PR Checks
In CI/CD pipeline:
```yaml
- name: Check Changelog
  run: |
    if git diff origin/main..HEAD --name-only | grep -q "src/"; then
      if ! git diff origin/main..HEAD --name-only | grep -q "CHANGELOG.md"; then
        echo "⚠️ Source changes detected but CHANGELOG.md not updated"
        exit 1
      fi
    fi
```

## See Also

- [Changelog Format Rule](./changelog-format.md) - Ensures proper formatting
- [Version Management Rule](./version-management.md) - Handles releases
- [Keep a Changelog](https://keepachangelog.com/) - Standard we follow
- [Conventional Commits](https://www.conventionalcommits.org/) - Commit format

---

📚 **Rule Definition**: [.claude/rules/project/changelog-update.md](../../../.claude/rules/project/changelog-update.md)