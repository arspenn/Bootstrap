# Rule: Task Commit Integration

## Instructions

### Rule Metadata
- ID: git/task-commit-integration
- Status: Active
- Security Level: Medium
- Token Impact: ~35 tokens per operation
- Priority: 400
- Dependencies: [git/git-commit-format]

### Rule Configuration
```yaml
trigger: "git commit"
conditions:
  - command_contains: ["commit"]
  - task_related_work: true
actions:
  - add_task_references: true
  - use_template: ".claude/templates/task-commit.template.md"
  - validate_task_exists: true
  - suggest_task_references: true
validations:
  - task_id_format: "TASK-\\d{3}"
  - task_exists_in_file: "TASK.md"
  - footer_format: ["Completed:", "Refs:", "Fixes"]
  - conventional_format_maintained: true
error_handling:
  - warn_if_task_not_found: true
  - suggest_correct_format: true
  - show_examples: true
```

### Behavior
- Adds task IDs to commit messages in footer section
- Validates referenced tasks exist in TASK.md
- Maintains conventional commit format
- Distinguishes between completed and referenced tasks
- Uses task-commit.template.md for format examples

### Task Reference Format
```
Completed: TASK-001              # Single completion
Completed: TASK-001, TASK-002    # Multiple completions
Refs: TASK-003                   # Partial/related work
```

### Integration with Conventional Commits
```
<type>(<scope>): <subject>

<body>

Completed: TASK-XXX
Refs: TASK-YYY
Fixes #issue
```

### Validation Rules
- Task IDs must exist in TASK.md
- Use "Completed:" for finished tasks
- Use "Refs:" for partial/related work
- Maintain conventional commit format
- Place task references in footer section

---

📚 **Full Documentation**: [.claude/docs/rules/git/task-commit-integration.md](../../docs/rules/git/task-commit-integration.md)