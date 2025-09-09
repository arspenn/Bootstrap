# Git Rule: Push Validation

## Overview
Performs pre-push validation checks to ensure code quality, prevent force pushes to protected branches, and maintain repository integrity.

## Trigger Conditions
- Command contains `git push`
- Any push operation

## Actions

### What the Rule Does
1. Checks remote repository state
2. Validates branch protection rules
3. Prevents force push to protected branches
4. Verifies no large files in push
5. Warns about branch divergence

### Configuration Options
| Setting | Default | Config Path | Description |
|---------|---------|-------------|-------------|
| forbid_force_push_to | [main,master,develop,release/*] | git.forbid_force_push_to | Branches protected from force push |
| force_push_protection | true | git.force_push_protection | Enable force push protection |
| require_upstream_check | true | git.require_upstream_check | Check upstream before push |
| max_file_size | 10MB | git.max_file_size | Maximum file size allowed |

## Examples

### Good Practices
```bash
# ✅ Normal push after pull
git fetch origin
git pull origin feature/new-feature
git push origin feature/new-feature

# ✅ Setting upstream on first push
git push -u origin feature/new-feature

# ✅ Safe force push to feature branch
git push --force-with-lease origin feature/my-feature
```

### Prevented Patterns
```bash
# ❌ Force pushing to main
git push --force origin main
git push -f origin master

# ❌ Pushing without checking remote
git push  # without fetch/pull first

# ❌ Pushing large files
git push  # with files > 10MB
```

## Protection Rules

### Protected Branches
- `main` / `master` - No force push, requires PR
- `develop` - No force push
- `release/*` - No force push
- Custom branches via config

### Pre-Push Checklist
1. ✓ All tests pass locally
2. ✓ No merge conflicts exist
3. ✓ Commits follow conventional format
4. ✓ No sensitive data in commits
5. ✓ Branch is up-to-date with remote

## Troubleshooting

### Common Issues
- **Issue**: "Updates were rejected"
  - **Solution**: Pull latest changes with `git pull --rebase`
  - Resolve conflicts if any
  - Push again

- **Issue**: "Cannot force-push to protected branch"
  - **Solution**: Protected branches cannot be force-pushed
  - Use PR workflow instead
  - Create new branch if needed

- **Issue**: "Large files detected"
  - **Solution**: Remove large files from commit
  - Use Git LFS for binary files
  - Update .gitignore

## Security Considerations
- Prevents accidental history rewriting
- Protects main branches from corruption
- Enforces review process via PRs
- Prevents repository bloat from large files

## Related Rules
- [git-add-safety](git-add-safety.md) - Safe staging practices
- [git-commit-format](git-commit-format.md) - Commit standards
- [git-pull-strategy](git-pull-strategy.md) - Synchronization strategy