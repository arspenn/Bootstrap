# Git Pull Strategy - Documentation

**Rule Reference:** `.claude/rules/git/git-pull-strategy.md`

## ID: git/git-pull-strategy
## Status: Active
## Security Level: Medium
## Token Impact: ~60 tokens per pull operation

## Description
Defines strategies for pulling changes from remote repositories, prioritizing rebase for cleaner history, conflict detection, and safe integration of remote changes. Recommends fetch-before-pull pattern.

## Rule Definition
```yaml
trigger: "git pull"
conditions:
  - command_contains: ["pull", "fetch"]
actions:
  - recommend_fetch_first: true
  - prefer_rebase: true
  - detect_conflicts_early: true
  - preserve_local_changes: true
validations:
  - check_working_directory: clean
  - verify_current_branch: true
  - conflict_resolution_strategy: manual
  - default_strategy: "--rebase"
  - protect_uncommitted_changes: true
```

## Rationale
Pull strategy affects:
- Commit history cleanliness
- Merge conflict handling
- Collaboration efficiency
- Local work preservation
- Repository timeline clarity

Rebase creates linear history without merge commits for feature branches.

## Examples

### ✅ Good: Fetch then pull with rebase
```bash
# First, see what's changed
git fetch origin
git log HEAD..origin/main --oneline

# Then pull with rebase
git pull --rebase origin main
```

### ✅ Good: Pull current branch with rebase
```bash
# For current branch
git pull --rebase

# Or configure as default
git config pull.rebase true
```

### ✅ Good: Stash before pull if needed
```bash
# If you have uncommitted changes
git stash
git pull --rebase
git stash pop
```

### ❌ Bad: Pull without checking state
```bash
# DON'T pull blindly
git pull  # might create unnecessary merge commits
```

### ❌ Bad: Pull with uncommitted changes
```bash
# DON'T pull with dirty working directory
# (uncommitted changes)
git pull --rebase  # will fail or cause problems
```

## Pull Strategies

### Rebase Strategy (Recommended for feature branches)
```bash
# Creates linear history
git pull --rebase origin main

# Equivalent to:
git fetch origin
git rebase origin/main
```

### Merge Strategy (For integration branches)
```bash
# Creates merge commit
git pull --no-rebase origin main

# Equivalent to:
git fetch origin
git merge origin/main
```

### Fast-Forward Only
```bash
# Only pull if fast-forward possible
git pull --ff-only origin main
```

## Common Scenarios

### Daily workflow update
```bash
# Start of day routine
git fetch --all
git status
git pull --rebase origin main
```

### Handling conflicts during rebase
```bash
git pull --rebase origin main
# CONFLICT (content): Merge conflict in file.py

# Resolve conflict in editor
git add file.py
git rebase --continue

# Or abort if needed
git rebase --abort
```

### Pulling specific branch
```bash
# Pull different branch
git fetch origin
git checkout feature-branch
git pull --rebase origin feature-branch
```

### Updating multiple branches
```bash
# Update main
git checkout main
git pull --rebase

# Update feature branch
git checkout feature-branch
git pull --rebase origin main
```

## Best Practices

1. **Always fetch before pull** - See what's coming
2. **Use rebase for feature branches** - Keep history clean
3. **Commit or stash before pulling** - Protect local work
4. **Pull frequently** - Avoid large conflicts
5. **Understand the changes** - Review before integrating

## Configuration Tips

### Set rebase as default
```bash
# For all pulls
git config --global pull.rebase true

# For specific repository
git config pull.rebase true
```

### Auto-stash during rebase
```bash
# Automatically stash/unstash during rebase
git config --global rebase.autoStash true
```

### Fetch prune configuration
```bash
# Remove deleted remote branches
git config --global fetch.prune true
```

## Conflict Resolution

### During rebase conflicts
```bash
# 1. Fix conflicts in files
# 2. Stage resolved files
git add <resolved-files>

# 3. Continue rebase
git rebase --continue

# Or skip the problematic commit
git rebase --skip

# Or abort entirely
git rebase --abort
```

### Viewing conflicts
```bash
# See conflict markers
git diff --name-only --diff-filter=U

# See detailed conflict
git diff
```

## Safety Patterns

### Check before pulling
```bash
# What's on remote?
git fetch
git log HEAD..origin/main --oneline

# What would change?
git diff HEAD...origin/main --stat
```

### Backup before risky pull
```bash
# Create backup branch
git branch backup-$(date +%Y%m%d)

# Then pull
git pull --rebase origin main
```

## Troubleshooting

### Common Issues

1. **"Cannot pull with rebase: You have unstaged changes"**
   - Commit your changes: `git commit -am "WIP"`
   - Or stash them: `git stash`
   - Then try pulling again

2. **"Merge conflict during rebase"**
   - Edit conflicted files to resolve
   - Stage resolved files: `git add <files>`
   - Continue: `git rebase --continue`
   - Or abort: `git rebase --abort`

3. **"Divergent branches and cannot fast-forward"**
   - Use `git pull --rebase` to rebase your changes
   - Or `git pull --no-rebase` to create a merge commit
   - Consider your team's workflow preferences

4. **"Automatic merge failed"**
   - Resolve conflicts manually in your editor
   - Look for conflict markers: `<<<<<<<`, `=======`, `>>>>>>>`
   - Choose the correct version or combine changes

### Rebase vs Merge Decision
- **Use rebase for**:
  - Feature branches
  - Keeping linear history
  - Before pushing to shared branch
  
- **Use merge for**:
  - Integration branches (main, develop)
  - Preserving branch context
  - When history clarity is important

### Recovery Options
If pull goes wrong:
1. Check reflog: `git reflog`
2. Reset to previous state: `git reset --hard HEAD@{1}`
3. Or create recovery branch from reflog

## Related Rules
- [git-push-validation](git-push-validation.md) - Pushing after pull
- [git-branch-naming](git-branch-naming.md) - Branch management
- [git-commit-format](git-commit-format.md) - Commit standards

## References
- [Git Pull Documentation](https://git-scm.com/docs/git-pull)
- [Git Rebase Documentation](https://git-scm.com/docs/git-rebase)
- [Merging vs Rebasing](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)