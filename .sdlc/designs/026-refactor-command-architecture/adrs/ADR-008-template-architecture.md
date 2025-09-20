# ADR-008: Template Architecture

## Status
Proposed

## Context
Commands need consistent output formats, but embedding templates in command files:
- Makes commands huge and hard to maintain
- Duplicates content across similar commands
- Makes it hard to update formats globally
- Prevents template reuse and sharing

## Decision
All output templates stored in `.claude/templates/` and referenced by commands.

### Template Organization
```
.claude/templates/
├── charter.template.md          # Main charter template
├── charter-prototype.template.md # Minimal version
├── charter-draft.template.md     # Full but mutable
├── charter-ratified.template.md  # Stable version
├── requirements.template.md      # Feature requirements
├── design.template.md           # Design document
├── dip.template.md              # Design Implementation Prompt
├── amendment.template.md        # Charter amendments
├── task.template.md             # Task entry format
└── commit.template.md           # Commit message format
```

### Command Integration
Commands reference templates by name:
```yaml
/determine command:
  template: requirements.template.md
  variables:
    - number: (sequential)
    - name: (from user)
    - charter_version: (from CHARTER.md)
```

### Template Features
- Variables using `{{variable}}` syntax
- Conditional sections using `{{#if condition}}`
- Includes for common sections `{{> footer}}`
- Version footer in all templates

## Consequences

### Positive
- Templates can be updated without touching commands
- Easy to add new output formats
- Templates can be shared/imported from other projects
- Clear separation of format from logic
- Enables template testing independently

### Negative
- Additional file reads during command execution
- Need to handle missing template errors
- More files to maintain

### Neutral
- Templates become first-class citizens in the framework
- Opens possibility for user-customized templates