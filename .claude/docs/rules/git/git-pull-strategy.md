# Git Rule: Pull Strategy

## Overview
Defines strategies for pulling changes from remote repositories, prioritizing rebase for cleaner history, conflict detection, and safe integration of remote changes.

## Trigger Conditions
- Command contains `git pull` or `git fetch`
- Any pull/fetch operation

## Actions

### What the Rule Does
1. Recommends fetch before pull
2. Prefers rebase strategy for clean history
3. Detects conflicts early
4. Protects uncommitted changes
5. Ensures clean working directory

### Configuration Options
| Setting | Default | Config Path | Description |
|---------|---------|-------------|-------------|
| prefer_rebase | true | git.prefer_rebase | Use rebase strategy by default |
| check_working_directory | clean | git.check_working_directory | Require clean working dir |
| conflict_resolution_strategy | manual | git.conflict_resolution_strategy | How to handle conflicts |
| default_pull_strategy | --rebase | git.default_pull_strategy | Default pull strategy |

## Examples

### Good Practices
```bash
# ✅ Fetch then pull with rebase
git fetch origin
git log HEAD..origin/main --oneline
git pull --rebase origin main

# ✅ Stash before pull if needed
git stash
git pull --rebase
git stash pop

# ✅ Configure rebase as default
git config pull.rebase true
```

### Prevented Patterns
```bash
# ❌ Pull without checking state
git pull  # might create unnecessary merge commits

# ❌ Pull with uncommitted changes
git pull --rebase  # will fail with dirty working directory

# ❌ Pull without understanding changes
git pull --force  # dangerous
```

## Pull Strategies

### Rebase Strategy (Recommended)
- Creates linear history
- No merge commits for feature branches
- Cleaner project timeline

### Merge Strategy
- Preserves branch context
- For integration branches
- Shows collaboration points

### Fast-Forward Only
- Only pulls if no divergence
- Safest but most restrictive
- Good for automated systems

## Troubleshooting

### Common Issues
- **Issue**: "Cannot pull with rebase: unstaged changes"
  - **Solution**: Commit or stash changes first
  - Use `git stash` then pull
  - Or commit with `git commit -am "WIP"`

- **Issue**: "Merge conflict during rebase"
  - **Solution**: Resolve conflicts in editor
  - Stage resolved files
  - Continue with `git rebase --continue`

- **Issue**: "Divergent branches"
  - **Solution**: Choose rebase or merge strategy
  - Consider team workflow
  - Use `--rebase` or `--no-rebase`

## Security Considerations
- Protects local work from being lost
- Prevents accidental merge commits
- Maintains clean commit history
- Early conflict detection saves time

## Related Rules
- [git-push-validation](git-push-validation.md) - Pushing after pull
- [git-branch-naming](git-branch-naming.md) - Branch management
- [git-commit-format](git-commit-format.md) - Commit standards