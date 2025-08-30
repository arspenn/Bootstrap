# Add New Task

## Arguments: $ARGUMENTS

Add a new task to TASK.md with auto-generated ID and metadata.

## When to Use This Command

**Use `task-add` when:**
- Creating a new task with proper structure
- Need auto-generated sequential task ID
- Want consistent metadata formatting
- Adding tasks discovered during work

**Skip and use manual editing when:**
- Updating existing tasks (use task-update)
- Making bulk changes (use task-audit)

## Process

### 1. **Parse Arguments**
   - Extract priority (HIGH/MEDIUM/LOW)
   - Extract task title
   - Extract estimate (optional)
   - Parse any additional metadata

### 2. **Generate Task ID**
   - Read current TASK.md
   - Find highest existing task ID
   - Generate next sequential ID (TASK-XXX)
   - Ensure no conflicts

### 3. **Determine Placement**
   - HIGH priority → Current Tasks (if space) or top of Backlog
   - MEDIUM priority → Backlog after HIGH priority tasks
   - LOW priority → Backlog after MEDIUM priority tasks
   - Consider current workload in Current Tasks section

### 4. **Create Task Entry**
   - Use task.template.md format
   - Add creation date (today)
   - Set initial status to "pending"
   - Include provided estimate
   - Format with proper metadata

### 5. **Update TASK.md**
   - Insert task in appropriate section
   - Maintain priority ordering
   - Preserve existing tasks
   - Save with proper formatting

## Usage Syntax

```bash
/task-add [priority] "title" [estimate] [blocked-by]
```

### Examples

```bash
# Simple task
/task-add high "Fix authentication bug"

# With estimate
/task-add medium "Refactor database layer" 3d

# With blocking dependency
/task-add low "Update documentation" 2h TASK-005

# Complete example
/task-add high "Implement caching system" 1w TASK-003
```

## Output Structure

Adds entry to TASK.md in format:
```markdown
### [HIGH] TASK-046: Implement caching system
**Created:** 2025-08-30  
**Estimate:** 1w  
**Status:** pending
**Blocked by:** TASK-003

Implement caching system to improve performance.

- [ ] Design cache architecture
- [ ] Implement cache layer
- [ ] Add cache invalidation
```

## Integration with Other Commands

- **Works with**: task-update, task-audit, task-summary
- **Uses**: task.template.md for formatting
- **Updates**: TASK.md with new entry

## Validation and Error Handling

- Validates priority level (HIGH/MEDIUM/LOW)
- Ensures unique task ID
- Checks blocking task exists if specified
- Confirms task title is not duplicate
- Reports successful addition

## Tips for Success

1. **Be Specific** - Use clear, actionable task titles
2. **Estimate Realistically** - Better to overestimate
3. **Check Dependencies** - Specify blocked-by when relevant

## Common Issues

- **Duplicate Title**: Warns if similar task exists
- **Invalid Priority**: Defaults to MEDIUM with warning
- **Missing Estimate**: Adds without estimate (can update later)