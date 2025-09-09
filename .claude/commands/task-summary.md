# Generate Task Summary

## Arguments: $ARGUMENTS

Generate a summary report of tasks in TASK.md.

## When to Use This Command

**Use `task-summary` when:**
- Need overview of current task distribution
- Checking workload and priorities
- Reviewing completion rates
- Planning next work items
- Generating status reports

**Skip and read TASK.md directly when:**
- Looking for specific task details
- Need to see full task descriptions

## Process

### 1. **Read and Parse**
   - Load TASK.md
   - Parse all tasks with metadata
   - Categorize by section and priority
   - Calculate statistics

### 2. **Generate Statistics**
   
   **By Section:**
   - Current Tasks count
   - Backlog count  
   - Completed count (with date range)
   
   **By Priority:**
   - HIGH priority tasks
   - MEDIUM priority tasks
   - LOW priority tasks
   
   **By Status:**
   - In-progress tasks
   - Blocked tasks with reasons
   - Pending tasks
   - Recently completed

### 3. **Calculate Metrics**
   - Completion rate (last 7/30 days)
   - Average time in progress
   - Overdue tasks (based on estimates)
   - Task velocity trend
   - Blocked task chains

### 4. **Format Report**
   - Summary statistics
   - Task distribution table
   - Priority breakdown
   - Blocked tasks list
   - Recommendations

## Usage Syntax

```bash
/task-summary [filter]
```

### Filters

- `current` - Only Current Tasks section
- `backlog` - Only Backlog section
- `completed` - Only Completed section
- `high` - Only HIGH priority tasks
- `blocked` - Only blocked tasks
- `overdue` - Tasks exceeding estimates
- `week` - Last 7 days activity
- `month` - Last 30 days activity

### Examples

```bash
# Full summary
/task-summary

# Current work only
/task-summary current

# High priority tasks
/task-summary high

# Blocked tasks
/task-summary blocked

# Weekly report
/task-summary week
```

## Output Structure

```markdown
Task Summary Report
==================
Generated: 2025-08-30

## Overview
Total Tasks: 45
Active Work: 3
Backlog: 35
Completed (30d): 7

## Current Tasks (3)
- [HIGH] TASK-001: Enhanced task structure (in-progress, 2d)
- [MEDIUM] TASK-002: Fix auth bug (in-progress, 1d)
- [MEDIUM] TASK-003: Update docs (in-progress, 4h)

## Priority Distribution
```
HIGH:   ████████ 8 tasks (18%)
MEDIUM: ████████████████ 20 tasks (44%)
LOW:    ████████████████ 17 tasks (38%)
```

## Blocked Tasks (2)
- TASK-015: Database migration (blocked by TASK-003)
- TASK-022: API v2 (blocked by TASK-015)

## Recent Completions (7 days)
- TASK-040: Framework docs (completed 2025-08-28)
- TASK-039: Git rules (completed 2025-08-27)

## Metrics
- Completion Rate: 5 tasks/week
- Avg Time in Progress: 2.5 days
- Overdue: 1 task (TASK-002)

## Recommendations
- Consider moving 2 HIGH priority tasks to Current
- Review 3 tasks blocked for >7 days
- Archive 4 completed tasks older than 30 days
```

## Integration with Other Commands

- **Reads from**: TASK.md
- **Works with**: task-audit for cleanup recommendations
- **Informs**: task-add placement decisions

## Validation and Error Handling

- Handles malformed tasks gracefully
- Reports parsing issues
- Validates metadata presence
- Highlights data quality issues

## Tips for Success

1. **Weekly Reviews** - Run summary every Monday
2. **Before Planning** - Check distribution before adding tasks
3. **Track Velocity** - Monitor completion rates

## Common Issues

- **Missing Metadata**: Some metrics unavailable
- **No Dates**: Can't calculate time-based metrics
- **Malformed Tasks**: Excluded from counts with warning