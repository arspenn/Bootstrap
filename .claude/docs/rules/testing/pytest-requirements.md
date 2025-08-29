# Pytest Requirements Rule Documentation

## Overview

The `testing/pytest-requirements` rule enforces comprehensive testing practices using pytest for all new features and code modifications. This rule ensures that code is thoroughly tested with multiple test scenarios, follows consistent naming patterns, and maintains high code coverage.

## Rule Definition

```yaml
- ID: testing/pytest-requirements
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 600
- Dependencies: ["project/test-file-location", "python/environment-management"]
```

## Rationale

Comprehensive testing provides:
- **Reliability**: Catch bugs before production
- **Confidence**: Safe refactoring with test coverage
- **Documentation**: Tests show how code should be used
- **Regression Prevention**: Ensure fixes stay fixed
- **Quality Metrics**: Coverage shows untested code

## When This Rule Triggers

The rule activates when:
1. Creating new functions or classes
2. Adding new features
3. Fixing bugs
4. Modifying existing logic
5. Refactoring code

## Test Structure Requirements

### Minimum Test Cases
Every testable unit must have at least three test cases:

1. **Happy Path**: Normal, expected usage
2. **Edge Case**: Boundary conditions and limits
3. **Error Case**: Exception handling and invalid inputs

### Example Test Structure
```python
import pytest
from mymodule import calculate_discount

class TestCalculateDiscount:
    """Test suite for calculate_discount function."""
    
    def test_calculate_discount_happy_path(self):
        """Test normal discount calculation."""
        # Happy path: normal usage
        result = calculate_discount(100, 0.1)
        assert result == 90
        
    def test_calculate_discount_edge_cases(self):
        """Test boundary conditions."""
        # Edge case: zero discount
        assert calculate_discount(100, 0) == 100
        
        # Edge case: 100% discount
        assert calculate_discount(100, 1.0) == 0
        
        # Edge case: zero price
        assert calculate_discount(0, 0.5) == 0
    
    def test_calculate_discount_error_cases(self):
        """Test error handling."""
        # Error case: negative price
        with pytest.raises(ValueError, match="Price cannot be negative"):
            calculate_discount(-100, 0.1)
        
        # Error case: invalid discount
        with pytest.raises(ValueError, match="Discount must be between 0 and 1"):
            calculate_discount(100, 1.5)
```

## Pytest Best Practices

### Test Naming Conventions
```python
# ✅ Good test names - descriptive and specific
def test_user_creation_with_valid_email():
    pass

def test_user_creation_fails_with_duplicate_email():
    pass

def test_calculate_total_includes_tax():
    pass

# ❌ Bad test names - vague or unclear
def test_user():
    pass

def test_1():
    pass

def test_function():
    pass
```

### Using Fixtures
```python
import pytest
from datetime import datetime

@pytest.fixture
def sample_user():
    """Provide a sample user for testing."""
    return {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "created_at": datetime.now()
    }

@pytest.fixture
def database_connection():
    """Provide database connection for tests."""
    conn = create_connection()
    yield conn  # This runs the test
    conn.close()  # This runs after the test

def test_user_save(sample_user, database_connection):
    """Test saving user to database."""
    result = save_user(database_connection, sample_user)
    assert result["status"] == "success"
    assert result["user_id"] == 1
```

### Parametrized Tests
```python
import pytest

@pytest.mark.parametrize("input_value,expected", [
    (0, 0),
    (1, 1),
    (2, 4),
    (3, 9),
    (-2, 4),
])
def test_square_function(input_value, expected):
    """Test square function with multiple inputs."""
    assert square(input_value) == expected

@pytest.mark.parametrize("email,is_valid", [
    ("user@example.com", True),
    ("user.name@example.co.uk", True),
    ("invalid.email", False),
    ("@example.com", False),
    ("user@", False),
    ("", False),
])
def test_email_validation(email, is_valid):
    """Test email validation with various formats."""
    if is_valid:
        assert validate_email(email) == email.lower()
    else:
        with pytest.raises(ValueError):
            validate_email(email)
```

### Mocking and Patching
```python
from unittest.mock import Mock, patch
import pytest

def test_api_call_success():
    """Test successful API call."""
    # Create mock response
    mock_response = Mock()
    mock_response.status_code = 200
    mock_response.json.return_value = {"status": "success"}
    
    with patch("requests.get", return_value=mock_response):
        result = fetch_data("https://api.example.com")
        assert result["status"] == "success"

def test_api_call_failure():
    """Test API call failure handling."""
    with patch("requests.get", side_effect=ConnectionError("Network error")):
        with pytest.raises(ConnectionError):
            fetch_data("https://api.example.com")

@patch("mymodule.datetime")
def test_with_fixed_time(mock_datetime):
    """Test with controlled time."""
    mock_datetime.now.return_value = datetime(2024, 1, 1, 12, 0, 0)
    result = get_current_timestamp()
    assert result == "2024-01-01 12:00:00"
```

## Test Organization

### Directory Structure
```
project/
├── src/
│   ├── models/
│   │   ├── user.py
│   │   └── product.py
│   ├── services/
│   │   ├── auth.py
│   │   └── payment.py
│   └── utils/
│       └── validators.py
└── tests/
    ├── conftest.py         # Shared fixtures
    ├── models/
    │   ├── test_user.py
    │   └── test_product.py
    ├── services/
    │   ├── test_auth.py
    │   └── test_payment.py
    └── utils/
        └── test_validators.py
```

### conftest.py for Shared Fixtures
```python
# tests/conftest.py
import pytest
from pathlib import Path
import tempfile

@pytest.fixture(scope="session")
def test_data_dir():
    """Provide test data directory."""
    return Path(__file__).parent / "data"

@pytest.fixture
def temp_dir():
    """Provide temporary directory for test files."""
    with tempfile.TemporaryDirectory() as tmpdir:
        yield Path(tmpdir)

@pytest.fixture(autouse=True)
def reset_database():
    """Reset database before each test."""
    setup_test_database()
    yield
    cleanup_test_database()
```

## Testing Patterns

### Testing Exceptions
```python
import pytest

def test_division_by_zero():
    """Test that division by zero raises appropriate error."""
    with pytest.raises(ZeroDivisionError) as exc_info:
        divide(10, 0)
    
    # Can also check the error message
    assert "division by zero" in str(exc_info.value)

def test_invalid_input_type():
    """Test type validation."""
    with pytest.raises(TypeError, match="Expected int, got str"):
        process_number("not a number")
```

### Testing Async Functions
```python
import pytest
import asyncio

@pytest.mark.asyncio
async def test_async_function():
    """Test asynchronous function."""
    result = await fetch_async_data()
    assert result["status"] == "complete"

@pytest.mark.asyncio
async def test_concurrent_requests():
    """Test multiple concurrent requests."""
    tasks = [fetch_async_data(i) for i in range(5)]
    results = await asyncio.gather(*tasks)
    assert len(results) == 5
    assert all(r["status"] == "complete" for r in results)
```

### Testing with Temporary Files
```python
import pytest
from pathlib import Path

def test_file_processing(tmp_path):
    """Test file processing with temporary files."""
    # Create temp file
    test_file = tmp_path / "test.txt"
    test_file.write_text("test content")
    
    # Process file
    result = process_file(test_file)
    
    # Check results
    assert result["lines"] == 1
    assert result["words"] == 2
    
    # Temp directory is automatically cleaned up

def test_csv_export(tmp_path):
    """Test CSV export functionality."""
    output_file = tmp_path / "output.csv"
    
    data = [{"name": "John", "age": 30}]
    export_to_csv(data, output_file)
    
    assert output_file.exists()
    content = output_file.read_text()
    assert "name,age" in content
    assert "John,30" in content
```

## Coverage Requirements

### Running Tests with Coverage
```bash
# Run tests with coverage report
pytest --cov=src --cov-report=html --cov-report=term

# Run with minimum coverage requirement
pytest --cov=src --cov-fail-under=80

# Generate coverage badge
pytest --cov=src --cov-report=term --cov-report=html
coverage-badge -o coverage.svg
```

### Coverage Configuration (pyproject.toml)
```toml
[tool.coverage.run]
source = ["src"]
omit = ["*/tests/*", "*/test_*.py"]

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "raise AssertionError",
    "raise NotImplementedError",
    "if __name__ == .__main__.:",
    "if TYPE_CHECKING:",
]
precision = 2
skip_covered = false
show_missing = true
```

## Marks and Test Selection

### Common Pytest Marks
```python
import pytest

@pytest.mark.slow
def test_complex_calculation():
    """Test that takes a long time."""
    result = complex_algorithm(large_dataset)
    assert result.is_valid()

@pytest.mark.integration
def test_database_integration():
    """Test requiring database connection."""
    with database_connection() as conn:
        result = query_users(conn)
        assert len(result) > 0

@pytest.mark.skip(reason="Feature not implemented yet")
def test_future_feature():
    """Test for upcoming feature."""
    pass

@pytest.mark.skipif(sys.platform == "win32", reason="Not supported on Windows")
def test_unix_only_feature():
    """Test Unix-specific functionality."""
    pass

@pytest.mark.xfail(reason="Known bug, see issue #123")
def test_known_issue():
    """Test that currently fails but should pass."""
    assert broken_function() == "expected"
```

### Running Specific Tests
```bash
# Run only slow tests
pytest -m slow

# Run all except slow tests
pytest -m "not slow"

# Run specific test file
pytest tests/test_user.py

# Run specific test
pytest tests/test_user.py::test_user_creation

# Run tests matching pattern
pytest -k "user and not delete"
```

## Common Testing Patterns

### Setup and Teardown
```python
class TestDatabase:
    """Test database operations."""
    
    def setup_method(self):
        """Run before each test method."""
        self.conn = create_test_database()
        self.test_data = load_test_data()
    
    def teardown_method(self):
        """Run after each test method."""
        self.conn.close()
        cleanup_test_database()
    
    def test_insert_user(self):
        """Test user insertion."""
        user = self.test_data["user"]
        result = insert_user(self.conn, user)
        assert result["id"] > 0
```

### Testing Private Methods
```python
class Calculator:
    def _validate_input(self, value):
        """Private method to validate input."""
        if not isinstance(value, (int, float)):
            raise TypeError("Input must be numeric")
    
    def calculate(self, value):
        """Public method using private validation."""
        self._validate_input(value)
        return value * 2

# Test private method indirectly through public interface
def test_calculator_validates_input():
    """Test that calculator validates input types."""
    calc = Calculator()
    
    # Valid input
    assert calc.calculate(5) == 10
    
    # Invalid input triggers private validation
    with pytest.raises(TypeError):
        calc.calculate("not a number")
```

## Best Practices

1. **Test behavior, not implementation** - Focus on what, not how
2. **One assertion per test** - Or related assertions testing one concept
3. **Use descriptive names** - Test names should explain what they test
4. **Keep tests independent** - Tests shouldn't depend on each other
5. **Use fixtures for setup** - Don't repeat setup code
6. **Mock external dependencies** - Tests should be fast and reliable
7. **Test edge cases** - Empty lists, None values, boundary conditions

## Configuration

```yaml
project:
  rules:
    testing-pytest-requirements: enabled
  config:
    min_test_cases: 3
    coverage_target: 80
    test_location: "tests/"
    require_docstrings: true
    enforce_marks: ["slow", "integration"]
```

## Related Rules

- `project/test-file-location`: Determines where test files are placed
- `python/environment-management`: Ensures pytest is installed in venv
- `documentation/docstring-format`: Test functions need docstrings too

## Implementation Notes

This rule has priority 600 and depends on:
1. `project/test-file-location`: To know where to create tests
2. `python/environment-management`: To ensure pytest is available

The rule enforces testing discipline by:
- Requiring minimum test coverage
- Ensuring multiple test scenarios
- Following consistent patterns
- Maintaining test organization

---

📚 **Rule Definition**: [.claude/rules/testing/pytest-requirements.md](../../../.claude/rules/testing/pytest-requirements.md)