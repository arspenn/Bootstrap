# ADR-002: Task-Focused Commit Strategy

## Status
Proposed

## Context
Currently, we make large commits that complete multiple tasks at once (like the recent v0.6.0 commit with 82 files). This makes it difficult to track individual task completions in git history.

With the enhanced task management system using task IDs, we have an opportunity to improve our commit practices to create a searchable task history.

## Decision
Implement a task-focused commit strategy:

1. **One task per commit** when feasible
2. **Task ID in commit message** for traceability
3. **Completed subtasks in commit body**
4. **Smaller, more frequent commits**

Example commit format:
```
feat(task): complete TASK-001 enhanced task structure

- Implement new TASK.md structure with metadata
- Add task management commands
- Create validation rules
- Update documentation

Completed: TASK-001
```

For multiple related tasks:
```
fix(git): resolve git rules issues

Completed:
- TASK-003: Fix security level format
- TASK-004: Add documentation links
- TASK-005: Update test expectations
```

## Consequences

### Positive
- Git history becomes searchable task archive
- Easy to find when specific tasks were completed
- Better traceability from task to implementation
- Encourages incremental development
- Rollback is more granular

### Negative
- More commits to manage
- May interrupt flow for small changes
- Need to update git-commit-format rule

### Neutral
- Changes current workflow to be more incremental
- Requires discipline but provides better history
- May need command to help format task-completion commits