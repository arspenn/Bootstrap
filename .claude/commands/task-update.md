# Update Task

## Arguments: $ARGUMENTS

Update task metadata or status in TASK.md.

## When to Use This Command

**Use `task-update` when:**
- Changing task status (pending → in-progress → completed)
- Updating task priority
- Modifying estimates
- Adding or removing blocked-by references
- Moving tasks between sections

**Skip and use manual editing when:**
- Adding subtasks or discovered items
- Changing task descriptions
- Making multiple updates at once

## Process

### 1. **Parse Arguments**
   - Extract task ID (TASK-XXX)
   - Parse update parameters (status=, priority=, estimate=, etc.)
   - Validate parameter values

### 2. **Locate Task**
   - Read TASK.md
   - Find task by ID
   - Verify task exists
   - Note current section

### 3. **Apply Updates**
   
   **Status Changes:**
   - `pending` → Keep in Backlog
   - `in-progress` → Move to Current Tasks
   - `completed` → Move to Completed with date
   - `blocked` → Keep in Backlog with reason
   
   **Priority Changes:**
   - Reorder within section by new priority
   - HIGH > MEDIUM > LOW ordering
   
   **Metadata Updates:**
   - Update estimate
   - Add/remove blocked-by reference
   - Update any other metadata fields

### 4. **Section Movement**
   - If status changed, move to appropriate section
   - Maintain priority ordering in new section
   - Add completion date if moving to Completed

### 5. **Save Changes**
   - Write updated TASK.md
   - Preserve formatting
   - Report changes made

## Usage Syntax

```bash
/task-update TASK-XXX parameter=value [parameter2=value2]
```

### Parameters

- `status=` - pending, in-progress, completed, blocked
- `priority=` - HIGH, MEDIUM, LOW
- `estimate=` - Time estimate (1h, 2d, 1w, etc.)
- `blocked-by=` - Task ID that blocks this task
- `unblock` - Remove blocked-by reference

### Examples

```bash
# Start working on task
/task-update TASK-001 status=in-progress

# Complete a task
/task-update TASK-001 status=completed

# Change priority
/task-update TASK-002 priority=HIGH

# Update estimate
/task-update TASK-003 estimate=5d

# Mark as blocked
/task-update TASK-004 status=blocked blocked-by=TASK-003

# Multiple updates
/task-update TASK-005 status=in-progress priority=HIGH estimate=2d
```

## Output Structure

Updates task in place and moves between sections as needed:

```markdown
# Before (in Backlog):
### [MEDIUM] TASK-001: Fix authentication
**Created:** 2025-08-28  
**Estimate:** 2d  
**Status:** pending

# After (in Current Tasks):
### [MEDIUM] TASK-001: Fix authentication
**Created:** 2025-08-28  
**Estimate:** 2d  
**Status:** in-progress
```

## Integration with Other Commands

- **Works with**: task-add, task-audit, task-summary
- **Updates**: TASK.md task entries
- **Triggers**: task-management rule validations

## Validation and Error Handling

- Validates task ID exists
- Checks valid status values
- Ensures priority is valid
- Validates blocked-by task exists
- Prevents invalid section moves
- Reports what was changed

## Tips for Success

1. **Update Status Promptly** - Keep task status current
2. **Complete Before Starting New** - Avoid too many in-progress
3. **Update Estimates** - Adjust as you learn more

## Common Issues

- **Task Not Found**: Check task ID format (TASK-XXX)
- **Invalid Status**: Must be pending/in-progress/completed/blocked
- **Section Full**: Current Tasks limited to ~10-15 tasks