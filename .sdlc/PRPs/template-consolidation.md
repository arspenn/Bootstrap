name: "Template Consolidation and Standardization"
description: |

## Purpose
Consolidate all Bootstrap framework templates into `.claude/templates/` with standardized kebab-case naming, delete unused templates, and create enforcement rules for consistent template management preparing for alpha release.

## Core Principles
1. **Single Location**: All templates in `.claude/templates/`
2. **Consistent Naming**: Kebab-case pattern (except README)
3. **Git History**: Preserve history with git mv
4. **Clean Migration**: Complete in single session
5. **Full Validation**: Verify all references updated

---

## Goal
Move active templates to `.claude/templates/`, delete unused templates, standardize naming to kebab-case (with README exception), update all references, and create template management rule.

## Why
- **Alpha Preparation**: Framework ready for new project generation
- **Consistency**: Single location for all templates
- **Standardization**: Uniform naming convention
- **Maintenance**: Easier template management

## What
Consolidate templates from `templates/design-templates/` to `.claude/templates/`, delete unused templates, ensure kebab-case naming, update only active rule/docs references (not PRPs/designs), and create enforcement rule.

### Success Criteria
- [ ] 3 active templates moved to .claude/templates/
- [ ] 4 unused templates deleted
- [ ] All templates follow kebab-case (except README)
- [ ] Rule and docs references updated (2 files only)
- [ ] Template management rule created
- [ ] Git history preserved
- [ ] Empty templates/ directory removed
- [ ] PRPs/designs unchanged (historical records)

## All Needed Context

### Documentation & References
```yaml
# Current Template Locations
- directory: templates/design-templates/
  active_templates:
    - adr.template.md
    - README.template.md  
    - feature-design.template.md
  unused_templates:
    - fix-design.template.md
    - refactor-design.template.md
    - spike-design.template.md
    - system-design.template.md

# Target Location
- directory: .claude/templates/
  naming_pattern: "{kebab-case-name}.template.{ext}"
  exception: "README.template.md keeps uppercase"

# Files with ADR template references (2 files to update)
- file: .claude/rules/project/adr-management.md
  line: 22
  current: '  - follow_template: "templates/design-templates/adr.template.md"'
  new: '  - follow_template: ".claude/templates/adr.template.md"'

- file: .claude/docs/rules/project/adr-management.md
  line: 237
  current: '    adr_template: "templates/design-templates/adr.template.md"'
  new: '    adr_template: ".claude/templates/adr.template.md"'

# NOTE: NOT updating PRPs or design documents - they are historical records

# Git operation pattern from recent rename
- reference: git log shows recent feature renames with R100 status
  command: "git mv [source] [target]"
  preserves: Full git history with rename tracking
```

### Known Gotchas
```text
# CRITICAL: Use git mv for all moves (preserves history)
# CRITICAL: Use git rm for deletions (tracks removal)
# CRITICAL: Complete all changes before removing templates/ directory
# IMPORTANT: README.template.md is exception to kebab-case
# IMPORTANT: Some PRPs reference absolute paths, update carefully
# NOTE: Git templates already follow naming convention
```

## Implementation Blueprint

### List of tasks to complete in order

```yaml
Task 1: Move ADR template
  Operation: Use git mv to relocate template
  Command: git mv templates/design-templates/adr.template.md .claude/templates/adr.template.md
  Verify: ls -la .claude/templates/adr.template.md

Task 2: Move README template  
  Operation: Use git mv to relocate template (keeps uppercase)
  Command: git mv templates/design-templates/README.template.md .claude/templates/README.template.md
  Verify: ls -la .claude/templates/README.template.md

Task 3: Move feature-design template
  Operation: Use git mv to relocate template
  Command: git mv templates/design-templates/feature-design.template.md .claude/templates/feature-design.template.md
  Verify: ls -la .claude/templates/feature-design.template.md

Task 4: Delete unused fix-design template
  Operation: Use git rm to remove template
  Command: git rm templates/design-templates/fix-design.template.md
  Verify: ! test -f templates/design-templates/fix-design.template.md

Task 5: Delete unused refactor-design template
  Operation: Use git rm to remove template
  Command: git rm templates/design-templates/refactor-design.template.md
  Verify: ! test -f templates/design-templates/refactor-design.template.md

Task 6: Delete unused spike-design template
  Operation: Use git rm to remove template
  Command: git rm templates/design-templates/spike-design.template.md
  Verify: ! test -f templates/design-templates/spike-design.template.md

Task 7: Delete unused system-design template
  Operation: Use git rm to remove template
  Command: git rm templates/design-templates/system-design.template.md
  Verify: ! test -f templates/design-templates/system-design.template.md

Task 8: Update ADR reference in adr-management rule
  File: .claude/rules/project/adr-management.md
  Line: 22
  Replace: '  - follow_template: "templates/design-templates/adr.template.md"'
  With: '  - follow_template: ".claude/templates/adr.template.md"'

Task 9: Update ADR reference in adr-management docs
  File: .claude/docs/rules/project/adr-management.md
  Line: 237
  Replace: '    adr_template: "templates/design-templates/adr.template.md"'
  With: '    adr_template: ".claude/templates/adr.template.md"'

Task 10: Create template management rule
  File: .claude/rules/project/template-management.md
  Content: See template management rule section below

Task 11: Remove empty templates directory
  Operation: Remove now-empty directory structure
  Command: rmdir templates/design-templates && rmdir templates
  Verify: ! test -d templates
```

### Template Management Rule Content
```markdown
# Template Management Rule

## When to Apply
When creating or managing templates in the Bootstrap framework.

## Rule Requirements
- location: All templates MUST be in .claude/templates/
- naming: {kebab-case-name}.template.{ext}
- exception: README.template.md keeps uppercase
- extensions: .md, .yaml, or no extension

## Actions
- enforce_location: true
- enforce_naming: true
- auto_fix: false
```

### Integration Points
```yaml
FILE_SYSTEM:
  - source: templates/design-templates/
  - target: .claude/templates/
  
REFERENCES_TO_UPDATE:
  - .claude/rules/project/adr-management.md (line 22)
  - .claude/docs/rules/project/adr-management.md (line 237)
  
NOT_UPDATING:
  - PRPs (historical records)
  - Design documents (historical records)
  
GIT:
  - Use git mv for moves
  - Use git rm for deletions
  - Stage all changes together
```

## Validation Loop

### Level 1: File System Verification
```bash
# Confirm templates moved successfully
ls -la .claude/templates/adr.template.md
ls -la .claude/templates/README.template.md
ls -la .claude/templates/feature-design.template.md
# Expected: All three files exist

# Confirm unused templates deleted
ls templates/design-templates/*.template.md 2>/dev/null | wc -l
# Expected: 0

# Confirm directory can be removed
ls templates/design-templates/ 2>/dev/null | wc -l  
# Expected: 0
```

### Level 2: Reference Verification
```bash
# Check no old references remain in active files (PRPs/designs will still have old refs)
grep -r "templates/design-templates" .claude/ --exclude-dir=.git
# Expected: No matches

# Verify ADR references updated in rules
grep -l "\.claude/templates/adr\.template\.md" .claude/rules/project/adr-management.md
# Expected: File name returned

# Verify ADR references updated in docs
grep -l "\.claude/templates/adr\.template\.md" .claude/docs/rules/project/adr-management.md
# Expected: File name returned

# Confirm PRPs still have historical references (not updated)
grep -l "templates/design-templates" PRPs/*.md | wc -l
# Expected: Several files (these are NOT updated)
```

### Level 3: Git History Check
```bash
# Verify git tracked the moves
git status --short | grep "^R"
# Expected: Shows renames for 3 templates

# Check history preserved for each
git log --follow --oneline .claude/templates/adr.template.md | head -2
git log --follow --oneline .claude/templates/README.template.md | head -2
git log --follow --oneline .claude/templates/feature-design.template.md | head -2
# Expected: Shows history before rename

# Verify deletions tracked
git status --short | grep "^D"
# Expected: Shows 4 deletions
```

### Level 4: Rule Validation
```bash
# Verify template rule created
test -f .claude/rules/project/template-management.md && echo "Rule exists"
# Expected: "Rule exists"

# Check all templates in correct location
ls .claude/templates/*.template.* | wc -l
# Expected: 15+ templates

# Verify naming convention (except README)
ls .claude/templates/*.template.* | grep -v README | grep -v -E "^.*/[a-z-]+\.template\."
# Expected: No output (all follow pattern)
```

## Final Validation Checklist
- [ ] ADR template moved to .claude/templates/
- [ ] README template moved (uppercase preserved)
- [ ] feature-design template moved
- [ ] 4 unused templates deleted
- [ ] 2 rule/docs references updated
- [ ] PRPs/designs left unchanged (historical)
- [ ] Template management rule created
- [ ] Git shows renames (not delete+add)
- [ ] Empty templates/ directory removed
- [ ] No broken references in active files

---

## Anti-Patterns to Avoid
- ❌ Don't use cp + rm (loses git history)
- ❌ Don't rename README to lowercase
- ❌ Don't forget any references (use grep to verify)
- ❌ Don't delete templates/ before updating references
- ❌ Don't skip validation steps

## Error Recovery
If anything goes wrong:
1. `git status` to see current state
2. `git checkout -- .` to revert all changes
3. `git clean -fd templates/` to remove any new files
4. Start over from Task 1

## Confidence Score: 9/10

High confidence because:
- Clear file operations with git preservation
- Exact line numbers for all references identified
- Simple validation commands provided
- Similar migrations done recently in project
- Comprehensive checklist for verification

Minor uncertainty only around potential test file references not caught by grep.