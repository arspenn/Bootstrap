# Python Code Style Rule Documentation

## Overview

The `python/code-style` rule enforces consistent Python coding standards across the project using PEP8 guidelines, type hints, Black formatting, and Pydantic for data validation. This rule ensures all Python code follows industry best practices and maintains high readability and maintainability standards.

## Rule Definition

```yaml
- ID: python/code-style
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 600
- Dependencies: ["python/environment-management"]
```

## Rationale

Enforcing consistent code style provides:
- **Readability**: Consistent formatting makes code easier to read
- **Maintainability**: Standard patterns reduce cognitive load
- **Type Safety**: Type hints catch errors early
- **Team Collaboration**: Everyone follows the same standards
- **Tool Integration**: Automated formatting and validation

## When This Rule Triggers

The rule activates when:
1. Creating new Python files
2. Editing existing Python code
3. Performing code reviews
4. Running validation checks

## PEP8 Key Guidelines

### Naming Conventions
```python
# ✅ Good
class UserAccount:      # CapWords for classes
    MAX_RETRIES = 3     # UPPER_CASE for constants
    
    def get_user_name(self):  # snake_case for functions
        user_age = 25          # snake_case for variables
        return "John"

# ❌ Bad
class user_account:     # Wrong: should be CapWords
    maxRetries = 3       # Wrong: should be UPPER_CASE
    
    def GetUserName(self):  # Wrong: should be snake_case
        UserAge = 25         # Wrong: should be snake_case
```

### Line Length and Indentation
```python
# ✅ Good: 88 characters max (Black default)
def process_user_data(
    user_id: int,
    include_metadata: bool = False
) -> Dict[str, Any]:
    """Process user data with optional metadata."""
    return {"id": user_id, "metadata": include_metadata}

# ❌ Bad: Line too long
def process_user_data(user_id: int, include_metadata: bool = False, additional_param: str = "default") -> Dict[str, Any]:
    return {"id": user_id, "metadata": include_metadata}
```

## Type Hints Examples

### Basic Type Hints
```python
from typing import List, Dict, Optional, Union, Any

# ✅ Good: Complete type hints
def calculate_total(
    prices: List[float],
    tax_rate: float = 0.1
) -> float:
    """Calculate total with tax."""
    subtotal = sum(prices)
    return subtotal * (1 + tax_rate)

def find_user(
    user_id: int
) -> Optional[Dict[str, Any]]:
    """Find user by ID, returns None if not found."""
    # Implementation here
    return None

# ❌ Bad: Missing type hints
def calculate_total(prices, tax_rate=0.1):
    subtotal = sum(prices)
    return subtotal * (1 + tax_rate)
```

### Advanced Type Hints
```python
from typing import TypeVar, Generic, Callable, Protocol

T = TypeVar('T')

class Repository(Generic[T]):
    """Generic repository pattern."""
    
    def get(self, id: int) -> Optional[T]:
        """Get entity by ID."""
        pass
    
    def save(self, entity: T) -> T:
        """Save entity."""
        pass

# Protocol for duck typing
class Drawable(Protocol):
    def draw(self) -> None: ...

def render(items: List[Drawable]) -> None:
    for item in items:
        item.draw()
```

## Black Formatting

### Configuration (pyproject.toml)
```toml
[tool.black]
line-length = 88
target-version = ['py38', 'py39', 'py310', 'py311']
include = '\.pyi?$'
extend-exclude = '''
/(
  | migrations
  | .venv
  | venv_linux
)/
'''
```

### Before and After Black
```python
# Before Black
x = {  'a':37,'b':42,
'c':927}
y = 'hello ''world'
z = 'hello '+'world'
a = 'hello {}'.format('world')

# After Black
x = {"a": 37, "b": 42, "c": 927}
y = "hello " "world"
z = "hello " + "world"
a = "hello {}".format("world")
```

## Pydantic Models

### Basic Model
```python
from pydantic import BaseModel, Field, validator
from typing import Optional, List
from datetime import datetime

class User(BaseModel):
    """User model with validation."""
    
    id: int
    username: str = Field(..., min_length=3, max_length=20)
    email: str = Field(..., regex=r'^[\w\.-]+@[\w\.-]+\.\w+$')
    age: Optional[int] = Field(None, ge=0, le=120)
    created_at: datetime = Field(default_factory=datetime.now)
    tags: List[str] = []
    
    @validator('username')
    def username_alphanumeric(cls, v):
        assert v.isalnum(), 'must be alphanumeric'
        return v
    
    class Config:
        schema_extra = {
            "example": {
                "id": 1,
                "username": "johndoe",
                "email": "john@example.com",
                "age": 30,
                "tags": ["active", "premium"]
            }
        }
```

### Using Pydantic for API Validation
```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field

app = FastAPI()

class CreateUserRequest(BaseModel):
    username: str = Field(..., min_length=3, max_length=20)
    email: str
    password: str = Field(..., min_length=8)

class UserResponse(BaseModel):
    id: int
    username: str
    email: str
    
@app.post("/users", response_model=UserResponse)
async def create_user(user: CreateUserRequest) -> UserResponse:
    # Pydantic automatically validates the request
    # and response data
    return UserResponse(
        id=1,
        username=user.username,
        email=user.email
    )
```

## Import Organization

### Correct Import Order
```python
# ✅ Good: Proper import organization
# Standard library imports
import os
import sys
from datetime import datetime
from typing import List, Optional

# Related third party imports
import numpy as np
import pandas as pd
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

# Local application/library specific imports
from .models import User
from .utils import calculate_hash
from .constants import MAX_RETRIES

# ❌ Bad: Mixed import order
from .models import User
import os
from fastapi import FastAPI
import sys
from .utils import calculate_hash
import numpy as np
```

## Common Violations and Fixes

### Violation: Missing Type Hints
```python
# ❌ Bad
def process_data(data):
    return data * 2

# ✅ Good
def process_data(data: float) -> float:
    return data * 2
```

### Violation: Inconsistent Quotes
```python
# ❌ Bad
name = 'John'
message = "Hello world"

# ✅ Good (Black enforces double quotes)
name = "John"
message = "Hello world"
```

### Violation: No Data Validation
```python
# ❌ Bad
def create_user(data: dict):
    username = data.get('username')
    email = data.get('email')
    # No validation!

# ✅ Good
from pydantic import BaseModel

class UserData(BaseModel):
    username: str
    email: str

def create_user(data: UserData):
    # Data is automatically validated
    pass
```

## Integration with Tools

### Ruff Configuration (.ruff.toml)
```toml
select = ["E", "F", "I", "N", "W"]
ignore = ["E501"]  # Line length handled by Black
line-length = 88
target-version = "py38"

[per-file-ignores]
"__init__.py" = ["F401"]  # Allow unused imports in __init__ files
```

### Pre-commit Hooks (.pre-commit-config.yaml)
```yaml
repos:
  - repo: https://github.com/psf/black
    rev: 23.3.0
    hooks:
      - id: black
  
  - repo: https://github.com/charliermarsh/ruff-pre-commit
    rev: v0.0.270
    hooks:
      - id: ruff
        args: [--fix]
  
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.3.0
    hooks:
      - id: mypy
        additional_dependencies: [pydantic]
```

## Best Practices

1. **Always use type hints** for function signatures
2. **Run Black** before committing code
3. **Use Pydantic** for any data that crosses boundaries (API, database, files)
4. **Keep functions small** and focused (< 20 lines ideally)
5. **Write descriptive variable names** even if longer
6. **Group related imports** and sort them
7. **Use constants** for magic numbers and strings

## Configuration

```yaml
project:
  rules:
    python-code-style: enabled
  config:
    formatter: "black"
    linter: "ruff"
    type_checker: "mypy"
    line_length: 88
    enforce_type_hints: true
    require_pydantic: true
```

## Troubleshooting

### Issue: Black and IDE formatter conflict
**Solution**: Configure IDE to use Black or disable IDE formatting

### Issue: Type hints for third-party libraries
**Solution**: Install type stubs: `pip install types-requests`

### Issue: Pydantic validation too strict
**Solution**: Use `Optional` types and custom validators for flexibility

## Related Rules

- `python/environment-management`: Sets up Python environment
- `documentation/docstring-format`: Complements with documentation standards
- `testing/pytest-requirements`: Ensures tests follow same style

## Implementation Notes

This rule has priority 600 and depends on `python/environment-management` because:
1. The environment must be set up before enforcing style
2. Tools like Black and Ruff need to be installed
3. The virtual environment ensures consistent tool versions

The rule uses a token impact of ~30 because it needs to:
- Check file extensions and content
- Validate against multiple style rules
- Suggest corrections when violations are found

---

📚 **Rule Definition**: [.claude/rules/python/code-style.md](../../../.claude/rules/python/code-style.md)