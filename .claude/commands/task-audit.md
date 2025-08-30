# Audit and Migrate Tasks

## Arguments: $ARGUMENTS

Clean up, reorganize, and migrate TASK.md to the enhanced structure. This command handles both ongoing maintenance and initial migration from the old unstructured format.

## When to Use This Command

**Use `task-audit` when:**
- Migrating from old unstructured TASK.md format (auto-detected or with --migrate)
- Performing regular cleanup of completed tasks older than 30 days
- Reorganizing tasks by priority
- Finding and removing duplicate tasks
- Validating task metadata and structure

**Skip and use manual editing when:**
- Making simple one-line changes
- Adding a single new task (use task-add instead)

## Process

### 1. **Detection Phase**
   - Read current TASK.md
   - Detect format (old unstructured vs new structured)
   - If old format detected, prompt for migration
   - Check for backup file existence

### 2. **Migration Mode** (--migrate flag or auto-detected)
   - Create backup: TASK.md.backup-YYYY-MM-DD
   - Parse all existing tasks (currently 219 lines)
   - Auto-generate sequential task IDs (TASK-001, TASK-002, etc.)
   - Categorize tasks:
     - Active work → Current Tasks
     - Future work → Backlog (by priority)
     - Completed items → Completed section
   - Merge duplicate "Discovered During Work" sections
   - Present removal candidates for user approval:
     ```
     Candidates for removal (likely obsolete):
     [ ] Virtual environment setup (probably complete)
     [ ] User preferences standardization (old format)
     [ ] Test scripts in root (rule already exists)
     [ ] Documentation already moved (completed in v0.6.0)
     
     Remove selected items? (y/n for each or a for all, k for keep all):
     ```

### 3. **Standard Audit Mode** (default)
   - Remove completed tasks older than 30 days
   - Check for duplicate task IDs or descriptions
   - Validate metadata presence (Created, Estimate, Status)
   - Reorder by priority within sections
   - Fix formatting inconsistencies
   - Report issues found

### 4. **Task Organization**
   - **Current Tasks**: In-progress items (max 10-15)
   - **Backlog**: Pending/blocked items by priority
   - **Completed**: Recent completions with dates
   - Apply consistent formatting from templates

### 5. **Validation**
   - Ensure sequential task IDs
   - Verify metadata format
   - Check priority levels (HIGH/MEDIUM/LOW)
   - Validate status values
   - Confirm section placement

### 6. **Report Generation**
   ```
   Task Audit Report
   =================
   Tasks migrated: 45
   Tasks removed: 12
   Duplicates merged: 3
   New task IDs assigned: 45
   
   Current distribution:
   - Current Tasks: 3 (1 HIGH, 2 MEDIUM)
   - Backlog: 35 (5 HIGH, 15 MEDIUM, 15 LOW)
   - Completed: 7
   
   File size: 219 lines → 95 lines (57% reduction)
   ```

## Output Structure

```
TASK.md (restructured)
TASK.md.backup-YYYY-MM-DD (if migration performed)
```

## Integration with Other Commands

- **Input from**: Existing unstructured TASK.md
- **Output to**: Structured TASK.md for all task commands
- **Works with**: task-add, task-update, task-summary

## Validation and Error Handling

- Creates backup before any destructive changes
- Validates each task during migration
- Prompts for user confirmation on removals
- Preserves task history in git commits
- Reports any tasks that couldn't be migrated

## Example Usage

```bash
# Auto-detect and migrate if needed
/task-audit

# Force migration mode
/task-audit --migrate

# Standard cleanup only
/task-audit --cleanup
```

## Tips for Success

1. **First Migration** - Review removal candidates carefully
2. **Regular Use** - Run weekly to keep TASK.md clean
3. **Before Commits** - Audit to ensure task IDs are current

## Common Issues

- **Large Migration**: Take time to review removal candidates
- **Duplicate Tasks**: Will prompt for which to keep
- **Missing Metadata**: Will add default values with warnings