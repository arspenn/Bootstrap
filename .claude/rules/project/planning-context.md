# Rule: Planning Context Management

## Instructions

### Rule Metadata
- ID: project/planning-context
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 800
- Dependencies: []

### Rule Configuration
```yaml
trigger: ["new conversation", "context check", "start task"]
conditions:
  - conversation_start: true
  - task_initiation: true
  - explicit_request: ["check planning", "review context", "load context"]
actions:
  - read_file: "PLANNING.md"
  - read_file: "TASK.md"
  - validate_existence: true
  - create_if_missing: true
  - use_content_for_context: true
validations:
  - planning_md_exists: true
  - task_md_exists: true
  - format_compliance: true
  - consistent_patterns: true
environment:
  python_env: "venv_linux"
templates:
  - planning: ".claude/templates/planning.template"
  - task: ".claude/templates/task.template"
```

### Behavior
- Always read PLANNING.md at conversation start
- Check TASK.md before starting new tasks
- Add new tasks to TASK.md if not listed
- Create files with templates if missing
- Use consistent naming conventions and patterns
- Use venv_linux for Python execution

---

📚 **Full Documentation**: [docs/rules/project/planning-context.md](../../../docs/rules/project/planning-context.md)