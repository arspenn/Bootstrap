# Version Management Rule Documentation

## Overview

The `version-management` rule automates version bumping and release preparation while maintaining human control over version decisions. It ensures proper changelog management, version consistency, and release readiness through validation and automation.

## Rationale

Proper version management:
- **Communicates Impact**: Version numbers indicate change magnitude
- **Ensures Consistency**: Automated checks prevent version conflicts  
- **Streamlines Releases**: Reduces manual steps and errors
- **Maintains History**: Clear progression through versions
- **Follows Standards**: Enforces Semantic Versioning

## How It Works

### Trigger Conditions
The rule activates when:
1. Running version bump commands
2. Preparing releases
3. Creating version tags
4. On main/master branch only

### Version Bump Logic
Based on Semantic Versioning 2.0.0:
- **Major (X.0.0)**: Breaking changes
- **Minor (0.X.0)**: New features, backward compatible  
- **Patch (0.0.X)**: Bug fixes, backward compatible

### Automated Actions
1. **Validate** changelog has unreleased content
2. **Update** version in configuration files
3. **Move** unreleased entries to new version section
4. **Create** git tag with version
5. **Update** changelog link references

## Examples

### Example 1: Minor Version Bump
```bash
$ git status
On branch main
Your branch is up to date with 'origin/main'.

$ claude version bump
Analyzing changes in Unreleased section...

Found in CHANGELOG.md:
- 3 Added entries (new features)
- 2 Fixed entries (bug fixes)
- 0 Breaking changes

Recommended version bump: 0.2.0 → 0.3.0 (minor)

Proceed? [Y/n] y

✓ Updated version in package.json
✓ Updated version in pyproject.toml  
✓ Moved Unreleased entries to [0.3.0] - 2025-07-15
✓ Updated changelog links
✓ Created commit: "chore: release version 0.3.0"
✓ Created tag: v0.3.0

Ready to push: git push origin main --tags
```

### Example 2: Major Version Bump
```bash
$ claude version bump
Analyzing changes in Unreleased section...

Found in CHANGELOG.md:
- 2 Added entries
- 1 Changed entry marked BREAKING
- 1 Removed entry marked BREAKING

⚠️  Breaking changes detected!

Recommended version bump: 0.5.2 → 1.0.0 (major)

Breaking changes:
- BREAKING: Removed support for legacy API format
- BREAKING: Changed authentication to use JWT tokens

Proceed? [Y/n] y

✓ Updated versions to 1.0.0
✓ Created migration guide reminder
✓ Tagged as v1.0.0
```

### Example 3: Patch Release
```bash
$ claude version bump --patch
Analyzing changes...

Found in CHANGELOG.md:
- 3 Fixed entries

Forcing patch version: 1.0.0 → 1.0.1

✓ Released as patch version 1.0.1
```

## Version File Management

### Supported Files
The rule automatically updates version in:

```json
// package.json
{
  "version": "1.0.0"
}
```

```toml
# pyproject.toml
[tool.poetry]
version = "1.0.0"
```

```python
# __version__.py or version.py
__version__ = "1.0.0"
```

```yaml
# version.yml
version: 1.0.0
```

### Custom Version Files
Configure additional files:

```yaml
version_files:
  - path: "src/__init__.py"
    pattern: "__version__ = \"{version}\""
  - path: "docs/conf.py"
    pattern: "release = \"{version}\""
```

## Changelog Integration

### Before Release
```markdown
## [Unreleased]

### Added
- New feature A
- New feature B

### Fixed
- Bug fix X

## [0.2.0] - 2025-07-01
```

### After Release
```markdown
## [Unreleased]

## [0.3.0] - 2025-07-15

### Added
- New feature A
- New feature B

### Fixed
- Bug fix X

## [0.2.0] - 2025-07-01

[Unreleased]: https://github.com/user/repo/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/user/repo/compare/v0.2.0...v0.3.0
```

## Best Practices

### 1. Review Before Bump
Always review the suggested version:
```bash
$ claude version bump --dry-run
Would bump: 1.0.0 → 1.1.0
Based on:
- 2 new features
- 3 bug fixes
- 0 breaking changes
```

### 2. Document Breaking Changes
For major version bumps:
```markdown
## [2.0.0] - 2025-07-15

### Changed
- BREAKING: API now requires authentication for all endpoints
  - Migration: Add Bearer token to all requests
  - See migration guide: docs/MIGRATION_v2.md
```

### 3. Use Prerelease Versions
For testing releases:
```bash
$ claude version bump --prerelease beta
Version: 1.0.0 → 1.1.0-beta.1

$ claude version bump --prerelease rc
Version: 1.1.0-beta.1 → 1.1.0-rc.1
```

### 4. Tag Consistently
Always use 'v' prefix for tags:
- ✅ `v1.0.0`
- ❌ `1.0.0`
- ❌ `version-1.0.0`

## Configuration

### Rule Configuration
In `.claude/rules/project/version-management.md`:

```yaml
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
```

### User Preferences
```yaml
project:
  rules:
    version-management: enabled
  config:
    auto_version_bump: false        # Require confirmation
    version_prefix: "v"             # Tag prefix
    prerelease_identifier: "beta"   # Default prerelease
    version_files:                  # Additional files
      - "src/__version__.py"
      - "helm/Chart.yaml"
```

## Common Scenarios

### Scenario 1: Feature Release Cycle
```bash
# Development phase
$ git commit -m "feat: add export feature"
$ git commit -m "feat: add import feature"
$ git commit -m "fix: handle edge case"

# Release preparation
$ claude version bump
# Suggests minor bump (0.2.0 → 0.3.0)
```

### Scenario 2: Hotfix Release
```bash
# On main branch
$ git commit -m "fix: critical security issue"
$ claude version bump --patch --message "Security patch"
# Forces patch bump (1.0.0 → 1.0.1)
```

### Scenario 3: Major Version Planning
```bash
# Preview breaking changes
$ claude version analyze
Breaking changes detected:
- Removed: Legacy API endpoints
- Changed: Authentication method
- Changed: Configuration format

This will require major version bump: 1.x.x → 2.0.0

# When ready
$ claude version bump --major
```

### Scenario 4: Release Candidate
```bash
# First RC
$ claude version bump --prerelease rc
Version: 0.9.0 → 1.0.0-rc.1

# Final RC
$ claude version bump --prerelease rc
Version: 1.0.0-rc.1 → 1.0.0-rc.2

# Official release
$ claude version bump --release
Version: 1.0.0-rc.2 → 1.0.0
```

## Troubleshooting

### Issue: Version Bump Rejected
**Symptom**: "No changes found in Unreleased section"

**Solution**:
1. Ensure CHANGELOG.md has entries under `## [Unreleased]`
2. Check you're on the main branch
3. Verify changelog format is valid

### Issue: Version Conflict
**Symptom**: "Version 1.0.0 already exists"

**Causes**:
1. Tag already exists: `git tag -l v1.0.0`
2. Version not incremented properly
3. Manual version edit created mismatch

**Fix**:
```bash
# Check existing tags
$ git tag -l

# Force specific version
$ claude version set 1.0.1
```

### Issue: Files Not Updated
**Symptom**: Some files still show old version

**Solution**:
1. Check file is in version_files config
2. Verify file pattern matches
3. Ensure file exists and is tracked

## Advanced Usage

### Custom Bump Rules
Define project-specific rules:

```yaml
custom_bump_rules:
  - pattern: "SECURITY:"
    bump: "patch"
    priority: 1
  - pattern: "PERF:"
    bump: "minor"
    category: "Changed"
```

### CI/CD Integration
```yaml
# .github/workflows/release.yml
- name: Prepare Release
  run: |
    claude version bump --ci
    echo "VERSION=$(cat version.txt)" >> $GITHUB_ENV

- name: Create Release
  uses: actions/create-release@v1
  with:
    tag_name: v${{ env.VERSION }}
```

### Version Scripts
Pre/post version hooks:

```bash
# .claude/hooks/pre-version.sh
#!/bin/bash
echo "Running tests before version bump..."
pytest

# .claude/hooks/post-version.sh  
#!/bin/bash
echo "Building release artifacts..."
make build
```

### Multi-Package Repos
For monorepos:

```yaml
packages:
  - name: "core"
    path: "packages/core"
    version_file: "package.json"
  - name: "cli"
    path: "packages/cli"
    version_file: "package.json"
    
bump_strategy: "synchronized"  # or "independent"
```

## Validation Checks

### Pre-Bump Validations
1. **Branch Check**: Must be on main/master
2. **Clean Working Directory**: No uncommitted changes
3. **Changelog Content**: Unreleased section not empty
4. **Version Format**: Valid semver
5. **Tag Availability**: Version tag doesn't exist

### Post-Bump Validations
1. **Files Updated**: All version files modified
2. **Changelog Formatted**: Proper structure maintained
3. **Links Updated**: References point to correct comparisons
4. **Tag Created**: Git tag matches version
5. **Tests Pass**: If configured, tests must pass

## See Also

- [Changelog Update Rule](./changelog-update.md) - Entry reminders
- [Changelog Format Rule](./changelog-format.md) - Format validation
- [Semantic Versioning](https://semver.org/) - Version standard
- [Conventional Commits](https://www.conventionalcommits.org/) - Commit format
- [Release Please](https://github.com/googleapis/release-please) - Similar tool

---

📚 **Rule Definition**: [.claude/rules/project/version-management.md](../../../.claude/rules/project/version-management.md)