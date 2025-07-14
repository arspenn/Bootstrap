---
title: Claude Memory Integration Design
status: completed
created: 2024-12-05
updated: 2024-12-05
type: feature
author: Bootstrap Team
tags: [claude, memory, import, rules]
estimated_effort: medium
actual_effort: medium
---

# Claude Memory Integration Design Document

## Executive Summary

This design document outlines the integration of Claude Code's memory import feature (@file syntax) with our existing rule system. The primary goal is to restructure rules to contain only direct behavioral instructions while moving all documentation (examples, rationale, scenarios) to separate documentation files. This separation enables proper automatic rule loading via Claude's import mechanism while maintaining comprehensive documentation for users.

## Requirements

### Functional Requirements
- Integrate Claude's @import syntax for automatic rule loading
- Separate instructions from documentation in rule files
- Maintain YAML format for unambiguous rule definitions
- Create master import file for clean CLAUDE.md
- Enable user preferences to control rule imports
- Preserve bidirectional references between rules and documentation

### Non-Functional Requirements
- **Performance**: Maintain token overhead under 10%
- **Modularity**: Keep one-rule-per-file architecture
- **Compatibility**: Preserve existing user preference system
- **Maintainability**: Clear separation of concerns
- **Import Depth**: Stay within Claude's 5-hop limit
- **Version**: Consider this version 1.1.2

## Current State Analysis

### Existing Structure
```
.claude/rules/git/
├── git-add-safety.md (2,908 bytes - mixed content)
├── git-commit-format.md (5,403 bytes - mixed content)
├── git-push-validation.md (4,648 bytes - mixed content)
├── git-pull-strategy.md (4,889 bytes - mixed content)
└── git-branch-naming.md (6,289 bytes - mixed content)
```

Current rule files contain:
- Metadata (ID, Status, Security Level, Token Impact)
- Description sections
- YAML rule definitions
- Rationale explanations
- Multiple examples (good and bad)
- Best practices
- Common scenarios
- Related rules references

### Problems with Current Approach
1. Rules are referenced but not imported in CLAUDE.md
2. Documentation mixed with instructions (15+ documentation sections across 5 rules)
3. Files too large for direct behavioral instructions
4. No automatic loading mechanism

## Proposed Design

### Overview
Implement a clean separation between rule instructions and documentation, using Claude's @import syntax for automatic rule loading via a master import file.

### Architecture

#### File Structure
```
.claude/
├── MASTER_IMPORTS.md              # Single import point
└── rules/
    └── git/
        ├── git-add-safety.md      # Instructions only (~500 bytes)
        ├── git-commit-format.md   # Instructions only
        └── ...

docs/rules/
└── git/
    ├── git-add-safety.md          # Full documentation
    ├── git-commit-format.md       # Full documentation
    └── ...
```

#### Rule File Format (Instructions Only)
```markdown
# Rule: Git Add Safety

## ID: git/git-add-safety
## Status: Active
## Security Level: High
## Token Impact: ~50 tokens per git add operation

## Instructions
```yaml
trigger: "git add"
conditions:
  - command_contains: ["add", "stage"]
actions:
  - require_status_check: true
  - forbid_commands: ["git add .", "git add -A", "git add --all"]
  - require_explicit_paths: true
  - check_file_patterns: ["*.env", "*.key", "*.pem", "*_secret*", "*password*"]
validations:
  - max_file_size: 10MB
  - warn_on_binary: true
  - require_diff_review: true
```

See documentation: `docs/rules/git/git-add-safety.md`
```

#### Documentation File Format
```markdown
# Git Add Safety - Documentation

## Rule Reference: `.claude/rules/git/git-add-safety.md`

## Overview
[Current description content]

## Rationale
[Current rationale content]

## Examples
[All current examples]

## Best Practices
[Current best practices]

## Common Scenarios
[Current scenarios]

## Troubleshooting
[New section for common issues]
```

#### Master Import File
```markdown
# Claude Rule Imports
# This file is imported by CLAUDE.md to load all active rules

## Git Rules
@.claude/rules/git/git-add-safety.md
@.claude/rules/git/git-commit-format.md
@.claude/rules/git/git-push-validation.md
@.claude/rules/git/git-pull-strategy.md
@.claude/rules/git/git-branch-naming.md

## Future Rule Categories
# @.claude/rules/testing/*.md
# @.claude/rules/documentation/*.md
```

### Design Decisions
1. **YAML Format Retention** (ADR-004): Keep structured format for clarity
2. **Master Import Strategy** (ADR-005): Single import point for cleanliness
3. **Bidirectional References**: Rules link to docs, docs link to rules
4. **Minimal Metadata**: Keep only essential metadata in rules

## Alternative Approaches Considered

### Alternative 1: Natural Language Instructions
Convert YAML to prose instructions for more natural reading.

**Rejected because**:
- YAML provides unambiguous structure
- Easier to parse programmatically
- Reduces interpretation errors

### Alternative 2: Consolidated Category Files
Merge all rules in a category into single files.

**Rejected because**:
- Loses modularity
- Harder to enable/disable individual rules
- Conflicts with one-rule-per-file principle

### Alternative 3: No Documentation Separation
Keep current structure but add imports.

**Rejected because**:
- Too verbose for behavioral instructions
- High token overhead
- Mixes concerns

## Implementation Plan

### Phase 1: Infrastructure Setup
1. Create MASTER_IMPORTS.md file
2. Update CLAUDE.md with single import
3. Create docs/rules/git/ directory structure

### Phase 2: Rule Extraction
For each existing rule:
1. Copy file to docs/rules/git/
2. Extract instructions to keep in .claude/rules/git/
3. Add cross-references
4. Reduce rule file to essentials

### Phase 3: Documentation Enhancement
1. Enhance documentation with troubleshooting sections
2. Add more examples where helpful
3. Improve cross-referencing
4. Create documentation index

### Phase 4: Testing
1. Verify imports work correctly
2. Test rule application
3. Validate documentation links
4. Check token usage

### Phase 5: Future Preparation
1. Create templates for new rule categories
2. Document the process
3. Update contribution guidelines

## Risks and Mitigations

### Technical Risks
- **Import failures**: Test thoroughly, have fallback instructions
- **Broken references**: Automated link checking
- **Token overhead**: Monitor usage, optimize if needed

### Process Risks
- **Maintenance overhead**: Automate where possible
- **Confusion about where to look**: Clear documentation, good indexing
- **Version conflicts**: Clear versioning strategy

## Success Criteria
1. ✓ All rules successfully import via @syntax
2. ✓ Rules contain only instructions (500 bytes avg vs 5KB current)
3. ✓ Documentation remains comprehensive and accessible
4. ✓ Token overhead stays under 10%
5. ✓ Bidirectional references work correctly
6. ✓ User preferences continue to function

## Implementation Checklist
- [ ] Create MASTER_IMPORTS.md
- [ ] Update CLAUDE.md with import
- [ ] Create docs/rules/git/ structure
- [ ] Extract instructions for all 5 Git rules
- [ ] Move documentation content
- [ ] Add cross-references
- [ ] Test import mechanism
- [ ] Verify rule application
- [ ] Update tests
- [ ] Document changes

## Future Considerations
- Automated rule/doc synchronization
- Import optimization for large rule sets
- Conditional imports based on user preferences
- Rule versioning system
- Testing framework for rule compliance