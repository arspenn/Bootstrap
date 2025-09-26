# ADR-001: Agents Execute Sequentially, Not in Parallel

## Status
Accepted

## Context
Through empirical testing on 2025-09-26, we discovered that Claude Code executes agents sequentially, even when multiple Task tool calls are made in a single response. This contradicts our assumption that agents run in parallel and invalidates our 3-agent memory constraint design.

## Evidence
1. **Test with 20 agents**: All executed successfully in order
2. **Timing test**: Agents with different delays finished in call order, not completion order
3. **Return order**: Always matches call order exactly (1, 2, 3... 20)
4. **No memory issues**: 20 sequential agents didn't crash (would need 64GB if parallel)

## Decision
Redesign Bootstrap's architecture around sequential agent execution:
- Remove parallel execution assumptions
- Remove 3-agent limit tracking
- Focus on context accumulation management
- Simplify to single-level orchestration

## Consequences

### Positive
- Dramatically simpler architecture
- No concurrency concerns
- Predictable, deterministic execution
- No memory calculations needed
- Can run many more agents (20+ tested)

### Negative
- No actual parallelism for performance
- Sequential execution may be slower for independent tasks
- Context accumulates across all agents

### Neutral
- Changes entire mental model of system
- Requires rewriting all documentation
- Simplifies some things, complicates others

## Implementation Notes
```python
# Old (incorrect) assumption:
# Agent 1 ┐
# Agent 2 ├─ All running simultaneously
# Agent 3 ┘

# Reality:
# Agent 1 → completes → Agent 2 → completes → Agent 3
```

The key insight: We were solving the wrong problem. Memory wasn't the issue - context accumulation was.

---
*Discovered: 2025-09-26 through empirical testing*