name: "Enhanced Task Structure Implementation PRP"
description: |

## Purpose
Transform the current unstructured 219-line TASK.md into a robust, compact task management system with metadata, commands, and automated cleanup. This PRP provides comprehensive context for one-pass implementation of Phase 1 of the enhanced task structure design.

## Core Principles
1. **Simplicity First**: Keep TASK.md as single file with clear sections
2. **Git as Archive**: Use git commits as permanent task history
3. **Automation Support**: Commands handle complexity, not manual editing
4. **Token Efficiency**: Plain markdown metadata (same token count as HTML)
5. **Bootstrap Ready**: Prepare for v1.0 framework release

---

## Goal
Implement a structured task management system that:
- Reduces TASK.md from 219 to <100 lines through migration and cleanup
- Adds metadata (ID, priority, dates, estimates) to all tasks
- Provides commands for task CRUD operations and automated maintenance
- Uses git commits with task IDs as permanent archive
- Supports both user and Claude agent task management

## Why
- **Current Chaos**: TASK.md has 219 lines with duplications, no structure, no metadata
- **Token Efficiency**: Unaudited tasks bloat context window
- **No Tracking**: Can't track creation, completion, or estimates
- **Manual Work**: No automation for cleanup or organization
- **Bootstrap v1.0**: Need efficient task management for framework release

## What
Transform TASK.md into a structured format with three sections:
- **Current Tasks**: Active work for next commit (max 10-15 tasks)
- **Backlog**: Future work organized by priority
- **Completed**: Recent completions (auto-removed after 30 days)

Each task will have:
- Sequential ID (TASK-001, TASK-002, etc.)
- Priority (HIGH/MEDIUM/LOW)
- Metadata (Created date, Estimate, Status)
- Subtasks with checkboxes
- Discovered items section (optional)

### Success Criteria
- [ ] TASK.md reduced from 219 to <100 lines
- [ ] All tasks have ID, priority, and creation date
- [ ] Commands working for add/update/audit/summary
- [ ] Git commits include task IDs
- [ ] Completed tasks auto-archive after 30 days
- [ ] Documentation updated with new workflow
- [ ] No duplicate or obsolete tasks remain

## All Needed Context

### Documentation & References
```yaml
# Design documents to understand requirements
- file: /home/arspenn/Dev/Bootstrap/designs/012-feature-enhanced-task-structure/design.md
  why: Complete design with all requirements, implementation plan, and examples
  
- file: /home/arspenn/Dev/Bootstrap/designs/012-feature-enhanced-task-structure/adrs/ADR-001-single-file-architecture.md
  why: Decision to keep single file with plain markdown metadata
  
- file: /home/arspenn/Dev/Bootstrap/designs/012-feature-enhanced-task-structure/adrs/ADR-002-task-focused-commits.md
  why: Decision to use git commits as archive with task IDs

# Existing patterns to follow
- file: /home/arspenn/Dev/Bootstrap/.claude/commands/design-feature.md
  why: Command structure pattern with process, validation, output
  
- file: /home/arspenn/Dev/Bootstrap/.claude/rules/git/git-commit-format.md
  why: Rule structure with metadata, configuration, and behavior
  
- file: /home/arspenn/Dev/Bootstrap/.claude/templates/command.template.md
  why: Template for new command documentation
  
- file: /home/arspenn/Dev/Bootstrap/.claude/templates/rule.template.md
  why: Template for new rule documentation
  
- file: /home/arspenn/Dev/Bootstrap/TASK.md
  why: Current chaotic state that needs migration - 219 lines of mixed tasks

# Framework docs for task management patterns
- url: https://docs.github.com/en/issues/tracking-your-work-with-issues/about-task-lists
  why: Reference for markdown task list syntax and features
```

### Current Codebase Structure
```bash
Bootstrap/
├── .claude/
│   ├── commands/        # Command definitions
│   │   ├── design-feature.md
│   │   ├── execute-prp.md
│   │   └── generate-prp.md
│   ├── rules/           # Rule definitions  
│   │   ├── git/        # Git-related rules
│   │   └── project/    # Project management rules
│   ├── templates/       # Templates for various artifacts
│   │   ├── command.template.md
│   │   ├── rule.template.md
│   │   └── commit-message.template
│   └── docs/           # Framework documentation
├── designs/            # Design documents
│   └── 012-feature-enhanced-task-structure/
│       ├── design.md
│       └── adrs/
├── PRPs/              # Project Requirement Prompts
├── TASK.md            # Current task file (219 lines, needs migration)
├── CLAUDE.md          # AI behavior configuration
└── CHANGELOG.md       # High-level release history
```

### Desired Structure After Implementation
```bash
Bootstrap/
├── .claude/
│   ├── commands/
│   │   ├── task-add.md         # NEW: Add task with metadata
│   │   ├── task-update.md      # NEW: Update task status/metadata
│   │   ├── task-audit.md       # NEW: Clean up and migrate tasks
│   │   └── task-summary.md     # NEW: Generate task summary
│   ├── rules/
│   │   ├── project/
│   │   │   ├── task-management.md      # NEW: Enforce structure
│   │   │   └── task-discovery.md       # NEW: Track discovered tasks
│   │   └── git/
│   │       ├── task-commit-integration.md  # NEW: Task IDs in commits
│   │       └── git-commit-format.md        # UPDATE: Support task refs
│   └── templates/
│       ├── task.template.md              # NEW: Standard task format
│       ├── task-commit.template          # NEW: Commit with task IDs
│       └── task-discovered.template.md   # NEW: Discovered task format
└── TASK.md  # MIGRATED: Structured with <100 lines
```

### Known Gotchas
```markdown
# CRITICAL: Plain markdown metadata uses same tokens as HTML comments
# Both "**Created:** 2025-08-28" and "<!-- created: 2025-08-28 -->" = 37 tokens
# We chose plain markdown for visibility in rendered output

# IMPORTANT: Task IDs must be sequential for easy tracking
# Format: TASK-001, TASK-002, etc. (not UUID or timestamp-based)

# WARNING: Migration must handle 219 lines of existing tasks
# Two "Discovered During Work" sections need merging
# Many obsolete tasks need user approval for removal

# NOTE: Git commits become permanent archive
# Completed tasks only kept in TASK.md for 30 days
# After 30 days, git history is the only record
```

## Implementation Blueprint

### Phase 1: Foundation (This PRP's Scope)

#### Task 1: Create Task Templates
```yaml
CREATE .claude/templates/task.template.md:
  - Standard format for new tasks with metadata
  - Include priority levels (HIGH/MEDIUM/LOW)
  - Metadata fields: Created, Estimate, Status, Blocked by
  - Example subtasks with checkboxes
  - Optional "Discovered" section

CREATE .claude/templates/task-commit.template:
  - Extend existing commit-message.template
  - Add footer section for task references
  - Format: "Completed: TASK-001" or "Refs: TASK-002, TASK-003"
  - Maintain conventional commit format

CREATE .claude/templates/task-discovered.template.md:
  - Format for tasks discovered during work
  - Lighter metadata (just creation date)
  - Auto-added under parent task
```

#### Task 2: Create Task Management Rules
```yaml
CREATE .claude/rules/project/task-management.md:
  - Rule ID: project/task-management
  - Trigger: "task operations, TASK.md edits"
  - Enforce task ID format (TASK-XXX)
  - Validate metadata presence
  - Ensure proper section placement
  - Priority: 500
  - Reference templates for format

CREATE .claude/rules/project/task-discovery.md:
  - Rule ID: project/task-discovery  
  - Trigger: "code implementation, debugging"
  - Track new tasks found during work
  - Add to parent task's "Discovered" section
  - Auto-generate next task ID
  - Priority: 450
```

#### Task 3: Create Git Integration Rules
```yaml
CREATE .claude/rules/git/task-commit-integration.md:
  - Rule ID: git/task-commit-integration
  - Trigger: "git commit"
  - Add task IDs to commit messages
  - Format: "Completed: TASK-001" in footer
  - Validate task exists in TASK.md
  - Priority: 400
  - Dependencies: [git/git-commit-format]

UPDATE .claude/rules/git/git-commit-format.md:
  - Add support for task references in footer
  - Maintain existing conventional format
  - Add validation for task ID format
  - Example: "feat(tasks): implement task management\n\nCompleted: TASK-001"
```

#### Task 4: Create Task Audit Command (with Migration)
```yaml
CREATE .claude/commands/task-audit.md:
  Purpose: Clean up, reorganize, and migrate TASK.md
  
  Standard Mode (ongoing maintenance):
    - Remove completed tasks older than 30 days
    - Check for duplicate tasks
    - Reorder by priority within sections
    - Validate all tasks have required metadata
    - Generate summary report
  
  Migration Mode (--migrate flag or auto-detect old format):
    - Backup current TASK.md to TASK.md.backup
    - Parse all 219 lines of existing tasks
    - Auto-generate sequential task IDs
    - Organize into Current/Backlog/Completed
    - Present removal candidates for approval:
      * Likely completed tasks
      * Duplicate entries
      * Obsolete items
    - Apply new structure with metadata
    - Create git commit with migration summary
  
  Process:
    1. Read current TASK.md
    2. Detect format (old vs new)
    3. If old format, prompt for migration
    4. Parse tasks and categorize
    5. Apply transformations
    6. Write new TASK.md
    7. Report changes made
```

#### Task 5: Create Basic Task Commands
```yaml
CREATE .claude/commands/task-add.md:
  - Usage: /task-add [priority] "title" [estimate]
  - Generate next sequential task ID
  - Add to appropriate section based on priority
  - Include creation date metadata
  - Use task.template.md for format

CREATE .claude/commands/task-update.md:
  - Usage: /task-update TASK-001 status=done
  - Update task metadata
  - Move between sections as needed
  - Support status changes: pending/in-progress/done
  - Validate task ID exists

CREATE .claude/commands/task-summary.md:
  - Usage: /task-summary [filter]
  - Count tasks by section and priority
  - Show completion rate for current week
  - List overdue tasks (based on estimates)
  - Generate markdown summary
```

### Integration Points
```yaml
TASK.md:
  - Will be completely restructured
  - Backup created before migration
  - New format with three sections
  
Git Workflow:
  - Commits will include task IDs
  - Task completion tracked in commit messages
  - Git history becomes permanent archive
  
CLAUDE.md:
  - No changes needed (uses @.claude/MASTER_IMPORTS.md)
  
MASTER_IMPORTS.md:
  - Add new rules to imports:
    * @.claude/rules/project/task-management.md
    * @.claude/rules/project/task-discovery.md
    * @.claude/rules/git/task-commit-integration.md
```

## Validation Loop

### Level 1: File Creation Validation
```bash
# Verify all new files exist
ls -la .claude/templates/task*.md
ls -la .claude/commands/task-*.md
ls -la .claude/rules/project/task-*.md
ls -la .claude/rules/git/task-commit-integration.md

# Expected: All files present with content
```

### Level 2: Rule Syntax Validation
```bash
# Check rule files follow correct format
grep -E "^- ID:|^- Status:|^- Priority:" .claude/rules/project/task-*.md
grep -E "^- ID:|^- Status:|^- Priority:" .claude/rules/git/task-commit-integration.md

# Expected: All rules have required metadata fields
```

### Level 3: Command Testing
```bash
# Test task-audit migration capability
cp TASK.md TASK.md.test-backup
/task-audit --migrate

# Expected: 
# - Prompts for removal candidates
# - Creates structured TASK.md
# - All tasks have IDs and metadata

# Test task-add command
/task-add high "Test new task" 1d

# Expected: Creates TASK-XXX with proper format

# Test task-summary
/task-summary

# Expected: Shows task counts and statistics
```

### Level 4: Integration Testing
```bash
# Test git commit with task reference
echo "test" > test.txt
git add test.txt
git commit -m "test(tasks): validate task integration

Testing task ID reference in commit

Completed: TASK-001"

git log -1 --format="%B"
# Expected: Commit message includes task reference

# Verify TASK.md structure
head -50 TASK.md
# Expected: Shows new structured format with metadata
```

## Final Validation Checklist
- [ ] All templates created and follow patterns
- [ ] All rules created with proper metadata
- [ ] All commands created with documentation
- [ ] task-audit successfully migrates existing TASK.md
- [ ] TASK.md reduced from 219 to <100 lines
- [ ] All tasks have IDs and metadata
- [ ] Commands work: add, update, audit, summary
- [ ] Git commits can reference task IDs
- [ ] MASTER_IMPORTS.md updated with new rules
- [ ] No duplicate tasks remain after migration

---

## Anti-Patterns to Avoid
- ❌ Don't create complex multi-file task system
- ❌ Don't use JSON or YAML for task storage
- ❌ Don't create separate archive files
- ❌ Don't auto-delete tasks without user approval
- ❌ Don't break existing git commit format
- ❌ Don't ignore the 219 lines of existing tasks

## Migration Strategy for Existing Tasks

### Audit Categories for 219 Lines
```yaml
Lines 5-20 (Git Rules):
  - Check recent commits for completion
  - Consolidate related items
  - Move incomplete to backlog
  
Lines 22-47 (Future Features):
  - Identify top 10 priorities for backlog
  - Mark others as LOW priority
  - Group related items
  
Lines 82-107 (First "Discovered" section):
  - Check if already implemented
  - Merge with second discovered section
  
Lines 94-108 (Second "Discovered" section):  
  - Merge with first section
  - Remove duplicates
  - Validate still relevant
  
Lines 109-219 (Future Backlog):
  - Keep only actionable items
  - Remove vague wishes
  - Group by theme
```

### Removal Candidates to Present
```markdown
Likely obsolete (present for approval):
- [ ] Virtual environment setup (probably done)
- [ ] User preferences standardization (old format)
- [ ] Test scripts in root (rule exists)
- [ ] Documentation already moved
- [ ] Completed git rules work
```

## Implementation Order

1. **Create all templates first** (they're referenced by rules)
2. **Create rules** (they're used by commands)  
3. **Create commands** (they operate on TASK.md)
4. **Run task-audit --migrate** (transforms TASK.md)
5. **Test all commands** (verify working system)
6. **Update MASTER_IMPORTS.md** (activate rules)
7. **Create git commit** with task completion

## Confidence Score: 9/10

High confidence because:
- Clear design document with all requirements
- Existing patterns to follow in codebase
- Migration strategy handles complexity
- Validation steps ensure correctness
- Familiar markdown and git-based approach

Minor uncertainty (-1) for:
- Exact behavior of 219-line migration (may need iteration)

Remember: Start with templates, then rules, then commands, then migrate!