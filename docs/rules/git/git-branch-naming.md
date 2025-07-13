# Git Branch Naming - Documentation

📚 **Rule Definition**: [.claude/rules/git/git-branch-naming.md](../../../.claude/rules/git/git-branch-naming.md)

## ID: git/git-branch-naming
## Status: Active
## Security Level: Low
## Token Impact: ~40 tokens per branch operation

## Description
Enforces consistent branch naming conventions using the pattern `<type>/<feature-name>-<base-version>`. This enables better collaboration, clear purpose identification, and traceable branch history.

## Rule Definition
```yaml
trigger: ["git branch", "git checkout -b"]
conditions:
  - command_contains: ["branch", "checkout -b"]
actions:
  - enforce_naming_pattern: true
  - auto_append_base_version: true
  - validate_branch_name: true
  - use_template: ".claude/templates/branch-name.template"
validations:
  - pattern: "^(feature|fix|docs|refactor|test|chore)/.+-[a-f0-9]{7}$"
  - allowed_types:
      - feature    # New functionality
      - fix        # Bug fixes
      - docs       # Documentation
      - refactor   # Code refactoring
      - test       # Test additions
      - chore      # Maintenance
  - lowercase_only: true
  - use_hyphens: true  # not underscores
  - include_base_commit: true
```

## Rationale
Structured branch names provide:
- Clear purpose identification
- Easy filtering and searching
- Traceable origin (base version)
- Consistent collaboration patterns
- Automated workflow integration
- Better branch organization

## Examples

### ✅ Good: Feature branch with base version
```bash
# Creating a new feature branch
git checkout -b feature/user-authentication-ad87b9f

# Another example
git checkout -b feature/payment-integration-b8964e0
```

### ✅ Good: Bug fix branch
```bash
# Fix branch from current main
git checkout -b fix/login-timeout-error-ad87b9f

# Fix for specific issue
git checkout -b fix/invoice-calculation-ad87b9f
```

### ✅ Good: Other branch types
```bash
# Documentation update
git checkout -b docs/api-endpoints-ad87b9f

# Refactoring branch
git checkout -b refactor/database-queries-ad87b9f

# Test additions
git checkout -b test/user-service-coverage-ad87b9f
```

### ❌ Bad: Non-conforming names
```bash
# DON'T use these patterns
git checkout -b myfeature              # No type or version
git checkout -b feature_new_thing      # Underscores not hyphens
git checkout -b FEATURE/SOMETHING      # Uppercase
git checkout -b feature/cool          # No base version
git checkout -b wip/stuff             # Invalid type
```

## Naming Pattern Breakdown

### Format: `<type>/<description>-<base-version>`

1. **Type**: Category of work
   - `feature/` - New functionality
   - `fix/` - Bug fixes
   - `docs/` - Documentation only
   - `refactor/` - Code restructuring
   - `test/` - Test additions/changes
   - `chore/` - Maintenance tasks

2. **Description**: Kebab-case description
   - Use hyphens, not underscores
   - Keep it concise but descriptive
   - All lowercase
   - No special characters

3. **Base Version**: Short commit hash
   - 7 characters from base commit
   - Indicates branch starting point
   - Helps track branch age

## Common Scenarios

### Creating feature from main
```bash
# Get latest main
git checkout main
git pull --rebase

# Create feature branch
BASE=$(git rev-parse --short HEAD)
git checkout -b feature/shopping-cart-$BASE
```

### Creating fix from specific commit
```bash
# From specific commit
git checkout abc123f
BASE=$(git rev-parse --short HEAD)
git checkout -b fix/security-patch-$BASE
```

### Branching from another feature
```bash
# From another feature branch
git checkout feature/payment-integration-b8964e0
BASE=$(git rev-parse --short HEAD)
git checkout -b feature/payment-refunds-$BASE
```

## Automation Helper

### Bash function for branch creation
```bash
# Add to your .bashrc or .zshrc
create-branch() {
    TYPE=$1
    NAME=$2
    BASE=$(git rev-parse --short HEAD)
    
    if [[ -z "$TYPE" || -z "$NAME" ]]; then
        echo "Usage: create-branch <type> <name>"
        echo "Types: feature, fix, docs, refactor, test, chore"
        return 1
    fi
    
    BRANCH="$TYPE/$NAME-$BASE"
    git checkout -b "$BRANCH"
}

# Usage
create-branch feature user-authentication
create-branch fix login-error
```

## Branch Type Guidelines

| Type | Use When | Example |
|------|----------|---------|
| **feature** | Adding new functionality | `feature/export-pdf-ad87b9f` |
| **fix** | Fixing bugs | `fix/memory-leak-ad87b9f` |
| **docs** | Documentation only | `docs/setup-guide-ad87b9f` |
| **refactor** | Restructuring code | `refactor/api-cleanup-ad87b9f` |
| **test** | Adding/fixing tests | `test/integration-suite-ad87b9f` |
| **chore** | Maintenance tasks | `chore/update-deps-ad87b9f` |

## Best Practices

1. **Keep descriptions clear** - Others should understand the purpose
2. **Update base version** - Always use current HEAD commit
3. **Delete after merging** - Keep branch list clean
4. **Use lowercase** - Consistency across team
5. **Be specific** - `fix/user-login-error` not `fix/bug`

## Branch Lifecycle

### Creation to deletion
```bash
# 1. Create branch
git checkout -b feature/new-dashboard-ad87b9f

# 2. Work on feature
git add .
git commit -m "feat: implement new dashboard"

# 3. Push to remote
git push -u origin feature/new-dashboard-ad87b9f

# 4. After PR merge, delete local
git branch -d feature/new-dashboard-ad87b9f

# 5. Delete remote
git push origin --delete feature/new-dashboard-ad87b9f
```

## Viewing and Managing Branches

### List branches by pattern
```bash
# All feature branches
git branch -a | grep "feature/"

# All fix branches
git branch -a | grep "fix/"

# Branches from specific base
git branch -a | grep "ad87b9f$"
```

### Clean up old branches
```bash
# Delete merged branches
git branch --merged | grep -v main | xargs -n 1 git branch -d

# Find old branches (>30 days)
git for-each-ref --format='%(refname:short) %(committerdate)' refs/heads/ | awk '$2 < "'$(date -d '30 days ago' '+%Y-%m-%d')'"'
```

## Troubleshooting

### Common Issues

1. **"Branch name doesn't match pattern"**
   - Ensure format is `type/description-hash`
   - Check that type is one of: feature, fix, docs, refactor, test, chore
   - Verify the hash is 7 characters of valid commit SHA
   - Use only lowercase and hyphens

2. **"Cannot create branch: already exists"**
   - Check if branch exists locally: `git branch -a | grep branch-name`
   - Delete old branch if needed: `git branch -D old-branch`
   - Or use a different description

3. **"Base version hash is invalid"**
   - Ensure you're using short hash: `git rev-parse --short HEAD`
   - The hash should be from an existing commit
   - Don't manually type hashes - use the automation helper

4. **"Template not found"**
   - The branch name template should exist at `.claude/templates/branch-name.template`
   - This template provides the pattern for consistent naming

### Branch Naming Conflicts
If branch name already exists:
1. Add more specificity: `feature/user-auth-login-ad87b9f`
2. Include issue number: `feature/user-auth-123-ad87b9f`
3. Check if old branch can be deleted

### Finding Base Commit
To find where a branch was created from:
```bash
# Show the base commit of a branch
git merge-base main feature/something-ad87b9f
```

## Related Rules
- [git-commit-format](git-commit-format.md) - Commit message standards
- [git-push-validation](git-push-validation.md) - Pushing branches
- [git-pull-strategy](git-pull-strategy.md) - Updating branches

## References
- [Git Branch Documentation](https://git-scm.com/docs/git-branch)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Git Branching Best Practices](https://nvie.com/posts/a-successful-git-branching-model/)

---

📚 **Rule Definition**: [.claude/rules/git/git-branch-naming.md](../../../.claude/rules/git/git-branch-naming.md)