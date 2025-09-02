# ADR Standardization Feature Design

## Feature Overview
Standardize the location and organization of Architecture Decision Records (ADRs) across the Bootstrap project using a hybrid approach that keeps design-specific ADRs with their designs while maintaining project-wide ADRs in a central location.

## Problem Statement
Currently, ADRs are scattered across the project:
- 5 ADRs in `docs/ADRs/` (project-wide decisions)
- 10 ADRs in various design folders
- 2 orphaned ADRs in `designs/claude-memory-integration-adrs/`

This inconsistency makes it difficult to:
1. Find relevant architectural decisions
2. Understand the full architectural landscape
3. Maintain consistency in decision documentation
4. Avoid duplicate or conflicting decisions

## Proposed Solution

### Hybrid ADR Organization
Implement a hybrid approach that leverages the benefits of both centralized and distributed ADR storage:

1. **Project-wide ADRs** → `docs/ADRs/`
   - Framework architecture decisions
   - Technology choices
   - Global conventions
   - Cross-cutting concerns
   - Security policies
   - Development workflow decisions

2. **Design-specific ADRs** → `designs/*/adrs/`
   - Implementation choices for specific features
   - Feature-specific trade-offs
   - Local optimizations
   - Design pattern choices within the feature

3. **Central ADR Index** → `docs/ADRs/INDEX.md`
   - Complete listing of all ADRs (both central and distributed)
   - Categorized by type and impact area
   - Quick reference with summaries
   - Decision impact matrix

### Classification Criteria

#### Project-wide ADR Criteria
An ADR belongs in `docs/ADRs/` if it:
- Affects multiple features or the entire codebase
- Establishes conventions or standards
- Defines technology choices used across features
- Sets security or performance policies
- Impacts the development workflow
- Defines architectural patterns or principles

#### Design-specific ADR Criteria
An ADR belongs with its design if it:
- Only affects the specific feature implementation
- Documents trade-offs unique to that feature
- Explains implementation choices within established conventions
- Describes optimizations specific to the feature
- Won't impact other features or future development

### Migration Plan

#### Phase 1: Establish Structure
1. Create `docs/ADRs/INDEX.md` with initial structure
2. Document classification criteria
3. Create ADR template for consistent formatting

#### Phase 2: Classify Existing ADRs
1. Review all existing ADRs against classification criteria
2. Create migration list with target locations
3. Handle orphaned ADRs:
   - `ADR-004-rule-instruction-separation.md` → Move to `docs/ADRs/` (affects all rules)
   - `ADR-005-master-import-strategy.md` → Move to `docs/ADRs/` (affects framework)

#### Phase 3: Execute Migration
1. Move ADRs to their appropriate locations
2. Update all references and links
3. Ensure consistent numbering within each location
4. Update the central index

#### Phase 4: Establish Process
1. Update CLAUDE.md with ADR location guidelines
2. Create ADR creation workflow documentation
3. Add ADR location decision to design template

## Implementation Details

### ADR Numbering Convention
- **Project-wide**: `ADR-XXX-descriptive-name.md` (continuous numbering)
- **Design-specific**: `ADR-XXX-descriptive-name.md` (per-design numbering)

### Index Structure
```markdown
# ADR Index

## Project-wide ADRs
Located in `docs/ADRs/`

### Architecture & Framework
- [ADR-001](./ADR-001-git-rules-architecture.md) - Git Rules Architecture: One Rule Per File
- [ADR-006](./ADR-006-comprehensive-framework-pivot.md) - Pivot to Comprehensive AI Framework

### Development Process
- [ADR-002](./ADR-002-git-commit-standards.md) - Git Commit Standards
- [ADR-007](./ADR-007-changelog-automation-level.md) - Changelog Automation Level

## Design-specific ADRs

### Feature: Standardize Designs (005)
- [ADR-001](../designs/005-feature-standardize-designs/adrs/ADR-001-metadata-based-status-tracking.md) - Metadata-based Status Tracking
- [ADR-002](../designs/005-feature-standardize-designs/adrs/ADR-002-sequential-numbering-scheme.md) - Sequential Numbering Scheme

[Additional categories and entries...]
```

### Migration Checklist
- [ ] Create INDEX.md structure
- [ ] Move orphaned ADRs to docs/ADRs/
- [ ] Update ADR numbers for consistency
- [ ] Update all cross-references
- [ ] Add classification guidelines to CLAUDE.md
- [ ] Update design template with ADR guidance
- [ ] Create ADR template if missing
- [ ] Document the new ADR workflow

## Benefits
1. **Discoverability**: Central index provides overview of all decisions
2. **Context**: Design-specific ADRs stay with their implementation context
3. **Clarity**: Clear criteria for ADR placement
4. **Consistency**: Standardized structure and numbering
5. **Maintainability**: Easier to manage and update ADRs

## Risks and Mitigation
- **Risk**: Confusion about where to place new ADRs
  - **Mitigation**: Clear classification criteria and examples
- **Risk**: Broken links during migration
  - **Mitigation**: Systematic link update process
- **Risk**: Duplicate ADR numbers
  - **Mitigation**: Separate numbering per location

## Success Criteria
- All ADRs properly classified and located
- No orphaned ADRs remaining
- Central index accurately reflects all ADRs
- Clear guidelines documented in CLAUDE.md
- No broken ADR references in the codebase