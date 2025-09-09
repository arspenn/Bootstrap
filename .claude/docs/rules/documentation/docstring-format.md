# Docstring Format Rule Documentation

## Overview

The `documentation/docstring-format` rule enforces Google-style docstrings for all Python functions, classes, and modules. This ensures consistent, comprehensive documentation that can be processed by tools like Sphinx and provides clear guidance for developers using the code.

## Rule Definition

```yaml
- ID: documentation/docstring-format
- Status: Active
- Security Level: Low
- Token Impact: ~25 tokens per operation
- Priority: 500
- Dependencies: ["python/code-style"]
```

## Rationale

Proper docstrings provide:
- **API Documentation**: Clear understanding of function interfaces
- **IDE Support**: Better autocomplete and hover documentation
- **Automated Docs**: Can generate documentation with Sphinx
- **Maintainability**: Future developers understand intent
- **Type Information**: Complements type hints with descriptions

## When This Rule Triggers

The rule activates when:
1. Creating new functions or methods
2. Defining classes
3. Creating modules
4. Writing generators or coroutines
5. Defining properties

## Google Style Format

### Function Docstring Template
```python
def function_name(param1: str, param2: int = 0) -> Dict[str, Any]:
    """
    Brief summary of what the function does.
    
    More detailed explanation of the function's behavior,
    edge cases, and any important notes.
    
    Args:
        param1: Description of param1.
        param2: Description of param2. Defaults to 0.
    
    Returns:
        Description of the return value.
    
    Raises:
        ValueError: When param1 is empty.
        TypeError: When param2 is not an integer.
    
    Example:
        >>> result = function_name("test", 42)
        >>> print(result)
        {'status': 'success', 'value': 42}
    """
    pass
```

### Class Docstring Template
```python
class MyClass:
    """
    Brief summary of the class.
    
    Longer description of the class purpose and usage.
    
    Attributes:
        attribute1: Description of attribute1.
        attribute2: Description of attribute2.
    
    Example:
        >>> obj = MyClass()
        >>> obj.method()
        'result'
    """
    
    def __init__(self, param1: str):
        """
        Initialize MyClass.
        
        Args:
            param1: Description of param1.
        """
        self.attribute1 = param1
        self.attribute2 = 0
```

### Module Docstring Template
```python
"""
Module brief description.

This module provides functionality for [purpose].
It includes [key features/components].

Classes:
    MyClass: Brief description of MyClass.
    AnotherClass: Brief description of AnotherClass.

Functions:
    main_function: Brief description of main_function.
    helper_function: Brief description of helper_function.

Example:
    Basic usage of the module:
    
    >>> from mymodule import MyClass
    >>> obj = MyClass()
    >>> obj.process()
"""
```

## Docstring Sections

### Required Sections

#### Args Section
```python
def calculate(price: float, tax_rate: float = 0.1) -> float:
    """
    Calculate total price with tax.
    
    Args:
        price: Base price before tax.
        tax_rate: Tax rate as decimal. Defaults to 0.1 (10%).
    
    Returns:
        Total price including tax.
    """
    return price * (1 + tax_rate)
```

#### Returns Section
```python
def get_user_data(user_id: int) -> Dict[str, Any]:
    """
    Retrieve user data from database.
    
    Args:
        user_id: Unique identifier for the user.
    
    Returns:
        Dictionary containing user information with keys:
        - 'id': User ID
        - 'name': User's full name
        - 'email': User's email address
        - 'created_at': Account creation timestamp
    """
    pass
```

#### Raises Section
```python
def validate_email(email: str) -> str:
    """
    Validate and normalize email address.
    
    Args:
        email: Email address to validate.
    
    Returns:
        Normalized email address.
    
    Raises:
        ValueError: If email format is invalid.
        TypeError: If email is not a string.
    """
    if not isinstance(email, str):
        raise TypeError("Email must be a string")
    if "@" not in email:
        raise ValueError("Invalid email format")
    return email.lower().strip()
```

### Optional Sections

#### Example Section
```python
def fibonacci(n: int) -> List[int]:
    """
    Generate Fibonacci sequence.
    
    Args:
        n: Number of Fibonacci numbers to generate.
    
    Returns:
        List of first n Fibonacci numbers.
    
    Example:
        >>> fibonacci(5)
        [0, 1, 1, 2, 3]
        
        >>> fibonacci(10)
        [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
    """
    pass
```

#### Note Section
```python
def process_data(data: List[float]) -> float:
    """
    Process data with statistical analysis.
    
    Args:
        data: List of numerical values.
    
    Returns:
        Processed result.
    
    Note:
        This function uses numpy for calculations and requires
        at least 10 data points for statistical significance.
        Empty lists will return 0.0.
    """
    pass
```

#### Yields Section (for generators)
```python
def read_large_file(filepath: str) -> Generator[str, None, None]:
    """
    Read large file line by line.
    
    Args:
        filepath: Path to the file to read.
    
    Yields:
        One line from the file at a time.
    
    Example:
        >>> for line in read_large_file("data.txt"):
        ...     process(line)
    """
    with open(filepath) as f:
        for line in f:
            yield line.strip()
```

## Special Cases

### Property Docstrings
```python
class Person:
    @property
    def age(self) -> int:
        """Get the person's age in years."""
        return self._age
    
    @age.setter
    def age(self, value: int) -> None:
        """
        Set the person's age.
        
        Args:
            value: Age in years, must be non-negative.
        
        Raises:
            ValueError: If age is negative.
        """
        if value < 0:
            raise ValueError("Age cannot be negative")
        self._age = value
```

### Async Function Docstrings
```python
async def fetch_data(url: str) -> Dict[str, Any]:
    """
    Asynchronously fetch data from URL.
    
    Args:
        url: The URL to fetch data from.
    
    Returns:
        JSON response as dictionary.
    
    Raises:
        aiohttp.ClientError: If request fails.
    
    Example:
        >>> data = await fetch_data("https://api.example.com")
        >>> print(data["status"])
        'success'
    """
    pass
```

### Context Manager Docstrings
```python
class DatabaseConnection:
    """
    Context manager for database connections.
    
    Example:
        >>> with DatabaseConnection() as conn:
        ...     conn.execute("SELECT * FROM users")
    """
    
    def __enter__(self):
        """
        Open database connection.
        
        Returns:
            Database connection object.
        """
        pass
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        """
        Close database connection.
        
        Args:
            exc_type: Exception type if error occurred.
            exc_val: Exception value if error occurred.
            exc_tb: Exception traceback if error occurred.
        
        Returns:
            False to propagate any exception.
        """
        pass
```

## Common Mistakes and Fixes

### Mistake: Missing Type Information
```python
# ❌ Bad
def calculate(price, tax):
    """
    Calculate total.
    
    Args:
        price: The price.
        tax: The tax.
    """
    pass

# ✅ Good
def calculate(price: float, tax: float) -> float:
    """
    Calculate total price with tax.
    
    Args:
        price: Base price in dollars.
        tax: Tax rate as decimal (e.g., 0.1 for 10%).
    
    Returns:
        Total price including tax.
    """
    pass
```

### Mistake: Vague Descriptions
```python
# ❌ Bad
def process(data):
    """Process the data."""
    pass

# ✅ Good
def process(data: List[Dict]) -> pd.DataFrame:
    """
    Process user activity data for analysis.
    
    Converts raw user activity logs into a structured
    DataFrame suitable for statistical analysis.
    
    Args:
        data: List of activity dictionaries with keys:
            - 'user_id': Unique user identifier
            - 'action': Action performed
            - 'timestamp': When action occurred
    
    Returns:
        DataFrame with processed activity metrics.
    """
    pass
```

### Mistake: Missing Edge Cases
```python
# ❌ Bad
def divide(a: float, b: float) -> float:
    """
    Divide a by b.
    
    Args:
        a: Numerator.
        b: Denominator.
    
    Returns:
        Result of division.
    """
    return a / b

# ✅ Good
def divide(a: float, b: float) -> float:
    """
    Divide a by b.
    
    Args:
        a: Numerator.
        b: Denominator, must be non-zero.
    
    Returns:
        Result of division.
    
    Raises:
        ZeroDivisionError: If b is zero.
        TypeError: If inputs are not numeric.
    """
    if b == 0:
        raise ZeroDivisionError("Cannot divide by zero")
    return a / b
```

## Sphinx Integration

### Napoleon Extension Configuration
```python
# conf.py
extensions = [
    'sphinx.ext.napoleon',
    'sphinx.ext.autodoc',
    'sphinx.ext.viewcode',
]

napoleon_google_docstring = True
napoleon_numpy_docstring = False
napoleon_include_init_with_doc = True
napoleon_include_private_with_doc = False
```

### Building Documentation
```bash
# Install Sphinx
pip install sphinx sphinx-rtd-theme

# Generate docs
sphinx-apidoc -o docs/api src/
sphinx-build -b html docs/ docs/_build/
```

## Best Practices

1. **First line is a summary** - Keep it under 79 characters
2. **Use imperative mood** - "Return" not "Returns" in summary
3. **Document all parameters** - Even if they seem obvious
4. **Include types** - In both docstring and type hints
5. **Add examples** - For complex functions
6. **Document exceptions** - All exceptions that can be raised
7. **Keep it updated** - Update docstrings when code changes

## Configuration

```yaml
project:
  rules:
    documentation-docstring-format: enabled
  config:
    style: "google"  # or "numpy", "sphinx"
    require_docstrings: true
    check_completeness: true
    min_function_length: 1  # Require docstrings even for one-liners
    enforce_sections: ["Args", "Returns", "Raises"]
```

## Related Rules

- `python/code-style`: Provides the Python context for docstrings
- `testing/pytest-requirements`: Test docstrings can include test examples
- `project/code-structure`: Module-level docstrings describe structure

## Implementation Notes

This rule has priority 500 because:
1. It's important but not critical for code execution
2. Depends on Python code style being established first
3. Should be applied during code creation, not after
4. Enhances but doesn't block functionality

The dependency on `python/code-style` ensures:
- Python syntax is valid before documenting
- Type hints are in place to reference
- Code structure is established

---

📚 **Rule Definition**: [.claude/rules/documentation/docstring-format.md](../../../.claude/rules/documentation/docstring-format.md)