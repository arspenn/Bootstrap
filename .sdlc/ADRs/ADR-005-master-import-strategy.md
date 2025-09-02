# ADR-005: Master Import File Strategy

## Status
Accepted

## Context
Claude Code supports importing additional instructions using @file syntax in CLAUDE.md. We need a strategy for importing our modular rule system that:
- Keeps CLAUDE.md clean for prose additions
- Respects the 5-hop recursive import limit
- Allows user preferences to control which rules are active
- Maintains shallow hierarchy for simplicity

## Decision
We will create a master import file (`.claude/MASTER_IMPORTS.md`) that:
1. Acts as the single import point from CLAUDE.md
2. Conditionally imports rules based on user preferences
3. Maintains a shallow two-level hierarchy (CLAUDE.md → MASTER_IMPORTS.md → individual rules)
4. Groups imports by category for organization

CLAUDE.md will contain a single import:
```
@.claude/MASTER_IMPORTS.md
```

MASTER_IMPORTS.md will import active rules:
```
# Git Rules (if enabled in preferences)
@.claude/rules/git/git-add-safety.md
@.claude/rules/git/git-commit-format.md
...
```

## Consequences

### Positive
- **Clean CLAUDE.md**: Only one import line needed
- **Centralized control**: All imports managed in one place
- **Preference integration**: Can implement conditional loading
- **Shallow hierarchy**: Only 2 levels deep (well within 5-hop limit)
- **Extensible**: Easy to add new rule categories

### Negative
- **Extra indirection**: One more file in the import chain
- **Conditional logic**: Need to implement preference checking

### Neutral
- **Performance**: Single import file may be more efficient than multiple imports
- **Debugging**: Clear import path makes troubleshooting easier