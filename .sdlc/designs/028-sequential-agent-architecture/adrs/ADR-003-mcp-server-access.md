# ADR-003: Subagents Can Access MCP Servers

## Status
Accepted

## Context
We discovered through testing that while subagents cannot use the Task tool to spawn other agents, they CAN access MCP (Model Context Protocol) servers. This provides a path for true memory isolation and parallel processing that the Task tool doesn't offer.

## Evidence
Testing on 2025-09-26 confirmed:
1. Subagent found `mcp__ide__getDiagnostics` tool
2. Subagent found `mcp__ide__executeCode` tool
3. All tools except Task are available to subagents
4. MCP tools work normally in subagent context

## Decision
Leverage MCP servers as an optimization layer for memory-intensive operations:
- Subagents can offload heavy computation to MCP servers
- MCP servers run in separate processes with configurable memory
- This provides true parallelism and memory isolation
- Use MCP for specific high-memory agents (logic-design-expert, etc.)

## Architecture Pattern
```
Main Agent (16GB Claude Code memory)
    ↓ (Task tool - sequential)
Subagent (shares same memory)
    ↓ (MCP tool - separate process!)
MCP Server (configurable memory, true isolation)
```

## Implementation Strategy

### Phase 1: Identify Candidates
Agents that would benefit from MCP isolation:
- logic-design-expert (complex analysis)
- code-reviewer (large file processing)
- test-runner (heavy computation)

### Phase 2: Simple MCP Implementation
Start with one agent as proof of concept:
```javascript
// .claude/mcp-servers/logic-expert/server.js
{
  "command": "node",
  "args": ["--max-old-space-size=4096", "server.js"],
  "transport": "stdio"
}
```

### Phase 3: Gradual Migration
Only convert agents that actually need memory isolation

## Consequences

### Positive
- True memory isolation (separate processes)
- Real parallelism possible (MCP + sequential agents)
- No context accumulation in MCP servers
- Subagents remain useful for orchestration
- Escape Claude's 16GB limit for specific operations

### Negative
- Additional complexity (MCP server management)
- Requires MCP server implementation
- Not all operations suitable for MCP
- Learning curve for MCP protocol

### Neutral
- Changes mental model again (but in a good way)
- Optional enhancement, not required
- Can implement incrementally

## Comparison: Task vs MCP

| Aspect | Task Tool | MCP Server |
|--------|-----------|------------|
| Availability | Main agent only | All agents |
| Execution | Sequential | True parallel |
| Memory | Shared 16GB | Separate process |
| Context | Accumulates | Isolated |
| Complexity | Simple | More complex |
| Use Case | Orchestration | Heavy computation |

## Recommendation
Use MCP servers selectively for memory-intensive operations while keeping the simple sequential architecture for general orchestration. This gives us the best of both worlds:
- Simple sequential orchestration via Task tool
- True parallel processing via MCP when needed
- Memory isolation for heavy operations
- No unnecessary complexity for simple tasks

---
*Discovered: 2025-09-26 through subagent testing*