# ADR-004: Complete 3-Agent Architecture with PLANNING.md

## Status
Proposed

## Context
After multiple iterations and logic-design-expert review, we've converged on a simplified architecture that solves memory constraints while maintaining analytical power through intelligent use of shared workspace and unified logging.

## Decision

### Core Architecture
1. **Maximum 3 concurrent agents** (hard limit due to 16GB memory)
2. **PLANNING.md as shared workspace** (state management simplified)
3. **Unified agent-collaboration.log** (context sharing)
4. **Command-specific orchestration patterns**:
   - `/determine`: Executor → RE → Serial Specialists (3 agents)
   - `/design`: Executor → TA → Serial Specialists (3 agents)
   - `/define`: Executor → PM → Serial Specialists (3 agents)
   - `/do`: Executor → Direct Specialist (2 agents)
   - `/init`: Executor only (1 agent)

### PLANNING.md Workflow

```markdown
# Standard Flow
1. User invokes command
2. Executor creates PLANNING.md from template
3. Command lead reads/updates PLANNING.md
4. Specialists serially read/update PLANNING.md
5. Each agent logs to unified log
6. Lead synthesizes final content
7. Executor copies to target location

# Failure Recovery
- PLANNING.md persists (git tracked)
- Can resume from any point
- User can manually edit if needed
```

### Key Design Choices

#### Why PLANNING.md?
- **Single source of truth** - No state transfer complexity
- **Natural persistence** - Survives crashes
- **User visibility** - Can watch progress
- **Git integration** - Natural versioning/rollback
- **Simple debugging** - Human readable

#### Why Unified Log?
- **Context preservation** - Later agents see earlier work
- **Natural audit trail** - Complete execution history
- **Async collaboration** - No blocking on state
- **Debug friendly** - Single file to review

#### Why Direct /do Execution?
- **DIP already exists** - Created by /define
- **No synthesis needed** - Just execution
- **Memory efficiency** - 2 agents vs 3
- **Faster execution** - No orchestration overhead

### Implementation Patterns

```python
# Executor pattern
class Executor:
    def handle_command(self, command, args):
        # Initialize workspace
        self.init_planning(command)

        # Route to appropriate pattern
        if command == "/do":
            return self.direct_execution()
        else:
            return self.orchestrated_execution(command)

    def init_planning(self, command):
        template = f"planning-{command}.template.md"
        copy(template, "PLANNING.md")

    def direct_execution(self):
        # Read DIP, execute tasks directly
        for task in load_dip().tasks:
            specialist = self.get_specialist(task.type)
            self.call_specialist(specialist, task)

    def orchestrated_execution(self, command):
        lead = self.get_lead(command)
        lead.coordinate_specialists()
        return copy("PLANNING.md", get_target_path())
```

### Phase Indicators (Not Depth)
Show meaningful progress:
- `[Phase: Analysis]` - Understanding the problem
- `[Phase: Coordination]` - Lead working with specialists
- `[Phase: Synthesis]` - Combining insights
- `[Phase: Finalization]` - Creating final artifact

## Consequences

### Positive
- **Simplified state management** - File system is the database
- **Natural recovery** - PLANNING.md persists
- **Clear mental model** - File-centric workflow
- **User control** - Can intervene at any point
- **Proven pattern** - Files + git is battle-tested

### Negative
- **File I/O overhead** - Minor performance impact
- **Serial execution slower** - 2x for complex operations
- **Learning curve** - New workflow pattern

### Critical Success Factors
1. **Templates must be comprehensive** - Starting point matters
2. **Agents must respect PLANNING.md format** - Consistent sections
3. **Log entries must be meaningful** - Context for later agents
4. **Phase indicators must be accurate** - User trust

## Migration Requirements

1. Create planning templates for all commands
2. Update Executor with PLANNING.md initialization
3. Modify command leads for shared workspace
4. Update specialists for unified logging
5. Replace depth indicators with phase indicators
6. Test failure/recovery scenarios

## Validation Criteria
- [ ] Never exceed 3 concurrent agents
- [ ] PLANNING.md preserves all context
- [ ] Recovery works from any failure point
- [ ] Phase indicators match actual state
- [ ] Final artifacts match quality standards

This architecture represents the simplest thing that could possibly work while respecting hard constraints and maintaining quality.

---
*Created: 2025-09-25*