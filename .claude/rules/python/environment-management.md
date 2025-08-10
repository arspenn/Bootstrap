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

📚 **Full Documentation**: [docs/rules/python/environment-management.md](../../../docs/rules/python/environment-management.md)