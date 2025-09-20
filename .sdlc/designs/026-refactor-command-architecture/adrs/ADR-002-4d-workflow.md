# ADR-002: 4D Workflow vs Spec-Kit Flow

## Status
Accepted

## Context
Need a memorable, clear workflow that guides users through the SDLC. Spec-kit uses `/specify → /plan → /tasks → /implement` but these terms are somewhat generic and don't form a memorable pattern.

## Decision
Adopt the 4D workflow: Determine → Design → Define → Do. This creates a memorable alliteration while clearly indicating the progression from abstract to concrete.

## Consequences

### Positive
- More intuitive progression with clear action verbs
- Better alliteration aids memorability
- Clearer distinction between phases
- Natural flow from requirements to implementation

### Negative
- Different from spec-kit users' expectations
- Requires education for users familiar with other workflows
- Potential confusion during transition period

### Neutral
- Can provide command aliases for spec-kit compatibility
- Documentation must clearly map old commands to new