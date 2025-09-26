---
title: Sequential Agent Architecture - Reality-Based Design
status: draft
created: 2025-09-26
type: major-refactor
author: Bootstrap Team
tags: [architecture, sequential-execution, multi-agent, reality-based]
estimated_effort: 2-3 weeks
---

# Design: Sequential Agent Architecture

## Executive Summary

Complete redesign based on empirically verified Claude Code behavior: agents execute **sequentially**, not in parallel, and **only the main agent can launch subagents**. This dramatically simplifies our architecture while solving the actual problem: context accumulation across sequential agent calls.

## The Reality We Discovered

Through empirical testing on 2025-09-26:

1. **Agents run SEQUENTIALLY** - Even when called "in parallel", they execute one at a time
2. **No concurrent memory usage** - Only one agent is active at any moment
3. **Subagents cannot spawn agents** - Task tool is restricted to main agent only
4. **We can queue 20+ agents** - They just run in sequence
5. **Memory issues were from context accumulation**, not concurrent execution

## Problem Statement

Our original design assumed:
- ❌ 3 agents run in parallel (FALSE - they run sequentially)
- ❌ Memory consumed concurrently (FALSE - sequential = one at a time)
- ❌ 3.2GB per agent (FALSE - much less, context is the issue)
- ❌ Need complex tracking (FALSE - only one active at a time)

The REAL problem:
- ✅ Context accumulates across sequential agents
- ✅ Large outputs can overflow context window
- ✅ No way to clear context between agents
- ✅ All orchestration must happen at top level

## Proposed Solution

### Sequential Orchestration Pattern

```
Main Agent (Executor)
    ├─ Queues Agent 1 → Executes → Returns
    ├─ Queues Agent 2 → Executes → Returns
    ├─ Queues Agent 3 → Executes → Returns
    └─ Synthesizes all results
```

**Key Principles:**
1. **Embrace Sequential Nature** - Design for it, don't fight it
2. **Minimize Context Growth** - Keep agent outputs concise
3. **Progressive Summarization** - Compress results after each agent
4. **Single-Level Orchestration** - Only main agent coordinates

### Command Architecture

#### `/init` - Simple Direct Execution
```
Executor → Direct implementation (no subagents needed)
```

#### `/determine` - Sequential Requirements Gathering
```
Executor:
  → Business Analyst (gather user stories)
  → Domain Expert (add domain context)
  → QA Specialist (define acceptance criteria)
  → Synthesize into requirements document
```

#### `/design` - Sequential Architecture Analysis
```
Executor:
  → Technical Architect (system design)
  → Security Specialist (security review)
  → Performance Engineer (performance analysis)
  → Synthesize into design document
```

#### `/define` - Sequential Implementation Planning
```
Executor:
  → Developer (technical breakdown)
  → DevOps Engineer (deployment planning)
  → Test Engineer (test strategy)
  → Create DIP document
```

#### `/do` - Direct Task Execution
```
Executor:
  → Execute each DIP task directly (no orchestration needed)
```

### Context Management Strategy

Since the real constraint is context accumulation:

1. **Concise Prompts** - Minimize input to agents
2. **Bounded Outputs** - Limit response length
3. **Progressive Compression** - Summarize after each agent
4. **Context Resets** - Clear unnecessary context between major phases

Example:
```python
# After each agent
result = agent.execute(minimal_prompt)
compressed = summarize(result)  # Reduce to key points
context.append(compressed)       # Only store summary
```

## What We're Removing

### No Longer Needed:
1. **3-agent tracking system** - Pointless for sequential execution
2. **Complex state management** - One agent at a time = simple state
3. **Memory calculations** - Not relevant for sequential
4. **Parallel orchestration patterns** - Everything is sequential
5. **Agent depth indicators** - Always depth 1 or 2 max

### What We Keep:
1. **Executor as primary orchestrator**
2. **Command-specific agent sequences**
3. **Progressive result synthesis**
4. **Audit logging** (simplified)

## Implementation Changes

### Simplified Hooks
```json
{
  "PreToolUse": {
    "description": "Log agent start",
    "command": "echo 'Starting: $AGENT_NAME'"
  },
  "PostToolUse": {
    "description": "Log agent complete",
    "command": "echo 'Completed: $AGENT_NAME'"
  }
}
```

### Simplified Tracking
```bash
# Just track current agent and total count
CURRENT_AGENT="business-analyst"
TOTAL_EXECUTED=5
```

### Command Template
```markdown
/command Implementation:
1. Parse user request
2. For each specialist needed (in sequence):
   - Call with minimal context
   - Get bounded response
   - Compress/summarize result
3. Synthesize all results
4. Return final output
```

## MCP Server Enhancement Layer (Optional)

While agents execute sequentially through the Task tool, subagents CAN access MCP servers for true parallel processing and memory isolation.

### When to Use MCP Servers
Use MCP for specific memory-intensive operations:
- **logic-design-expert** - Complex semantic analysis
- **code-reviewer** - Large codebase processing
- **test-runner** - Heavy computational tasks
- **data-processor** - Large dataset operations

### Architecture with MCP
```
Main Agent (Executor)
    ↓ Sequential via Task
Subagent (Orchestrator)
    ├─ Regular operations (in-process)
    └─ Heavy operations → MCP Server (separate process)
```

### MCP Implementation Pattern
```javascript
// .claude/mcp-servers/logic-expert/server.js
module.exports = {
  name: "logic-expert",
  memory: "4GB",
  operations: {
    analyze: (input) => {
      // Memory-intensive analysis
      // Runs in separate 4GB process
      // No context accumulation
    }
  }
}
```

### Benefits of MCP Layer
1. **True parallelism** - MCP runs in separate process
2. **Memory isolation** - No impact on Claude's 16GB
3. **No context accumulation** - Isolated from main context
4. **Selective use** - Only for operations that need it

### Keep It Simple
- Most agents DON'T need MCP servers
- Sequential execution is fine for 90% of cases
- Only add MCP when memory becomes an issue
- Start with one MCP server as proof of concept

## Benefits of Reality-Based Design

### Simplifications:
1. **No concurrency concerns** - Everything sequential
2. **No memory math** - One agent at a time
3. **Simple orchestration** - Just a queue
4. **Predictable behavior** - Sequential = deterministic
5. **Easier debugging** - Linear execution path

### Performance:
1. **No slower than before** - We thought parallel, but it was sequential anyway
2. **Better context management** - Now we know to optimize for it
3. **More agents possible** - 20+ in sequence vs imagined 3 parallel

## Migration Strategy

### Phase 1: Update Core Understanding (Week 1)
1. Remove 3-agent limit assumptions
2. Update documentation to reflect sequential reality
3. Simplify tracking to current agent only
4. Remove parallel execution patterns

### Phase 2: Optimize for Sequential (Week 2)
1. Implement progressive summarization
2. Add context compression between agents
3. Optimize prompt sizes
4. Add output bounding

### Phase 3: Simplify Commands (Week 3)
1. Remove unnecessary orchestration complexity
2. Streamline agent sequences
3. Remove depth tracking
4. Simplify state management

## Success Criteria

1. **Context stays under limits** with 10+ sequential agents
2. **No memory errors** regardless of agent count
3. **Clear audit trail** of sequential execution
4. **Faster development** due to simpler architecture
5. **Better performance** through context optimization

## Risks

### Main Risk: Context Overflow
- **Mitigation**: Aggressive summarization and output limits
- **Fallback**: Limit number of agents per command

### Secondary Risk: Long Sequential Execution
- **Mitigation**: Show progress indicators
- **Fallback**: Allow early termination

## Conclusion

By accepting the reality that Claude Code executes agents sequentially and only the main agent can orchestrate, we can build a much simpler, more reliable architecture. The real challenge isn't managing parallel execution - it's managing context accumulation across sequential agents.

This design embraces what the system actually does rather than fighting against imagined constraints.

---
*Generated by Bootstrap /design v0.13.0 - Based on empirical testing*