# PRP: Standardize Designs Folder Structure

## Summary
Implement a standardized naming convention and structure for the designs folder to improve discoverability and organization. This includes sequential numbering, YAML frontmatter for metadata, self-documenting README files, and migration of existing designs.

## Context

### Design Document
- **Path**: designs/005-feature-standardize-designs/design.md
- **Key Decisions**:
  - Sequential numbering with type prefixes (001-feature-name)
  - YAML frontmatter for status tracking
  - No index files - rely on folder structure
  - README.md in each root folder for documentation

### Current State
The designs folder currently has:
- Inconsistent naming (some with -design suffix, some without)
- Mix of single files and folders
- No status tracking
- No documentation of structure

### Implementation Phases
1. **Templates and Documentation** - Create templates and README files
2. **Structure Implementation** - Ensure proper formatting
3. **Migration** - Rename and reorganize existing designs
4. **Integration** - Update references and add rules

## Requirements

### Phase 1: Templates and Documentation

#### 1.1 Create Design Templates Directory
```bash
# Already exists at: templates/design-templates/
# Contains: feature-design.template.md, adr.template.md
```

#### 1.2 Create Additional Design Templates
Need templates for: refactor, fix, spike, system

**Template Pattern** (from existing feature-design.template.md):
- YAML frontmatter with all required fields
- Standard sections: Executive Summary, Requirements, Current State, etc.
- Placeholder format: `{Field Name}`

#### 1.3 Update designs/README.md
Current file has outdated references to:
- Line 62: `/index designs` command
- Line 70: `/new designs` command  
- Line 80: `/validate designs` command

Remove these and ensure it matches the design's documentation pattern.

#### 1.4 Create README.md for Other Root Folders
Using the pattern from the design document:
```markdown
# [Folder Name] Structure

## Purpose
Brief description of what this folder contains

## Structure
```
folder/
├── required-file.ext    # Description (REQUIRED)
├── optional-file.ext    # Description (OPTIONAL)
└── subfolder/          # Description
```

## Naming Conventions
- Pattern: `naming-pattern-here`
- Examples: ...

## Required Contents
- What must be in every item

## ⚠️ UNDEFINED STRUCTURE WARNING ⚠️
**This section needs definition. Please update during implementation.**
```

Folders needing README.md:
- features/
- PRPs/
- tests/
- docs/
- .claude/
- templates/

#### 1.5 Create README Template
Create `templates/design-templates/README.template.md` using the pattern from step 1.4:

```bash
cat > templates/design-templates/README.template.md << 'EOF'
# {Folder Name} Structure

## Purpose
{Brief description of what this folder contains}

## Structure
```
{folder}/
├── {required-file.ext}    # {Description} (REQUIRED)
├── {optional-file.ext}    # {Description} (OPTIONAL)
└── {subfolder}/          # {Description}
```

## Naming Conventions
- Pattern: `{naming-pattern-here}`
- Examples: {list examples}

## Required Contents
- {What must be in every item}
- {Another requirement}

## Relationship to Other Folders
- **{Related Folder}**: {How they connect}
- **{Another Folder}**: {Relationship}

## ⚠️ UNDEFINED STRUCTURE WARNING ⚠️
**This section needs definition. Please update during implementation.**
EOF
```

This template will be used to create all root folder README.md files, ensuring consistency.

### Phase 2: Structure Implementation

#### 2.1 Verify Existing Designs Have Frontmatter
Check each design.md file for proper YAML frontmatter.

**Required fields**:
```yaml
---
title: Human-readable title
status: draft|approved|implementing|completed|archived
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: feature|refactor|fix|spike|system
author: Name or identifier
tags: [tag1, tag2]
estimated_effort: small|medium|large
actual_effort: small|medium|large  # Added after completion
---
```

### Phase 3: Migration

#### 3.1 Determine Chronological Order
Based on git history:
1. git-control-design.md (2025-07-12 00:43:51)
2. claude-memory-integration-design.md (2025-07-12 05:00:07)
3. changelog-management-design.md (2025-07-12 19:16:28)
4. standards-documentation-design.md (2025-07-12 19:16:28)
5. analyze-command-design.md (untracked, newest)
6. 005-feature-standardize-designs/ (current design)

#### 3.2 Migration Mapping
```
git-control-design.md → 001-feature-git-control/design.md
claude-memory-integration-design.md → 002-feature-claude-memory/design.md
changelog-management-design.md → 003-feature-changelog-management/design.md
standards-documentation-design.md → 004-system-standards-documentation/design.md
analyze-command-design.md → 006-feature-analyze-command/design.md
005-feature-standardize-designs/ → (already correct)
```

#### 3.3 Update Internal References
Files with references to update:
- PRPs/git-control-rules.md (line 60)
- PRPs/claude-memory-integration.md (lines 5, 52, 54, 56)

### Phase 4: Integration

#### 4.1 Create Design Convention Rule
Create `.claude/rules/project/design-structure.md` following the pattern from test-file-location.md

#### 4.2 Update CLAUDE.md
Add section about design conventions and folder structure.

#### 4.3 Update MASTER_IMPORTS.md
Add the new design-structure rule to imports.

## Implementation Steps

### Step 1: Create Missing Templates
```bash
# Create refactor template
cat > templates/design-templates/refactor-design.template.md << 'EOF'
---
title: {Refactor Title}
status: draft
created: {YYYY-MM-DD}
updated: {YYYY-MM-DD}
type: refactor
author: {Your Name}
tags: []
estimated_effort: {small|medium|large}
---

# {Refactor Title} Design Document

## Executive Summary

{Brief overview of what is being refactored and why. 2-3 sentences.}

## Current State

### Problems
- {Issue with current implementation}
- {Another issue}
- {Performance/maintainability concern}

### Technical Debt
- {Debt item 1}
- {Debt item 2}

## Proposed Refactoring

### Overview
{High-level description of the refactoring approach}

### Changes
1. **{Area 1}**
   - Current: {How it works now}
   - Proposed: {How it will work}
   - Benefit: {Why this is better}

### Migration Strategy
{How to transition from old to new without breaking things}

## Success Criteria
- [ ] {Measurable improvement}
- [ ] {Another success metric}
- [ ] All tests pass
- [ ] No breaking changes

## References
- {Related code/designs}
EOF
```

Create similar templates for: fix, spike, system

### Step 2: Update designs/README.md
Remove references to CLI commands and ensure it follows the current design.

### Step 3: Create Root Folder READMEs
Start with features/README.md as an example:
```markdown
# Features Folder Structure

## Purpose
This folder contains feature request documents that describe desired functionality before design and implementation.

## Structure
```
features/
├── FEATURE_{NAME}.md    # Feature request document (REQUIRED)
└── archive/            # Completed features (OPTIONAL)
```

## Naming Conventions
- Pattern: `FEATURE_{SCREAMING_SNAKE_CASE}.md`
- Examples: 
  - FEATURE_TASK_MANAGEMENT.md
  - FEATURE_GIT_CONTROL.md

## Required Contents
Each feature file must include:
- FEATURE section with bullet points
- EXAMPLES section with references
- DOCUMENTATION section with relevant links
- OTHER CONSIDERATIONS section
- CONTEXT section (optional)

## Relationship to Other Folders
- **Designs**: Features lead to designs in `/designs`
- **PRPs**: Designs lead to PRPs in `/PRPs`
- **Tasks**: Implementation tracked in TASK.md
```

### Step 4: Migrate Existing Designs
```bash
# Create new folders and move files
mkdir -p designs/001-feature-git-control
mv designs/git-control-design.md designs/001-feature-git-control/design.md
mv designs/git-control-diagrams designs/001-feature-git-control/diagrams

# Repeat for others...
```

### Step 5: Add Frontmatter to Designs
For designs missing frontmatter, add it based on git history and content analysis.

### Step 6: Update References
Update all references in PRPs to point to new paths.

### Step 7: Create Design Structure Rule
```yaml
trigger: ["create design", "new design document"]
conditions:
  - directory: "designs/"
  - file_pattern: "*/design.md"
actions:
  - enforce_naming: "{sequence}-{type}-{description}/"
  - require_frontmatter: true
  - suggest_structure: "standard_design"
```

## Validation

### Checklist
- [ ] All design templates created (feature ✓, refactor, fix, spike, system, adr ✓)
- [ ] README template created at templates/design-templates/README.template.md
- [ ] designs/README.md updated without CLI references
- [ ] All root folders have README.md files following the template
- [ ] Existing designs migrated to new structure
- [ ] All designs have proper frontmatter
- [ ] Internal references updated
- [ ] Design structure rule created
- [ ] CLAUDE.md updated with conventions

### Verification Commands
```bash
# Check all designs follow naming pattern
ls -la designs/ | grep -E "^d.*[0-9]{3}-[a-z]+-"

# Verify all design.md files have frontmatter
for f in designs/*/design.md; do
  echo "Checking $f"
  head -n 1 "$f" | grep -q "^---$" || echo "Missing frontmatter: $f"
done

# Check for broken references
grep -r "designs/.*-design\.md" . --include="*.md" | grep -v "designs/[0-9]"

# Verify all root folders have README.md
for dir in features PRPs tests docs .claude templates; do
  [ -f "$dir/README.md" ] && echo "✓ $dir/README.md exists" || echo "✗ $dir/README.md missing"
done

# Check README.md files have required sections
for readme in */README.md; do
  echo "Checking $readme for required sections..."
  grep -q "## Purpose" "$readme" || echo "  Missing: ## Purpose"
  grep -q "## Structure" "$readme" || echo "  Missing: ## Structure"
  grep -q "## Naming Conventions" "$readme" || echo "  Missing: ## Naming Conventions"
done
```

## External Resources

### Documentation
- YAML Frontmatter Specification: https://jekyllrb.com/docs/front-matter/
- Markdown Best Practices: https://www.markdownguide.org/extended-syntax/
- Keep a Changelog Format: https://keepachangelog.com/en/1.1.0/ (for understanding Bootstrap's documentation style)

### Patterns to Follow
- Existing test-file-location.md rule structure
- Changelog entry template format
- Bootstrap's emphasis on self-documenting systems

## Notes for Implementation

1. **Order Matters**: Create templates and documentation first, then migrate
2. **Preserve Git History**: Use `git mv` for renaming to maintain history
3. **Test References**: After migration, test that all internal links work
4. **Incremental Approach**: Can implement in phases if needed
5. **No Breaking Changes**: Old references should produce clear error messages

## Dependencies
- No external dependencies
- Uses only standard Git and filesystem operations
- Compatible with existing Bootstrap conventions

---

**Confidence Score**: 9/10

This PRP provides comprehensive context for implementing the standardized designs folder structure. The implementation is straightforward file operations with clear patterns to follow. The only complexity is ensuring all references are updated correctly, which is addressed with verification commands.