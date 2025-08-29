# Getting Started with Bootstrap Framework

## Overview

Bootstrap is a comprehensive software engineering framework designed to work seamlessly with Claude AI. It provides structured workflows for designing features, generating implementation plans, and executing them with built-in validation and testing.

## Core Concepts

### 1. Document-Driven Development
Everything starts with documentation. Features are specified in markdown, designs are documented before implementation, and all decisions are recorded.

### 2. Command-Based Workflow
Bootstrap uses Claude commands to guide you through each phase:
- `design-feature` - Interactive design exploration
- `generate-prp` - Create detailed implementation prompts
- `execute-prp` - Execute implementation with validation

### 3. Rule System
Automated rules ensure consistency and best practices:
- Git operations follow safety rules
- Commits use conventional format
- Documentation stays updated
- Tests are required

## Quick Start

### Step 1: Create a Feature Request
```bash
# Use the feature template
cp FEATURE_TEMPLATE.md features/FEATURE_MY_NEW_FEATURE.md
# Edit to describe your feature
```

### Step 2: Design the Feature
```bash
# Run the design command
/design-feature features/FEATURE_MY_NEW_FEATURE.md
```
This will:
- Gather requirements interactively
- Explore design alternatives
- Create ADRs for key decisions
- Generate comprehensive design documentation

### Step 3: Generate Implementation Plan
```bash
# Create a PRP (Project Requirements Prompt) from your design
/generate-prp designs/my-feature/design.md
```
This creates a detailed PRP with:
- All necessary context for Claude
- Step-by-step implementation tasks
- Validation gates
- Success criteria

### Step 4: Execute Implementation
```bash
# Execute the PRP
/execute-prp PRPs/my-feature.md
```
Claude will:
- Read the requirements prompt
- Implement all tasks in order
- Run validation after each step
- Fix any issues automatically
- Ensure all tests pass

## Project Structure

```
.claude/              # Framework configuration and rules
├── docs/            # Framework documentation (you are here)
├── rules/           # Automated behavior rules
├── commands/        # Available Claude commands
└── templates/       # Framework templates

Project Root/
├── features/        # Feature requests
├── designs/         # Design documentation
├── PRPs/           # Project Requirements Prompts
├── docs/           # Project documentation
├── tests/          # Test files
└── src/            # Source code
```

## Key Files

- **CLAUDE.md** - Main configuration file that loads rules
- **PLANNING.md** - Project architecture and plans
- **TASK.md** - Current tasks and todos
- **CHANGELOG.md** - Project change history

## What is a PRP?

A **Project Requirements Prompt (PRP)** is a specialized document format designed to give Claude Code all the context and instructions needed to successfully implement a feature. Unlike traditional requirements documents, PRPs are:

- **Context-rich**: Include all necessary documentation, examples, and gotchas
- **Executable**: Contain validation commands Claude can run
- **Self-correcting**: Include error patterns and fixes
- **Complete**: Provide everything needed for one-pass implementation

## Next Steps

1. Read the [Rule System Guide](rule-system.md) to understand automated behaviors
2. Learn about [Configuration](configuration.md) options
3. Explore the [Workflow Guide](workflow.md) for detailed processes
4. Check [Command System](command-system.md) for available commands

## Best Practices

1. **Always design before implementing** - Use `design-feature` for complex features
2. **Follow the workflow** - Feature → Design → PRP → Execute
3. **Let rules guide you** - They enforce best practices automatically
4. **Document everything** - Decisions, designs, and changes
5. **Test continuously** - Validation gates ensure quality

## Getting Help

- Framework documentation: `.claude/docs/`
- Project documentation: `docs/`
- Rule explanations: `.claude/docs/rules/`
- Command help: `.claude/commands/`

## Common Commands

```bash
# Check current tasks
cat TASK.md

# View active rules
cat .claude/MASTER_IMPORTS.md

# See project architecture
cat PLANNING.md

# Review recent changes
cat CHANGELOG.md
```

## Tips for Success

1. **Trust the process** - The workflow is designed to prevent mistakes
2. **Be specific in features** - Clear requirements lead to better designs
3. **Use existing patterns** - Bootstrap provides many examples
4. **Validate often** - Run tests frequently during development
5. **Keep documentation current** - Update as you work

Remember: Bootstrap handles the complexity so you can focus on building great software.