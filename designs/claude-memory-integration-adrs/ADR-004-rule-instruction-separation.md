# ADR-004: Separation of Rule Instructions from Documentation

## Status
Proposed

## Context
Our Git control rules currently mix behavioral instructions with documentation (examples, rationale, scenarios). Claude Code's memory import feature (@file syntax) expects direct instructions, not reference documentation. This mixing violates the principle that rules should be direct behavioral instructions for Claude to follow.

Current rule files contain:
- Metadata (ID, Status, Security Level)
- Rule definitions (YAML format)
- Descriptions
- Rationale sections
- Multiple examples
- Best practices
- Common scenarios

This makes rules verbose and not suitable for direct import as Claude instructions.

## Decision
We will separate rule files into two distinct types:
1. **Rule files** (`.claude/rules/`) - Contain only instructions Claude needs to follow
2. **Documentation files** (`docs/rules/`) - Contain examples, rationale, and explanations

Rule files will retain:
- Metadata headers (ID, Status, Security Level, Token Impact)
- Rule Definition in YAML format
- Brief instruction summary

Documentation files will contain:
- Examples
- Rationale
- Best practices
- Common scenarios
- Troubleshooting
- Cross-references to the rule

## Consequences

### Positive
- **Clear separation**: Instructions vs documentation is unambiguous
- **Import-ready**: Rules can be directly imported via @file syntax
- **Maintainability**: Changes to examples don't affect rule behavior
- **Performance**: Smaller rule files mean less token usage
- **User clarity**: Developers know where to look for what

### Negative
- **Duplication**: Some metadata exists in both files
- **Maintenance overhead**: Two files per rule to maintain
- **Migration effort**: Existing rules need restructuring

### Neutral
- **File count**: Doubles the number of files but improves organization
- **Cross-references**: Need to maintain links between rules and docs