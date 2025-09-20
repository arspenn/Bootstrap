# ADR-004: Critical Missing Concepts from Rule Analysis

## Status
Proposed

## Context
After loading all 26 Bootstrap rules and reviewing the command refactoring design, several critical concepts from the existing rule system were not adequately addressed in the new 4D workflow.

## Decision
Incorporate the following missing concepts into the command refactoring:

1. **TASK.md Integration** - Central task tracking system
2. **Sequential Numbering** - Consistent numbering across all artifacts
3. **PLANNING.md Context** - Project-wide planning document
4. **Changelog Management** - Automated changelog updates
5. **Python Environment** - venv_linux standardization
6. **Test Location Strategy** - Where tests live
7. **Discovery Tracking** - New tasks found during work

## Consequences

### Positive
- Preserves hard-won organizational patterns
- Maintains consistency across project artifacts
- Ensures critical safety patterns aren't lost
- Keeps the self-bootstrapping philosophy intact

### Negative
- Commands become more complex with additional embedded logic
- More scripts needed for deterministic operations
- Increased initial learning curve

### Neutral
- These patterns can be progressively disclosed to new users
- Existing Bootstrap projects benefit immediately