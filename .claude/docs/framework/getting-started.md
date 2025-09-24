# Getting Started with Bootstrap Framework

## Overview

Bootstrap uses the **4D+1 Workflow** - a structured approach that guides projects from initialization through implementation with AI-powered multi-agent support.

## Core Workflow

```
/init → /determine → /design → /define → /do
```

## Quick Start

### Step 1: Initialize Your Project
```bash
/init
```
Choose your charter mode:
- `prototype` - Quick experiments
- `draft` - Active development
- `ratified` - Stable projects

Creates `CHARTER.md` and `.sdlc/` structure.

### Step 2: Determine Requirements
```bash
/determine
```
Interactive requirements gathering:
- Identifies what to build and why
- Clarifies success criteria
- Validates against charter

Creates: `.sdlc/requirements/{number}-{name}.md`

### Step 3: Design Architecture (Optional)
```bash
/design
```
For complex features:
- Explores 2+ alternatives
- Documents trade-offs
- Creates ADRs

Creates: `.sdlc/designs/{number}-{type}-{name}/`

### Step 4: Define Implementation
```bash
/define
```
Generates detailed implementation prompts:
- Breaks work into tasks
- Specifies tests
- Updates TASK.md

Creates: `.sdlc/implementation/{number}-{name}/dip.md`

### Step 5: Do Implementation
```bash
/do
```
Executes the plan:
- Implements code and tests
- Runs validation
- Updates progress

## Project Structure

```
CHARTER.md           # Project principles
TASK.md             # Active tasks
.sdlc/
├── requirements/   # What to build
├── designs/        # How to build it
├── implementation/ # Detailed plans
└── amendments/     # Charter updates
```

## Multi-Agent System

Commands use specialized AI agents:
- **Requirements Engineer** - Your primary interface
- **Project Manager** - Coordinates team
- **Domain Experts** - Specialized knowledge
- **Technical Architects** - System design
- **QA Specialists** - Test strategies

## Key Concepts

### Document-Driven Development
Everything starts with clear documentation - requirements before design, design before code.

### Deterministic Safety
Critical operations use scripts, not AI interpretation, ensuring consistent behavior.

### Progressive Refinement
Commands accept previous outputs for iteration:
```bash
/design existing.md "make it more scalable"
```

## Next Steps

1. Run `/init` to set up your project
2. Use `/determine` to clarify what you're building
3. Apply `/design` for complex features
4. Generate plans with `/define`
5. Build with `/do`

## Best Practices

1. **Never skip /determine** - Understanding is critical
2. **Use /design for complexity** - Prevents costly mistakes
3. **Trust the validation** - Automatic error correction
4. **Review before commits** - You maintain control
5. **Leverage multi-agent expertise** - Specialists provide depth

## Getting Help

- Command details: `.claude/commands/`
- Workflow guide: [workflow.md](workflow.md)
- Command system: [command-system.md](command-system.md)
- Rule system: [rule-system.md](rule-system.md)

## Common Patterns

**New Feature:**
```bash
/init → /determine → /design → /define → /do
```

**Bug Fix:**
```bash
/determine → /define → /do
```

**Refactor:**
```bash
/determine → /design → /define → /do
```

Bootstrap handles complexity through structured workflows and multi-agent collaboration, letting you focus on building great software.