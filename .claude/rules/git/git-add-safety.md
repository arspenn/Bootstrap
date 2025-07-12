# Rule: Git Add Safety

## ID: git/git-add-safety
## Status: Active
## Security Level: High
## Token Impact: ~50 tokens per git add operation

## Description
Ensures safe file staging practices to prevent accidental commits of sensitive data, large files, or unintended changes. This rule enforces explicit file selection and pre-staging review.

## Rule Definition
```yaml
trigger: "git add"
conditions:
  - command_contains: ["add", "stage"]
actions:
  - require_status_check: true
  - forbid_commands: ["git add .", "git add -A", "git add --all"]
  - require_explicit_paths: true
  - check_file_patterns:
      - "*.env"
      - "*.key"
      - "*.pem"
      - "*_secret*"
      - "*password*"
validations:
  - max_file_size: 10MB
  - warn_on_binary: true
  - require_diff_review: true
```

## Rationale
Bulk staging commands like `git add .` can accidentally include:
- Environment files with secrets
- Large binary files
- Temporary or build artifacts
- Private keys or credentials
- Files meant to remain local

Requiring explicit paths ensures intentional staging decisions.

## Examples

### ✅ Good: Explicit file staging
```bash
# Review changes first
git status
git diff src/utils.py

# Stage specific files
git add src/utils.py
git add tests/test_utils.py
git add docs/utils.md
```

### ✅ Good: Staging with patterns (explicit)
```bash
# Stage specific file types in a directory
git add src/*.py
git add tests/test_*.py
```

### ❌ Bad: Bulk staging without review
```bash
# DON'T DO THIS - stages everything
git add .
git add -A
git add --all

# DON'T DO THIS - might include secrets
git add *.env
```

### ❌ Bad: Staging sensitive files
```bash
# DON'T stage these files
git add .env
git add private.key
git add config/secrets.yaml
```

## Best Practices

1. **Always run `git status` first** to see what files have changed
2. **Review changes with `git diff`** before staging
3. **Stage files individually or with specific patterns**
4. **Use `.gitignore`** for files that should never be staged
5. **Double-check before staging configuration files**

## Common Scenarios

### Staging multiple related files
```bash
# Good: Stage related files together but explicitly
git add src/feature.py tests/test_feature.py docs/feature.md
```

### Staging after code review
```bash
# Good: Review then stage
git diff src/
git add src/module1.py src/module2.py
```

### Handling accidental staging
```bash
# If you accidentally staged a file
git reset HEAD sensitive_file.env
```

## Related Rules
- [git-commit-format](git-commit-format.md) - What happens after staging
- [git-push-validation](git-push-validation.md) - Final safety check before pushing

## References
- [Git Add Documentation](https://git-scm.com/docs/git-add)
- [Git Best Practices](https://about.gitlab.com/topics/version-control/version-control-best-practices/)
- [.gitignore Documentation](https://git-scm.com/docs/gitignore)