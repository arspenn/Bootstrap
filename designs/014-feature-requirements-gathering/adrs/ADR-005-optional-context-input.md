# ADR-005: Optional Context Input for Feature Requirements

## Status
Proposed

## Context

The `/gather-feature-requirements` command needs to handle various starting points for users:
- Some users have nothing and need full guidance
- Some have partial ideas or notes they want to structure
- Some have examples or user stories partially written
- Some may have informal specifications to formalize

Requiring all users to go through the full conversation flow would be inefficient for those with existing context. However, the Week 1 implementation must remain simple.

## Decision

We will implement **optional argument handling** for initial context input:

1. The command accepts an optional text argument
2. If provided, extract available information from the text
3. Ask only for missing components
4. If not provided, start with an open prompt
5. Use simple keyword matching for extraction (no complex NLP)

This allows flexibility while maintaining Week 1 simplicity.

## Consequences

### Positive
- Users can provide whatever context they have upfront
- Reduces conversation length when information is available
- More natural interaction (paste notes and refine)
- Sets pattern for Week 3's project requirements command
- No additional complexity for users who start from scratch

### Negative
- Slight increase in Week 1 implementation complexity
- Context extraction may miss nuanced information
- Need to handle various input formats gracefully

### Neutral
- Creates two paths through the conversation (with/without context)
- Requires confirmation of extracted information
- May need refinement in Week 2 for better extraction