# Rule: Task Management

## Instructions

### Rule Metadata
- ID: project/task-management
- Status: Active
- Security Level: Low
- Token Impact: ~40 tokens per operation
- Priority: 500
- Dependencies: []

### Rule Configuration
```yaml
trigger: "task operations, TASK.md edits"
conditions:
  - file_path: "TASK.md"
  - operation_type: ["create", "update", "edit"]
actions:
  - enforce_task_id_format: "TASK-\\d{3}"
  - validate_metadata_presence: true
  - ensure_section_placement: true
  - use_template: ".claude/templates/task.template.md"
validations:
  - task_id_sequential: true
  - priority_valid: ["HIGH", "MEDIUM", "LOW"]
  - metadata_required: ["Created", "Estimate", "Status"]
  - status_valid: ["pending", "in-progress", "completed", "blocked"]
  - section_valid: ["Current Tasks", "Backlog", "Completed"]
error_handling:
  - suggest_next_task_id: true
  - show_template_example: true
  - auto_fix_format: false
```

### Behavior
- Enforces structured task format with metadata
- Validates task IDs are sequential (TASK-001, TASK-002, etc.)
- Ensures tasks are in correct sections based on status
- Validates priority levels and metadata presence
- References task.template.md for proper format

### Task Sections
- **Current Tasks**: Active work (status: in-progress)
- **Backlog**: Future work (status: pending/blocked)
- **Completed**: Recent completions (status: completed)

### Metadata Requirements
- **Task ID**: Sequential TASK-XXX format
- **Priority**: [HIGH], [MEDIUM], or [LOW]
- **Created**: Date in YYYY-MM-DD format
- **Estimate**: Time estimate (1h, 2d, 1w, etc.)
- **Status**: pending, in-progress, completed, or blocked
- **Blocked by**: Optional, references blocking task ID

---

📚 **Full Documentation**: [.claude/docs/rules/project/task-management.md](../../docs/rules/project/task-management.md)