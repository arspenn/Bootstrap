# ADR-005: Simplified Scope - Serial 3-Agent System Only

## Status
Accepted

## Context
The initial design included both the 3-agent serial architecture AND the PLANNING.md shared workspace system. Project Manager review identified that combining both changes creates too much risk and complexity. We need to separate these concerns.

## Decision

### Current Scope (Phase 1)
Implement only the serial 3-agent architecture:
- Maximum 3 agents active simultaneously
- Serial specialist execution
- Command-specific lead agents (RE, TA, PM)
- Direct execution for `/do` (2 agents)
- Simple state passing between agents

### Deferred to Backlog (Phase 2)
PLANNING.md shared workspace enhancement:
- Unified planning document
- Shared agent collaboration log
- Template-based initialization
- File-based state management

## Rationale

### Why Separate?
1. **Reduced Risk** - Test one architectural change at a time
2. **Faster Delivery** - 2-3 weeks vs 4-6 weeks
3. **Clearer Testing** - Isolate performance impact of serial execution
4. **Simpler Rollback** - Only one thing to revert if needed

### Implementation Approach
```python
# Phase 1: Simple state passing
class CommandLead:
    def coordinate_specialists(self):
        context = {}
        for specialist in self.specialists:
            result = self.call_specialist(specialist, context)
            context.update(result)
        return self.synthesize(context)

# Phase 2 (Future): PLANNING.md approach
# Will be designed after Phase 1 proves stable
```

## Consequences

### Positive
- Faster time to production (2-3 weeks)
- Lower implementation risk
- Easier to test and validate
- Clear success metrics

### Negative
- No immediate benefit of shared workspace
- State management remains in memory
- No persistent recovery mechanism yet

### Neutral
- Two-phase rollout extends total timeline
- Users get incremental improvements

## Success Criteria for Phase 1

1. **Memory Usage** - Never exceed 10GB (3 agents × 3.2GB)
2. **Serial Execution** - All specialists run sequentially
3. **Quality Maintained** - Output quality matches current system
4. **Performance Documented** - Clear metrics on slowdown

## Migration Path

### Phase 1 (Immediate)
1. Implement Executor as default agent
2. Update commands for serial execution
3. Enforce 3-agent limit
4. Test with real workflows

### Phase 2 (Future - After Phase 1 Success)
1. Design PLANNING.md templates
2. Add shared workspace initialization
3. Implement unified logging
4. Migrate state to file-based

## Backlog Item for PLANNING.md

```markdown
## Backlog: PLANNING.md Shared Workspace Enhancement

### Description
Implement PLANNING.md as universal shared workspace for all agents to enable
persistent state, better debugging, and natural recovery.

### Prerequisites
- Phase 1 (serial 3-agent) must be stable
- Performance metrics from Phase 1 available
- User feedback on serial execution gathered

### Estimated Effort
3-4 weeks after Phase 1 completion

### Value Proposition
- Natural failure recovery
- Real-time progress visibility
- Simplified state management
- Git-based versioning

### Priority
Medium (after core architecture stable)
```

---
*Created: 2025-09-25*