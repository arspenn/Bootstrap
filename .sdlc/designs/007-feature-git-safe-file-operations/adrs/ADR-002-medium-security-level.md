# ADR-002: Medium Security Level for Override Capability

## Status
Proposed

## Context

We need to determine the appropriate security level for the git-safe file operations rule:
- **High**: Cannot be disabled, critical for safety
- **Medium**: Can be disabled by advanced users when needed
- **Low**: Convenience feature, easily disabled

The choice affects whether advanced users can disable the rule when working with non-git files, performing bulk operations, or in special circumstances.

## Decision

Set the security level to **Medium**, allowing the rule to be disabled through user preferences while maintaining it as the default behavior.

Rationale:
1. File operations sometimes need to work outside git repositories
2. Advanced users may have valid reasons to use direct commands
3. Some scenarios (like initial setup) may require unsafe operations
4. Trust users to make informed decisions with proper warnings

## Consequences

### Positive
- Flexibility for advanced users
- No blocking of legitimate use cases
- Maintains user agency
- Allows for gradual adoption

### Negative
- Users could disable safety and lose data
- Requires clear documentation about risks
- May reduce effectiveness if widely disabled

### Neutral
- Aligns with Bootstrap philosophy of "safe defaults, flexible overrides"
- Requires balance between safety and usability
- Similar to other git rules in the system