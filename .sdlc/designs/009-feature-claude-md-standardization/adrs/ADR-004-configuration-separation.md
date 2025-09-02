# ADR-004: Configuration Separation Strategy

## Status
Proposed

## Context
CLAUDE.md currently mixes configuration values (like `venv_linux` environment) with behavioral rules. We need to decide:
1. Keep configuration in CLAUDE.md
2. Create separate configuration file
3. Embed configuration in individual rules
4. Use environment variables

Clean separation improves maintainability and allows project-specific overrides.

## Decision
We will create a separate `.claude/config.yaml` file for project configuration, keeping rules purely behavioral. Configuration can override rule defaults.

## Consequences

### Positive
- **Separation of Concerns**: Rules define behavior, config defines values
- **Project Flexibility**: Easy to change config without touching rules
- **Override Capability**: Projects can customize rule behavior
- **Clear Structure**: Obvious where to find/change settings
- **Version Control**: Config changes tracked separately

### Negative
- **Additional File**: One more file to manage
- **Potential Confusion**: Users need to know about both files
- **Synchronization**: Config and rules must stay compatible

### Neutral
- Config file is optional (rules have defaults)
- CLAUDE.md references config file
- Config validated against rule expectations