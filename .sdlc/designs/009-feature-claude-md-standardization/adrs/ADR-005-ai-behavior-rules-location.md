# ADR-005: AI Behavior Rules Location and Enhancement

## Status
Proposed

## Context
AI Behavior Rules in CLAUDE.md are fundamentally different from other rules - they govern Claude's general behavior rather than specific triggered actions. These rules are currently vague and need enhancement. We need to decide:
1. Extract them like other rules
2. Keep them in CLAUDE.md but enhance them
3. Create a special AI-specific rule format
4. Move them to a separate AI behavior file

These rules are critical for safe and predictable AI behavior.

## Decision
We will keep AI Behavior Rules in CLAUDE.md but significantly enhance them with specific, actionable guidelines that remove ambiguity.

## Consequences

### Positive
- **Immediate Visibility**: AI rules always loaded with CLAUDE.md
- **Different Nature Recognized**: Acknowledges these aren't trigger-based
- **Enhanced Clarity**: Specific actions replace vague directives
- **No Format Forcing**: Avoids shoehorning into YAML structure
- **Central Location**: Critical safety rules remain prominent

### Negative
- **Inconsistency**: Different format from other rules
- **No Metadata**: Missing priority and token tracking
- **Testing Challenge**: Harder to validate programmatically

### Neutral
- AI rules remain prose-based but more specific
- Future migration still possible if needed
- Enhanced rules provide measurable behaviors