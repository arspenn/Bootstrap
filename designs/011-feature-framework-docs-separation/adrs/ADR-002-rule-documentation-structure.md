# ADR-002: Rule Documentation Structure

## Status
Proposed

## Context
The Bootstrap framework uses a dual-structure for rules:
1. **Rule files** (`.claude/rules/`): Concise, actionable instructions that Claude parses efficiently
2. **Rule documentation** (`/docs/rules/` → `.claude/docs/rules/`): Detailed explanations, examples, and context for both users and Claude

Currently, rule documentation exists in `/docs/rules/` but needs to move to `.claude/docs/rules/` to be part of the framework documentation. This separation allows:
- Quick rule parsing without excessive token usage
- Detailed documentation when needed for understanding
- Clear separation between "what to do" (rules) and "why/how to do it" (documentation)

## Decision
Maintain the dual-structure approach with rule documentation moving to `.claude/docs/rules/`:

```
.claude/
├── rules/                          # Concise actionable rules
│   ├── git/
│   │   └── git-commit-format.md   # Rule: "Use conventional commits"
│   └── project/
│       └── changelog-update.md    # Rule: "Update CHANGELOG.md"
└── docs/
    └── rules/                      # Detailed rule documentation
        ├── git/
        │   └── git-commit-format.md   # Explains format, examples, rationale
        └── project/
            └── changelog-update.md    # Explains when, how, why to update
```

The structure mirrors each other - for every rule file, there should be corresponding documentation with the same path structure.

## Consequences

### Positive
- Clear separation between rules and their documentation
- Efficient token usage for rule parsing
- Comprehensive documentation available when needed
- Consistent structure makes finding documentation intuitive
- Documentation travels with framework when used as template

### Negative
- Potential for documentation to get out of sync with rules
- Duplicate file structure to maintain
- Need to ensure both are updated when rules change

### Neutral
- Rule files remain the source of truth for behavior
- Documentation provides context but doesn't change enforcement
- Future enhancement could auto-link rules to their documentation