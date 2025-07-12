# Git Commit Format - Documentation

**Rule Reference:** `.claude/rules/git/git-commit-format.md`

## ID: git/git-commit-format
## Status: Active
## Security Level: Medium
## Token Impact: ~80 tokens per commit operation

## Description
Enforces Conventional Commits v1.0.0 standard for all commit messages, ensuring consistent, searchable, and automation-friendly commit history. Includes character limits and format validation.

## Rule Definition
```yaml
trigger: "git commit"
conditions:
  - command_contains: ["commit"]
actions:
  - enforce_format: "conventional_commits"
  - use_template: ".claude/templates/commit-message.template"
  - validate_message_structure: true
validations:
  - format: "<type>(<scope>): <subject>"
  - subject_max_length: 250  # recommended
  - subject_hard_limit: 2000  # maximum
  - body_line_length: 72
  - allowed_types:
      - feat      # New feature
      - fix       # Bug fix
      - docs      # Documentation only
      - style     # Code style (formatting, semicolons, etc)
      - refactor  # Code restructuring
      - test      # Adding tests
      - chore     # Maintenance tasks
      - perf      # Performance improvements
      - ci        # CI/CD changes
      - build     # Build system changes
  - require_body_for: ["feat", "fix", "refactor"]
```

## Rationale
Conventional Commits provides:
- Automatic changelog generation
- Clear commit categorization
- Searchable git history
- Integration with semantic versioning
- Better code review process
- GitHub integration compatibility

## Examples

### ✅ Good: Feature commit with scope
```bash
git commit -m "feat(auth): add OAuth2 integration for Google login

- Implement OAuth2 flow with Google provider
- Add token refresh mechanism
- Update user model with OAuth fields
- Add integration tests

Closes #123"
```

### ✅ Good: Bug fix with clear description
```bash
git commit -m "fix(api): resolve timeout error in user endpoint

The user list endpoint was timing out for large datasets.
Added pagination with 100 items per page default.

Fixes #456"
```

### ✅ Good: Simple documentation update
```bash
git commit -m "docs: update README with new installation steps"
```

### ❌ Bad: Non-conventional format
```bash
# DON'T DO THIS
git commit -m "Fixed the bug"
git commit -m "Update code"
git commit -m "changes"
git commit -m "WIP"
```

### ❌ Bad: Exceeding character limits
```bash
# DON'T DO THIS - subject too long
git commit -m "feat: this is a really long commit message that goes way beyond the recommended character limit and provides too much detail in the subject line when it should be in the body instead"
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

## Scope Guidelines

Scope is optional but recommended for clarity:
- Use module/component names: `(auth)`, `(api)`, `(ui)`
- Use feature areas: `(shopping-cart)`, `(user-profile)`
- Keep it short and lowercase
- Use hyphens for multi-word scopes

## Message Structure

### Full Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Subject Line Rules
- Use imperative mood: "add" not "added" or "adds"
- Don't capitalize first letter
- No period at the end
- Limit to 250 characters (recommended)

### Body Guidelines
- Explain what and why, not how
- Wrap at 72 characters
- Use bullet points for multiple items
- Reference issues and PRs

### Footer Options
- `Fixes #123` - Closes issue
- `Closes #123` - Closes issue
- `Resolves #123` - Closes issue
- `Refs #123` - References without closing
- `Breaking change:` - For breaking changes

## Common Scenarios

### Multi-line commit with context
```bash
git commit -m "feat(payments): integrate Stripe payment processing

- Add Stripe SDK integration
- Implement payment intent workflow
- Add webhook handlers for payment events
- Create payment history tracking

This replaces the previous PayPal integration due to better
international support and lower fees.

Closes #789
Refs #790"
```

### Quick fix
```bash
git commit -m "fix(ui): correct button alignment on mobile devices"
```

### Breaking change
```bash
git commit -m "feat(api): change authentication to use JWT tokens

BREAKING CHANGE: API now requires JWT tokens instead of session cookies.
Migration guide available in docs/migration-v2.md

Closes #234"
```

## Troubleshooting

### Common Issues

1. **"Commit message does not match conventional format"**
   - Ensure you're using the correct type (feat, fix, docs, etc.)
   - Check that the format is `type(scope): subject` or `type: subject`
   - Verify lowercase and no trailing punctuation in subject

2. **"Subject line exceeds maximum length"**
   - Keep subject line under 250 characters (recommended)
   - Move detailed information to the commit body
   - Use the hard limit of 2000 characters only when absolutely necessary

3. **"Body required for feat/fix/refactor commits"**
   - These commit types require a body explaining the change
   - Add a blank line after the subject, then your explanation
   - Use the template if unsure about formatting

4. **"Invalid commit type"**
   - Only use allowed types: feat, fix, docs, style, refactor, test, chore, perf, ci, build
   - Check spelling and case (all lowercase)
   - Don't create custom types without updating the rule

### Template Usage
The commit message template at `.claude/templates/commit-message.template` provides a structured format for complex commits. Use it when:
- Making significant features or fixes
- Need guidance on commit structure
- Working on breaking changes

## Related Rules
- [git-add-safety](git-add-safety.md) - Safe staging before commits
- [git-push-validation](git-push-validation.md) - Validation before pushing

## References
- [Conventional Commits Specification](https://www.conventionalcommits.org/en/v1.0.0/)
- [Git Commit Documentation](https://git-scm.com/docs/git-commit)
- [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)