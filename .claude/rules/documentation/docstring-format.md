# Rule: Docstring Format

## Instructions

### Rule Metadata
- ID: documentation/docstring-format
- Status: Active
- Security Level: Low
- Token Impact: ~25 tokens per operation
- Priority: 500
- Dependencies: ["python/code-style"]

### Rule Configuration
```yaml
trigger: ["function creation", "class creation", "method creation", "module creation"]
conditions:
  - python_code: true
  - callable_object: true
  - new_definition: true
actions:
  - require_docstring: true
  - enforce_google_style: true
  - validate_format: true
  - check_completeness: true
validations:
  - docstring_present: true
  - google_format_compliance: true
  - summary_line_present: true
  - args_documented: true
  - returns_documented: true
  - raises_documented: true
exceptions:
  - private_methods: false  # Still require docstrings
  - magic_methods: ["__init__", "__str__", "__repr__"]  # Optional
  - property_getters: true  # Brief docstring OK
template: |
  """
  Brief summary in imperative mood.
  
  Longer description if needed, explaining the purpose
  and any important details.
  
  Args:
      param1 (type): Description of param1.
      param2 (type, optional): Description of param2. Defaults to None.
  
  Returns:
      type: Description of return value.
  
  Raises:
      ValueError: When invalid input provided.
      KeyError: When required key missing.
  
  Example:
      >>> result = function_name(arg1, arg2)
      >>> print(result)
      expected_output
  """
```

### Docstring Requirements
- Every function must have a docstring
- Use Google style format
- Document all parameters and returns
- Include type information
- Add examples for complex functions

---

📚 **Full Documentation**: [.claude/docs/rules/documentation/docstring-format.md](../../docs/rules/documentation/docstring-format.md)