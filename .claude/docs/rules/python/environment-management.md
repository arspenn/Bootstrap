# Python Environment Management Rule Documentation

## Overview

The `python/environment-management` rule ensures consistent Python environment usage across the project by enforcing the use of `venv_linux` virtual environment, managing dependencies through `requirements.txt`, and handling environment variables with `python-dotenv`. This rule is foundational for all Python development.

## Rule Definition

```yaml
- ID: python/environment-management
- Status: Active
- Security Level: Medium
- Token Impact: ~20 tokens per operation
- Priority: 700
- Dependencies: []
```

## Rationale

Proper environment management ensures:
- **Dependency Isolation**: Project dependencies don't conflict with system packages
- **Reproducibility**: Same package versions across all environments
- **Security**: Environment variables stored safely, not in code
- **Consistency**: Everyone uses the same Python version and packages
- **Portability**: Easy to replicate environment on different machines

## When This Rule Triggers

The rule activates when:
1. Running Python scripts or commands
2. Installing packages with pip
3. Setting up a development environment
4. Loading configuration from environment variables
5. Creating or updating requirements.txt

## Virtual Environment Setup

### Creating venv_linux
```bash
# Create virtual environment
python3 -m venv venv_linux

# Activate the environment
source venv_linux/bin/activate

# Verify activation
which python
# Should show: /path/to/project/venv_linux/bin/python
```

### Using venv_linux in Commands
```bash
# ✅ Good: Using virtual environment
venv_linux/bin/python script.py
venv_linux/bin/pip install requests
venv_linux/bin/pytest tests/

# ❌ Bad: Using system Python
python script.py
pip install requests
pytest tests/
```

## Requirements Management

### requirements.txt Structure
```txt
# Core dependencies
fastapi==0.104.1
pydantic==2.5.0
python-dotenv==1.0.0

# Development dependencies
pytest>=7.0.0
pytest-cov>=4.0.0
black==23.3.0
ruff==0.1.5
mypy==1.7.0

# Data processing
pandas>=2.0.0
numpy>=1.24.0
```

### Managing Dependencies
```bash
# Install all dependencies
venv_linux/bin/pip install -r requirements.txt

# Add new dependency
venv_linux/bin/pip install new-package
venv_linux/bin/pip freeze > requirements.txt

# Update specific package
venv_linux/bin/pip install --upgrade package-name
venv_linux/bin/pip freeze > requirements.txt

# Install dev dependencies
venv_linux/bin/pip install -r requirements-dev.txt
```

## Environment Variables with python-dotenv

### .env File Example
```bash
# .env file (never commit this!)
DATABASE_URL=postgresql://user:pass@localhost/db
API_KEY=sk-1234567890abcdef
DEBUG=True
ENVIRONMENT=development
SECRET_KEY=your-secret-key-here
```

### Loading Environment Variables
```python
# ✅ Good: Using python-dotenv
from dotenv import load_dotenv
import os

# Load .env file
load_dotenv()

# Access environment variables
api_key = os.getenv("API_KEY")
database_url = os.getenv("DATABASE_URL")
debug = os.getenv("DEBUG", "False").lower() == "true"

# With default values
port = int(os.getenv("PORT", "8000"))
workers = int(os.getenv("WORKERS", "4"))
```

### Advanced dotenv Usage
```python
from dotenv import load_dotenv, find_dotenv
from pathlib import Path

# Find .env file automatically
load_dotenv(find_dotenv())

# Load specific .env file
env_path = Path('.') / '.env.production'
load_dotenv(dotenv_path=env_path)

# Override existing variables
load_dotenv(override=True)

# Load .env but don't override existing
load_dotenv(override=False)
```

## Best Practices

### 1. Always Check Requirements Before Import
```python
# ✅ Good: Document required packages
"""
This module requires:
- pandas>=2.0.0
- numpy>=1.24.0

Install with: pip install -r requirements.txt
"""

import pandas as pd
import numpy as np
```

### 2. Use .env.example for Documentation
```bash
# .env.example (commit this!)
DATABASE_URL=postgresql://user:pass@localhost/db
API_KEY=your-api-key-here
DEBUG=False
ENVIRONMENT=production
```

### 3. Validate Environment on Startup
```python
def validate_environment():
    """Validate required environment variables are set."""
    required_vars = [
        "DATABASE_URL",
        "API_KEY",
        "SECRET_KEY"
    ]
    
    missing = []
    for var in required_vars:
        if not os.getenv(var):
            missing.append(var)
    
    if missing:
        raise EnvironmentError(
            f"Missing required environment variables: {', '.join(missing)}"
        )

# Call on application startup
if __name__ == "__main__":
    load_dotenv()
    validate_environment()
    # Start application
```

## Common Patterns

### Pattern 1: Configuration Class
```python
from pydantic import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    """Application settings from environment."""
    
    api_key: str
    database_url: str
    debug: bool = False
    environment: str = "development"
    port: int = 8000
    workers: int = 4
    
    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"

# Usage
settings = Settings()
print(settings.database_url)
```

### Pattern 2: Environment-Specific Settings
```python
import os
from dotenv import load_dotenv

# Load environment-specific .env file
env = os.getenv("ENVIRONMENT", "development")
load_dotenv(f".env.{env}")

# Now load the base .env (won't override)
load_dotenv(".env", override=False)
```

### Pattern 3: Script Execution
```python
#!/usr/bin/env python
"""Script that uses virtual environment."""

import sys
import os

# Ensure we're using the right Python
expected_venv = os.path.join(os.path.dirname(__file__), "venv_linux")
if not sys.prefix.startswith(expected_venv):
    print(f"Warning: Not using venv_linux. Current: {sys.prefix}")
    sys.exit(1)

# Now safe to import and run
from dotenv import load_dotenv
load_dotenv()

# Your script logic here
```

## Troubleshooting

### Issue: "Module not found" errors
**Solution**: Ensure virtual environment is activated and package is in requirements.txt

### Issue: Different behavior in production
**Solution**: Check that all environment variables are set in production

### Issue: Can't activate virtual environment
**Solution**: Ensure venv_linux exists, recreate if needed: `python3 -m venv venv_linux`

### Issue: Wrong Python version
**Solution**: Check venv was created with correct Python: `venv_linux/bin/python --version`

## Configuration

```yaml
project:
  rules:
    python-environment-management: enabled
  config:
    virtual_env: "venv_linux"
    requirements_file: "requirements.txt"
    env_file: ".env"
    python_version: "3.8+"
    auto_activate: true
    validate_on_startup: true
```

## Security Considerations

1. **Never commit .env files** - Add to .gitignore
2. **Use .env.example** as template
3. **Rotate secrets regularly**
4. **Use different keys** for dev/staging/production
5. **Validate environment variables** at startup
6. **Don't log sensitive values**

## Related Rules

- `python/code-style`: Depends on this for tool installation
- `testing/pytest-requirements`: Uses virtual environment for tests
- `project/planning-context`: References venv_linux in documentation

## Implementation Notes

This rule has priority 700 (highest among language rules) because:
1. It's foundational - other Python rules depend on it
2. Must be applied before any Python code execution
3. Affects how all Python commands are run
4. Critical for reproducibility and security

The rule has medium security level because:
- It handles sensitive environment variables
- Improper use could expose secrets
- Affects system-level Python execution

---

📚 **Rule Definition**: [.claude/rules/python/environment-management.md](../../../.claude/rules/python/environment-management.md)