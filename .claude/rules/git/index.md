# Git Rules Index

This directory contains rules for Git version control operations. These rules ensure consistent, safe, and professional Git usage following industry best practices.

## Active Rules

| Rule | Description | Security Level | Status |
|------|-------------|----------------|--------|
| [git-add-safety](git-add-safety.md) | Safe file staging practices | High | Active |
| [git-commit-format](git-commit-format.md) | Conventional Commits standard | Medium | Active |
| [git-push-validation](git-push-validation.md) | Pre-push validation checks | High | Active |
| [git-pull-strategy](git-pull-strategy.md) | Pull and merge strategies | Medium | Active |
| [git-branch-naming](git-branch-naming.md) | Branch naming conventions | Low | Active |

## Overview

These rules work together to:
- Prevent accidental commits of sensitive data
- Maintain clean, searchable commit history
- Ensure safe interaction with remote repositories
- Standardize branch naming for better collaboration
- Reduce merge conflicts through consistent strategies

## Quick Reference

### Commit Message Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `ci`, `build`

### Branch Naming Format
```
<type>/<feature-name>-<base-version>
```

Example: `feature/git-rules-v1-b8964e0`

## Git Documentation Links

- [Git Add Documentation](https://git-scm.com/docs/git-add)
- [Git Commit Documentation](https://git-scm.com/docs/git-commit)
- [Git Push Documentation](https://git-scm.com/docs/git-push)
- [Git Pull Documentation](https://git-scm.com/docs/git-pull)
- [Git Branch Documentation](https://git-scm.com/docs/git-branch)
- [Conventional Commits Specification](https://www.conventionalcommits.org/)

## Best Practices Summary

1. **Always review changes before staging** - Use `git status` and `git diff`
2. **Write meaningful commit messages** - Follow Conventional Commits
3. **Keep commits atomic** - One logical change per commit
4. **Pull before push** - Avoid conflicts by staying up-to-date
5. **Use descriptive branch names** - Include feature and base version

## Configuration

User preferences for these rules can be set in:
`.claude/rules/config/user-preferences.yaml`

Example:
```yaml
git:
  rules:
    git-add-safety: enabled
    git-commit-format: enabled
    git-push-validation: enabled
    git-pull-strategy: enabled
    git-branch-naming: enabled
```

## Future Enhancements

Planned additions to Git rules:
- Conflict resolution strategies
- Tag management rules
- Advanced GitHub features
- Issue reference requirements
- Release procedures
- Hotfix workflows

## Troubleshooting

If Git rules aren't being applied:
1. Check if the rule is enabled in user preferences
2. Verify the rule file exists and is properly formatted
3. Check the conflict log for any rule conflicts
4. Ensure Claude Code has loaded the rules (check CLAUDE.md)

For more information, see the [Git Control User Guide](../../../docs/rules/git/README.md).