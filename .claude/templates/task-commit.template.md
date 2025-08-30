# Task-Focused Commit Message Template

## Format
```
<type>(<scope>): <subject>

<body>

<footer with task references>
```

## Types
- `feat` - New feature for users
- `fix` - Bug fix for users  
- `docs` - Documentation changes
- `style` - Code style/formatting (no logic change)
- `refactor` - Code restructuring (no behavior change)  
- `test` - Test additions or modifications
- `chore` - Maintenance tasks
- `perf` - Performance improvements
- `ci` - CI/CD changes
- `build` - Build system changes

## Guidelines

### Subject Line
- Complete the sentence "This commit will..."
- Use imperative mood (add, not added/adds)
- Don't capitalize first letter
- No period at the end
- Limit to 250 characters (recommended)

### Body
- Explain what and why, not how
- Wrap at 72 characters
- Use bullet points for multiple items
- Separate from subject with blank line

### Footer - Task References
- `Completed: TASK-XXX` - for completed tasks
- `Refs: TASK-XXX` - for related/partial work
- `Fixes #123` - for GitHub issues
- `BREAKING CHANGE: description` - for breaking changes

## Task Reference Examples

### Single Task Completion
```
Completed: TASK-001
```

### Multiple Task Completion
```
Completed: TASK-001, TASK-002, TASK-003
```

### Partial Work on Task
```
Refs: TASK-004
```

### Mixed References
```
Completed: TASK-001
Refs: TASK-002, TASK-003
Fixes #789
```

## Full Example
```
feat(tasks): implement enhanced task structure

- Add metadata to all tasks (ID, priority, dates)
- Create commands for task management
- Implement automated migration from old format
- Reduce TASK.md from 219 to <100 lines

This provides structured task management with automated
cleanup and git commit integration for Bootstrap v1.0.

Completed: TASK-001
Refs: TASK-002
Fixes #456
```