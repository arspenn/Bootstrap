# ADR-005: Rule System Evolution

## Status
Proposed

## Context
The current rule system has two problems:
1. Rules split between minimal `.md` files and separate documentation
2. Rules are often language/tool-specific rather than pattern-based
3. No clear mapping between rules and what should be embedded in commands

Since rules no longer need to be minimal (not loaded into context), we can redesign them as comprehensive reference specifications.

## Decision
Transform rules from minimal context files into comprehensive reference specifications that:

1. **Consolidate** all documentation into the rule file itself
2. **Modularize** by pattern rather than specific tools
3. **Map explicitly** to command requirements
4. **Support multiple stacks** through conditional sections

## Rule Structure Template
```yaml
# Rule: {Pattern Name}

## Required in Commands
- What MUST be embedded in command prompts
- Critical safety checks
- Non-negotiable validations

## Stack Configurations
python:
  environment: venv_linux
  tools: [black, ruff, mypy, pytest]
nodejs:
  environment: npm/yarn
  tools: [eslint, prettier, jest]
rust:
  environment: cargo
  tools: [clippy, rustfmt]

## Examples
- Working examples for each stack
- Edge cases and how to handle them
- Common mistakes to avoid

## Rationale
- Why this pattern exists
- What problems it prevents
- Historical context if relevant
```

## Consequences

### Positive
- Single source of truth for each pattern
- Easy to add new language/tool support
- Clear guidance for command creation
- Rules become valuable reference documentation
- Reduced duplication across similar patterns

### Negative
- Larger individual rule files
- Migration effort from current structure
- Need to update command generation process

### Neutral
- Rules shift from "loaded context" to "reference specs"
- Commands become the execution layer, rules the knowledge layer