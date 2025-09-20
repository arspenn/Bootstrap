# ADR-003: Deterministic Scripts for Safety

## Status
Accepted

## Context
AI interpretation of safety rules is unreliable. Critical operations like git commands, file operations, and security checks cannot depend on AI following written rules consistently. We need guaranteed enforcement of safety constraints.

## Decision
Implement critical safety operations using deterministic bash/python scripts that are called by commands rather than relying on AI interpretation of rules.

## Consequences

### Positive
- 100% reliable safety enforcement
- No ambiguity in critical operations
- Can be tested independently
- Provides audit trail of operations
- Works identically across all AI platforms

### Negative
- Additional complexity in the system
- Platform-specific considerations (Windows vs Unix)
- Requires script maintenance alongside commands
- Users need script execution permissions

### Neutral
- Scripts can be optional with fallback to AI prompts
- Creates clear boundary between deterministic and AI-driven operations
- Opens possibility for user customization of safety rules