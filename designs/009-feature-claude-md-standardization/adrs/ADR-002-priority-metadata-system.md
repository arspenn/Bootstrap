# ADR-002: Priority Metadata System

## Status
Proposed

## Context
Rules need a way to resolve conflicts when multiple rules could apply to the same situation. We need to decide how to implement priority:
1. Implicit priority through import order
2. Explicit priority field in metadata
3. Separate priority configuration file
4. No priority system (first match wins)

Clear priority resolution is essential for predictable rule behavior.

## Decision
We will add an explicit `priority` field to rule metadata using a 0-1000 scale, with higher numbers indicating higher priority. Default priority is 500.

## Consequences

### Positive
- **Explicit Control**: Clear which rule takes precedence
- **Self-Documenting**: Priority visible in rule file
- **Flexible**: Easy to adjust priorities without changing import order
- **Predictable**: Developers can reason about rule interactions
- **Standardized**: Consistent scale across all rules

### Negative
- **Additional Complexity**: Another field to manage
- **Potential Conflicts**: Same priority values need tiebreaker
- **Maintenance Burden**: Priorities may need rebalancing

### Neutral
- Priority scale is 0-1000 with 500 as default
- User instructions always override (implicit priority 1000)
- Tiebreaker is alphabetical rule ID