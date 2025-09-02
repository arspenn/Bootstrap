name: "Framework Documentation Separation - Complete Migration"
description: |

## Purpose
Separate Bootstrap framework documentation from project-specific documentation by migrating all framework docs to `.claude/docs/`, ensuring the framework is self-contained, portable, and maintains clear boundaries.

## Core Principles
1. **Preserve Git History**: Use `git mv` for all file moves
2. **Atomic Operation**: Complete migration in one commit
3. **No Broken References**: Update all links as part of migration
4. **Complete Separation**: Framework docs must not reference project docs
5. **Global rules**: Follow all rules in CLAUDE.md, especially git-safe-file-operations

---

## Goal
Move all Bootstrap framework documentation to `.claude/docs/` to establish clear separation between reusable framework components (in `.claude/`) and project-specific implementation (in project folders). Create all necessary templates and documentation structure for a self-contained framework.

## Why
- Framework portability: When Bootstrap is used as a template, `.claude/` contains everything needed
- Clear boundaries: Instant identification of framework vs project documentation
- No confusion: Users know exactly where to find framework guides vs project decisions
- Template-ready: New projects get complete framework docs without project-specific content

## What
Complete migration of framework documentation with:
- All rule documentation moved from `/.claude/docs/rules/` to `.claude/docs/rules/`
- New framework guides, how-tos, and reference documentation created
- Templates for all framework file types in `.claude/templates/`
- Updated references throughout the codebase
- Future enhancement items added to TASK.md

### Success Criteria
- [ ] All rule documentation moved to `.claude/docs/rules/` with git history preserved
- [ ] Framework guides created in `.claude/docs/framework/`
- [ ] How-to guides created in `.claude/docs/guides/`
- [ ] All templates created in `.claude/templates/`
- [ ] All references updated to new locations
- [ ] TASK.md updated with future features
- [ ] No broken links or missing documentation
- [ ] Single atomic commit with clear message

## All Needed Context

### Documentation & References
```yaml
# Design document with full requirements
- file: designs/011-feature-framework-docs-separation/design.md
  why: Complete design with migration strategy, ADRs, and final structure

# Migration strategy ADR
- file: designs/011-feature-framework-docs-separation/adrs/ADR-001-mirror-then-switch-migration.md
  why: Approved approach for safe migration with git history preservation

# Git safe operations rule
- file: .claude/rules/git/git-safe-file-operations.md
  why: Must use git mv commands for all file movements

# Existing rule documentation pattern
- file: .claude/rules/project/changelog-update.md
  why: Shows rule metadata structure and documentation link pattern

# Template examples
- file: templates/design-templates/adr.template.md
  why: Example of existing template structure to follow

# PRP base template
- file: PRPs/templates/prp_base.md
  why: Shows documentation structure patterns

# Command structure example
- file: .claude/commands/design-feature.md
  why: Example command documentation format
```

### Current Codebase Structure
```bash
# Rule documentation to move (20 files total)
.claude/docs/rules/
├── git/
│   ├── README.md
│   ├── git-add-safety.md
│   ├── git-branch-naming.md
│   ├── git-commit-format.md
│   ├── git-pull-strategy.md
│   ├── git-push-validation.md
│   ├── git-safe-file-operations.md
│   ├── git-safe-file-operations-integration.md
│   └── git-safe-file-operations-migration.md
├── project/
│   ├── adr-management.md
│   ├── changelog-format.md
│   ├── changelog-update.md
│   ├── code-structure.md
│   ├── planning-context.md
│   ├── test-file-location.md
│   └── version-management.md
├── documentation/
│   └── docstring-format.md
├── python/
│   ├── code-style.md
│   └── environment-management.md
└── testing/
    └── pytest-requirements.md
```

### Desired Structure
```bash
.claude/
├── docs/                           # All framework documentation
│   ├── framework/                  # Core framework guides (5 new files)
│   │   ├── getting-started.md
│   │   ├── configuration.md
│   │   ├── rule-system.md
│   │   ├── command-system.md
│   │   └── workflow.md
│   ├── guides/                     # How-to guides (5 new files)
│   │   ├── creating-features.md
│   │   ├── writing-rules.md
│   │   ├── design-process.md
│   │   ├── prp-workflow.md
│   │   └── testing-strategy.md
│   ├── rules/                      # Moved rule docs (20 files)
│   │   ├── git/                    # (9 files moved here)
│   │   ├── project/                # (7 files moved here)
│   │   ├── documentation/          # (1 file moved here)
│   │   ├── python/                 # (2 files moved here)
│   │   └── testing/                # (1 file moved here)
│   ├── reference/                  # Technical reference (4 new files)
│   │   ├── rule-metadata.md
│   │   ├── config-schema.md
│   │   ├── command-api.md
│   │   └── template-variables.md
│   └── README.md                   # Documentation index (1 new file)
├── templates/                       # Framework templates (5 new files)
│   ├── rule.template.md
│   ├── command.template.md
│   ├── rule-doc.template.md
│   ├── config-section.template.yaml
│   └── README.md
└── (existing rules/, commands/, etc.)
```

### Known Gotchas & Critical Patterns
```bash
# CRITICAL: Must use git mv to preserve history (per git-safe-file-operations rule)
git mv .claude/docs/rules/git/*.md .claude/docs/rules/git/

# PATTERN: Rule documentation links in rule files
# Current: .claude/docs/rules/git/git-commit-format.md
# New: .claude/docs/rules/git/git-commit-format.md

# GOTCHA: Some rules reference their documentation with relative paths
# Example: ../../../.claude/docs/rules/git/git-safe-file-operations.md
# Must update to: ../../.claude/docs/rules/git/git-safe-file-operations.md

# PATTERN: Test files check for both rule and documentation existence
# See tests/test_final_validation.py lines 31-52 for validation patterns

# CRITICAL: 50 files have references to ".claude/docs/rules/" that need updating
# Use grep to find and sed to update references
```

## Implementation Blueprint

### List of tasks to be completed in order

```yaml
Task 1 - Create Directory Structure:
  CREATE .claude/docs/framework/:
    - Create directory for framework guides
  CREATE .claude/docs/guides/:
    - Create directory for how-to guides
  CREATE .claude/docs/rules/:
    - Create directory structure mirroring current .claude/docs/rules/
  CREATE .claude/docs/reference/:
    - Create directory for technical reference
  CREATE .claude/templates/:
    - Create directory for framework templates

Task 2 - Move Rule Documentation with Git History:
  EXECUTE git commands:
    - git mv .claude/docs/rules/git/*.md .claude/docs/rules/git/
    - git mv .claude/docs/rules/project/*.md .claude/docs/rules/project/
    - git mv .claude/docs/rules/documentation/*.md .claude/docs/rules/documentation/
    - git mv .claude/docs/rules/python/*.md .claude/docs/rules/python/
    - git mv .claude/docs/rules/testing/*.md .claude/docs/rules/testing/

Task 3 - Update References in Rule Files:
  MODIFY each rule file in .claude/rules/:
    - FIND pattern: ".claude/docs/rules/{category}/{rule}.md"
    - REPLACE with: ".claude/docs/rules/{category}/{rule}.md"
    - Update relative paths: "../../../docs/" becomes "../../docs/"
  Files to update (examples):
    - .claude/rules/git/git-commit-format.md
    - .claude/rules/project/changelog-update.md
    - All other rule files with documentation links

Task 4 - Update References in Other Files:
  FIND AND UPDATE references in:
    - Tests (tests/test_final_validation.py, tests/test_git_rules.py, etc.)
    - Designs (designs/*/design.md files)
    - PRPs (PRPs/*.md files)
    - Features (features/*.md files)
    - Root files (README.md, CHANGELOG.md, TASK.md)
  PATTERN: ".claude/docs/rules/" → ".claude/docs/rules/"

Task 5 - Create Framework Documentation:
  CREATE .claude/docs/framework/getting-started.md:
    - Overview of Bootstrap framework
    - Quick start guide
    - Core concepts
  CREATE .claude/docs/framework/configuration.md:
    - config.yaml structure
    - CLAUDE.md configuration
    - Rule loading mechanism
  CREATE .claude/docs/framework/rule-system.md:
    - How rules work
    - Rule metadata format
    - Rule priority and conflicts
  CREATE .claude/docs/framework/command-system.md:
    - Available commands
    - Creating custom commands
    - Command execution flow
  CREATE .claude/docs/framework/workflow.md:
    - Feature → Design → PRP → Execute workflow
    - Best practices
    - Integration patterns

Task 6 - Create How-To Guides:
  CREATE .claude/docs/guides/creating-features.md:
    - Using FEATURE_TEMPLATE.md
    - Writing effective feature requests
    - Examples and patterns
  CREATE .claude/docs/guides/writing-rules.md:
    - Rule structure and metadata
    - Testing rules
    - Common patterns
  CREATE .claude/docs/guides/design-process.md:
    - Using design-feature command
    - Creating ADRs
    - Design documentation standards
  CREATE .claude/docs/guides/prp-workflow.md:
    - Using generate-prp command
    - PRP structure and best practices
    - Validation strategies
  CREATE .claude/docs/guides/testing-strategy.md:
    - Test organization
    - Testing patterns
    - Validation gates

Task 7 - Create Framework Templates:
  CREATE .claude/templates/rule.template.md:
    - Standard rule structure with metadata
    - Placeholders for all required sections
  CREATE .claude/templates/command.template.md:
    - Command documentation template
    - Include process steps and examples
  CREATE .claude/templates/rule-doc.template.md:
    - Detailed rule documentation template
    - Examples and rationale sections
  CREATE .claude/templates/config-section.template.yaml:
    - Template for adding config sections
    - Include validation and defaults
  CREATE .claude/templates/README.md:
    - Explain template usage
    - List all available templates

Task 8 - Create Reference Documentation:
  CREATE .claude/docs/reference/rule-metadata.md:
    - Complete metadata specification
    - Priority levels and meanings
    - Security levels explained
  CREATE .claude/docs/reference/config-schema.md:
    - Full config.yaml schema
    - All available options
    - Default values
  CREATE .claude/docs/reference/command-api.md:
    - Command structure
    - Arguments and options
    - Extension points
  CREATE .claude/docs/reference/template-variables.md:
    - Available template variables
    - Substitution patterns
    - Examples

Task 9 - Create Documentation Index:
  CREATE .claude/docs/README.md:
    - Table of contents for all docs
    - Quick navigation links
    - Documentation organization explanation

Task 10 - Update TASK.md:
  MODIFY TASK.md:
    - ADD section "## Future Features"
    - ADD: "- Advanced documentation search functionality"
    - ADD: "- Customization points for framework extensions in projects"
    - ADD: "- Auto-read documentation when Claude needs clarification"
    - ADD: "- Auto-read rules when Claude has questions about behavior"
    - ADD: "- Cleanup script to prepare framework for new projects"

Task 11 - Clean Up and Verify:
  REMOVE empty directories:
    - rmdir .claude/docs/rules/* (after verifying all files moved)
  VERIFY all references:
    - grep -r ".claude/docs/rules/" to ensure no missed references
  TEST rule loading:
    - Ensure CLAUDE.md still loads rules correctly
```

### Per-task Details

```bash
# Task 2 - Git Move Commands (preserve history)
mkdir -p .claude/docs/rules/{git,project,documentation,python,testing}
git mv .claude/docs/rules/git/*.md .claude/docs/rules/git/
git mv .claude/docs/rules/project/*.md .claude/docs/rules/project/
git mv .claude/docs/rules/documentation/*.md .claude/docs/rules/documentation/
git mv .claude/docs/rules/python/*.md .claude/docs/rules/python/
git mv .claude/docs/rules/testing/*.md .claude/docs/rules/testing/

# Task 4 - Reference Update Pattern
# Find all files with references
grep -r ".claude/docs/rules/" --include="*.md" --include="*.py" | cut -d: -f1 | sort -u

# For each file, update references
# Example sed command (adjust for each file):
sed -i 's|.claude/docs/rules/|.claude/docs/rules/|g' <filename>

# Task 5-8 - Documentation Creation
# Each new file should follow existing patterns
# Use clear headings, examples, and cross-references
# Link to related documentation where appropriate
```

## Validation Loop

### Level 1: File Movement Verification
```bash
# Verify all files moved with history
git log --follow .claude/docs/rules/git/git-commit-format.md
# Expected: Shows full history from original location

# Check no files left behind
ls -la .claude/docs/rules/
# Expected: Directory should be empty or not exist
```

### Level 2: Reference Validation
```bash
# Check for any remaining old references
grep -r ".claude/docs/rules/" --include="*.md" --include="*.py"
# Expected: No results (all updated)

# Verify rule files point to correct documentation
grep -h "Full Documentation" .claude/rules/**/*.md
# Expected: All paths start with .claude/docs/rules/
```

### Level 3: Structure Validation
```bash
# Verify new structure matches design
tree .claude/docs/
# Expected: Matches desired structure with all files present

# Count files to ensure complete migration
find .claude/docs/rules -name "*.md" | wc -l
# Expected: 20 files (all rule documentation)

find .claude/templates -name "*.md" -o -name "*.yaml" | wc -l
# Expected: 5 files (all templates)
```

### Level 4: Rule Loading Test
```bash
# Test that CLAUDE.md still loads rules correctly
grep -A5 "Rule Loading" CLAUDE.md
# Expected: Shows @.claude/MASTER_IMPORTS.md

# Verify MASTER_IMPORTS still works
head -20 .claude/MASTER_IMPORTS.md
# Expected: Shows all rule imports
```

## Final Validation Checklist
- [ ] All 20 rule documentation files moved to `.claude/docs/rules/`
- [ ] Git history preserved for all moved files (`git log --follow` works)
- [ ] All references updated (no ".claude/docs/rules/" references remain)
- [ ] 5 framework guide files created in `.claude/docs/framework/`
- [ ] 5 how-to guide files created in `.claude/docs/guides/`
- [ ] 4 reference documentation files created in `.claude/docs/reference/`
- [ ] 5 template files created in `.claude/templates/`
- [ ] Documentation index created at `.claude/docs/README.md`
- [ ] TASK.md updated with future features
- [ ] Rule loading still works (CLAUDE.md → MASTER_IMPORTS.md → rules)
- [ ] No broken links or missing files
- [ ] Clean git status ready for single commit

---

## Anti-Patterns to Avoid
- ❌ Don't use `mv` instead of `git mv` - loses history
- ❌ Don't move files without updating references - breaks links
- ❌ Don't create documentation without examples - reduces usefulness
- ❌ Don't skip validation - might miss broken references
- ❌ Don't commit partially completed migration - should be atomic
- ❌ Don't mix project docs into framework docs - breaks separation

## Commit Message Template
```
feat(docs): separate framework documentation into .claude/docs/

- Move all rule documentation to .claude/docs/rules/ with git history
- Create comprehensive framework guides in .claude/docs/framework/
- Add how-to guides for common tasks in .claude/docs/guides/
- Create reference documentation in .claude/docs/reference/
- Add templates for all framework file types in .claude/templates/
- Update all references throughout codebase to new locations
- Add future feature items to TASK.md
- Preserve git history for all moved files using git mv

This establishes clear separation between Bootstrap framework 
documentation (in .claude/) and project-specific documentation,
making the framework self-contained and portable.
```

---

## Confidence Score: 9/10

This PRP provides comprehensive context for one-pass implementation:
- Complete file listing of what to move and create
- Exact git commands to preserve history
- All reference patterns that need updating
- Template structures based on existing patterns
- Validation commands to ensure success
- Clear task order with dependencies

The only reason it's not 10/10 is that creating good documentation content (guides, references) requires some creative writing that may need minor adjustments.