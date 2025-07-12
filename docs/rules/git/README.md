# Git Rules Documentation

This directory contains comprehensive documentation for all Git control rules used by Claude.

## Rule Documentation Files

- [Git Add Safety](git-add-safety.md) - Safe file staging practices
- [Git Commit Format](git-commit-format.md) - Conventional Commits standard
- [Git Push Validation](git-push-validation.md) - Pre-push safety checks
- [Git Pull Strategy](git-pull-strategy.md) - Safe branch synchronization
- [Git Branch Naming](git-branch-naming.md) - Branch naming conventions

## Structure

Each documentation file contains:
- **Overview** - Purpose and benefits of the rule
- **Rationale** - Why the rule exists and what problems it solves
- **Examples** - Good and bad practices with code samples
- **Best Practices** - Recommended approaches
- **Common Scenarios** - Real-world usage patterns
- **Troubleshooting** - Solutions to common issues
- **References** - Links to relevant documentation

## Rule Files

The actual rule instructions that Claude imports are located in:
`.claude/rules/git/`

These instruction files are kept minimal (~500-800 bytes) for efficient token usage, while this documentation provides comprehensive guidance for users.

## User Guide

This guide explains how Git control rules work in Claude Code and how to configure them for your workflow.

## Overview

Git control rules provide automated guidance and safety checks for Git operations. They ensure consistent practices, prevent common mistakes, and maintain high-quality version control standards.

## Quick Start

Git control rules are active by default. When you use Git commands, Claude Code will:

1. Check applicable rules before executing
2. Provide warnings for unsafe operations
3. Suggest best practices
4. Format commits and branches consistently

### Example Workflow

```bash
# Claude Code ensures safe staging
git add src/feature.py  # ✓ Explicit file - allowed
git add .              # ✗ Bulk staging - prevented

# Commit with enforced format
git commit -m "feat(auth): add login functionality"  # ✓ Conventional format

# Safe pushing with validation
git push origin feature/login-ad87b9f  # ✓ After validation checks
```

## Active Rules

### 1. Git Add Safety (`git-add-safety`)
**Purpose**: Prevents accidental staging of sensitive or unwanted files

**Key Behaviors**:
- Blocks `git add .` and `git add -A`
- Requires explicit file paths
- Warns about sensitive file patterns (`.env`, `*.key`)
- Checks file size limits

**Configuration**:
```yaml
git:
  rules:
    git-add-safety: enabled  # or disabled
```

### 2. Git Commit Format (`git-commit-format`)
**Purpose**: Enforces Conventional Commits standard

**Format**: `<type>(<scope>): <subject>`

**Valid Types**:
- `feat` - New features
- `fix` - Bug fixes
- `docs` - Documentation
- `style` - Formatting
- `refactor` - Code restructuring
- `test` - Test changes
- `chore` - Maintenance
- `perf` - Performance
- `ci` - CI/CD changes
- `build` - Build changes

**Example**:
```bash
git commit -m "fix(api): resolve timeout in user endpoint

Increased connection timeout from 30s to 60s for large
datasets. Added retry logic for transient failures.

Fixes #123"
```

### 3. Git Push Validation (`git-push-validation`)
**Purpose**: Validates pushes to prevent repository issues

**Checks**:
- Remote repository state
- Branch protection rules
- File size limits
- Force push prevention on protected branches

**Protected Branches**:
- `main`, `master`
- `develop`
- `release/*`

### 4. Git Pull Strategy (`git-pull-strategy`)
**Purpose**: Maintains clean history with smart pull strategies

**Default Behavior**:
- Recommends fetch before pull
- Uses rebase for feature branches
- Detects and warns about conflicts
- Protects uncommitted changes

**Configuration**:
```yaml
git:
  config:
    pull_strategy:
      default: rebase  # or merge, ff-only
      auto_stash: true
```

### 5. Git Branch Naming (`git-branch-naming`)
**Purpose**: Standardizes branch names for clarity

**Format**: `<type>/<description>-<base-version>`

**Example**: `feature/user-auth-ad87b9f`

**Valid Types**:
- `feature` - New functionality
- `fix` - Bug fixes
- `docs` - Documentation
- `refactor` - Refactoring
- `test` - Test changes
- `chore` - Maintenance

## Configuration

### Enabling/Disabling Rules

Edit `.claude/rules/config/user-preferences.yaml`:

```yaml
git:
  rules:
    git-add-safety: disabled      # Disable specific rule
    git-commit-format: enabled    # Keep enabled
```

### Customizing Rule Behavior

```yaml
git:
  config:
    commit_format:
      max_subject_length: 100    # Override default 250
    
    branch_naming:
      allowed_types:
        - feature
        - bugfix              # Add custom type
        - hotfix
```

### Global Settings

```yaml
global:
  strict_mode: true          # Fail on rule violations
  log_conflicts: true        # Log rule conflicts
```

## Common Scenarios

### Starting a New Feature

```bash
# 1. Create branch with proper naming
git checkout main
git pull --rebase
BASE=$(git rev-parse --short HEAD)
git checkout -b feature/shopping-cart-$BASE

# 2. Make changes and stage safely
git add src/cart.py src/models/item.py
git add tests/test_cart.py

# 3. Commit with conventional format
git commit -m "feat(cart): implement shopping cart functionality

- Add Cart and CartItem models
- Implement add/remove item methods
- Add quantity validation
- Include unit tests

Part of e-commerce feature set"

# 4. Push with validation
git push -u origin feature/shopping-cart-$BASE
```

### Fixing a Bug

```bash
# 1. Create fix branch
git checkout -b fix/login-error-$(git rev-parse --short HEAD)

# 2. Make fix and stage
git add src/auth/login.py

# 3. Commit with clear message
git commit -m "fix(auth): correct login validation error

Username field was not being trimmed, causing authentication
failures for users with accidental spaces.

Fixes #456"

# 4. Push for review
git push origin fix/login-error-ad87b9f
```

### Handling Rule Warnings

When a rule prevents an action:

```bash
$ git add .
⚠️  Git Add Safety Rule: Bulk staging prevented
   Use explicit file paths instead:
   git add <file1> <file2>
   
   Files detected:
   - src/feature.py (modified)
   - tests/test_feature.py (new)
   - .env (WARNING: sensitive file)
```

### Overriding Rules (When Necessary)

To temporarily bypass a rule:

1. Disable in user preferences
2. Perform the operation
3. Re-enable the rule

```yaml
# Temporarily in user-preferences.yaml
git:
  rules:
    git-add-safety: disabled  # Temporary override
```

## Troubleshooting

### Rules Not Being Applied

1. Check if rule is enabled:
   ```bash
   cat .claude/rules/config/user-preferences.yaml
   ```

2. Verify rule file exists:
   ```bash
   ls .claude/rules/git/
   ```

3. Check CLAUDE.md has Git rules section:
   ```bash
   grep "Git Control Rules" CLAUDE.md
   ```

### Commit Message Rejected

Ensure format follows:
- Type is valid (feat, fix, docs, etc.)
- Subject is under 250 characters
- No capital first letter
- No period at end

### Branch Creation Failed

Verify:
- Type is allowed (feature, fix, etc.)
- Description uses hyphens, not underscores
- Includes base version hash
- All lowercase

### Conflicts Between Rules

Check `.claude/rules/config/conflict-log.md` for:
- Recorded conflicts
- Resolution decisions
- Patterns to report

## Best Practices

1. **Review Before Staging**: Always check `git status` and `git diff`
2. **Commit Often**: Small, focused commits are easier to review
3. **Pull Frequently**: Stay synchronized to avoid conflicts
4. **Use Templates**: Leverage commit and branch templates
5. **Configure for Your Workflow**: Adjust preferences as needed

## Advanced Configuration

### Custom Branch Types

Add new types in user preferences:
```yaml
branch_naming:
  allowed_types:
    - feature
    - fix
    - experiment    # Custom type
    - spike         # Custom type
```

### Commit Message Templates

Create custom templates in `.claude/templates/`:
```bash
cp .claude/templates/commit-message.template .claude/templates/my-commit.template
# Edit as needed
```

### Integration with CI/CD

Rules work with CI/CD by ensuring:
- Consistent commit messages for changelog generation
- Predictable branch names for automation
- Clean history for easier debugging

## Getting Help

- **Rule Documentation**: `.claude/rules/git/[rule-name].md`
- **Navigation Guide**: `.claude/rules/README.md`
- **Design Decisions**: `docs/ADRs/`
- **Git Documentation**: https://git-scm.com/docs

## Future Enhancements

Planned additions:
- Conflict resolution strategies
- Tag management rules
- GitHub-specific features
- Team collaboration patterns
- CI/CD integration rules

## Feedback

To report issues or suggest improvements:
1. Create detailed description in TASK.md
2. Note specific rule and scenario
3. Include error messages if applicable
4. Suggest desired behavior

Remember: These rules are designed to help, not hinder. Configure them to match your team's workflow while maintaining code quality and safety.