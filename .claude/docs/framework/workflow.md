# Workflow Guide

## Overview

Bootstrap uses the **4D+1 Workflow** to guide projects from idea to implementation:

```
/init (once) → /determine → /design → /define → /do
                    ↑__________________________|
                    (cycle for each feature)
```

## Core Workflow

### Phase 1: Initialize Project (Once)
```bash
/init
```
Creates project charter and .sdlc/ structure. Choose mode:
- **prototype**: Rapid experimentation
- **draft**: Active development
- **ratified**: Stable with amendments

### Phase 2: Determine Requirements
```bash
/determine
```
Gather and document what needs to be built:
- Interactive requirements elicitation
- Stakeholder identification
- Success criteria definition

### Phase 3: Design Architecture
```bash
/design
```
Plan how to build it:
- Explore 2+ alternatives
- Create Architecture Decision Records
- Define implementation approach

### Phase 4: Define Implementation
```bash
/define
```
Generate detailed implementation prompts (DIPs):
- Break work into manageable tasks
- Specify test requirements
- Create TASK.md checklist

### Phase 5: Do Implementation
```bash
/do
```
Execute the DIP to build the solution:
- Implement code and tests
- Run validation checks
- Update task progress

## When to Skip Phases

**Skip Design** when approach is obvious or feature is simple
**Skip Define** for trivial changes with clear implementation
**Never skip Determine** - always understand what you're building

## File Organization

```
CHARTER.md                          # Project principles
.sdlc/
├── requirements/                   # /determine outputs
│   └── 001-user-auth.md
├── designs/                        # /design outputs
│   └── 001-system-user-auth/
│       ├── design.md
│       └── adrs/
├── implementation/                 # /define outputs
│   └── 001-user-auth/
│       └── dip.md
└── amendments/                     # Charter changes
```

## Command Arguments

Commands accept optional arguments for flexibility:
```bash
/design                    # Interactive mode
/design existing.md        # Iterate on existing design
/design existing.md "Make it scale to 10x"  # Refine with feedback
/do                        # Execute all tasks
/do 5                      # Execute specific task
```

## Quick Examples

**New Feature:**
```bash
/init → /determine → /design → /define → /do
```

**Bug Fix:**
```bash
/determine → /define → /do  # Skip design for simple fixes
```

**Refactor:**
```bash
/determine → /design → /define → /do  # Design critical for impact analysis
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Requirements unclear | Re-run `/determine` with more questions |
| Design too complex | Use `/design` to create phased approach |
| DIP missing context | Add references to existing code patterns |
| Tests failing | `/do` automatically fixes most test issues |
| Need charter changes | Create amendment in `.sdlc/amendments/` |

## Multi-Agent Support

Commands leverage specialized AI agents:
- **Requirements Engineer**: Leads all interactions
- **Project Manager**: Coordinates team efforts
- **Domain Experts**: Provide specialized knowledge
- **Technical Architects**: Design system structure
- **QA Specialists**: Define test strategies

Agents work in parallel for comprehensive analysis while maintaining single point of user interaction.