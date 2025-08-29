# Rule: {Rule Name}

## Instructions

### Rule Metadata
- ID: {category}/{rule-name}
- Status: Active
- Security Level: {Critical|High|Medium|Low}
- Token Impact: ~{XX} tokens per operation
- Priority: {0-1000}
- Dependencies: [{list of rule IDs or empty}]

### Rule Configuration
```yaml
trigger: "{when the rule activates}"
conditions:
  - {condition_type}: {value}
  - {another_condition}: {value}
actions:
  - {action_type}: "{action_value}"
  - {another_action}: "{{config.path.to.value:default}}"
validations:
  - {validation_check}: {expected_value}
  - {another_validation}: true
error_handling:
  - {error_action}: {how_to_handle}
  - {provide_solution}: true
```

### Behavior
- {Brief description of what the rule does}
- {When it triggers}
- {What it validates}
- {How it handles errors}

---

📚 **Full Documentation**: [.claude/docs/rules/{category}/{rule-name}.md](../../docs/rules/{category}/{rule-name}.md)