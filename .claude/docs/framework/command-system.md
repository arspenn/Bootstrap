# Command System Guide

## Overview

Bootstrap uses the **4D+1 Workflow** - five commands that guide projects from initialization through implementation:

```
/init → /determine → /design → /define → /do
```

## Core Commands

### `/init` - Initialize Project
Sets up project structure and charter.

**Usage**: `/init` or `/init "project-name"`

**Creates**:
- `CHARTER.md` with project principles
- `.sdlc/` directory structure
- Initial configuration

**Modes**:
- `prototype` - Rapid experimentation
- `draft` - Active development
- `ratified` - Stable with amendments

### `/determine` - Gather Requirements
Interactive requirements elicitation.

**Usage**: `/determine` or `/determine existing-req.md "refine for scale"`

**Creates**: `.sdlc/requirements/{number}-{name}.md`

**Process**:
- Identifies stakeholders
- Clarifies problem space
- Defines success criteria
- Validates against charter

### `/design` - Architecture Planning
Explores implementation alternatives.

**Usage**: `/design` or `/design existing-design.md`

**Creates**: `.sdlc/designs/{number}-{type}-{name}/`
- `design.md` - Architecture document
- `adrs/` - Decision records
- `diagrams/` - Visual representations

**Process**:
- Evaluates 2+ alternatives
- Documents trade-offs
- Creates ADRs for key decisions

### `/define` - Implementation Definition
Generates detailed implementation prompts (DIPs).

**Usage**: `/define` or `/define design.md`

**Creates**: `.sdlc/implementation/{number}-{name}/`
- Single: `dip.md`
- Phased: `{letter}-{component}-dip.md`
- Updates `TASK.md` checklist

### `/do` - Execute Implementation
Builds the solution from DIP specifications.

**Usage**: `/do` or `/do 5` (specific task)

**Process**:
- Implements code and tests
- Runs validation checks
- Updates task progress
- NO automatic commits

## Workflow Patterns

**Standard Feature**:
```bash
/init → /determine → /design → /define → /do
```

**Quick Fix**:
```bash
/determine → /define → /do  # Skip design for simple changes
```

**Complex Refactor**:
```bash
/determine → /design → /define → /do  # Design critical
```

## Multi-Agent Architecture

Commands leverage specialized AI agents:
- **Requirements Engineer** - Primary user interface
- **Project Manager** - Coordinates team
- **Technical Architects** - System design
- **QA Specialists** - Test strategies
- **Domain Experts** - Specialized knowledge

## File Organization

```
CHARTER.md                    # Project principles
TASK.md                       # Active tasks
.sdlc/
├── requirements/             # /determine outputs
├── designs/                  # /design outputs
├── implementation/           # /define outputs
└── amendments/               # Charter updates
```

## Command Arguments

Commands support flexible arguments:
```bash
/design                       # Interactive
/design existing.md           # Iterate
/design existing.md "scale"   # Refine
/do                          # All tasks
/do 5                        # Specific task
```

## Supporting Scripts

Commands use deterministic scripts in `.claude/scripts/`:
- Structure creation (`init-structure.sh`)
- Stack detection (`detect-stack.sh`)
- Document generation (`create-*.sh`)
- Testing (`run-tests.sh`, `lint-check.sh`)
- Git safety (`git-safe-add.sh`)

## Best Practices

1. **Always start with /init** - Establishes project charter
2. **Never skip /determine** - Understanding is critical
3. **Use /design for complexity** - Prevents costly mistakes
4. **Trust /do validation** - Automatic error correction
5. **Review before commits** - User maintains control

For detailed command documentation, see `.claude/commands/`.