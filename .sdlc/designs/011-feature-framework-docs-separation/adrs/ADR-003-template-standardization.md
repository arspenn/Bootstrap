# ADR-003: Template Standardization in .claude

## Status
Proposed

## Context
The `.claude/` folder contains various types of files that should follow consistent templates:
- Rules (git, project, testing, documentation, python)
- Commands (design-feature, generate-prp, execute-prp)
- Configuration files (config.yaml, MASTER_IMPORTS.md)
- Documentation files

Currently, these files don't have formal templates, leading to inconsistency. We need templates for creating new instances of these files to ensure consistency and completeness.

## Decision
Create a comprehensive template structure in `.claude/templates/`:

```
.claude/templates/
├── rule.template.md           # Template for new rules
├── command.template.md        # Template for new commands  
├── rule-doc.template.md       # Template for rule documentation
├── config-section.template.yaml  # Template for config sections
└── README.md                  # Explains template usage
```

Each template will include:
- Required sections with placeholders
- Metadata headers where appropriate
- Usage examples
- Comments explaining each section

This is separate from project templates in `/templates/` which are for project artifacts like designs and features.

## Consequences

### Positive
- Consistency across all framework files
- Easier to create new rules and commands
- Clear guidelines for contributors
- Reduced cognitive load when adding framework components
- Templates serve as documentation of expected format

### Negative
- Additional templates to maintain
- Need to update templates when formats change
- Risk of templates becoming outdated

### Neutral
- Templates are guidelines, not strict requirements
- Can evolve templates based on usage patterns
- Separate PRP may be needed if template creation becomes complex