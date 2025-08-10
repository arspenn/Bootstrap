# Rule: Python Code Style

## Instructions

### Rule Metadata
- ID: python/code-style
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 600
- Dependencies: ["python/environment-management"]

### Rule Configuration
```yaml
trigger: ["python file creation", "python file edit", "code review"]
conditions:
  - file_extension: [".py"]
  - language: "python"
actions:
  - enforce_pep8: true
  - require_type_hints: true
  - format_with_black: true
  - validate_with_ruff: true
  - use_pydantic: true
validations:
  - pep8_compliance: true
  - type_hints_present: true
  - black_formatted: true
  - imports_sorted: true
  - pydantic_models: true
tools:
  formatter: "black"
  linter: "ruff"
  type_checker: "mypy"
  validation: "pydantic"
standards:
  line_length: 88  # Black default
  quotes: "double"
  type_hints: "required for all public functions"
```

### Style Requirements
- Python is the primary language
- Follow PEP8 guidelines
- Use type hints for all functions
- Format with black
- Use pydantic for data validation
- Sort imports with isort

---

📚 **Full Documentation**: [docs/rules/python/code-style.md](../../../docs/rules/python/code-style.md)