# ADR-003: Configuration Reset Approach

## Status
Accepted

## Context

The `.claude/config.yaml` file contains project-specific settings that need to be reset to generic defaults when preparing the framework for a new project. We have several options:

1. **In-place Editing**: Modify specific fields in the existing config
2. **Template Replacement**: Replace entire file with a default template
3. **Merge Approach**: Merge defaults with existing structure
4. **Removal**: Delete config.yaml entirely

The config file contains:
- Project metadata (name, description, version)
- Development settings (linting, testing, formatting)
- Framework paths (.sdlc/ directories)
- Git configuration

## Decision

Use a template replacement approach with a pre-defined default configuration template stored at `.claude/templates/config-default.template.yaml`.

The reset process will:
1. Load the default template
2. Replace the existing config.yaml entirely
3. Set generic values:
   - Project name: "YourProjectName"
   - Description: "Your project description"
   - Version: "0.1.0"
   - Keep all other settings at framework defaults

## Consequences

### Positive
- **Simplicity**: Clean, predictable replacement
- **Completeness**: Ensures all project-specific data removed
- **Maintainability**: Template can be updated independently
- **Consistency**: All reset projects start with identical config

### Negative
- **No Preservation**: Any user customizations to defaults are lost
- **Template Maintenance**: Requires keeping template in sync with framework

### Neutral
- **File Size**: Template duplicates config structure
- **Version Control**: Template changes tracked separately
- **Testing**: Template correctness must be validated

## Notes

The template approach provides the cleanest reset while maintaining framework functionality. Users can customize the config after reset for their specific project needs. The template file serves as documentation of the default configuration.