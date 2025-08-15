# Git Rule: Add Safety

## Overview
Prevents accidental addition of sensitive files to Git staging area and enforces explicit file selection for better commit hygiene.

## Trigger Conditions
- Command contains `git add` or `git stage`
- Any file staging operation

## Actions

### What the Rule Does
1. Checks Git status before operations
2. Validates file patterns against forbidden list
3. Checks file size limits
4. Warns about binary files
5. Blocks wildcard operations

### Configuration Options
| Setting | Default | Config Path | Description |
|---------|---------|-------------|-------------|
| max_file_size | 10MB | git.max_file_size | Maximum file size allowed |
| forbidden_patterns | [*.env,*.key,*.pem,*_secret*,*password*] | git.forbidden_patterns | Patterns to block |
| warn_on_binary | true | git.warn_on_binary | Warn when adding binary files |

## Examples

### Good Practices
```bash
# ✅ Explicit file addition
git add src/main.py
git add README.md docs/

# ✅ Review before staging
git status
git diff src/main.py
git add src/main.py
```

### Prevented Patterns
```bash
# ❌ Blocked operations
git add .              # Too broad
git add -A             # Adds everything
git add *.env          # Sensitive file
git add large_file.zip # Over size limit
```

## Troubleshooting

### Common Issues
- **Issue**: "File too large" error
  - **Solution**: Check file size with `ls -lh filename`
  - Consider using Git LFS for large files
  - Add to .gitignore if not needed in repo

- **Issue**: "Forbidden pattern" error
  - **Solution**: File matches sensitive pattern
  - Use .gitignore for permanent exclusion
  - Override with explicit path if intentional

- **Issue**: "Binary file warning"
  - **Solution**: Binary files detected
  - Verify file is intended for repository
  - Consider alternatives like Git LFS

## Security Considerations
- Prevents secrets from entering repository
- Reduces risk of credential exposure
- Enforces deliberate file selection
- Protects against accidental data leaks

## Related Rules
- [git-commit-format](git-commit-format.md) - Commit message standards
- [git-push-validation](git-push-validation.md) - Push safety checks
- [git-safe-file-operations](git-safe-file-operations.md) - File operation safety