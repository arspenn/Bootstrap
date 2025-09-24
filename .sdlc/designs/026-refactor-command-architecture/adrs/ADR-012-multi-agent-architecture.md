# ADR-012: Multi-Agent Architecture Pattern (Memory-Optimized)

## Status
ACCEPTED (Updated 2025-09-24 for memory constraints)

## Context
Complex projects require diverse expertise - technical, domain-specific, quality, and strategic perspectives. A single AI agent, regardless of capability, cannot match the depth of specialized agents working in concert.

Claude Code's Task tool enables spawning sub-agents that can work independently and in parallel, each maintaining their own context and returning synthesized results.

**Critical Discovery**: JavaScript heap exhaustion occurs with >2 concurrent agents due to token accumulation (~3000 tokens per agent). Previous design allowing 5+ parallel agents causes consistent memory failures.

## Decision
Bootstrap adopts a **memory-optimized hierarchical multi-agent architecture** with:

1. **Requirements Engineer** as the sole user interface
2. **Project Manager** as coordination layer
3. **Specialized Domain Agents** for deep expertise
4. **Maximum 2 agents in parallel** to prevent memory exhaustion
5. **Paired sequential execution** for comprehensive analysis
6. **Synthesis before user interaction** for coherence

### Agent Hierarchy
```
User
  ↕
Requirements Engineer (Primary Agent)
  ↓
Project Manager (Coordinator)
  ↓
[Paired Sequential Specialists - MAX 2 at once]
Phase 1: Technical Architect + QA Specialist
Phase 2: Domain Expert + DevOps Engineer
Phase 3: Security Specialist (alone if needed)
```

## Rationale

### Why Requirements Engineer as Primary?
- Maintains focus on understanding needs first
- Provides consistent user interaction point
- Prevents premature solutioning
- Ensures requirements drive all decisions

### Why Hierarchical vs Round-table?
- Claude Code agents cannot interact directly with each other
- User shouldn't be overwhelmed by multiple agent voices
- Synthesis provides best of all perspectives
- Clear chain of responsibility

### Why Maximum 2 Agents in Parallel?
- JavaScript heap limit of ~4GB in most environments
- Task tool orchestration overhead for multiple concurrent processes
- 5+ agents cause consistent JavaScript memory exhaustion
- Sub-agents have separate contexts (don't affect main window)
- 2 agents provide balance of speed and stability
- Strategic pairing maintains analysis quality

### Why Domain Diversity?
- Software projects often have non-technical constraints
- Cross-pollination from other fields provides innovation
- Public health expert might spot risk patterns developer misses
- Opera singer might suggest better user experience flows

## Implementation

### Agent Invocation Pattern (Memory-Optimized)
```markdown
Use Task tool:
- description: "Coordinate team for [task]"
- subagent_type: "general-purpose"
- prompt: "You are a Project Manager. Think hard about coordination.

  CRITICAL: Maximum 2 agents in parallel due to memory constraints.

  Phase 1: Launch these specialists together (2 max):
  - Technical Architect for system design
  - QA Specialist for test strategy

  Wait for completion, then Phase 2:
  - Domain Expert for domain insights
  - DevOps Engineer for deployment strategy

  Phase 3 if needed (single agent):
  - Security Specialist for safety review

  Synthesize all outputs and return consensus with alternatives."
```

### Key Principles
1. **Think Hard Mode**: All agents must use maximum reasoning
2. **Personality Persistence**: Agents maintain role throughout
3. **No Direct User Interaction**: Only Requirements Engineer talks to user
4. **2-Agent Maximum**: Never exceed 2 concurrent agents
5. **Strategic Pairing**: Pair complementary agents for synergy
6. **Sequential Phases**: Complete each phase before next
7. **Synthesis Required**: PM must reconcile all perspectives

### Pairing Strategy
- **Technical + QA**: Implementation and quality perspectives
- **Domain + DevOps**: Business needs and operational reality
- **Security alone**: Deep focus on safety without distraction

## Consequences

### Positive
- Comprehensive analysis from multiple perspectives
- **Memory-stable execution** - no JavaScript heap exhaustion
- Higher quality through specialization
- Reduced blind spots in decision-making
- **Predictable resource usage** (~6000 tokens max at any time)

### Negative
- **Slower execution** than full parallel (adds ~30-60 seconds)
- Increased complexity in command structure
- Higher token usage for multi-agent coordination
- Potential for conflicting recommendations
- Learning curve for personality management
- **Phase coordination overhead** between agent pairs

### Neutral
- Session logs become more complex but richer
- Debugging requires understanding agent interactions
- Performance depends on Task tool efficiency

## Examples

### Requirements Gathering
- Requirements Engineer leads user interaction
- PM coordinates: Business Analyst, Domain Expert, Technical Architect
- Each analyzes requirements from their perspective
- PM synthesizes into comprehensive requirements document

### Design Phase
- Requirements Engineer ensures design meets requirements
- PM coordinates: Technical Architect, Security Expert, UX Designer
- Parallel exploration of alternatives
- Consensus recommendation with documented trade-offs

## Future Considerations
- Dynamic agent selection based on project type
- Persistent agent memory across sessions
- Inter-agent communication protocols
- Specialized agent training/fine-tuning

---
*Decided on: 2024-09-24*
*Decided by: Bootstrap Development Team*