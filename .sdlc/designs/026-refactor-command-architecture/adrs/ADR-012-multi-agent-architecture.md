# ADR-011: Multi-Agent Architecture Pattern

## Status
ACCEPTED

## Context
Complex projects require diverse expertise - technical, domain-specific, quality, and strategic perspectives. A single AI agent, regardless of capability, cannot match the depth of specialized agents working in concert.

Claude Code's Task tool enables spawning sub-agents that can work independently and in parallel, each maintaining their own context and returning synthesized results.

## Decision
Bootstrap adopts a **hierarchical multi-agent architecture** with:

1. **Requirements Engineer** as the sole user interface
2. **Project Manager** as coordination layer
3. **Specialized Domain Agents** for deep expertise
4. **Parallel execution** for efficiency
5. **Synthesis before user interaction** for coherence

### Agent Hierarchy
```
User
  ↕
Requirements Engineer (Primary Agent)
  ↓
Project Manager (Coordinator)
  ↓
[Parallel Specialists]
- Technical Architect
- QA Specialist
- Domain Expert(s)
- DevOps Engineer
- Documentation Specialist
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

### Why Domain Diversity?
- Software projects often have non-technical constraints
- Cross-pollination from other fields provides innovation
- Public health expert might spot risk patterns developer misses
- Opera singer might suggest better user experience flows

## Implementation

### Agent Invocation Pattern
```markdown
Use Task tool:
- description: "Coordinate team for [task]"
- subagent_type: "general-purpose"
- prompt: "You are a Project Manager. Think hard about coordination.

  Launch these specialists in parallel:
  - Technical Architect for system design
  - QA Specialist for test strategy
  - [Domain Expert] for domain insights

  Synthesize outputs and return consensus with alternatives."
```

### Key Principles
1. **Think Hard Mode**: All agents must use maximum reasoning
2. **Personality Persistence**: Agents maintain role throughout
3. **No Direct User Interaction**: Only Requirements Engineer talks to user
4. **Parallel When Possible**: Launch specialists simultaneously
5. **Synthesis Required**: PM must reconcile different perspectives

## Consequences

### Positive
- Comprehensive analysis from multiple perspectives
- Faster execution through parallelism
- Higher quality through specialization
- Reduced blind spots in decision-making

### Negative
- Increased complexity in command structure
- Higher token usage for multi-agent coordination
- Potential for conflicting recommendations
- Learning curve for personality management

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