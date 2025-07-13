# Changelog Format Rule Documentation

## Overview

The `changelog-format` rule enforces the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) standard for CHANGELOG.md files. It validates structure, categories, version formats, and markdown syntax to ensure consistent, professional documentation.

## Rationale

A well-formatted changelog:
- **Improves Readability**: Users can quickly find relevant changes
- **Enables Automation**: Tools can parse standardized format
- **Maintains Professionalism**: Consistent documentation reflects code quality
- **Facilitates History**: Clear version progression and change categorization

## Format Requirements

### File Structure
```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New features

## [1.0.0] - 2025-07-12

### Added
- Initial release features

[Unreleased]: https://github.com/user/repo/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/user/repo/releases/tag/v1.0.0
```

### Required Elements

1. **Title**: Must be "# Changelog"
2. **Description**: Brief intro paragraph
3. **Standards References**: Links to Keep a Changelog and Semantic Versioning
4. **Unreleased Section**: Always present at top
5. **Version Sections**: In reverse chronological order
6. **Links Section**: At bottom with comparison/release URLs

## Valid Categories

Only these categories are allowed (in this order when present):

### Added
For new features and capabilities
```markdown
### Added
- Support for JSON export format
- User preference system with YAML configuration
- Batch processing mode for large datasets
```

### Changed
For changes in existing functionality
```markdown
### Changed
- Improved performance of file parsing by 50%
- Updated error messages to be more descriptive
- Migrated from REST to GraphQL API
```

### Deprecated
For features that will be removed
```markdown
### Deprecated
- Legacy XML export format (use JSON instead) - removal in 2.0.0
- `--old-flag` CLI option (use `--new-flag`) - removal in 1.5.0
```

### Removed
For removed features
```markdown
### Removed
- Support for Python 3.6 (minimum now 3.8)
- Deprecated `process_old()` function
- Legacy configuration format
```

### Fixed
For bug fixes
```markdown
### Fixed
- Memory leak when processing large files
- Incorrect timestamp formatting in logs
- Race condition in concurrent exports
```

### Security
For security updates
```markdown
### Security
- Updated dependencies to patch CVE-2024-XXXX
- Fixed path traversal vulnerability in file imports
- Enhanced input validation to prevent injection attacks
```

## Examples

### Example 1: Proper Format
```markdown
## [Unreleased]

### Added
- Git merge control rules for safer branch integration
- Automated changelog reminders for significant changes

### Changed
- Improved token efficiency by 83% through rule restructuring

### Fixed
- Git push validation now correctly handles force pushes

## [0.2.0] - 2025-07-12

### Added
- Claude memory integration with @import syntax
- Master imports file for centralized rule management

### Changed
- Restructured rules to separate instructions from documentation
- Updated Git rules to use YAML configuration format

### Removed
- Legacy rule loading system

[Unreleased]: https://github.com/user/repo/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/user/repo/compare/v0.1.0...v0.2.0
```

### Example 2: Invalid Format (Rule Violations)
```markdown
## Unreleased  ❌ Missing brackets

### New Stuff  ❌ Invalid category name
- Added feature

### Added
Added new feature  ❌ Missing bullet point

## 1.0.0  ❌ Missing brackets and date
### Features  ❌ Invalid category
- Something new

❌ Missing link references section
```

## Validation Rules

### 1. Version Format
- Must follow Semantic Versioning: `[MAJOR.MINOR.PATCH]`
- Date in ISO format: `YYYY-MM-DD`
- Example: `## [1.2.3] - 2025-07-12`

### 2. Entry Format
- Each entry must start with `-` 
- One change per line
- No commit hashes or PR numbers
- User-focused language

### 3. Category Order
When multiple categories exist in a version:
1. Added
2. Changed  
3. Deprecated
4. Removed
5. Fixed
6. Security

### 4. Link References
- Must be at end of file
- Unreleased link compares latest version to HEAD
- Version links point to releases or compare with previous

## Best Practices

### 1. Write Clear Entries
```markdown
❌ Bad:  - Fixed bug
✅ Good: - Fixed crash when importing files larger than 2GB

❌ Bad:  - Updated deps
✅ Good: - Updated React from 17.0 to 18.0 for improved performance

❌ Bad:  - Refactored code
✅ Good: - Improved startup time by 40% through lazy loading
```

### 2. Group Related Changes
```markdown
### Added
- Export functionality:
  - CSV format with custom delimiters
  - JSON with pretty-printing option  
  - Excel with multiple worksheet support
```

### 3. Version Consistently
- Use 0.x.x for pre-release development
- 1.0.0 for first stable release
- Follow semantic versioning strictly

### 4. Maintain Unreleased Section
Always keep an Unreleased section for ongoing work:
```markdown
## [Unreleased]
<!-- Current development work goes here -->

## [1.0.0] - 2025-07-12
<!-- Released versions below -->
```

## Common Scenarios

### Scenario 1: First Changelog Entry
Starting a new changelog:
```bash
$ cp .claude/templates/CHANGELOG_template.md CHANGELOG.md
$ # Edit to add your first entries
```

### Scenario 2: Preparing Release
Moving unreleased changes to new version:
```markdown
## [Unreleased]

## [1.1.0] - 2025-07-15  <!-- New version section -->

### Added
- Feature that was in Unreleased  <!-- Moved from Unreleased -->

### Fixed  
- Bug that was in Unreleased  <!-- Moved from Unreleased -->
```

### Scenario 3: Hotfix Release
For patches that skip Unreleased:
```markdown
## [Unreleased]
<!-- Unchanged -->

## [1.0.1] - 2025-07-13  <!-- Added directly -->

### Security
- Patched critical vulnerability (CVE-2024-XXXX)

## [1.0.0] - 2025-07-12
```

## Troubleshooting

### Issue: Validation Fails
**Symptom**: Format validation rejects valid-looking entries

**Check**:
1. Bullet points start with `-` (not `*` or `•`)
2. Categories are exactly as specified (case-sensitive)
3. No extra blank lines between entries
4. Version format includes brackets: `[1.0.0]`

### Issue: Links Not Working
**Symptom**: GitHub links return 404

**Fix**:
```markdown
<!-- Ensure tag exists and format matches -->
[1.0.0]: https://github.com/USER/REPO/releases/tag/v1.0.0
                                                    ^
                                    Note the 'v' prefix if used
```

### Issue: Markdown Rendering
**Symptom**: Changelog looks wrong on GitHub

**Common Fixes**:
1. Ensure blank line after headers
2. Use consistent indentation (2 spaces)
3. Check for unclosed markdown formatting

## Configuration

### Validation Settings
In `.claude/rules/project/changelog-format.md`:

```yaml
standards:
  - format: "keep_a_changelog_1.1.0"
  - sections_required: ["Unreleased"]
  - valid_categories: ["Added", "Changed", "Deprecated", "Removed", "Fixed", "Security"]
actions:
  - validate_format: true
  - suggest_corrections: true
  - check_version_format: "semver"
```

### User Preferences
```yaml
project:
  rules:
    changelog-format: enabled
  config:
    changelog_strict_mode: true      # Reject any deviation
    allow_custom_categories: false   # Only standard categories
    require_links_section: true      # Must have references
```

## Integration with Other Rules

### With Changelog Update Rule
Update rule triggers reminder → Format rule validates the entry:
```bash
$ git commit -m "feat: add new feature"
# Update rule: "Please update CHANGELOG.md"
$ edit CHANGELOG.md
# Format rule: Validates your entry follows standards
```

### With Version Management Rule  
Version management relies on valid format:
1. Checks Unreleased has content
2. Creates new version section with correct format
3. Updates link references

## Validation Examples

### Valid Entry
```markdown
### Added
- New dashboard with real-time metrics
- API endpoint for bulk operations
- Configuration validation on startup
```
✅ Proper bullets, clear descriptions, user-focused

### Invalid Entries
```markdown
### Added
* New dashboard  ❌ Wrong bullet style

### ADDED  ❌ Wrong capitalization
- New feature

### Features  ❌ Invalid category name  
- Something

- Added new function processData() in utils.js  ❌ Too technical
```

## See Also

- [Changelog Update Rule](./changelog-update.md) - Reminder system
- [Version Management Rule](./version-management.md) - Release process
- [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) - Official standard
- [Semantic Versioning](https://semver.org/) - Version numbering
- [Common Changelog](https://common-changelog.org/) - Alternative format

---

📚 **Rule Definition**: [.claude/rules/project/changelog-format.md](../../../.claude/rules/project/changelog-format.md)