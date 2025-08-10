# Enhanced Rule Metadata Pattern

## Overview
This document defines the metadata pattern for Claude rules, including priority and dependency management for proper rule loading and conflict resolution.

## Metadata Fields

### Rule Metadata Structure
All rules must include the following metadata fields in their header:

- **ID**: Unique identifier in format `category/rule-name`
- **Status**: Current status (Active, Deprecated, Experimental)
- **Security Level**: Risk level (Low, Medium, High)
- **Token Impact**: Estimated tokens per operation
- **Priority**: Integer 100-800 determining precedence
- **Dependencies**: Array of rule IDs that must load first

## Priority Scale
The priority system uses a scale from 100-800 to determine rule precedence:

- 800-700: Critical project rules (planning, structure)
- 699-600: Language-specific rules (Python, JavaScript)
- 599-500: Style and documentation rules
- 499-400: Testing and quality rules
- 399-300: Optional enhancement rules
- 299-100: Low-priority suggestions

## Dependency Format
Dependencies are specified as an array of rule IDs:

```yaml
Dependencies: []  # No dependencies
Dependencies: ["project/planning-context"]  # Single dependency
Dependencies: ["python/environment", "project/structure"]  # Multiple dependencies
```

## Complete Rule Example
```markdown
# Rule: Python Code Style

## Instructions

### Rule Metadata
- ID: python/code-style
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 600
- Dependencies: ["python/environment-management"]

### Rule Configuration
```yaml
trigger: ["python file creation", "python file edit"]
conditions:
  - file_extension: [".py"]
  - language: "python"
actions:
  - enforce_pep8: true
  - require_type_hints: true
  - format_with_black: true
validations:
  - pep8_compliance: true
  - type_hints_present: true
```

### Behavior
[Rule-specific behavior description]

---

📚 **Full Documentation**: [docs/rules/python/code-style.md](../../../docs/rules/python/code-style.md)
```

## Override Hierarchy
Rules are applied according to the following precedence hierarchy:

1. User instructions (implicit priority: 1000)
2. TASK.md requirements (implicit priority: 900)
3. Individual rules (explicit priority: 100-800)
4. CLAUDE.md defaults (implicit priority: 100)

When multiple rules could apply to a situation, the rule with the highest priority takes precedence.

## Validation Requirements
- Priority must be an integer between 100-800
- Dependencies must reference existing rule IDs
- No circular dependencies allowed
- Dependencies array can be empty
- All metadata fields must be present
- ID must follow `category/rule-name` format

## Rule Categories
Standard categories for organizing rules:

- `git/` - Git and version control rules
- `project/` - Project management and structure rules
- `python/` - Python-specific development rules
- `testing/` - Testing and quality assurance rules
- `documentation/` - Documentation standards rules
- `config/` - Configuration and setup rules

## Metadata Template
```markdown
### Rule Metadata
- ID: category/rule-name
- Status: Active
- Security Level: Low|Medium|High
- Token Impact: ~N tokens per operation
- Priority: 100-800
- Dependencies: ["dependency/id", "another/dependency"]
```