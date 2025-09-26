# Insight: MCP Server Memory Optimization Strategy

**Date Captured**: 2025-09-25
**Category**: Enhancement
**Severity**: High
**Component**: Multi-agent architecture

## Summary
Implement MCP (Model Context Protocol) servers to bypass Claude Code's 16GB memory limitation by running memory-intensive operations in separate processes with configurable memory allocation. The logic-design-expert agent will run as an MCP server with 4GB allocation to handle heavy computational tasks while preserving system stability.

## Context
During discussion of the Bootstrap command refactoring (design 026), we identified that JavaScript heap exhaustion limits concurrent agents to 2 (ADR-013). The user's system has 26GB safe memory allocation, with Claude using 16GB, leaving ~10GB for additional processes.

## Details
### The Plan
1. **Architecture**: Each specialist agent can spawn its own MCP server process
2. **Memory Management**:
   - System total safe: 26GB
   - Claude Code main: 16GB (fixed)
   - Available for MCP: ~10GB
   - Per MCP instance: 4GB (allowing 2 concurrent)
3. **Implementation**: Start with logic-design-expert as stdio MCP server
4. **Lifecycle**: On-demand spawning with automatic cleanup after task completion

### Technical Approach
```javascript
// MCP server configuration
{
  "command": "node",
  "args": ["--max-old-space-size=4096", "server.js"],
  "transport": "stdio"
}
```

### Benefits
- **Memory Isolation**: Each MCP runs in separate process
- **Concurrent Execution**: 2 sub-agents can each spawn MCP servers
- **Automatic Cleanup**: Memory freed immediately after task
- **No Context Pollution**: Clean state for each invocation
- **Bypass Limitations**: Escape Claude's 16GB sandbox

## Impact
This approach solves the critical memory constraint that limits multi-agent orchestration to 2 concurrent agents. By offloading heavy computation to MCP servers, we can maintain the 2-agent limit while still performing memory-intensive operations.

## Recommendation
1. Build production-ready MCP server (not just prototype)
2. Start with logic-design-expert implementation
3. Configure with 4GB memory limit for safety
4. Test with concurrent agent calls
5. Document as ADR-014 once proven
6. Consider expanding to other specialist agents

## Implementation Path
```bash
.claude/mcp-servers/
├── logic-design-expert/
│   ├── server.js         # MCP server with 4GB limit
│   ├── package.json      # Dependencies and scripts
│   └── README.md         # Configuration docs
└── config.json           # Claude Code MCP config
```

## Related Context
- **Current Phase**: Between 1D (agent personalities) and Phase 2 (rule reorganization)
- **Fits Architecture**: Scripts handle deterministic ops (ADR-011), MCP is similar
- **Already Planned**: Backlog-TASK.md line 409: "Add MCP capability"
- **Memory Strategy**: Aligns with ADR-013's memory optimization goals

---
*Captured via `/insight-capture` from conversation about MCP server implementation strategy*