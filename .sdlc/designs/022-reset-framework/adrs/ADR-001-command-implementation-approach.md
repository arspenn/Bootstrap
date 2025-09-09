# ADR-001: Command Implementation Approach

## Status
Accepted

## Context

The reset framework feature needs to be implemented as a user-invokable command. We have several options for how to implement this command:

1. **External Script**: A standalone Python or Bash script that users run separately
2. **Claude Command**: A markdown-based command in `.claude/commands/` that Claude executes
3. **Hybrid Approach**: Claude command that calls an external script

Each approach has different implications for usability, maintainability, and integration with the framework.

## Decision

Implement the reset framework feature as a Claude command (`/reset-framework`) using the existing markdown-based command pattern in `.claude/commands/`.

## Consequences

### Positive
- **Consistency**: Follows existing Bootstrap framework patterns
- **Integration**: Naturally integrated with Claude's context and capabilities
- **No Dependencies**: Doesn't require external script execution permissions
- **Self-Documenting**: Command documentation is part of the implementation
- **Platform Agnostic**: Claude handles platform differences internally

### Negative
- **Claude Dependency**: Requires Claude to execute (cannot run standalone)
- **Limited Capabilities**: Constrained by what Claude can do through its tools
- **Debugging Challenges**: Harder to debug than standalone scripts

### Neutral
- **Performance**: Similar performance to external scripts for this use case
- **Testing**: Can be tested through Claude but not in isolation
- **Version Control**: Command changes tracked like any other framework file

## Notes

This decision aligns with the Bootstrap framework's philosophy of keeping everything within Claude's operational context. Future enhancements could add a standalone script option if needed, but the Claude command provides the best initial implementation path.