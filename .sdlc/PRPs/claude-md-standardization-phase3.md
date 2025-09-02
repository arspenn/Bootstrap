name: "CLAUDE.md Standardization - Phase 3: Language Rules Migration"
description: |

## Purpose
Extract and migrate Python-specific, documentation, and testing rules from CLAUDE.md into standardized format files with enhanced metadata. This is Phase 3 of 4 for the CLAUDE.md standardization project.

## Core Principles
1. **Language Specificity**: Rules for Python development practices
2. **Quality Standards**: Documentation and testing requirements
3. **Dependencies**: Some rules depend on others
4. **Comprehensive Docs**: Full documentation for each rule
5. **Global rules**: Follow all rules in CLAUDE.md

---

## Goal
Extract four language/quality rules from CLAUDE.md:
- `python/code-style.md` - PEP8, black, type hints
- `python/environment-management.md` - venv_linux usage
- `documentation/docstring-format.md` - Google-style docstrings
- `testing/pytest-requirements.md` - Test creation standards

## Why
- **Development Standards**: Ensures consistent Python development
- **Quality Enforcement**: Documentation and testing are mandatory
- **Dependency Chain**: Code style depends on environment setup
- **Mid-Priority Rules**: 500-600 range for appropriate precedence

## What
Four rules covering Python practices, documentation standards, and testing requirements.

### Success Criteria
- [ ] Four language/quality rules extracted from CLAUDE.md
- [ ] Each rule has appropriate priority and dependencies
- [ ] Full documentation created for each rule
- [ ] MASTER_IMPORTS.md updated with new sections
- [ ] Tests pass for Phase 3
- [ ] Dependencies properly configured

## Prerequisites
- [ ] Phase 1 and 2 completed
- [ ] Python, documentation, and testing directories exist
- [ ] Test infrastructure in place

## All Needed Context

### Documentation & References
```yaml
- file: /home/arspenn/Dev/Bootstrap/CLAUDE.md
  why: Source file containing rules to extract
  sections:
    - "Style & Conventions" (lines 36-55)
    - "Testing & Reliability" (lines 23-30)
    - "Use venv_linux" (line 10)
    - "Use python_dotenv" (line 21)
    
- file: /home/arspenn/Dev/Bootstrap/docs/patterns/enhanced-rule-metadata.md
  why: Enhanced metadata pattern from Phase 1
  
- file: /home/arspenn/Dev/Bootstrap/.claude/rules/project/code-structure.md
  why: Example from Phase 2 with enhanced metadata
  
- url: https://www.python.org/dev/peps/pep-0008/
  why: PEP8 style guide reference
  
- url: https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings
  why: Google docstring format specification
  
- url: https://docs.pytest.org/en/stable/
  why: Pytest documentation for testing standards
  
- url: https://github.com/psf/black
  why: Black formatter documentation
```

### Rules to Extract from CLAUDE.md

#### 1. Python Code Style (lines 37-39)
```markdown
- **Use Python** as the primary language
- **Follow PEP8**, use type hints, and format with `black`
- **Use `pydantic` for data validation**
```

#### 2. Environment Management (lines 10, 21)
```markdown
- **Use venv_linux** (the virtual environment) whenever executing Python commands
- **Use python_dotenv and load_env()** for environment variables
```

#### 3. Docstring Format (lines 43-55)
```markdown
- Write **docstrings for every function** using the Google style:
  ```python
  def example():
      """
      Brief summary.

      Args:
          param1 (type): Description.

      Returns:
          type: Description.
      """
  ```
```

#### 4. Testing Requirements (lines 23-30)
```markdown
- **Always create Pytest unit tests for new features**
- **After updating any logic**, check whether existing unit tests need to be updated
- **Tests should live in a `/tests` folder** mirroring the main app structure
  - Include at least:
    - 1 test for expected use
    - 1 edge case
    - 1 failure case
```

## Implementation Blueprint

### Task 1: Create python/code-style.md
CREATE .claude/rules/python/code-style.md:
```markdown
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

📚 **Full Documentation**: [.claude/docs/rules/python/code-style.md](../../../.claude/docs/rules/python/code-style.md)
```

CREATE .claude/docs/rules/python/code-style.md:
[Full documentation including:
- PEP8 key points
- Type hint examples
- Black configuration
- Pydantic model examples
- Good/bad code examples
- Integration with ruff and mypy]

### Task 2: Create python/environment-management.md
CREATE .claude/rules/python/environment-management.md:
```markdown
# Rule: Python Environment Management

## Instructions

### Rule Metadata
- ID: python/environment-management
- Status: Active
- Security Level: Medium
- Token Impact: ~20 tokens per operation
- Priority: 700
- Dependencies: []

### Rule Configuration
```yaml
trigger: ["python execution", "pip install", "environment setup", "script run"]
conditions:
  - python_command: true
  - requires_environment: true
actions:
  - use_virtual_env: "venv_linux"
  - load_dotenv: true
  - check_requirements: true
  - verify_env_active: true
validations:
  - virtual_env_active: true
  - dependencies_installed: true
  - env_vars_loaded: true
  - python_version_correct: true
environment:
  default_venv: "venv_linux"
  activation: "source venv_linux/bin/activate"
  dotenv_module: "python-dotenv"
  env_file: ".env"
commands:
  install: "pip install -r requirements.txt"
  freeze: "pip freeze > requirements.txt"
  activate: "source venv_linux/bin/activate"
```

### Environment Usage
- Always use venv_linux for Python commands
- Load environment variables with python-dotenv
- Check requirements.txt before imports
- Never use system Python directly

---

📚 **Full Documentation**: [.claude/docs/rules/python/environment-management.md](../../../.claude/docs/rules/python/environment-management.md)
```

CREATE .claude/docs/rules/python/environment-management.md:
[Full documentation including:
- Virtual environment best practices
- python-dotenv usage examples
- Environment variable patterns
- Troubleshooting activation issues
- Requirements.txt management]

### Task 3: Create documentation/docstring-format.md
CREATE .claude/rules/documentation/docstring-format.md:
```markdown
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

📚 **Full Documentation**: [.claude/docs/rules/documentation/docstring-format.md](../../../.claude/docs/rules/documentation/docstring-format.md)
```

CREATE .claude/docs/rules/documentation/docstring-format.md:
[Full documentation including:
- Complete Google style guide
- Examples for different function types
- Class and module docstrings
- Property and generator docstrings
- Napoleon sphinx configuration]

### Task 4: Create testing/pytest-requirements.md
CREATE .claude/rules/testing/pytest-requirements.md:
```markdown
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

📚 **Full Documentation**: [.claude/docs/rules/testing/pytest-requirements.md](../../../.claude/docs/rules/testing/pytest-requirements.md)
```

CREATE .claude/docs/rules/testing/pytest-requirements.md:
[Full documentation including:
- Pytest best practices
- Test structure examples
- Fixture usage patterns
- Mocking strategies
- Parametrized test examples
- Coverage requirements]

### Task 5: Update MASTER_IMPORTS.md
EDIT .claude/MASTER_IMPORTS.md - Add new sections:
```markdown
## Python Rules
@.claude/rules/python/code-style.md
@.claude/rules/python/environment-management.md

## Documentation Rules
@.claude/rules/documentation/docstring-format.md

## Testing Rules
@.claude/rules/testing/pytest-requirements.md
```

### Task 6: Update Phase 3 Tests
EDIT tests/test_claude_md_standardization.py - Update Phase 3 tests:
```python
class TestPhase3LanguageRules:
    """Phase 3: Language Rules Migration Tests"""
    
    def test_python_rules_exist(self):
        """Test that Python rules are created with metadata."""
        root = get_project_root()
        
        # Check code-style rule
        code_style = root / ".claude/rules/python/code-style.md"
        assert code_style.exists()
        content = code_style.read_text()
        assert "Priority: 600" in content
        assert 'Dependencies: ["python/environment-management"]' in content
        
        # Check environment-management rule
        env_mgmt = root / ".claude/rules/python/environment-management.md"
        assert env_mgmt.exists()
        content = env_mgmt.read_text()
        assert "Priority: 700" in content
        assert "venv_linux" in content
    
    def test_documentation_rules_exist(self):
        """Test that documentation rules are created."""
        root = get_project_root()
        
        docstring = root / ".claude/rules/documentation/docstring-format.md"
        assert docstring.exists()
        content = docstring.read_text()
        assert "Priority: 500" in content
        assert 'Dependencies: ["python/code-style"]' in content
        assert "Google style" in content
    
    def test_testing_rules_exist(self):
        """Test that testing rules are created."""
        root = get_project_root()
        
        pytest_rule = root / ".claude/rules/testing/pytest-requirements.md"
        assert pytest_rule.exists()
        content = pytest_rule.read_text()
        assert "Priority: 600" in content
        assert "happy_path" in content
        assert "edge_case" in content
        assert "error_case" in content
    
    def test_all_phase3_docs_exist(self):
        """Test that all documentation files exist."""
        root = get_project_root()
        
        docs = [
            ".claude/docs/rules/python/code-style.md",
            ".claude/docs/rules/python/environment-management.md",
            ".claude/docs/rules/documentation/docstring-format.md",
            ".claude/docs/rules/testing/pytest-requirements.md"
        ]
        
        for doc_path in docs:
            doc_file = root / doc_path
            assert doc_file.exists(), f"{doc_path} not found"
    
    def test_master_imports_has_new_sections(self):
        """Test that MASTER_IMPORTS has new sections."""
        root = get_project_root()
        imports = root / ".claude/MASTER_IMPORTS.md"
        
        content = imports.read_text()
        assert "## Python Rules" in content
        assert "## Documentation Rules" in content
        assert "## Testing Rules" in content
        assert "@.claude/rules/python/code-style.md" in content
```

## Validation Loop

### Level 1: File Creation
```bash
# Verify Python rules
ls -la .claude/rules/python/code-style.md
ls -la .claude/rules/python/environment-management.md

# Verify other rules
ls -la .claude/rules/documentation/docstring-format.md
ls -la .claude/rules/testing/pytest-requirements.md

# Check documentation
ls -la .claude/docs/rules/python/
ls -la .claude/docs/rules/documentation/
ls -la .claude/docs/rules/testing/
```

### Level 2: Metadata and Dependencies
```bash
# Check priorities are correct
grep "Priority:" .claude/rules/python/*.md
grep "Priority:" .claude/rules/documentation/*.md
grep "Priority:" .claude/rules/testing/*.md

# Verify dependencies
grep "Dependencies:" .claude/rules/python/code-style.md
grep "Dependencies:" .claude/rules/documentation/docstring-format.md
grep "Dependencies:" .claude/rules/testing/pytest-requirements.md
```

### Level 3: Test Execution
```bash
# Run Phase 3 tests
pytest tests/test_claude_md_standardization.py::TestPhase3LanguageRules -v

# Ensure previous phases still pass
pytest tests/test_claude_md_standardization.py::TestPhase1Infrastructure -v
pytest tests/test_claude_md_standardization.py::TestPhase2CoreRules -v

# Run all tests
pytest tests/ -v
```

### Level 4: Import Sections
```bash
# Verify new sections in MASTER_IMPORTS
grep "## Python Rules" .claude/MASTER_IMPORTS.md
grep "## Documentation Rules" .claude/MASTER_IMPORTS.md
grep "## Testing Rules" .claude/MASTER_IMPORTS.md

# Check all imports present
grep "@.claude/rules/python" .claude/MASTER_IMPORTS.md | wc -l  # Should be 2
grep "@.claude/rules/documentation" .claude/MASTER_IMPORTS.md | wc -l  # Should be 1
grep "@.claude/rules/testing" .claude/MASTER_IMPORTS.md | wc -l  # Should be 1
```

## Final Validation Checklist
- [ ] Four language/quality rules created
- [ ] Each rule has appropriate priority (500-700 range)
- [ ] Dependencies correctly configured
- [ ] Documentation files created for all rules
- [ ] MASTER_IMPORTS.md has new sections
- [ ] Phase 3 tests pass
- [ ] All previous tests still pass

---

## Anti-Patterns to Avoid
- ❌ Don't forget dependencies between rules
- ❌ Don't mix rule categories (keep Python rules together)
- ❌ Don't skip creating new sections in MASTER_IMPORTS
- ❌ Don't remove from CLAUDE.md yet (Phase 4)

## Next Phase
After Phase 3 completion:
- Commit changes with message: "feat(rules): add Python, documentation, and testing rules"
- Proceed to Phase 4: Configuration and Finalization

## PRP Confidence Score: 9/10

High confidence because:
- Clear extraction from CLAUDE.md
- Well-defined dependencies
- Established patterns from previous phases
- External documentation references available