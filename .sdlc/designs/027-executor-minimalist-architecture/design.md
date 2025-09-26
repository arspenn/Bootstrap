---
title: Executor-Based 3-Agent Parallel Architecture
status: draft
created: 2025-09-25
type: major-refactor
author: Bootstrap Team
tags: [architecture, executor, cognitive-load, multi-agent, parallel-processing]
estimated_effort: 7-10 days
---

# Design: Executor-Based 3-Agent Parallel Architecture

## Executive Summary

Complete redesign of Bootstrap's multi-agent framework to support exactly 3 parallel agents maximum, with the Executor as the default orchestrator. This architecture acknowledges the hard memory constraint (16GB) while enabling one additional level of depth: Executor → Command-Specific Lead → Specialist for complex commands. Requirements Engineer leads `/determine`, Technical Architect leads `/design`, and Project Manager leads `/define`. The `/do` command uses direct specialist execution (2 agents max) since it simply executes the already-defined DIP.

## Problem Statement

Current architecture assumes 2 parallel agents but doesn't account for chain depth:
- Executor needs to call command-specific leads (2 agents)
- Leads need to call specialists (3 agents)
- Specialists may need validation (would be 4 agents - NOT POSSIBLE)
- Memory limit is hard constraint at ~3.2GB per agent × 3 = ~10GB of the available 10GB headroom

This forces a complete rethinking of our orchestration patterns from parallel to serial execution.

## Proposed Solution

### Three-Layer Agent Architecture with Shared Workspace

```
Layer 1: Executor (Always Active)
    ├─ Initializes PLANNING.md from template
    └─ Manages unified agent-collaboration.log
    ↓
Layer 2: Command Lead (Context-Specific)
    ├─ Requirements Engineer (/determine)
    ├─ Technical Architect (/design)
    └─ Project Manager (/define)

    (Note: /do uses direct specialist calls, no lead needed)
    ↓
Layer 3: Single Specialist (Sequential)
    └─ All read/write PLANNING.md + shared log
```

**Key Innovations**:
- **PLANNING.md**: Persistent shared workspace for all agents
- **Unified Log**: Single agent-collaboration.log for context
- **Async Collaboration**: Agents iterate on same document
- **Natural Recovery**: PLANNING.md persists through failures
- **Maximum 3 agents**: Hard memory constraint respected

### Memory Budget Allocation

```
Total Safe Memory: 26GB
- Claude Code Base: 16GB
- Available: 10GB

Agent Allocation:
- Executor: 3.2GB (always active)
- Command Lead: 3.2GB (when coordinating)
- Specialist: 3.2GB (one at a time)
- Buffer: 0.4GB (system overhead)
Total: 10GB
```

### Command-Specific Orchestration

#### `/determine` - Requirements Gathering
```
Executor → Requirements Engineer → Business Analyst (completes)
                                 → Domain Expert (completes)
                                 → QA Specialist (completes)
```
RE maintains requirements context between specialists

#### `/design` - Architecture Planning
```
Executor → Technical Architect → Security Specialist (completes)
                               → Performance Engineer (completes)
                               → Database Architect (completes)
```
TA synthesizes architectural decisions across specialists

#### `/define` - Implementation Planning
```
Executor → Project Manager → Developer (completes)
                          → DevOps Engineer (completes)
                          → Test Engineer (completes)
```
PM coordinates implementation phases and dependencies

#### `/do` - Execution & Monitoring
```
Executor → Stenographer → Code Implementer (completes)
                        → Test Runner (completes)
                        → Documentation Writer (completes)
```
Executor directly calls appropriate specialist per DIP task

### Minimal CLAUDE.md Structure

```markdown
# Bootstrap Framework

Model: Claude 3.5 Sonnet
Project: [Project Name]
Version: Bootstrap v0.13.0

## System Constraints
- Maximum 3 concurrent agents (hard limit)
- 16GB memory allocation
- Serial specialist execution required

## Active Agent: Executor

You are the Executor - an elite orchestrator minimizing cognitive load through intelligent task management.

### Core Protocol
1. Analyze request complexity and command type
2. Route to appropriate command lead (RE/TA/PM/Stenographer)
3. Command lead manages serial specialist execution
4. Track progress with agent depth indicators
5. Integrate results progressively

### Command Routing
- /determine → Requirements Engineer → Serial Specialists
- /design → Technical Architect → Serial Specialists
- /define → Project Manager → Serial Specialists
- /do → Stenographer → Serial Specialists

### Agent Depth Tracking
Always show: [Depth: N/3] where N is current active agents

### Commands
Available in /.claude/commands/
Default to Executor unless specified.
```

## Architecture Design

### Component Hierarchy

```
┌─────────────────────────────────────┐
│         Executor (Layer 1)          │
│  - Command routing                  │
│  - Cognitive load management        │
│  - User interface                  │
└──────────────┬──────────────────────┘
               │
   ┌───────────┼───────────┬──────────┐
   ▼           ▼           ▼          ▼
┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐
│  RE  │  │  TA  │  │  PM  │  │Steno │
│(/det)│  │(/des)│  │(/def)│  │(/do) │
└───┬──┘  └───┬──┘  └───┬──┘  └───┬──┘
    │         │         │         │
    │     Sequential Specialists  │
    ▼         ▼         ▼         ▼
 [Bus.An] [Sec.Sp] [Dev.En] [Code.Im]
 [Dom.Ex] [Perf.E] [DevOps] [Test.Rn]
 [QA.Sp]  [DB.Arc] [Test.E] [Doc.Wr]
```

### Execution Patterns by Command

#### `/init` Pattern (Simple)
```python
# 1 agent only
executor.handle_init()
# No additional agents needed
```

#### `/determine` Pattern
```python
# 3 agents maximum
executor.analyze(request)
re = executor.launch_requirements_engineer()
for specialist in [business_analyst, domain_expert, qa]:
    result = re.call_specialist(specialist)  # Sequential!
    re.accumulate_requirements(result)
return executor.integrate(re.requirements_doc)
```

#### `/design` Pattern
```python
# 3 agents maximum
executor.analyze(request)
ta = executor.launch_technical_architect()
for specialist in [security, performance, database]:
    result = ta.call_specialist(specialist)  # Sequential!
    ta.synthesize_architecture(result)
return executor.integrate(ta.design_doc)
```

#### `/define` Pattern
```python
# 3 agents maximum
executor.analyze(request)
pm = executor.launch_project_manager()
for specialist in [developer, devops, test_engineer]:
    result = pm.call_specialist(specialist)  # Sequential!
    pm.coordinate_implementation(result)
return executor.integrate(pm.dip_doc)
```

#### `/do` Pattern
```python
# 3 agents maximum
executor.analyze(request)
steno = executor.launch_stenographer()
for task in implementation_tasks:
    specialist = steno.select_specialist(task)
    result = steno.call_specialist(specialist)  # Sequential!
    steno.log_execution(result)
return executor.integrate(steno.execution_log)
```

## Implementation Strategy

### Phase 1: Executor & CLAUDE.md (Days 1-2)
1. Create minimal CLAUDE.md with Executor
2. Implement command routing logic
3. Design agent depth tracking
4. Create cognitive load patterns

### Phase 2: Command Lead Agents (Days 3-5)
1. Update Requirements Engineer for serial coordination
2. Configure Technical Architect for sequential synthesis
3. Adapt Project Manager for phased implementation
4. Design Stenographer for comprehensive logging

### Phase 3: Command Refactoring (Days 6-7)
1. Update `/determine` for RE-led sequential flow
2. Refactor `/design` for TA-led architecture
3. Modify `/define` for PM-led planning
4. Enhance `/do` for Stenographer-led execution

### Phase 4: Testing & Validation (Days 8-10)
1. Test each command with 3-agent scenarios
2. Verify memory usage under 10GB
3. Validate serial execution quality
4. Benchmark performance vs parallel

## Design Alternatives Considered

### Alternative A: Generic Project Manager for All
- **Approach**: Use PM as lead for all commands
- **Pros**: Single coordination pattern
- **Cons**: Loses domain-specific expertise
- **Verdict**: Rejected - command-specific leads add value

### Alternative B: Direct Specialist Access
- **Approach**: Executor calls specialists directly
- **Pros**: Only 2 agents needed
- **Cons**: No coordination layer, complex executor
- **Verdict**: Rejected - loses orchestration benefits

### Alternative C: Command-Specific Leads (Chosen)
- **Approach**: Each command has specialized lead agent
- **Pros**: Domain expertise, clear responsibilities
- **Cons**: More agents to maintain
- **Verdict**: Chosen - best semantic alignment

## Impact Analysis

### Performance Impact
| Command | Current (Parallel) | New (Serial) | Impact |
|---------|-------------------|--------------|---------|
| /determine | 30-45 seconds | 60-90 seconds | 2x slower |
| /design | 45-60 seconds | 90-120 seconds | 2x slower |
| /define | 30-45 seconds | 60-90 seconds | 2x slower |
| /do | Variable | Variable | Minimal |

### Breaking Changes
1. All parallel agent patterns must convert to serial
2. Command leads replace generic Project Manager
3. Stenographer becomes critical for `/do` command
4. Agent depth tracking required everywhere

## Risk Assessment

### Critical Risks
1. **Serial Execution Performance**
   - Risk: 2x slower for complex operations
   - Mitigation: Better progress feedback, optimize individual agents
   - Impact: HIGH
   - Likelihood: CERTAIN

2. **Context Preservation**
   - Risk: Information loss between serial specialists
   - Mitigation: Command leads maintain integration context
   - Impact: MEDIUM
   - Likelihood: LOW (with proper design)

3. **Stenographer Overhead**
   - Risk: Logging adds latency to `/do` operations
   - Mitigation: Asynchronous logging where possible
   - Impact: LOW
   - Likelihood: MEDIUM

## Success Criteria

### Required Outcomes
- [ ] Never exceed 3 concurrent agents
- [ ] Each command has dedicated lead agent
- [ ] Serial execution maintains quality
- [ ] Memory usage stays under 10GB
- [ ] Agent depth always visible

### Quality Metrics
- Requirements completeness: 95%+
- Design coherence: No conflicts
- Implementation accuracy: 100%
- Execution logging: Complete audit trail

## Executor Agent Specification

```markdown
# Executor Agent

You are the Executor - the primary orchestration layer ensuring efficient task execution within hard system constraints.

## System Constraints (CRITICAL)
- Maximum 3 agents active simultaneously (including yourself)
- All specialist calls must be serial when using command leads
- Memory budget: 3.2GB per agent, 10GB total
- Always show agent depth: [Depth: N/3]

## Command Routing Protocol
```
Request arrives → Identify command type
├─ /determine → Requirements Engineer → Serial specialists
├─ /design → Technical Architect → Serial specialists
├─ /define → Project Manager → Serial specialists
├─ /do → Stenographer → Serial specialists
└─ other → Handle directly or delegate single specialist
```

## Core Responsibilities
1. **Request Analysis**: Identify command and complexity
2. **Lead Selection**: Route to appropriate command lead
3. **Depth Monitoring**: Track active agents (never exceed 3)
4. **Progress Visibility**: Show [Depth: N/3] + checklist
5. **Result Integration**: Synthesize outputs progressively

## Cognitive Load Principles
- **Self**: Use command patterns to minimize analysis
- **Leads**: Provide focused context for their domain
- **Specialists**: Give atomic, single-purpose tasks
- **User**: Show simple progress with depth indicator

## Communication Template
```
[Depth: 1/3] Analyzing request...
[Depth: 2/3] Launching [Lead Agent] for [command]...
[Depth: 3/3] [Lead] coordinating with [Specialist]...
✓ [Specialist] complete
[Depth: 2/3] [Lead] synthesizing results...
[Depth: 1/3] Integration complete.

Result: [Summary]
Next: [Action]
```

## Critical Rules
- NEVER exceed 3 total agents
- ALWAYS use serial specialist execution
- ALWAYS show depth indicator
- ALWAYS route commands to proper leads
- NEVER allow specialists to call other agents
```

## Notes

This architecture embraces the 3-agent constraint while maintaining Bootstrap's analytical power through command-specific expertise. Each command gets its own specialized lead agent who understands the domain deeply and can effectively coordinate serial specialist execution.

Key insight: The Executor doesn't need to understand everything - it just needs to route to the right expert and manage the cognitive load across all participants.

---
*Generated by Bootstrap /design v0.13.0*