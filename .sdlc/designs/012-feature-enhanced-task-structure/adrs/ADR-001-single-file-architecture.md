# ADR-001: Single File Task Management Architecture

## Status
Proposed

## Context
The current TASK.md has grown to 219 lines with various organizational issues:
- Duplicate sections
- No metadata or tracking
- Mix of current, future, and backlog items
- Manual additions without audit

We need to decide between:
1. Keeping a single TASK.md file
2. Splitting into multiple files (CURRENT.md, BACKLOG.md, etc.)
3. Using a database or external system

Additionally, we need to determine how to handle historical task data.

## Decision
We will maintain a single TASK.md file with enhanced structure and metadata, supported by task management commands.

The file will have clear sections:
- **Current Tasks** - Active work for next commit
- **Backlog** - Future work organized by priority  
- **Completed** - Recent completions (retained for 30-60 days)

**Metadata Format**: Use plain markdown for visibility
- Metadata as bold key-value pairs under task headers
- Same token count as HTML comments (verified: 37 tokens each)
- Visible in rendered markdown for better transparency
- Example:
  ```markdown
  ### [HIGH] TASK-001: Task Title
  **Created:** 2025-08-28  
  **Estimate:** 2d  
  **Status:** in-progress
  ```

**Archival Strategy**: Use git commits as the permanent task archive
- Make smaller, task-focused commits
- Include completed task IDs and details in commit messages
- CHANGELOG.md remains high-level for releases
- Git history provides detailed task-level history

## Consequences

### Positive
- Maintains simplicity and current workflow
- Single source of truth for all tasks
- Git commits provide permanent, searchable task history
- No additional archive files to maintain
- Encourages better commit practices

### Negative
- File can still grow large (mitigated by archival)
- Requires discipline in commit message quality
- Need to adjust git rules for task-focused commits

### Neutral
- Requires periodic cleanup via commands
- May need new git rule for task-completion commits
- Commands handle complexity instead of file structure