# Move PRP Template to .claude/templates Design Document

## Executive Summary

This design documents the migration of the PRP template from `PRPs/templates/prp_base.md` to `.claude/templates/prp-base.template.md` to consolidate all templates in a single, standardized location and follow the project's kebab-case naming convention. This is a straightforward file reorganization with minimal risk.

## Requirements

### Functional Requirements
- Move PRP template file to the standard templates directory
- Rename file to follow kebab-case convention (prp-base.template.md)
- Update all references to the template's new location and name
- Maintain backward compatibility (no functional changes to the template itself)

### Non-Functional Requirements
- Zero downtime during migration
- Preserve git history of the template file
- Maintain all template functionality

## Current State Analysis

### Existing Structure
- **Current Location**: `PRPs/templates/prp_base.md`
- **Target Location**: `.claude/templates/prp-base.template.md`
- **Files with References**: 
  - `.claude/commands/generate-prp.md` (line 29)
  - `PRPs/framework-docs-separation.md` (line 68)
  - Plus recent references in `features/017-move-prp-template.md` and `TASK.md`

### Template Directory Analysis
The `.claude/templates/` directory already contains 14 templates:
- Command templates (command.template.md)
- Feature templates (feature-quick.template.md, feature-enhanced.template.md)
- Task templates (task.template.md, task-commit.template.md)
- Git templates (commit-message.template, branch-name.template)
- Rule templates (rule.template.md, rule-doc.template.md)

Adding prp-base.template.md here aligns with the established kebab-case naming pattern used by other templates (e.g., feature-quick.template.md, task-commit.template.md).

## Proposed Design

### Overview
Use `git mv` to preserve history while moving and renaming the file to follow kebab-case convention, then update references using the Edit tool.

### Implementation Approach

1. **File Migration**
   - Use `git mv` to move and rename the template while preserving history
   - Change from `prp_base.md` to `prp-base.template.md` for consistency
   - Ensures git tracks both the move and rename as a single operation

2. **Reference Updates**
   - Update `.claude/commands/generate-prp.md` line 29
   - Update `PRPs/framework-docs-separation.md` line 68
   - No need to update feature file or TASK.md (they're documentation)

3. **Validation**
   - Verify the template is accessible at the new location
   - Test the generate-prp command to ensure it finds the template
   - Check git history is preserved

## Alternative Approaches Considered

### Alternative 1: Copy and Delete
**Approach**: Copy file to new location, then delete old file
**Pros**: Simple, safe fallback if something goes wrong
**Cons**: Loses git history, creates two separate file histories
**Decision**: Rejected - git history preservation is valuable

### Alternative 2: Symlink
**Approach**: Create symlink from old location to new location
**Pros**: Maintains backward compatibility automatically
**Cons**: Adds complexity, not all systems handle symlinks well
**Decision**: Rejected - Clean migration is preferred

### Alternative 3: Git Move and Rename (Chosen)
**Approach**: Use `git mv` command to relocate and rename file
**Pros**: Preserves history, clean migration, standard git practice, enforces naming convention
**Cons**: Requires updating references
**Decision**: Selected - Best practice for file reorganization and standardization

## Implementation Plan

### Tasks
1. Move and rename the template file using git mv
2. Update reference in generate-prp.md command
3. Update reference in framework-docs-separation.md PRP
4. Stage and commit all changes
5. Test generate-prp command functionality

### Order of Operations
```yaml
Step 1: Move and rename template file
  command: git mv PRPs/templates/prp_base.md .claude/templates/prp-base.template.md
  
Step 2: Update generate-prp.md
  file: .claude/commands/generate-prp.md
  line: 29
  old: "Using PRPs/templates/prp_base.md as template:"
  new: "Using .claude/templates/prp-base.template.md as template:"
  
Step 3: Update framework-docs-separation.md
  file: PRPs/framework-docs-separation.md  
  line: 68
  old: "- file: PRPs/templates/prp_base.md"
  new: "- file: .claude/templates/prp-base.template.md"
  
Step 4: Verify and commit
  - Check file exists at new location
  - Test generate-prp command
  - Commit with appropriate message
```

## Risks and Mitigations

### Technical Risks
- **Risk**: Breaking generate-prp command
  - **Mitigation**: Test command after update
  - **Fallback**: Revert changes if needed

- **Risk**: Missing references in other files
  - **Mitigation**: Used comprehensive grep search
  - **Monitor**: Check for any runtime errors

### Project Risks
- **Risk**: None identified (low-impact change)

## Success Criteria
- [ ] Template successfully moved to `.claude/templates/`
- [ ] Template renamed to follow kebab-case convention
- [ ] All references updated to new location and name
- [ ] Generate-prp command works correctly
- [ ] Git history preserved for the template file
- [ ] No broken functionality

## Validation Checklist
- [x] Requirements are clear and simple
- [x] Design approach is straightforward
- [x] Implementation steps are defined
- [x] Risks are minimal and mitigated
- [x] Ready for PRP generation

---
*Design completed: 2025-09-01*