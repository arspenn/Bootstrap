---
title: Root Directory Cleanup
status: draft
created: 2025-09-02
updated: 2025-09-02
type: feature
author: Claude
tags: [cleanup, organization, alpha-prep]
estimated_effort: small
---

# Root Directory Cleanup Design Document

## Executive Summary

Remove obsolete directories and files from the project root to prepare for alpha release. This includes deleting the old test suite, unused scripts, empty directories, and obsolete templates while preserving informal response files by adding them to `.gitignore`.

## Requirements

### Functional Requirements
- Delete obsolete directories: benchmarks/, docs/, PRPs/, scripts/, tests/
- Delete obsolete file: FEATURE_TEMPLATE.md
- Add responses/ directory to .gitignore
- Preserve git history for all deletions
- Document the cleanup operation

### Non-Functional Requirements
- **Safety**: Use git-safe operations for all deletions
- **Reversibility**: Changes can be reverted via git history
- **Clarity**: Clear commit message explaining the cleanup
- **Documentation**: Update relevant documentation if needed

## Current State Analysis

### Root Directory Structure (Current)
```
Bootstrap/
├── benchmarks/          # 3 benchmark files (obsolete)
├── docs/                # Obsolete placeholder documentation (delete)
│   ├── patterns/        # Obsolete pattern docs (delete)
│   ├── PR/              # Historical PR summary (delete)
│   └── templates/       # Empty directory (delete)
├── PRPs/                # Empty directory (delete)
├── responses/           # 9 historical response files (ignore)
├── scripts/             # adr-tools.py script (obsolete)
├── temp/                # Already in .gitignore (keep as-is)
├── tests/               # 8 test files (obsolete, not effective)
├── FEATURE_TEMPLATE.md  # Obsolete template (delete)
└── [other essential files kept]
```

### Files to Keep
- Core docs: README.md, LICENSE, CHANGELOG.md, ROADMAP.md
- Framework: CLAUDE.md, PLANNING.md, TASK.md
- Config: requirements.txt, .gitignore
- Info: AI_TRANSPARENCY.md, CREDITS.md

## Proposed Design

### Overview

Execute a systematic cleanup of the project root, removing obsolete testing and tooling while preserving historical responses through .gitignore.

### Implementation Steps

1. **Delete Obsolete Directories**
   ```bash
   git rm -rf benchmarks/
   git rm -rf docs/
   git rm -rf tests/
   git rm -rf scripts/
   git rm -rf PRPs/
   ```

2. **Delete Obsolete Files**
   ```bash
   git rm FEATURE_TEMPLATE.md
   ```

3. **Update .gitignore**
   ```
   # Historical response files (informal method)
   responses/
   ```

4. **Verify and Commit**
   - Verify all deletions successful
   - Check no broken references
   - Commit with clear message

### Validation Approach

1. Confirm directories no longer exist
2. Verify .gitignore properly ignores responses/
3. Check git status shows clean working tree
4. Ensure no documentation references deleted items

## Alternative Approaches Considered

### Option 1: Archive Instead of Delete
**Approach**: Move obsolete files to an archive directory
**Pros**: Preserves files locally without git
**Cons**: Adds clutter, history already in git
**Decision**: Rejected - git history is sufficient

### Option 2: Move Tests to .claude/
**Approach**: Preserve tests in framework directory
**Pros**: Keeps test examples
**Cons**: Tests aren't effective, would add confusion
**Decision**: Rejected - will build proper tests later

### Option 3: Keep Scripts Directory
**Approach**: Preserve scripts for potential future use
**Pros**: Might be useful someday
**Cons**: Unknown purpose, can recreate if needed
**Decision**: Rejected - remove unused code

## Implementation Plan

1. Create feature and design documentation
2. Execute directory deletions with git rm
3. Delete obsolete template file
4. Update .gitignore for responses/
5. Verify all operations successful
6. Commit with descriptive message
7. Update TASK.md to mark complete

## Architecture Decision Records

### ADR-001: Delete Ineffective Tests

**Status**: Accepted

**Context**: The current test suite doesn't effectively test code sections, just rules and templates. We need scenario-based testing for Claude commands and rules instead.

**Decision**: Delete the entire tests/ directory and build proper scenario-based testing in the future.

**Consequences**:
- **Positive**: Removes confusion about test effectiveness, clean slate for proper testing
- **Negative**: No tests temporarily (but current tests weren't effective anyway)
- **Neutral**: History preserved in git if we need to reference old test patterns

## Risks and Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| Accidentally delete needed file | High | Low | Use git rm for recovery ability |
| Break documentation references | Low | Medium | Search for references before deletion |
| Lose historical context | Medium | Low | Git history preserves everything |

## Success Criteria

- [x] All specified directories deleted
- [x] FEATURE_TEMPLATE.md deleted
- [x] responses/ added to .gitignore
- [x] Git history preserved for all deletions
- [x] Clean git status after completion
- [x] No broken references in remaining files

## References

- Feature request: .sdlc/features/021-root-directory-cleanup.md
- SDLC consolidation: .sdlc/designs/019-sdlc-directory-consolidation/
- Template consolidation: .sdlc/features/018-template-consolidation-and-standardization.md