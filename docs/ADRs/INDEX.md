# ADR Index

## Overview

This index provides a comprehensive listing of all Architecture Decision Records (ADRs) in the Bootstrap project. ADRs document important architectural decisions and their rationale.

### ADR Organization

We use a hybrid approach for organizing ADRs:
- **Project-wide ADRs** are stored in `docs/ADRs/` and affect the entire framework
- **Design-specific ADRs** are stored with their features in `designs/*/adrs/` and document feature-specific decisions

### Classification Criteria

**Project-wide ADRs** include decisions that:
- Affect multiple features or the entire codebase
- Establish conventions or standards
- Define technology choices used across features
- Set security or performance policies
- Impact the development workflow
- Define architectural patterns or principles

**Design-specific ADRs** include decisions that:
- Only affect the specific feature implementation
- Document trade-offs unique to that feature
- Explain implementation choices within established conventions
- Describe optimizations specific to the feature

## Project-wide ADRs

Located in `docs/ADRs/`

### Architecture & Framework
- [ADR-001](./ADR-001-git-rules-architecture.md) - Git Rules Architecture: One Rule Per File
- [ADR-004](./ADR-004-rule-instruction-separation.md) - Separation of Rule Instructions from Documentation
- [ADR-005](./ADR-005-master-import-strategy.md) - Master Import File Strategy
- [ADR-006](./ADR-006-comprehensive-framework-pivot.md) - Pivot to Comprehensive AI Development Framework
- [ADR-009](./ADR-009-no-automatic-fallback-principle.md) - No Automatic Fallback Principle

### Development Process
- [ADR-002](./ADR-002-git-commit-standards.md) - Git Commit Standards
- [ADR-003](./ADR-003-branching-strategy.md) - Git Branching Strategy
- [ADR-007](./ADR-007-changelog-automation-level.md) - Changelog Automation Level
- [ADR-008](./ADR-008-design-numbering-convention.md) - Design Numbering Convention

## Design-specific ADRs

### Feature: Standardize Designs (005)
Located in `designs/005-feature-standardize-designs/adrs/`
- [ADR-001](../../designs/005-feature-standardize-designs/adrs/ADR-001-metadata-based-status-tracking.md) - Metadata-based Status Tracking
- [ADR-003](../../designs/005-feature-standardize-designs/adrs/ADR-003-no-index-filesystem-navigation.md) - No Index File - Direct Filesystem Navigation
- Note: ADR-002 moved to project-wide as ADR-008

### Feature: Analyze Command (006)
Located in `designs/006-feature-analyze-command/adrs/`
- [ADR-001](../../designs/006-feature-analyze-command/adrs/ADR-001-modular-analyzer-architecture.md) - Modular Analyzer Architecture

### Feature: Git-Safe File Operations (007)
Located in `designs/007-feature-git-safe-file-operations/adrs/`
- [ADR-002](../../designs/007-feature-git-safe-file-operations/adrs/ADR-002-medium-security-level.md) - Medium Security Level for Override Capability
- [ADR-003](../../designs/007-feature-git-safe-file-operations/adrs/ADR-003-path-specific-status-checks.md) - Path-Specific Git Status Checks
- Note: ADR-001 moved to project-wide as ADR-009

## Quick Reference

| ADR | Title | Location | Status |
|-----|-------|----------|--------|
| ADR-001 | Git Rules Architecture | Project-wide | Accepted |
| ADR-002 | Git Commit Standards | Project-wide | Accepted |
| ADR-003 | Branching Strategy | Project-wide | Accepted |
| ADR-004 | Rule Instruction Separation | Project-wide | Accepted |
| ADR-005 | Master Import Strategy | Project-wide | Accepted |
| ADR-006 | Comprehensive Framework Pivot | Project-wide | Accepted |
| ADR-007 | Changelog Automation Level | Project-wide | Accepted |
| ADR-008 | Design Numbering Convention | Project-wide | Accepted |
| ADR-009 | No Automatic Fallback Principle | Project-wide | Accepted |
| 005/ADR-001 | Metadata-based Status Tracking | Design-specific | Proposed |
| 005/ADR-003 | No Index Filesystem Navigation | Design-specific | Proposed |
| 006/ADR-001 | Modular Analyzer Architecture | Design-specific | Proposed |
| 007/ADR-002 | Medium Security Level | Design-specific | Proposed |
| 007/ADR-003 | Path-Specific Status Checks | Design-specific | Proposed |

## Maintenance Notes

- This index should be updated whenever a new ADR is created
- Use the `scripts/adr-tools.py` script to validate and update this index
- When ADRs are superseded or deprecated, update their status and link to the replacement