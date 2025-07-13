# Rule: Test File Location

## Instructions

### Rule Metadata
- ID: project/test-file-location
- Status: Active
- Security Level: Low
- Token Impact: ~20 tokens per operation

### Rule Configuration
```yaml
trigger: ["create test", "write test", "new test file"]
conditions:
  - file_pattern: "*test*.py"
  - file_pattern: "*test*.js"
  - file_pattern: "*test*.ts"
  - file_pattern: "*spec*.js"
  - file_pattern: "*spec*.ts"
actions:
  - enforce_directory: "tests/"
  - suggest_structure: "mirror_source"
  - create_directory_if_missing: true
validations:
  - no_test_files_in_root: true
  - proper_naming_convention: true
```

---

📚 **Full Documentation**: [docs/rules/project/test-file-location.md](../../../docs/rules/project/test-file-location.md)