# Planning Context Management Rule Documentation

## Overview

The `planning-context` rule ensures that every Claude session begins with proper project context by automatically reading `PLANNING.md` at conversation start and checking `TASK.md` before starting new tasks. This rule is crucial for maintaining consistent development patterns and ensuring Claude understands the project's architecture and current state.

## Rule Definition

```yaml
- ID: project/planning-context
- Status: Active  
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 800
- Dependencies: []
```

## Rationale

Loading planning context ensures:
- **Consistent Approach**: Every conversation follows established project patterns
- **Architectural Awareness**: Claude understands the system's structure
- **Task Continuity**: Work aligns with ongoing tasks and priorities
- **Convention Adherence**: Development follows project-specific conventions
- **Reduced Errors**: Context prevents conflicting with established patterns

## When This Rule Triggers

The rule activates when:
1. Starting a new conversation
2. Beginning work on a new task
3. Explicit context check requests
4. Any task initiation command

## Examples

### Example 1: New Conversation Start
```
User: "Help me implement the user authentication feature"
Claude: [Automatically reads PLANNING.md and TASK.md]
Claude: "I've loaded the project context. I see this project follows a design-first approach..."
```

### Example 2: Task Management
```
# TASK.md content:
### Current Tasks
- [ ] Implement user authentication
- [ ] Add password reset functionality

# When user requests a new feature:
User: "Add user profile management"
Claude: [Checks TASK.md, sees it's not listed]
Claude: "I'll add this to TASK.md as a new task..."
```

### Example 3: Creating Missing Files
```
# If PLANNING.md doesn't exist:
Claude: "PLANNING.md not found. Creating with template..."
# Creates file with project overview structure
```

## File Templates

### PLANNING.md Template
```markdown
# [Project Name] Planning

## Project Overview
[Brief description of the project and its goals]

## Architecture
- **Component Structure**: [Key architectural components]
- **Design Patterns**: [Patterns used in the project]
- **Technology Stack**: [Primary technologies]

## Key Components
1. **[Component 1]**: [Description]
2. **[Component 2]**: [Description]

## Design Principles
- [Principle 1]
- [Principle 2]

## Future Enhancements
- [Enhancement 1]
- [Enhancement 2]
```

### TASK.md Template
```markdown
# Task Management

## Current Tasks

### [Feature/Task Name] - [Date]
- [ ] Sub-task 1
- [ ] Sub-task 2

## Completed Tasks
- [Task name] ([Date])

## Discovered During Work
- [Issue or task discovered]

## Future Features Backlog
- [Feature 1]
- [Feature 2]
```

## Common Scenarios

### Scenario 1: Design-First Development
```
1. Claude reads PLANNING.md → sees "design-first approach"
2. User requests new feature
3. Claude suggests creating design document first
4. Development follows established workflow
```

### Scenario 2: Environment Setup
```
1. PLANNING.md specifies "venv_linux" for Python
2. User runs Python command
3. Claude automatically uses: `venv_linux/bin/python`
4. Consistent environment across all operations
```

### Scenario 3: Convention Enforcement
```
1. PLANNING.md defines naming conventions
2. User creates new file
3. Claude ensures file follows conventions
4. Suggests corrections if needed
```

## Best Practices

1. **Keep PLANNING.md Updated**: Reflect architectural changes
2. **Task Granularity**: Break large tasks into sub-tasks
3. **Date Tasks**: Include dates for tracking
4. **Document Discoveries**: Add unexpected findings to TASK.md
5. **Use Consistent Patterns**: Follow naming and structure conventions

## Configuration

```yaml
project:
  rules:
    planning-context: enabled
  config:
    auto_create_files: true
    use_templates: true
    python_environment: "venv_linux"
    check_interval: "conversation_start"
```

## Troubleshooting

### Issue: Context Not Loading
**Solution**: Ensure files are in project root, not subdirectories

### Issue: Template Not Applied
**Solution**: Check template paths in rule configuration

### Issue: Tasks Not Tracked
**Solution**: Verify TASK.md format matches expected structure

## Related Rules

- `project/code-structure`: Uses conventions from PLANNING.md
- `project/design-structure`: Follows design patterns specified
- `project/adr-management`: Aligns with architectural decisions

## Implementation Notes

This rule has the highest priority (800) among project rules because:
1. It establishes foundational context
2. Other rules depend on this information
3. Must execute before any development begins
4. Sets the stage for all subsequent operations

---

📚 **Rule Definition**: [.claude/rules/project/planning-context.md](../../../.claude/rules/project/planning-context.md)