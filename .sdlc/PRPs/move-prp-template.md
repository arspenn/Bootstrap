name: "Move and Rename PRP Template to .claude/templates"
description: |

## Purpose
Move and rename the PRP template from `PRPs/templates/prp_base.md` to `.claude/templates/prp-base.template.md` to consolidate all templates in the standard location and follow kebab-case naming conventions.

## Core Principles
1. **Preserve Git History**: Use git mv to maintain file history
2. **Update All References**: Ensure no broken references remain
3. **Follow Conventions**: Use kebab-case naming to match other templates
4. **Validate Thoroughly**: Test that generate-prp command still works

---

## Goal
Relocate and rename the PRP template to the standard templates directory with proper naming convention, updating all references to maintain functionality.

## Why
- **Consolidation**: All templates should be in `.claude/templates/` for consistency
- **Standardization**: Follow kebab-case naming convention used by other templates
- **Organization**: Easier to find and manage all templates in one location
- **Maintenance**: Reduces confusion about template locations

## What
Move `PRPs/templates/prp_base.md` to `.claude/templates/prp-base.template.md` and update all references in the codebase.

### Success Criteria
- [ ] Template moved to `.claude/templates/prp-base.template.md`
- [ ] Git history preserved for the file
- [ ] All references updated (2 files)
- [ ] Generate-prp command works correctly
- [ ] No broken functionality

## All Needed Context

### Documentation & References
```yaml
# Files that reference the template
- file: .claude/commands/generate-prp.md
  line: 29
  current: "Using PRPs/templates/prp_base.md as template:"
  update_to: "Using .claude/templates/prp-base.template.md as template:"
  
- file: PRPs/framework-docs-separation.md
  line: 68
  current: "- file: PRPs/templates/prp_base.md"
  update_to: "- file: .claude/templates/prp-base.template.md"

# Template naming convention examples
- file: .claude/templates/feature-quick.template.md
  why: Shows kebab-case naming pattern for templates
  
- file: .claude/templates/task-commit.template.md
  why: Another example of kebab-case template naming
```

### Current Directory Structure
```bash
PRPs/
└── templates/
    └── prp_base.md          # Current location

.claude/
└── templates/
    ├── feature-quick.template.md
    ├── task-commit.template.md
    └── [other templates]    # Target directory
```

### Target Structure
```bash
.claude/
└── templates/
    ├── prp-base.template.md  # New location and name
    ├── feature-quick.template.md
    └── [other templates]
```

### Known Gotchas
```text
# CRITICAL: Use git mv to preserve history
# The command must be: git mv [old] [new]
# This ensures git tracks it as a rename, not delete+add

# IMPORTANT: Line numbers may shift
# Verify the exact line numbers before editing
# Use grep to confirm if unsure
```

## Implementation Blueprint

### List of tasks to complete in order

```yaml
Task 1: Move and rename the template file
  Operation: Use git mv to relocate and rename
  Command: git mv PRPs/templates/prp_base.md .claude/templates/prp-base.template.md
  Verify: Check file exists at new location with: ls -la .claude/templates/prp-base.template.md

Task 2: Update reference in generate-prp command
  File: .claude/commands/generate-prp.md
  Line: 29
  Operation: Replace old path with new path
  Old: "Using PRPs/templates/prp_base.md as template:"
  New: "Using .claude/templates/prp-base.template.md as template:"
  
Task 3: Update reference in framework-docs-separation PRP
  File: PRPs/framework-docs-separation.md
  Line: 68
  Operation: Replace old path with new path
  Old: "- file: PRPs/templates/prp_base.md"
  New: "- file: .claude/templates/prp-base.template.md"

Task 4: Verify all changes
  Check: Ensure no other references exist
  Command: grep -r "prp_base.md" . --exclude-dir=.git
  Expected: Should only find references in this PRP file and possibly recent docs

Task 5: Test functionality
  Test: Verify generate-prp command can find the template
  Method: Read the generate-prp.md file and confirm it references the correct path
  Verify: Template content is accessible at new location
```

### Integration Points
```yaml
FILESYSTEM:
  - old_path: PRPs/templates/prp_base.md
  - new_path: .claude/templates/prp-base.template.md
  
REFERENCES:
  - .claude/commands/generate-prp.md
  - PRPs/framework-docs-separation.md
  
GIT:
  - Use git mv for history preservation
  - Stage all changes together for atomic commit
```

## Validation Loop

### Level 1: File System Verification
```bash
# Confirm template moved successfully
ls -la .claude/templates/prp-base.template.md
# Expected: File exists with correct content

# Confirm old location is empty
ls -la PRPs/templates/
# Expected: prp_base.md no longer exists
```

### Level 2: Reference Verification
```bash
# Check generate-prp.md has correct reference
grep "prp-base.template.md" .claude/commands/generate-prp.md
# Expected: Line found with new path

# Check framework-docs-separation.md updated
grep "prp-base.template.md" PRPs/framework-docs-separation.md
# Expected: Line found with new path

# Ensure no old references remain (except in docs)
grep -r "prp_base.md" . --exclude-dir=.git --exclude="*.md"
# Expected: No results or only in documentation/history files
```

### Level 3: Git History Check
```bash
# Verify git tracked the rename
git status
# Expected: Shows rename from PRPs/templates/prp_base.md to .claude/templates/prp-base.template.md

# Check history is preserved
git log --follow .claude/templates/prp-base.template.md | head -5
# Expected: Shows history before the rename
```

### Level 4: Functional Test
```bash
# Test that generate-prp command would work
# (Can't actually run it, but verify the path exists)
test -f .claude/templates/prp-base.template.md && echo "Template accessible"
# Expected: "Template accessible"
```

## Final Validation Checklist
- [ ] Template exists at `.claude/templates/prp-base.template.md`
- [ ] Old location `PRPs/templates/prp_base.md` no longer exists
- [ ] generate-prp.md references new path (line 29)
- [ ] framework-docs-separation.md references new path (line 68)
- [ ] No broken references remain in codebase
- [ ] Git shows rename (not delete+add)
- [ ] Git history preserved for the file
- [ ] All changes staged for commit

---

## Anti-Patterns to Avoid
- ❌ Don't use cp + rm (loses git history)
- ❌ Don't forget to update all references
- ❌ Don't use snake_case in the new name (use kebab-case)
- ❌ Don't commit partial changes (do all at once)
- ❌ Don't skip validation steps

## Error Recovery
If anything goes wrong:
1. `git status` to see current state
2. `git checkout -- .` to revert all changes if needed
3. Start over with the git mv command

## Confidence Score: 9/10

High confidence because:
- Simple, well-defined task
- Only 2 references to update
- Clear validation steps
- Git mv is a standard operation
- Similar renames done recently in the project

Slight uncertainty only around potential undiscovered references, but grep search should catch those.