# Git Rule: Commit Format

## Overview
Enforces conventional commit format for all commit messages, ensuring consistent, searchable, and automation-friendly commit history.

## Trigger Conditions
- Command contains `git commit`
- Any commit operation

## Actions

### What the Rule Does
1. Enforces conventional commit format
2. Validates message structure
3. Checks subject line length
4. Validates commit types
5. Requires body for significant changes

### Configuration Options
| Setting | Default | Config Path | Description |
|---------|---------|-------------|-------------|
| commit_format | conventional | git.commit_format | Commit format style |
| subject_max_length | 250 | git.subject_max_length | Maximum subject line length |
| body_line_length | 72 | git.body_line_length | Body line wrap length |
| commit_types | [feat,fix,docs,style,refactor,test,chore,perf,ci,build] | git.commit_types | Allowed commit types |
| require_body_for | [feat,fix,refactor] | git.require_body_for | Types requiring body |

## Examples

### Good Practices
```bash
# ✅ Feature commit with scope
git commit -m "feat(auth): add OAuth2 integration

- Implement OAuth2 flow
- Add token refresh mechanism
- Update user model

Closes #123"

# ✅ Simple fix
git commit -m "fix: correct calculation error in invoice total"

# ✅ Documentation update
git commit -m "docs: update README with installation steps"
```

### Prevented Patterns
```bash
# ❌ Non-conventional format
git commit -m "Fixed the bug"  # No type
git commit -m "Update code"     # Vague
git commit -m "WIP"            # Not descriptive

# ❌ Format violations  
git commit -m "feat this is missing colon"  # Missing colon
git commit -m "Feat: capitalized type"       # Wrong case
git commit -m "feat: this is a really long commit message that goes way beyond the recommended character limit and provides too much detail in the subject line when it should be in the body instead"  # Too long
```

## Commit Types Guide

| Type | Description | Example |
|------|-------------|---------|
| **feat** | New feature for users | `feat: add export to PDF functionality` |
| **fix** | Bug fix for users | `fix: correct calculation in invoice total` |
| **docs** | Documentation changes | `docs: add API examples to README` |
| **style** | Code style/formatting | `style: format code with Black` |
| **refactor** | Code restructuring | `refactor: extract validation logic to utils` |
| **test** | Test additions/changes | `test: add unit tests for auth module` |
| **chore** | Maintenance tasks | `chore: update dependencies` |
| **perf** | Performance improvements | `perf: optimize database queries` |
| **ci** | CI/CD changes | `ci: add GitHub Actions workflow` |
| **build** | Build system changes | `build: update webpack configuration` |

## Troubleshooting

### Common Issues
- **Issue**: "Invalid commit type"
  - **Solution**: Use allowed types (feat, fix, docs, etc.)
  - Check spelling and lowercase
  - Update config to add custom types if needed

- **Issue**: "Subject line too long"
  - **Solution**: Keep under configured limit (default: 250)
  - Move details to body
  - Be concise in subject

- **Issue**: "Body required for type"
  - **Solution**: Add explanatory body for feat/fix/refactor
  - Leave blank line after subject
  - Explain what and why

## Security Considerations
- Standardized format enables automation
- Clear commit history for auditing
- Better traceability of changes
- Easier identification of breaking changes

## Related Rules
- [git-add-safety](git-add-safety.md) - Safe staging before commits
- [git-push-validation](git-push-validation.md) - Push safety checks
- [git-branch-naming](git-branch-naming.md) - Branch naming standards