# Feature Request: CLAUDE.md Standardization and Rule Extraction

## Summary
Refactor CLAUDE.md to follow the established rule format, extracting inline rules into separate files and resolving conflicts with existing rules.

## Problem Statement
CLAUDE.md currently contains mixed concerns with informal bullet-point rules that:
- Don't follow the structured YAML format of other rules
- Lack metadata (security level, token impact)
- Duplicate or conflict with existing rules
- Mix project setup, coding standards, and AI behavior in one file

## Proposed Solution
1. Extract inline rules from CLAUDE.md into separate rule files following the standard format
2. Transform CLAUDE.md into a minimal configuration loader
3. Establish clear override hierarchy for conflict resolution
4. Add metadata tracking for all rules

## Benefits
- **Consistency**: All rules follow the same structured format
- **Modularity**: Rules can be enabled/disabled independently
- **Clarity**: Clear conflict resolution through override hierarchy
- **Efficiency**: Token usage and security impact tracking
- **Maintainability**: Easier to update and test individual rules

## Implementation Details

### Rules to Extract:
1. **project/planning-context.md** - PLANNING.md and TASK.md requirements
2. **project/code-structure.md** - 500 line limit, module organization
3. **testing/pytest-requirements.md** - Test creation standards
4. **documentation/docstring-format.md** - Google-style docstrings
5. **project/adr-management.md** - ADR creation and organization
6. **python/code-style.md** - PEP8, black, type hints
7. **python/environment-management.md** - venv_linux usage

### New CLAUDE.md Structure:
```markdown
# Claude Configuration

## Rule Loading
@.claude/MASTER_IMPORTS.md

## Project Context
- Working Directory: {auto-detected}
- Python Environment: venv_linux
- Primary Language: Python

## Override Hierarchy
1. User instructions (highest priority)
2. TASK.md requirements
3. Individual rule files
4. CLAUDE.md defaults (lowest priority)
```

### Conflict Resolutions:
- File operations: Defer to git-safe-file-operations.md
- Testing location: Remove from CLAUDE.md (already in test-file-location.md)
- Design structure: Remove from CLAUDE.md (already in design-structure.md)

## Success Criteria
- [ ] All rules extracted into standard format files
- [ ] CLAUDE.md simplified to configuration loader
- [ ] No duplicate rules between files
- [ ] Clear documentation of override hierarchy
- [ ] All rules include metadata (ID, status, security level, token impact)

## Priority
Medium - Improves consistency and maintainability but not blocking current work

## Estimated Effort
1-2 days

## Dependencies
- Existing rule file structure
- MASTER_IMPORTS.md system

## Notes
- This aligns with the modular rule system already established
- Will make it easier to add/remove rules dynamically
- Improves clarity for AI understanding of project requirements