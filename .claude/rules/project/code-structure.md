# Rule: Code Structure and Modularity

## Instructions

### Rule Metadata
- ID: project/code-structure
- Status: Active
- Security Level: Low
- Token Impact: ~25 tokens per operation
- Priority: 700
- Dependencies: []

### Rule Configuration
```yaml
trigger: ["file creation", "file edit", "refactor request"]
conditions:
  - file_operation: ["create", "edit"]
  - line_count_check: true
  - language: ["python", "javascript", "typescript"]
actions:
  - enforce_line_limit: 500
  - suggest_refactor: true
  - enforce_module_structure: true
  - check_import_style: true
  - require_dotenv: true
validations:
  - max_lines_per_file: 500
  - clear_module_separation: true
  - consistent_imports: true
  - proper_file_organization: true
  - dotenv_usage: true
patterns:
  agent_structure:
    - "agent.py"      # Main agent definition
    - "tools.py"      # Tool functions
    - "prompts.py"    # System prompts
  import_style: "relative"  # Prefer relative imports
environment:
  dotenv_module: "python-dotenv"
```

### Module Organization
- Never exceed 500 lines per file
- Split into logical modules by feature/responsibility
- Use clear, descriptive file names
- Prefer relative imports within packages
- Use python-dotenv for environment variables

---

📚 **Full Documentation**: [docs/rules/project/code-structure.md](../../../docs/rules/project/code-structure.md)