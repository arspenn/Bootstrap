# Test File Location Rule Documentation

## Overview

The `test-file-location` rule ensures that all test files are created in the appropriate `tests/` directory rather than cluttering the project root or being scattered throughout the codebase.

## Rationale

Organizing test files properly:
- **Maintains Clean Structure**: Keeps project root uncluttered
- **Improves Discovery**: Tests are easy to find and run
- **Enables Patterns**: CI/CD can reliably find all tests
- **Follows Standards**: Most frameworks expect tests in specific locations

## When This Rule Triggers

The rule activates when:
1. Creating files with test patterns (`*test*.py`, `*spec*.js`)
2. Using test-related commands or descriptions
3. Writing test code

## Examples

### Example 1: Creating Python Test
```bash
# Instead of:
$ claude create test_git_rules.py  # ❌ Would create in root

# The rule suggests:
$ claude create tests/test_git_rules.py  # ✅ Proper location
```

### Example 2: Mirroring Source Structure
```
# Source file: src/utils/validator.py
# Test file:   tests/utils/test_validator.py

# Source file: lib/components/Button.tsx  
# Test file:   tests/components/Button.spec.tsx
```

## Best Practices

1. **Mirror source structure** in tests directory
2. **Use consistent naming**: `test_*.py` or `*.spec.js`
3. **Group related tests** in subdirectories
4. **Keep test utilities** in `tests/helpers/` or `tests/fixtures/`

## Configuration

```yaml
project:
  rules:
    test-file-location: enabled
  config:
    test_directory: "tests/"  # Can customize
    mirror_structure: true    # Mirror source layout
    test_patterns:           # Additional patterns
      - "*_test.go"
      - "*.test.tsx"
```

---

📚 **Rule Definition**: [.claude/rules/project/test-file-location.md](../../../.claude/rules/project/test-file-location.md)