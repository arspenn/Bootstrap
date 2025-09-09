name: Diagram Folder Migration Implementation
description: |
  Complete the diagram folder migration to properly place all diagram folders inside their respective design folders
  according to the standardized design structure. This implements the requirements from 
  designs/005-feature-standardize-designs/design-addendum-001.md.
  
  This migration ensures consistency in the design folder structure and makes diagrams easier to find and maintain.

## Goal

Migrate all orphaned diagram folders from the designs root directory into their respective design folders, update all references, and enhance rules/templates to prevent future misplacement.

## Why

**Consistency**: All design-related content should be contained within the design folder
**Discoverability**: Diagrams are easier to find when co-located with their designs
**Git History**: Using `git mv` preserves the history of diagram files
**Future Prevention**: Updated rules and templates will prevent this issue recurring

## What

User-visible changes:
- Diagram folders will be inside design folders (e.g., `001-feature-git-control/diagrams/`)
- All diagram references will use relative paths
- Design templates will explicitly mention diagram folder structure
- Design-structure rule will enforce proper diagram placement

### Success Criteria
- [ ] All three diagram folders migrated to correct locations
- [ ] No diagram folders remain at designs root level
- [ ] All diagram references updated to use relative paths
- [ ] Design-structure rule explicitly mentions diagram placement
- [ ] Design templates include diagram folder guidance
- [ ] Git history preserved for all moved files

## All Needed Context

### Current State
```yaml
current_diagram_locations:
  - path: designs/git-control-diagrams/
    files: [component-diagram.mmd, context-diagram.mmd, sequence-diagram.mmd]
  - path: designs/claude-memory-integration-diagrams/
    files: [component-diagram.mmd, context-diagram.mmd, sequence-diagram.mmd]
  - path: designs/changelog-management-diagrams/
    files: [component-diagram.mmd, context-diagram.mmd, workflow-diagram.mmd]

target_locations:
  - from: designs/git-control-diagrams/
    to: designs/001-feature-git-control/diagrams/
  - from: designs/claude-memory-integration-diagrams/
    to: designs/002-feature-claude-memory/diagrams/
  - from: designs/changelog-management-diagrams/
    to: designs/003-feature-changelog-management/diagrams/

files_with_references:
  - file: designs/003-feature-changelog-management/design.md
    lines: [170-176]
    pattern: "[name](changelog-management-diagrams/file.mmd)"
    update_to: "[name](diagrams/file.mmd)"
```

### Design Requirements (from addendum)
- Folder name: Always `diagrams/` (plural, lowercase)
- Location: Inside the design folder, never at root
- Contents: Mermaid files (.mmd), exported images (.png, .svg)

### Files to Update
1. **designs/003-feature-changelog-management/design.md**: Has diagram references that need path updates
2. **.claude/rules/project/design-structure.md**: Needs explicit diagram placement requirements
3. **templates/design-templates/*.template.md**: Need diagram folder guidance

### Known Gotchas
- Use `git mv` to preserve history (not regular `mv`)
- Check for both markdown link formats: `[text](path)` and `![alt](path)`
- Some designs use inline diagrams (001-feature-git-control) - these don't need updates
- Ensure relative paths work from the design.md location

## Implementation Blueprint

### Phase 1: Migration
```bash
# Create target directories and migrate folders
mkdir -p designs/001-feature-git-control/diagrams
git mv designs/git-control-diagrams/* designs/001-feature-git-control/diagrams/
rmdir designs/git-control-diagrams

mkdir -p designs/002-feature-claude-memory/diagrams  
git mv designs/claude-memory-integration-diagrams/* designs/002-feature-claude-memory/diagrams/
rmdir designs/claude-memory-integration-diagrams

mkdir -p designs/003-feature-changelog-management/diagrams
git mv designs/changelog-management-diagrams/* designs/003-feature-changelog-management/diagrams/
rmdir designs/changelog-management-diagrams
```

### Phase 2: Update References
```python
# In designs/003-feature-changelog-management/design.md
# Update lines 170-176
# FROM: [name](changelog-management-diagrams/file.mmd)
# TO:   [name](diagrams/file.mmd)
```

### Phase 3: Update Rule
Enhance `.claude/rules/project/design-structure.md`:
- Add explicit requirement that diagrams/ must be inside design folder
- Add validation for diagram placement
- Include example structure showing proper placement

### Phase 4: Update Templates
For each template in `templates/design-templates/`:
- Add section about diagram organization
- Include example: `diagrams/architecture.mmd`
- Mention that diagrams should use relative paths

### Task Order
1. **Migrate git-control diagrams** - Use git mv to preserve history
2. **Migrate claude-memory diagrams** - Use git mv to preserve history
3. **Migrate changelog diagrams** - Use git mv to preserve history
4. **Update changelog design references** - Fix paths in design.md
5. **Enhance design-structure rule** - Add explicit diagram requirements
6. **Update feature template** - Add diagram guidance
7. **Update other templates** - Add diagram guidance where relevant
8. **Validate migration** - Run checks to ensure success

## Validation

```bash
# Verify no orphaned diagram folders
ls -la designs/ | grep -E "diagram" | grep -v "^d.*[0-9]{3}-"
# Expected: No output

# Verify diagrams are in correct locations
find designs -type d -name "diagrams" | sort
# Expected: Only paths like designs/XXX-type-name/diagrams

# Check for broken references
grep -r "diagram.*\.mmd" designs/ --include="*.md" | grep -v "diagrams/"
# Expected: No results (all references should use diagrams/ path)

# Verify git history preserved
for design in 001-feature-git-control 002-feature-claude-memory 003-feature-changelog-management; do
  echo "Checking $design:"
  git log --oneline -- "designs/$design/diagrams/" | head -3
done
# Expected: Git history for each diagram file
```

## References
- Design Addendum: /home/arspenn/Dev/Bootstrap/designs/005-feature-standardize-designs/design-addendum-001.md
- Design Structure Rule: /home/arspenn/Dev/Bootstrap/.claude/rules/project/design-structure.md
- Feature Template: /home/arspenn/Dev/Bootstrap/templates/design-templates/feature-design.template.md
- Git Best Practices: https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository

## Confidence Score: 9/10

This PRP provides comprehensive context for one-pass implementation. The only potential issue might be unexpected references to diagrams in files not found during research, but the validation commands will catch these.