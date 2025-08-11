# ADR-003: Comprehensive Documentation Format for Git Rules

## Status
Accepted

## Context
Current Git rule documentation varies in format and completeness. With the refactoring effort, we need a standardized, comprehensive documentation format that provides clear guidance while remaining maintainable.

## Decision
Adopt a comprehensive documentation format for all Git rules in `docs/rules/git/` with the following structure:

1. **Overview**: Purpose and importance
2. **Trigger Conditions**: When the rule activates
3. **Actions**: What the rule does, step-by-step
4. **Configuration Options**: Table of settings with defaults
5. **Examples**: Good practices and prevented patterns
6. **Troubleshooting**: Common issues and solutions
7. **Security Considerations**: Risks mitigated
8. **Related Rules**: Workflow connections

Keep the rule file itself concise with a link to full documentation:
```yaml
---

📚 **Full Documentation**: [docs/rules/git/{rule-name}.md](../../../docs/rules/git/{rule-name}.md)
```

## Consequences

### Positive
- Comprehensive guidance for users
- Consistent documentation across all rules
- Clear separation of concerns (rule logic vs documentation)
- Better troubleshooting support
- Security rationale clearly documented

### Negative
- More documentation to maintain
- Potential for documentation drift
- Increased initial effort

### Neutral
- Documentation becomes a key part of rule definition
- Users can choose depth of information needed
- Enables better onboarding for new team members