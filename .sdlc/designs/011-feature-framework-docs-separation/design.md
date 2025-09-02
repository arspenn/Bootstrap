# Framework Documentation Separation Design Document

## Executive Summary
This design separates Bootstrap framework documentation from project-specific documentation by establishing `.claude/docs/` as the canonical location for all framework-related documentation. This ensures the framework is self-contained, portable, and maintains clear boundaries between reusable framework components and project-specific implementations.

## Requirements

### Functional Requirements
- Separate framework documentation (how to use Bootstrap) from project documentation (what we're building)
- Move all framework docs to `.claude/docs/` maintaining git history
- Update all references to point to new locations
- Preserve the dual-structure of rules (concise rules + detailed documentation)
- Create templates for all framework file types
- Ensure framework is self-contained when used as a template

### Non-Functional Requirements
- **Portability**: `.claude/` folder must contain everything needed to understand the framework
- **Maintainability**: Clear structure that's easy to navigate and update
- **Performance**: Maintain efficient token usage for rule parsing
- **Compatibility**: Preserve git history for all moved files
- **Usability**: Intuitive organization for both users and Claude

### Constraints
- Must use `git mv` for preserving history
- Framework docs cannot reference project docs (must be standalone)
- Must complete migration in a single atomic operation
- Templates must be created for all framework file types

## Current State Analysis

### Existing Structure
```
Project Root/
├── .claude/
│   ├── rules/           # Concise rule definitions ✓
│   ├── commands/        # Command definitions ✓
│   └── templates/       # Currently empty, needs templates
├── docs/
│   ├── rules/          # Rule documentation (needs moving)
│   ├── ADRs/           # Project ADRs (stays)
│   └── patterns/       # Mixed content (needs review)
├── designs/            # Project designs (stays)
├── features/           # Project features (stays)
└── PRPs/              # Project PRPs (stays)
```

### Identified Patterns
- Rules follow dual-structure: concise definition + detailed documentation
- Documentation is scattered across `/docs/`, making framework boundaries unclear
- Templates exist for project artifacts but not framework components
- Clear naming conventions already established for rules

## Proposed Design

### Overview
Implement a mirror-then-switch migration strategy to safely move all framework documentation to `.claude/docs/` while preserving git history and ensuring no broken references.

### Architecture

#### Final Structure
```
.claude/                         # Self-contained framework
├── docs/                       # All framework documentation
│   ├── framework/             # Core framework guides
│   │   ├── getting-started.md
│   │   ├── configuration.md
│   │   ├── rule-system.md
│   │   ├── command-system.md
│   │   └── workflow.md
│   ├── guides/               # How-to guides
│   │   ├── creating-features.md
│   │   ├── writing-rules.md
│   │   ├── design-process.md
│   │   ├── prp-workflow.md
│   │   └── testing-strategy.md
│   ├── rules/               # Detailed rule documentation
│   │   ├── git/            # Mirrors rule structure
│   │   ├── project/
│   │   ├── testing/
│   │   ├── documentation/
│   │   └── python/
│   ├── reference/          # Technical reference
│   │   ├── rule-metadata.md
│   │   ├── config-schema.md
│   │   ├── command-api.md
│   │   └── template-variables.md
│   └── README.md          # Documentation index
├── rules/                 # Concise rule definitions
├── commands/             # Command definitions
├── templates/            # Framework templates
│   ├── rule.template.md
│   ├── command.template.md
│   ├── rule-doc.template.md
│   ├── config-section.template.yaml
│   └── README.md
├── config.yaml          # Framework configuration
├── MASTER_IMPORTS.md    # Rule import manifest
└── README.md           # Framework overview
```

### Migration Strategy

#### Phase 1: Preparation
1. Create `.claude/docs/` directory structure
2. Create `.claude/templates/` directory
3. Identify all framework documentation to move

#### Phase 2: Migration Execution
1. Use `git mv` to move rule documentation from `/.claude/docs/rules/` to `.claude/docs/rules/`
2. Create new framework guides in `.claude/docs/framework/`
3. Create how-to guides in `.claude/docs/guides/`
4. Create reference documentation in `.claude/docs/reference/`
5. Create templates in `.claude/templates/`

#### Phase 3: Reference Updates
1. Update all file references to new locations
2. Update CLAUDE.md if needed
3. Update any README files with new paths

#### Phase 4: Verification
1. Verify all moved files retained git history
2. Check all references work correctly
3. Ensure no broken links
4. Test rule loading still works

#### Phase 5: Cleanup
1. Remove empty directories
2. Update documentation indices
3. Commit as single atomic change

### Component Details

#### Framework Documentation Categories

**Framework Guides** (`.claude/docs/framework/`)
- Getting started with Bootstrap
- Configuration overview
- Rule system explanation
- Command system overview
- Standard workflow (feature → design → PRP → execute)

**How-To Guides** (`.claude/docs/guides/`)
- Step-by-step instructions for common tasks
- Creating new features
- Writing effective rules
- Design process walkthrough
- PRP generation and execution

**Rule Documentation** (`.claude/docs/rules/`)
- Detailed explanation for each rule
- Examples and use cases
- Rationale and best practices
- Mirrors exact structure of `.claude/rules/`

**Technical Reference** (`.claude/docs/reference/`)
- Rule metadata specification
- Configuration schema
- Command API documentation
- Template variable reference

#### Template System

**Framework Templates** (`.claude/templates/`)
- `rule.template.md`: For creating new rules
- `command.template.md`: For creating new commands
- `rule-doc.template.md`: For rule documentation
- `config-section.template.yaml`: For config additions

### Design Decisions

1. **Mirror-then-Switch Migration** (ADR-001)
   - Safe approach with verification step
   - Preserves git history through `git mv`
   - Allows rollback if issues found

2. **Dual Rule Structure** (ADR-002)
   - Keep concise rules separate from documentation
   - Maintains efficient token usage
   - Provides detailed context when needed

3. **Template Standardization** (ADR-003)
   - Every framework file type has a template
   - Ensures consistency across components
   - Serves as documentation of expected format

## Implementation Plan

### High-Level Tasks
1. Create directory structure in `.claude/docs/`
2. Move rule documentation using `git mv`
3. Create framework guides and how-to documentation
4. Create framework templates
5. Update all references to new locations
6. Verify migration success
7. Update TASK.md with future enhancements
8. Clean up and commit

### Detailed Steps

```bash
# 1. Create new directory structure
mkdir -p .claude/docs/{framework,guides,rules,reference}
mkdir -p .claude/templates

# 2. Move rule documentation (preserve history)
git mv .claude/docs/rules/* .claude/docs/rules/

# 3. Create framework documentation
# (Create new files for framework guides, how-tos, reference)

# 4. Create templates
# (Create template files)

# 5. Update references
# (Use grep to find and update all references)

# 6. Verify
# (Check all links, test rule loading)

# 7. Update TASK.md
# (Add future features identified)

# 8. Commit
git add -A
git commit -m "feat(docs): separate framework documentation into .claude/docs/

- Move all framework documentation to .claude/docs/
- Create comprehensive template system
- Preserve git history for all moved files
- Update all references to new locations
- Establish clear framework/project boundaries"
```

### Migration Checklist
- [ ] Create `.claude/docs/` structure
- [ ] Move `/.claude/docs/rules/` → `.claude/docs/rules/`
- [ ] Create framework guides
- [ ] Create how-to guides  
- [ ] Create reference documentation
- [ ] Create all templates
- [ ] Update all file references
- [ ] Verify git history preserved
- [ ] Test rule loading works
- [ ] Update TASK.md with future features
- [ ] Remove old empty directories
- [ ] Final commit

## Alternative Approaches Considered

### Alternative 1: Complete Migration with Immediate Cleanup
- **Approach**: Direct move and delete in one step
- **Pros**: Clean, no duplication, single source of truth
- **Cons**: Risk of breaking references, no fallback, harder rollback
- **Rejected**: Too risky without verification step

### Alternative 2: Mirror-then-Switch ✓ SELECTED
- **Approach**: Copy, verify, then cleanup
- **Pros**: Safe transition, verification step, easy rollback
- **Cons**: Temporary duplication, extra step
- **Selected**: Best balance of safety and cleanliness

### Alternative 3: Symlink Bridge
- **Approach**: Move files and create symlinks
- **Pros**: No broken references initially
- **Cons**: Platform compatibility issues, adds complexity
- **Rejected**: Not portable, against clean separation goal

## Risks and Mitigations

### Risk 1: Broken References
- **Impact**: High - Could break documentation navigation
- **Probability**: Medium
- **Mitigation**: Use grep to find all references before updating, verify after migration

### Risk 2: Lost Git History
- **Impact**: High - Lose valuable context
- **Probability**: Low (if using git mv)
- **Mitigation**: Use `git mv` command exclusively, verify with `git log --follow`

### Risk 3: Incomplete Migration
- **Impact**: Medium - Confusion about documentation location
- **Probability**: Low
- **Mitigation**: Use comprehensive checklist, systematic approach

### Risk 4: Template Complexity
- **Impact**: Low - May need separate PRP
- **Probability**: Medium
- **Mitigation**: Start with simple templates, enhance iteratively

## Success Criteria

1. **Clean Separation**: Clear distinction between framework and project docs
2. **Complete Migration**: All framework docs in `.claude/docs/`
3. **Preserved History**: Git history maintained for all moved files
4. **No Broken Links**: All references updated and working
5. **Template Coverage**: Templates exist for all framework file types
6. **Self-Contained**: `.claude/` folder has everything needed to understand framework
7. **Updated Documentation**: READMEs and indices reflect new structure

## Future Enhancements

To be added to TASK.md:
- Advanced documentation search functionality
- Customization points for framework extensions in projects
- Auto-read documentation when Claude needs clarification
- Auto-read rules when Claude has questions about behavior
- Cleanup script to prepare framework for new projects
- Documentation versioning strategy
- Cross-reference linking between rules and documentation

## Appendices

### Appendix A: Files to Move

**From `/.claude/docs/rules/` to `.claude/docs/rules/`:**
- All rule documentation files maintaining directory structure

**New Framework Documentation to Create:**
- `.claude/docs/framework/getting-started.md`
- `.claude/docs/framework/configuration.md`
- `.claude/docs/framework/rule-system.md`
- `.claude/docs/framework/command-system.md`
- `.claude/docs/framework/workflow.md`
- `.claude/docs/guides/creating-features.md`
- `.claude/docs/guides/writing-rules.md`
- `.claude/docs/guides/design-process.md`
- `.claude/docs/guides/prp-workflow.md`
- `.claude/docs/guides/testing-strategy.md`

**Templates to Create:**
- `.claude/templates/rule.template.md`
- `.claude/templates/command.template.md`
- `.claude/templates/rule-doc.template.md`
- `.claude/templates/config-section.template.yaml`
- `.claude/templates/README.md`

### Appendix B: Reference Update Patterns

```bash
# Find all references to old documentation
grep -r ".claude/docs/rules/" --include="*.md"

# Update references (examples)
# Old: [Rule Documentation](.claude/docs/rules/git/git-commit-format.md)
# New: [Rule Documentation](.claude/docs/rules/git/git-commit-format.md)
```