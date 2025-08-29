# Command System Guide

## Overview

Bootstrap provides specialized Claude commands that guide you through software engineering workflows. These commands implement structured processes for design, planning, and implementation.

## Available Commands

### `/design-feature`
Interactive design exploration for feature implementation.

**Usage**: `/design-feature features/FEATURE_NAME.md`

**Process**:
- Gathers requirements interactively
- Explores design alternatives
- Creates Architecture Decision Records (ADRs)
- Generates comprehensive design documentation

**When to use**:
- Feature requirements are unclear or complex
- Multiple implementation approaches exist
- The feature impacts multiple system components

### `/generate-prp`
Generate a Project Requirements Prompt from a design document.

**Usage**: `/generate-prp designs/feature-name/design.md`

**Process**:
- Analyzes the design document
- Researches codebase patterns
- Adds implementation context
- Creates executable requirements with validation gates

**Output**: A comprehensive PRP document for one-pass implementation

### `/execute-prp`
Execute a Project Requirements Prompt with validation.

**Usage**: `/execute-prp PRPs/feature-name.md`

**Process**:
- Loads the PRP document
- Implements tasks in order
- Runs validation after each step
- Fixes issues automatically

## Standard Workflow

```
1. Create Feature Request (using FEATURE_TEMPLATE.md)
   ↓
2. /design-feature → Design Document + ADRs
   ↓
3. /generate-prp → Project Requirements Prompt
   ↓
4. /execute-prp → Implemented Feature
```

For simple features, you can skip the design phase:
```
1. Create Feature Request
   ↓
2. /generate-prp → Project Requirements Prompt
   ↓
3. /execute-prp → Implemented Feature
```

## Command Output Structure

### design-feature creates:
```
designs/
├── {number}-feature-{name}/
│   ├── design.md              # Main design document
│   ├── adrs/                  # Architecture Decision Records
│   │   └── ADR-001-{decision}.md
│   └── diagrams/              # Optional diagrams
```

### generate-prp creates:
```
PRPs/
└── {feature-name}.md          # Complete PRP document
```

### execute-prp creates:
- Implementation files as specified in the PRP
- Test files
- Updated documentation
- Modified existing files

## Command Files

Commands are defined in `.claude/commands/`:
- `design-feature.md`
- `generate-prp.md`
- `execute-prp.md`

Each command file contains:
- Process description
- When to use/skip
- Expected inputs and outputs
- Integration with other commands

## What is a PRP?

A **Project Requirements Prompt (PRP)** is a document format designed to give Claude all context needed for implementation:
- Complete requirements and goals
- Codebase context and examples
- Step-by-step implementation tasks
- Validation commands to run
- Error patterns and fixes

PRPs enable Claude to implement features in one pass with automatic validation and error correction.

## Best Practices

1. **Use design-feature for complex features** - It helps clarify requirements
2. **Review generated artifacts** - Ensure they meet your needs before proceeding
3. **Follow the workflow** - Feature → Design → PRP → Execute
4. **Let commands complete** - They include validation and error correction

For detailed command documentation, see individual command files in `.claude/commands/`.