# ADR-001: Context Window Size for Conversation Analysis

## Status
Accepted

## Context
The insight capture command needs to analyze recent conversation to extract discoveries and issues. We need to determine how much conversation history to scan - too little might miss important context, too much could slow processing and include irrelevant information.

Options considered:
- Last 5 exchanges (minimal)
- Last 10 exchanges (balanced)
- Last 20 exchanges (comprehensive)
- Entire session (complete)

## Decision
Scan the last 10 conversation exchanges (user input + Claude response = 1 exchange).

## Consequences

### Positive
- Captures most recent discoveries (typically occur within last few exchanges)
- Fast processing time maintains zero-friction goal
- Sufficient context for most debugging scenarios
- Manageable amount of text to analyze

### Negative  
- May miss context from earlier in session
- Complex issues discussed over time might be incomplete
- User may need to provide explicit description for older topics

### Neutral
- Can be adjusted based on usage patterns
- User can always provide explicit description as fallback
- Future enhancement could make this configurable