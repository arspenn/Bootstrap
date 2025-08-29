# Code Structure and Modularity Rule Documentation

## Overview

The `code-structure` rule enforces modular, maintainable code by limiting file size to 500 lines and establishing clear patterns for organizing code into logical modules. This rule is essential for preventing monolithic files and ensuring code remains readable and maintainable as projects grow.

## Rule Definition

```yaml
- ID: project/code-structure
- Status: Active
- Security Level: Low
- Token Impact: ~25 tokens per operation
- Priority: 700
- Dependencies: []
```

## Rationale

Enforcing code structure ensures:
- **Maintainability**: Smaller files are easier to understand and modify
- **Testability**: Modular code is easier to unit test
- **Collaboration**: Clear structure helps team members navigate code
- **Performance**: Smaller modules load and parse faster
- **Separation of Concerns**: Each module has a single, clear purpose

## When This Rule Triggers

The rule activates when:
1. Creating new Python, JavaScript, or TypeScript files
2. Editing files that approach or exceed 500 lines
3. Receiving explicit refactoring requests
4. Organizing agent or service code

## Examples

### Example 1: File Exceeding Line Limit
```python
# ❌ Bad: Single file with 750 lines
# app.py (750 lines)
class UserManager:
    # 200 lines of user management code
    
class ProductManager:
    # 250 lines of product code
    
class OrderProcessor:
    # 300 lines of order processing

# ✅ Good: Split into modules
# user_manager.py (200 lines)
class UserManager:
    # User management code

# product_manager.py (250 lines)  
class ProductManager:
    # Product code
    
# order_processor.py (300 lines)
class OrderProcessor:
    # Order processing code
```

### Example 2: Agent Structure Organization
```
# ✅ Correct agent structure:
agents/
  customer_service/
    agent.py      # Main agent definition (150 lines)
    tools.py      # Tool functions (200 lines)
    prompts.py    # System prompts (100 lines)
    
# ❌ Bad: Everything in one file
agents/
  customer_service.py  # 450 lines mixing everything
```

### Example 3: Import Style
```python
# ✅ Good: Relative imports within package
# In agents/customer_service/tools.py
from .prompts import SYSTEM_PROMPT
from .utils import format_response

# ❌ Bad: Absolute imports for internal modules
from agents.customer_service.prompts import SYSTEM_PROMPT
from agents.customer_service.utils import format_response
```

### Example 4: Environment Variables
```python
# ✅ Good: Using python-dotenv
from dotenv import load_dotenv
import os

load_dotenv()
API_KEY = os.getenv("API_KEY")

# ❌ Bad: Hardcoded values or direct os.environ
API_KEY = "sk-1234567890"  # Never hardcode!
API_KEY = os.environ["API_KEY"]  # May raise KeyError
```

## Module Organization Patterns

### Pattern 1: Feature-Based Organization
```
project/
  features/
    auth/
      __init__.py
      models.py      # < 500 lines
      views.py       # < 500 lines
      validators.py  # < 500 lines
      utils.py       # < 500 lines
    billing/
      __init__.py
      models.py
      processors.py
      webhooks.py
```

### Pattern 2: Layer-Based Organization
```
project/
  models/
    user.py
    product.py
    order.py
  services/
    user_service.py
    product_service.py
    order_service.py
  controllers/
    user_controller.py
    product_controller.py
```

### Pattern 3: Agent/Service Pattern
```
services/
  recommendation_agent/
    agent.py         # Core agent logic
    tools.py         # External tools/APIs
    prompts.py       # LLM prompts
    processors.py    # Data processors
    validators.py    # Input validation
    __init__.py      # Public interface
```

## Refactoring Strategies

### Strategy 1: Extract Classes
```python
# Before: large_file.py (600 lines)
class UserAuth:
    # 200 lines
    
class UserProfile:
    # 200 lines
    
class UserSettings:
    # 200 lines

# After refactoring:
# auth.py
class UserAuth:
    # 200 lines

# profile.py  
class UserProfile:
    # 200 lines
    
# settings.py
class UserSettings:
    # 200 lines
```

### Strategy 2: Extract Functions
```python
# Before: processor.py (550 lines)
def process_order(order):
    # validation logic (100 lines)
    # pricing logic (150 lines)
    # inventory logic (100 lines)
    # notification logic (100 lines)
    # shipping logic (100 lines)

# After refactoring:
# validators.py
def validate_order(order):
    # 100 lines

# pricing.py
def calculate_pricing(order):
    # 150 lines
    
# Continue for other functions...
```

## Best Practices

1. **Plan Before Coding**: Design module structure upfront
2. **Single Responsibility**: Each module should have one clear purpose
3. **Consistent Naming**: Use descriptive, consistent file names
4. **Document Interfaces**: Clear docstrings for module interfaces
5. **Test Modules Independently**: Each module should be testable in isolation

## Configuration

```yaml
project:
  rules:
    code-structure: enabled
  config:
    max_lines_per_file: 500
    preferred_import_style: "relative"
    enforce_dotenv: true
    module_patterns:
      agents: ["agent.py", "tools.py", "prompts.py"]
      services: ["service.py", "handlers.py", "validators.py"]
```

## Common Violations and Fixes

### Violation: Monolithic Script
**Fix**: Identify logical sections and extract to modules

### Violation: Mixed Concerns
**Fix**: Separate business logic, data access, and presentation

### Violation: Deep Import Chains
**Fix**: Use __init__.py to expose clean interfaces

### Violation: Circular Imports
**Fix**: Restructure dependencies or use import inside functions

## Troubleshooting

### Issue: Import Errors After Refactoring
**Solution**: Update all import statements and __init__.py files

### Issue: Shared State Between Modules
**Solution**: Use dependency injection or configuration objects

### Issue: Test Failures After Split
**Solution**: Update test imports and mock boundaries

## Related Rules

- `project/planning-context`: Provides architectural patterns to follow
- `python/style-guide`: Complements with coding standards
- `testing/unit-test-structure`: Ensures tests mirror module structure

## Implementation Notes

This rule has priority 700 because:
1. It directly impacts code quality and maintainability
2. Must run early to prevent accumulation of technical debt
3. Other rules depend on well-structured code
4. Refactoring becomes harder the longer it's delayed

The 500-line limit is based on research showing:
- Cognitive load increases significantly beyond 500 lines
- Most well-structured modules naturally stay under this limit
- It forces good separation of concerns
- It's a practical limit that doesn't force excessive splitting

---

📚 **Rule Definition**: [.claude/rules/project/code-structure.md](../../../.claude/rules/project/code-structure.md)