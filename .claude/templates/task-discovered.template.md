# Discovered Task Template

## Format
```markdown
**Discovered:** YYYY-MM-DD
- [ ] Task discovered during work
- [ ] Another discovered requirement (if any)
- [ ] ...
```

## Usage Instructions

### When to Use
Add this section to an existing task when you discover new requirements or subtasks during implementation.

### Where to Place
Add directly under the main task's subtasks, before the separator line.

### Guidelines
- Only add when tasks are actually discovered during work
- Keep descriptions concise but clear
- No need for full metadata (the parent task has that)
- These inherit priority from parent task
- Can be promoted to full tasks if they grow in scope

## Examples

### Simple Discovery
```markdown
**Discovered:** 2025-08-28
- [ ] Add input validation
```

### Multiple Discoveries
```markdown
**Discovered:** 2025-08-28
- [ ] Add error handling for edge case
- [ ] Update tests for new behavior
- [ ] Add logging for debugging
```

### Discovery That Should Become New Task
```markdown
**Discovered:** 2025-08-28
- [ ] Refactor authentication system (promote to TASK-XXX)
```

## Notes
- Discovered items are typically small additions found during implementation
- If a discovered item is large or complex, promote it to a full task
- These items should be completed as part of the parent task when possible
- If not completed with parent, they should be promoted to independent tasks