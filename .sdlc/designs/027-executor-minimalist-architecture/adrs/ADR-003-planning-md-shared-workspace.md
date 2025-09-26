# ADR-003: PLANNING.md as Universal Shared Workspace

## Status
Proposed

## Context
Serial specialist execution requires state transfer between agents. Rather than complex state objects, we can use PLANNING.md as a persistent, shared workspace that all agents can read, write, and iterate on asynchronously.

## Decision

### PLANNING.md as Central Hub
- Single file serves as shared scratch pad for all agents
- Starts from appropriate template based on command
- All agents read/write to same file
- Progressive refinement through iterations
- Final output copied to proper location when complete

### Unified Agent Log
- All agents append to same `.sdlc/logs/session-*/agent-collaboration.log`
- Each entry timestamped with agent identifier
- Later agents can scan log for context
- Provides natural audit trail

## Implementation

### File Structure
```
Project Root/
├── PLANNING.md                    # Active shared workspace
└── .sdlc/
    ├── logs/
    │   └── session-{timestamp}/
    │       └── agent-collaboration.log  # Unified log
    ├── requirements/               # Final requirements
    ├── designs/                     # Final designs
    └── templates/
        ├── planning-requirements.template.md
        ├── planning-design.template.md
        ├── planning-dip.template.md
        └── planning-generic.template.md
```

### Workflow Pattern

```python
# 1. Executor initializes PLANNING.md
executor.init_planning(command_type)
copy_template(f"planning-{command_type}.template.md", "PLANNING.md")

# 2. Command lead starts work
lead = executor.launch_lead()
lead.read("PLANNING.md")
lead.append_to_log("Starting analysis...")
lead.update_section("PLANNING.md", "## Problem Analysis")

# 3. Specialists iterate
for specialist in specialists:
    spec.read("PLANNING.md")
    spec.scan_log()  # Get context from previous agents
    spec.append_to_log(f"[{spec.name}] Analysis: ...")
    spec.update_section("PLANNING.md", relevant_section)

# 4. Lead synthesizes
lead.read_final("PLANNING.md")
lead.finalize_document()

# 5. Executor completes
executor.copy("PLANNING.md", target_location)
```

### PLANNING.md Template Structure

```markdown
# PLANNING: [Command Type] - [Feature Name]

## Status
[Draft | In Progress | Ready for Review | Complete]

## Working Notes
[Agent scratch space - messy is OK]

## Problem Statement
[Refined iteratively]

## Current Thinking
[Latest synthesis across all agents]

## Open Questions
- [ ] [Specialists add/resolve questions]

## Decisions Made
- [Agent adds decision with rationale]

## Next Steps
- [ ] [Agents add/check off tasks]

---
## Agent Contributions

### [Agent Name] - [Timestamp]
[Each agent's specific insights]
```

## Benefits

### State Management Simplified
- No complex state transfer protocol needed
- File persistence = automatic recovery
- Natural checkpoint (every file save)
- Easy to debug (human readable)

### Async Collaboration
- Agents can work independently
- No blocking on state transfer
- Natural merge of perspectives
- Progressive refinement

### Failure Recovery
- PLANNING.md persists through crashes
- Can resume from any point
- User can manually edit if needed
- Natural rollback (git history)

### Cognitive Load Reduction
- Single file to track
- All work visible in one place
- Clear progress indication
- Easy user intervention

## Consequences

### Positive
- Massive simplification of state management
- Natural audit trail in both log and file
- User can watch progress in real-time
- Recovery is trivial (just read the file)
- Supports both serial and parallel workflows

### Negative
- File I/O overhead (minimal)
- Potential merge conflicts if truly parallel
- Single point of failure (mitigated by git)

### Neutral
- Changes workflow to file-centric
- All agents must handle PLANNING.md format
- Templates become critical infrastructure

## Migration Path

1. Create planning templates for each command
2. Update Executor to initialize PLANNING.md
3. Modify command leads to use PLANNING.md
4. Update specialists for shared workspace
5. Implement unified logging

## Example Usage

```bash
# User runs command
/determine "user authentication"

# Executor creates PLANNING.md from template
# RE reads, updates problem statement
# Business Analyst adds user stories
# Domain Expert adds security considerations
# QA Specialist adds acceptance criteria

# All visible in PLANNING.md as it evolves
# Final version copied to .sdlc/requirements/001-user-authentication.md
```

This approach transforms complex distributed state management into simple file-based collaboration, using the filesystem as our database and git as our recovery mechanism.

---
*Created: 2025-09-25*