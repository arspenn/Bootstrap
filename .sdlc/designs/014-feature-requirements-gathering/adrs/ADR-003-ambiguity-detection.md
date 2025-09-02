# ADR-003: Ambiguity Detection Approach

## Status
Proposed

## Context

Requirements ambiguity is a major source of project problems. The system needs to detect and help resolve ambiguous statements like "the system should be fast" or "users want better UI". 

The challenge is implementing effective ambiguity detection that:
- Doesn't annoy users with false positives
- Catches genuinely problematic ambiguity
- Provides helpful suggestions for improvement
- Works within token/processing constraints
- Can be implemented incrementally

## Decision

We will implement **pattern-based ambiguity detection** with reference-backed suggestions:

1. Maintain a list of known ambiguous terms/phrases
2. Check user responses against these patterns
3. When detected, provide specific suggestions with references
4. Allow users to accept or override suggestions
5. Focus on high-impact ambiguity (performance, size, quality)
6. Use web search for current best practices when needed

Initially detect only the most common ambiguous terms:
- Qualitative: fast, slow, good, better, nice, easy, simple
- Quantitative: some, many, few, most, several
- Temporal: soon, eventually, later, quickly
- Quality: reliable, robust, secure, scalable

## Consequences

### Positive
- Simple to implement and understand
- Can start with basic patterns and expand over time
- Provides immediate value for common cases
- Easy to customize based on domain/project
- Transparent to users (they see why something is ambiguous)

### Negative
- Won't catch all forms of ambiguity
- Requires maintaining pattern lists
- May not understand context-specific usage
- Could be seen as pedantic if too aggressive

### Neutral
- Creates a balance between automation and user control
- Requires periodic updates to pattern library
- Effectiveness depends on pattern quality
- Different projects may need different sensitivity levels