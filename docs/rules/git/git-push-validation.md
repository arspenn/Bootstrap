# Git Push Validation - Documentation

**Rule Reference:** `.claude/rules/git/git-push-validation.md`

## ID: git/git-push-validation
## Status: Active
## Security Level: High
## Token Impact: ~70 tokens per push operation

## Description
Performs pre-push validation checks to ensure code quality, prevent force pushes to protected branches, and maintain repository integrity. Validates branch protection rules and remote state.

## Rule Definition
```yaml
trigger: "git push"
conditions:
  - command_contains: ["push"]
actions:
  - check_remote_state: true
  - validate_branch_protection: true
  - prevent_force_push_to: ["main", "master", "develop", "release/*"]
  - require_upstream_check: true
validations:
  - forbid_force_push_main: true
  - check_commit_signatures: recommended
  - verify_no_large_files: true
  - max_file_size: 10MB
  - warn_on_divergence: true
  - suggest_pull_before_push: true
```

## Rationale
Push validation prevents:
- Accidentally overwriting others' work with force push
- Pushing large files that bloat the repository
- Conflicts from not pulling latest changes
- Breaking protected branch rules
- Pushing to wrong remote/branch

## Examples

### ✅ Good: Normal push after pull
```bash
# Check remote state first
git fetch origin
git status

# Pull if behind
git pull origin feature/new-feature

# Then push
git push origin feature/new-feature
```

### ✅ Good: Setting upstream on first push
```bash
# First push of a new branch
git push -u origin feature/new-feature

# Subsequent pushes can be simpler
git push
```

### ✅ Good: Safe force push to feature branch
```bash
# Force push only to your feature branch after rebase
git push --force-with-lease origin feature/my-feature
```

### ❌ Bad: Force pushing to main
```bash
# NEVER DO THIS
git push --force origin main
git push -f origin master
```

### ❌ Bad: Pushing without checking remote
```bash
# DON'T push blindly
git push  # without fetch/pull first
```

## Protection Rules

### Protected Branches
The following branches have special protection:
- `main` / `master` - No force push, requires PR
- `develop` - No force push
- `release/*` - No force push
- `hotfix/*` - Limited force push

### Pre-Push Checklist
Before pushing, ensure:
1. ✓ All tests pass locally
2. ✓ No merge conflicts exist
3. ✓ Commits follow conventional format
4. ✓ No sensitive data in commits
5. ✓ Branch is up-to-date with remote

## Common Scenarios

### First push of a new branch
```bash
# Create and push new branch
git checkout -b feature/awesome-feature
git push -u origin feature/awesome-feature
```

### Pushing after rebase
```bash
# After rebasing, use force-with-lease
git rebase main
git push --force-with-lease origin feature/my-branch
```

### Handling push rejection
```bash
# If push is rejected
git push
# ! [rejected]        feature -> feature (non-fast-forward)

# Pull first, then push
git pull --rebase origin feature
git push
```

### Pushing tags
```bash
# Push a single tag
git push origin v1.0.0

# Push all tags
git push origin --tags
```

## Best Practices

1. **Always fetch before push** - Know the remote state
2. **Use `--force-with-lease`** instead of `--force` when needed
3. **Set upstream on first push** - Use `-u` flag
4. **Never force push to shared branches**
5. **Review what you're pushing** - Use `git log origin/branch..HEAD`

## Safety Commands

### Check what will be pushed
```bash
# See commits that will be pushed
git log origin/main..HEAD --oneline

# See full diff of what will be pushed
git diff origin/main...HEAD
```

### Verify remote configuration
```bash
# Check remotes
git remote -v

# Check branch tracking
git branch -vv
```

### Undo a push (if needed)
```bash
# If you just pushed to wrong branch
git push origin :wrong-branch  # Delete remote branch
git push origin correct-branch  # Push to correct branch
```

## Error Prevention

### Large File Detection
```bash
# Before pushing, check for large files
find . -type f -size +10M | grep -v .git
```

### Sensitive Data Check
```bash
# Search for potential secrets
git log -p | grep -i -E "(password|secret|key|token)"
```

## Troubleshooting

### Common Issues

1. **"Updates were rejected because the remote contains work"**
   - Pull the latest changes: `git pull --rebase origin branch-name`
   - Resolve any conflicts if they occur
   - Try pushing again

2. **"Cannot force-push to protected branch"**
   - This is intentional - protected branches cannot be force-pushed
   - Create a new branch or use proper PR workflow
   - If absolutely necessary, temporarily unprotect (requires admin rights)

3. **"Large files detected in push"**
   - Remove large files from commit history
   - Use Git LFS for large binary files
   - Consider using `.gitignore` to prevent adding large files

4. **"Push rejected due to commit format"**
   - Ensure commits follow conventional format
   - Use `git commit --amend` to fix the last commit
   - For older commits, use interactive rebase

### Force Push Recovery
If someone accidentally force-pushed:
1. Find the previous HEAD: `git reflog`
2. Create recovery branch: `git branch recovery-branch <previous-sha>`
3. Compare and merge necessary changes

### Push Hooks Failing
If pre-push hooks are failing:
1. Run tests locally to identify issues
2. Check hook output for specific errors
3. Temporarily bypass with `--no-verify` (use cautiously)

## Related Rules
- [git-add-safety](git-add-safety.md) - Safe staging practices
- [git-commit-format](git-commit-format.md) - Proper commit messages
- [git-pull-strategy](git-pull-strategy.md) - Staying synchronized

## References
- [Git Push Documentation](https://git-scm.com/docs/git-push)
- [GitHub Protected Branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/defining-the-mergeability-of-pull-requests/about-protected-branches)
- [Git Push Best Practices](https://about.gitlab.com/topics/version-control/version-control-best-practices/)