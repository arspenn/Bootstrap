# Git Rule: Branch Naming

## Overview
Enforces consistent branch naming conventions using the pattern `{type}/{description}-{commit-hash}` for better collaboration and clear purpose identification.

## Trigger Conditions
- Commands containing `git branch` or `git checkout -b`
- Any branch creation operation

## Actions

### What the Rule Does
1. Enforces naming pattern validation
2. Auto-appends base commit hash
3. Validates branch type prefix
4. Ensures lowercase with hyphens
5. Uses branch name template

### Configuration Options
| Setting | Default | Config Path | Description |
|---------|---------|-------------|-------------|
| branch_pattern | ^(feature\|fix\|docs\|refactor\|test\|chore)/.+-[a-f0-9]{7}$ | git.branch_pattern | Branch naming pattern |
| allowed_types | [feature,fix,docs,refactor,test,chore] | git.allowed_types | Allowed branch type prefixes |

## Examples

### Good Practices
```bash
# ✅ Feature branch with base version
git checkout -b feature/user-authentication-ad87b9f

# ✅ Bug fix branch
git checkout -b fix/login-timeout-error-b8964e0

# ✅ Documentation branch
git checkout -b docs/api-endpoints-c7d23f1
```

### Prevented Patterns
```bash
# ❌ Non-conforming names
git checkout -b myfeature              # No type or version
git checkout -b feature_new_thing      # Underscores not hyphens
git checkout -b FEATURE/SOMETHING      # Uppercase
git checkout -b feature/cool           # No base version
git checkout -b wip/stuff              # Invalid type
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

## Automation Helper

```bash
# Add to .bashrc or .zshrc
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
```

## Troubleshooting

### Common Issues
- **Issue**: "Branch name doesn't match pattern"
  - **Solution**: Use format `type/description-hash`
  - Check type is allowed (feature, fix, etc.)
  - Ensure 7-char commit hash at end

- **Issue**: "Branch already exists"
  - **Solution**: Add more specificity to name
  - Include issue number if applicable
  - Delete old branch if unused

- **Issue**: "Invalid branch type"
  - **Solution**: Use allowed types only
  - Update config to add custom types
  - Follow team conventions

## Security Considerations
- Clear branch purposes aid code review
- Traceable branch origins via commit hash
- Consistent naming prevents confusion
- Easy branch cleanup and management

## Related Rules
- [git-commit-format](git-commit-format.md) - Commit message standards
- [git-push-validation](git-push-validation.md) - Pushing branches
- [git-pull-strategy](git-pull-strategy.md) - Updating branches