# ADR-001: SDLC Directory Structure Consolidation

## Status
Proposed

## Context
The Bootstrap framework currently spreads SDLC (Software Development Life Cycle) artifacts across multiple root-level directories:
- `features/` - Feature specifications
- `designs/` - Design documents
- `PRPs/` - Project Requirement Plans
- `docs/ADRs/` - Architecture Decision Records

This creates a cluttered root directory that makes it difficult to distinguish between:
1. Framework configuration and documentation
2. Project-specific SDLC artifacts
3. Source code and tests

As we prepare for alpha release, we need a cleaner, more organized structure that clearly separates concerns.

## Decision
We will consolidate all SDLC-generated artifacts into a single `.sdlc/` directory at the project root. This hidden directory will contain:
- `.sdlc/features/` - All feature specifications
- `.sdlc/designs/` - All design documents
- `.sdlc/PRPs/` - All Project Requirement Plans
- `.sdlc/ADRs/` - All Architecture Decision Records

The dot-prefix makes it a hidden directory, indicating it contains framework-managed files rather than source code.

## Consequences

### Positive
- **Cleaner root directory**: Only essential files (README, CHANGELOG, TASK) remain visible at root
- **Clear separation**: SDLC artifacts are clearly separated from source code
- **Consistent location**: All framework-generated files in one predictable place
- **Easier .gitignore management**: Can ignore/include all SDLC files with single pattern
- **Better IDE experience**: Hidden directory reduces clutter in file explorers
- **Framework identity**: `.sdlc` clearly indicates Bootstrap framework usage

### Negative
- **Hidden by default**: Users must explicitly show hidden files to see SDLC content
- **Path updates required**: All commands and rules must be updated to new paths
- **Learning curve**: Users must learn new directory structure
- **Existing projects**: Would require migration (not applicable pre-alpha)

### Neutral
- **Git history**: Will be preserved through `git mv` operations
- **Sequential numbering**: Will continue to work in new locations
- **File references**: Historical documents (PRPs, designs) won't be updated