# Rule: Sub-Agent Execution Limits

## Quick Summary
Maximum 2 sub-agents can execute in parallel due to JavaScript memory constraints

## When Applied
This rule is embedded in all commands that use multi-agent orchestration:
- `/init` - Project initialization agents
- `/determine` - Requirements analysis specialists
- `/design` - Architecture design team
- `/define` - Implementation planning specialists
- `/do` - Validation and testing agents

## Detailed Behavior

### Execution Pattern
When launching sub-agents via the Task tool, follow this pattern:

```markdown
CRITICAL: Maximum 2 agents in parallel due to JavaScript memory constraints.

Phase 1: Launch first pair (2 max)
- Agent A for [purpose]
- Agent B for [complementary purpose]

Wait for completion, then Phase 2:
- Agent C for [purpose]
- Agent D for [complementary purpose]

Phase 3 if needed (single agent):
- Agent E for [focused purpose]
```

### Why This Limit Exists
- JavaScript V8 heap has ~4GB limit in most environments
- Task tool orchestration requires memory for each concurrent process
- 5+ concurrent agents consistently cause JavaScript heap exhaustion
- Sub-agents have separate context windows (don't affect main conversation)
- 2 agents provide optimal balance of speed and stability

### Strategic Pairing Guidelines

Pair agents with complementary perspectives:
- **Technical + QA**: Implementation quality and testing
- **Business + Technical**: Requirements and feasibility
- **Domain + DevOps**: Business needs and operational reality
- **Security + Performance**: Non-functional requirements
- **Documentation + UX**: User-facing clarity

### Implementation in Commands

Commands should instruct the Project Manager to:
1. Identify all needed specialists
2. Group them into complementary pairs
3. Execute pairs sequentially with synthesis between phases
4. Never exceed 2 concurrent Task tool invocations

### Memory Monitoring

If memory issues are detected:
```bash
# Check heap usage (pseudo-code)
if heap_usage > 80%:
    switch_to_sequential_mode()
```

### Fallback Strategy

If 2 agents still cause issues:
1. Fall back to fully sequential (1 agent at a time)
2. Preserve quality by ensuring all perspectives are covered
3. Notify user of degraded performance mode

## Stack Variants

This rule applies universally regardless of technology stack, as it's a JavaScript runtime constraint in Claude Code, not a project-specific limitation.

## Common Issues

### Issue: "Why is multi-agent execution slower?"
**Solution**: Explain that phased execution with 2-agent max prevents crashes while maintaining quality

### Issue: "Can we increase the limit for simple agents?"
**Solution**: No - the limit is based on Task tool overhead, not agent complexity

### Issue: "Agents seem to be waiting unnecessarily"
**Solution**: This is intentional - synthesis between phases ensures coherent results

## Testing Guidelines

When testing multi-agent commands:
1. Monitor JavaScript heap usage during execution
2. Verify no more than 2 Task tool invocations are active simultaneously
3. Confirm all specified agents eventually execute
4. Check that synthesis occurs between phases

## References
- ADR-012: Multi-Agent Architecture Pattern (Updated for memory constraints)
- ADR-013: Memory Optimization Strategy
- Claude Code documentation on sub-agents having separate contexts

---
*Rule created: 2025-09-24*
*Reason: JavaScript memory exhaustion discovered during 4D+1 implementation*