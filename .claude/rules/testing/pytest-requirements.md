# Rule: Pytest Requirements

## Instructions

### Rule Metadata
- ID: testing/pytest-requirements
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 600
- Dependencies: ["project/test-file-location", "python/environment-management"]

### Rule Configuration
```yaml
trigger: ["new feature", "function creation", "class creation", "bug fix", "logic change"]
conditions:
  - testable_code: true
  - new_functionality: true
  - existing_logic_modified: true
actions:
  - create_test_file: true
  - use_pytest: true
  - follow_test_pattern: true
  - include_test_cases: ["happy_path", "edge_case", "error_case"]
  - update_existing_tests: true
validations:
  - test_file_exists: true
  - test_cases_complete: true
  - pytest_compatible: true
  - proper_assertions: true
  - fixtures_used: true
patterns:
  test_naming: "test_{function_name}"
  file_location: "tests/"
  file_naming: "test_{module_name}.py"
  class_naming: "Test{ClassName}"
requirements:
  min_test_cases: 3
  coverage_target: 80
  test_types:
    - happy_path: "Normal expected usage"
    - edge_case: "Boundary conditions"
    - error_case: "Exception handling"
```

### Test Requirements
- Always create pytest tests for new features
- Update tests when modifying existing logic
- Tests live in /tests folder mirroring structure
- Include three types of tests minimum
- Use descriptive test names
- Leverage pytest fixtures

---

📚 **Full Documentation**: [.claude/docs/rules/testing/pytest-requirements.md](../../docs/rules/testing/pytest-requirements.md)