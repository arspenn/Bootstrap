# ADR-001: Simplified /do Command with Direct Specialist Execution

## Status
Proposed

## Context
The initial design proposed a 3-layer architecture for all commands, including `/do`. However, the `/do` command simply executes tasks from the Design Implementation Plan (DIP) that was already created by `/define`. Adding an intermediate orchestrator for `/do` adds unnecessary complexity without value.

## Decision
The `/do` command will use direct specialist execution:
- Executor reads the DIP created by `/define`
- For each task, Executor directly calls the appropriate specialist
- Maximum 2 agents active (Executor + Specialist)
- No intermediate orchestration layer needed

## Consequences

### Positive
- Simpler architecture for `/do` command
- Better memory utilization (2 agents vs 3)
- Faster execution without orchestration overhead
- Clearer separation: planning (`/define`) vs execution (`/do`)

### Negative
- Inconsistent pattern (3 commands use leads, 1 doesn't)
- Executor has more complexity for `/do` handling

### Neutral
- `/init` also uses direct execution (1 agent only)
- Pattern becomes: complex commands get orchestrators, simple ones don't

## Implementation Notes
```python
# /do execution pattern
for task in dip.tasks:
    if task.type == "code":
        executor.call(code_implementer, task)
    elif task.type == "test":
        executor.call(test_runner, task)
    elif task.type == "docs":
        executor.call(documentation_writer, task)
```

This aligns with the principle that orchestration is only needed when synthesizing or coordinating multiple perspectives, not when executing predefined tasks.

---
*Created: 2025-09-25*