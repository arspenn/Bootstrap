# Rule: Task Discovery

## Instructions

### Rule Metadata
- ID: project/task-discovery
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 450
- Dependencies: [project/task-management]

### Rule Configuration
```yaml
trigger: "code implementation, debugging, development work"
conditions:
  - during_implementation: true
  - new_requirement_found: true
actions:
  - add_to_discovered_section: true
  - use_template: ".claude/templates/task-discovered.template.md"
  - auto_generate_next_id: true
  - update_parent_task: true
validations:
  - parent_task_exists: true
  - discovered_date_format: "YYYY-MM-DD"
  - description_present: true
error_handling:
  - create_discovered_section: true
  - suggest_promotion_to_task: true
```

### Behavior
- Tracks new tasks discovered during implementation
- Adds discovered items under parent task's "Discovered" section
- Auto-generates next task ID if item needs promotion
- Suggests when discovered items should become independent tasks
- Uses task-discovered.template.md for format

### Discovery Guidelines
- Add to parent task's "Discovered" section
- Include discovery date
- Keep descriptions concise
- Promote to full task if scope grows
- Complete with parent task when possible

### Promotion Criteria
Promote discovered item to full task when:
- Scope is larger than originally thought
- Blocks other work
- Requires separate commit
- Different priority than parent
- Cannot be completed with parent task

---

📚 **Full Documentation**: [.claude/docs/rules/project/task-discovery.md](../../docs/rules/project/task-discovery.md)