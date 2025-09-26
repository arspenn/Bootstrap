# ADR-002: Only Main Agent Can Use Task Tool

## Status
Accepted

## Context
Testing confirmed that subagents cannot use the Task tool to spawn other agents. This is an intentional Claude Code restriction to prevent recursive spawning and resource exhaustion.

## Evidence
1. **Direct test**: Agent #2 reported "no Task tool available"
2. **GitHub Issue #4182**: Community confirmed this limitation
3. **No documentation**: This restriction isn't officially documented
4. **Intentional design**: Prevents infinite recursion

## Decision
Accept this as a hard constraint and design accordingly:
- All orchestration happens at the main agent level
- No hierarchical agent structures
- No agent-to-agent delegation
- Single point of coordination (Executor)

## Consequences

### Positive
- Prevents runaway recursion
- Simplifies agent relationships
- Clear orchestration model
- Easier to debug and trace

### Negative
- Can't build agent hierarchies
- Can't delegate orchestration
- All complexity at top level
- Less flexible architectures

### Neutral
- Forces flat agent structures
- Main agent becomes critical bottleneck
- Requires different design patterns

## Workarounds Considered and Rejected
1. **Using bash `claude -p`**: Loses context and observability
2. **Message passing**: Too complex for little benefit
3. **File-based coordination**: Slow and error-prone

## Implementation Pattern
```python
# CORRECT: Main agent orchestrates all
main_agent:
    → subagent_1
    → subagent_2
    → subagent_3

# IMPOSSIBLE: Hierarchical delegation
main_agent:
    → subagent_1:
        → subagent_1a  # ❌ Can't do this
        → subagent_1b  # ❌ Task tool not available
```

---
*Confirmed: 2025-09-26 through testing and research*