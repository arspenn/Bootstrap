# ADR-013: Memory Optimization Strategy for Multi-Agent Orchestration

## Status
ACCEPTED

## Context
During implementation of the 4D+1 workflow with multi-agent orchestration, we discovered that JavaScript heap memory exhaustion occurs consistently when running more than 2 concurrent sub-agents via Claude Code's Task tool.

### Discovery Timeline
- Initial design: 5+ agents running in parallel
- First failure: JavaScript out of memory with 5 agents
- Memory increase attempted: Still failed with increased allocation
- Root cause: JavaScript heap exhaustion from Task tool orchestration (not token accumulation)
- Key insight: Sub-agents have separate contexts, don't share main window tokens
- Solution found: Maximum 2 agents concurrent execution due to JS memory limits

### Technical Constraints
- JavaScript V8 heap limit: ~4GB default
- Claude Code context windows: **SEPARATE for each sub-agent** (not shared)
- Token usage: ~3000 tokens per agent (in their own context)
- Memory overhead: Task tool orchestration and result synthesis
- Main context: Only receives final results from sub-agents

## Decision
Implement a **paired sequential execution model** with strict 2-agent maximum parallelism.

### Architecture Pattern
```
Sequential Phases with Paired Agents:
Phase 1: [Agent A] + [Agent B] → Synthesis
Phase 2: [Agent C] + [Agent D] → Synthesis
Phase 3: [Agent E] (alone) → Final synthesis
```

### Implementation Strategy
1. **Hard limit**: Never exceed 2 concurrent Task tool invocations
2. **Strategic pairing**: Combine complementary perspectives
3. **Phase boundaries**: Complete synthesis before next phase
4. **Memory monitoring**: Track heap usage for early warning
5. **Graceful degradation**: Fall back to sequential if needed

## Alternatives Considered

### Alternative A: Sequential Pipeline
**Description**: One agent at a time, fully sequential
- **Pros**: Minimal memory (3000 tokens), guaranteed stability
- **Cons**: Slow execution (5x longer), poor user experience
- **Decision**: Rejected - too slow for practical use

### Alternative B: Paired Processing (CHOSEN)
**Description**: Maximum 2 agents in parallel, phased execution
- **Pros**: Balance of speed and memory, stable execution, separate contexts preserve main window
- **Cons**: Slightly slower than full parallel, coordination complexity
- **Decision**: Selected - optimal trade-off

### Alternative C: Dynamic Scaling
**Description**: Start with many, reduce on memory pressure
- **Pros**: Optimal performance when possible
- **Cons**: Complex implementation, unpredictable behavior
- **Decision**: Deferred - future enhancement

## Implementation Details

### Pairing Strategy
Agents are paired based on complementary skills:

```markdown
## Standard Pairings
- Technical Architect + QA Specialist (implementation quality)
- Domain Expert + DevOps Engineer (business operations)
- Security Specialist + Performance Engineer (non-functional)
- Documentation + User Experience (communication)
```

### Command Updates Required
All 5 core commands must be updated:
1. `/init.md` - Limit charter creation agents
2. `/determine.md` - Sequential requirements analysis
3. `/design.md` - Phased architecture exploration
4. `/define.md` - Paired DIP creation
5. `/do.md` - Sequential implementation validation

### Memory Monitoring
```javascript
// Pseudo-code for memory checking
const heapUsed = process.memoryUsage().heapUsed;
const heapLimit = process.memoryUsage().heapTotal;
if (heapUsed / heapLimit > 0.8) {
  // Switch to sequential mode
  useSingleAgent = true;
}
```

## Consequences

### Positive
- **Stability**: No more memory crashes
- **Predictability**: Consistent resource usage
- **Quality maintained**: Strategic pairing preserves analysis depth
- **User trust**: Reliable execution builds confidence

### Negative
- **Speed reduction**: ~30-60 seconds added per command
- **Complexity**: Phase coordination logic required
- **Token increase**: Multiple synthesis points add overhead

### Neutral
- **Different rhythm**: Users adapt to phased execution
- **Log structure**: More complex but clearer phases
- **Testing**: Easier to test smaller agent groups

## Risks and Mitigations

### Risk: User Frustration with Slower Execution
**Mitigation**: Clear progress indicators showing phases

### Risk: Quality Loss from Fewer Parallel Perspectives
**Mitigation**: Strategic pairing ensures key perspectives covered

### Risk: Implementation Complexity
**Mitigation**: Clear phase boundaries, simple coordination logic

## Validation Criteria
- [ ] No JavaScript memory errors in 100 consecutive runs
- [ ] Execution time < 3 minutes for standard commands
- [ ] All critical perspectives represented in analysis
- [ ] User satisfaction maintained or improved

## Migration Path
1. Update ADR-012 with memory constraints
2. Modify command templates for phased execution
3. Test with Bootstrap's own development
4. Document pairing strategies
5. Monitor and optimize pairings based on results

## Future Enhancements
- Automatic heap monitoring and adaptation
- Persistent agent state between phases
- Optimized token usage through compression
- WebAssembly for memory-intensive operations

---
*Decided on: 2025-09-24*
*Decided by: Bootstrap Development Team*
*Reason: JavaScript memory exhaustion with >2 concurrent agents*