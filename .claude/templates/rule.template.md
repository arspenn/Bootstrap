---
name: "Rule Template"
description: "Comprehensive reference specification for Bootstrap rules"
---

# Rule: [RULE_NAME]

## Quick Summary
[One-line description for MASTER_IMPORTS.md reference - what this rule does in plain language]

## Metadata

### Rule Classification
- **ID:** [CATEGORY]/[RULE-NAME]
- **Status:** [Active | Beta | Deprecated | Superseded]
- **Category:** [git | project | stack | core | patterns]
- **Subcategory:** [specific area within category]
- **Version:** [VERSION_NUMBER]
- **Created:** [YYYY-MM-DD]
- **Updated:** [YYYY-MM-DD]

### Impact Analysis
- **Security Level:** [Critical | High | Medium | Low]
- **Token Impact:** ~[XX] tokens per operation
- **Performance Impact:** [Negligible | Low | Medium | High]
- **Priority:** [0-1000] (higher = more important)
- **Dependencies:** [[RULE-ID-1], [RULE-ID-2]] or [none]
- **Conflicts:** [[RULE-ID-3]] or [none]

## When Applied

### Command Embedding
This rule is embedded in the following commands:
- `/[COMMAND_1]` - [How it's used in this command]
- `/[COMMAND_2]` - [How it's used in this command]
- `/[COMMAND_3]` - [How it's used in this command]

### Manual Triggers
Rule activates when:
- [TRIGGER_CONDITION_1]
- [TRIGGER_CONDITION_2]
- [TRIGGER_CONDITION_3]

### Automatic Triggers
Rule automatically applies during:
- [AUTOMATIC_SCENARIO_1]
- [AUTOMATIC_SCENARIO_2]

## Detailed Behavior

### Core Functionality
[Comprehensive description of what the rule does, why it exists, and how it works - 2-3 paragraphs]

### Rule Logic
```yaml
trigger: "[WHEN_RULE_ACTIVATES]"
conditions:
  - [CONDITION_TYPE_1]: [VALUE]
  - [CONDITION_TYPE_2]: [VALUE]
  - [CONDITION_TYPE_3]:
      - [SUB_CONDITION_1]
      - [SUB_CONDITION_2]

pre_checks:
  - [CHECK_1]: [EXPECTED_STATE]
  - [CHECK_2]: [EXPECTED_STATE]

actions:
  - [ACTION_TYPE_1]: "[ACTION_VALUE]"
  - [ACTION_TYPE_2]: "{{config.path.to.value:default}}"
  - [ACTION_TYPE_3]:
      if: [CONDITION]
      then: [ACTION]
      else: [ALTERNATIVE_ACTION]

validations:
  - [VALIDATION_CHECK_1]: [EXPECTED_VALUE]
  - [VALIDATION_CHECK_2]: true
  - [VALIDATION_CHECK_3]:
      pattern: "[REGEX_PATTERN]"
      message: "[ERROR_MESSAGE]"

error_handling:
  - [ERROR_TYPE_1]:
      action: [HOW_TO_HANDLE]
      message: "[USER_MESSAGE]"
      recovery: "[RECOVERY_STEPS]"
  - [ERROR_TYPE_2]:
      action: [HOW_TO_HANDLE]
      fallback: [FALLBACK_BEHAVIOR]

post_actions:
  - [CLEANUP_ACTION_1]
  - [LOGGING_ACTION]
  - [NOTIFICATION_ACTION]
```

### Decision Tree
```
[TRIGGER_EVENT]
    ├── Check: [CONDITION_1]
    │   ├── Yes → [ACTION_1]
    │   └── No → [ACTION_2]
    └── Check: [CONDITION_2]
        ├── Yes → [ACTION_3]
        └── No → [ERROR_HANDLING]
```

## Stack Variants

### Generic Implementation
```[LANGUAGE]
# Default implementation that works across stacks
[CODE_EXAMPLE]
```

### Python Specific
```python
# Python-specific implementation
[PYTHON_CODE_EXAMPLE]
```

### Node.js Specific
```javascript
// Node.js-specific implementation
[NODEJS_CODE_EXAMPLE]
```

### Other Stacks
- **Rust:** [Specific behavior or n/a]
- **Go:** [Specific behavior or n/a]
- **Java:** [Specific behavior or n/a]

## Examples

### Example 1: [COMMON_SCENARIO]
**Scenario:** [Description of the situation]
**Input:** [What triggers the rule]
**Rule Application:** [How the rule processes this]
**Output:** [What happens as a result]

```bash
# Example command or code
[EXAMPLE_COMMAND]
```

### Example 2: [EDGE_CASE]
**Scenario:** [Description of edge case]
**Input:** [Unusual input]
**Rule Application:** [How rule handles this]
**Output:** [Result]

### Example 3: [ERROR_SCENARIO]
**Scenario:** [What goes wrong]
**Input:** [Problematic input]
**Rule Application:** [How rule catches/handles error]
**Output:** [Error message and recovery]

## Configuration

### Default Settings
```yaml
[CATEGORY].[RULE_NAME]:
  enabled: true
  [SETTING_1]: [DEFAULT_VALUE]
  [SETTING_2]: [DEFAULT_VALUE]
  [SETTING_3]: [DEFAULT_VALUE]
```

### Customization Options
- **[SETTING_1]:** [What this controls and valid values]
- **[SETTING_2]:** [What this controls and valid values]
- **[SETTING_3]:** [What this controls and valid values]

### Environment Variables
- `[ENV_VAR_1]` - [Purpose and default]
- `[ENV_VAR_2]` - [Purpose and default]

## Integration Points

### Hooks
- **Pre-execution:** [HOOK_NAME] - [When it fires]
- **Post-execution:** [HOOK_NAME] - [When it fires]
- **Error:** [HOOK_NAME] - [When it fires]

### APIs
- **Consumes:** [API_1] - [What data it uses]
- **Provides:** [API_2] - [What data it exposes]

### File System
- **Reads:** [FILE_PATTERN] - [What it looks for]
- **Writes:** [FILE_PATTERN] - [What it creates/modifies]
- **Watches:** [FILE_PATTERN] - [What it monitors]

## Common Issues

### Issue: [ISSUE_NAME_1]
- **Symptoms:** [What users observe]
- **Cause:** [Why this happens]
- **Solution:** [How to fix it]
- **Prevention:** [How to avoid it]

### Issue: [ISSUE_NAME_2]
- **Symptoms:** [What users observe]
- **Cause:** [Why this happens]
- **Solution:** [How to fix it]
- **Prevention:** [How to avoid it]

## Troubleshooting

### Debug Mode
Enable debug output:
```bash
[DEBUG_COMMAND]
```

### Validation Commands
Check rule configuration:
```bash
[VALIDATION_COMMAND]
```

### Common Error Messages
- **"[ERROR_MESSAGE_1]"** - [What this means and how to fix]
- **"[ERROR_MESSAGE_2]"** - [What this means and how to fix]
- **"[ERROR_MESSAGE_3]"** - [What this means and how to fix]

## Best Practices

### DO:
- ✅ [BEST_PRACTICE_1] - [Why this is important]
- ✅ [BEST_PRACTICE_2] - [Why this is important]
- ✅ [BEST_PRACTICE_3] - [Why this is important]

### DON'T:
- ❌ [ANTI_PATTERN_1] - [Problems this causes]
- ❌ [ANTI_PATTERN_2] - [Problems this causes]
- ❌ [ANTI_PATTERN_3] - [Problems this causes]

### Performance Tips
- 🚀 [PERFORMANCE_TIP_1]
- 🚀 [PERFORMANCE_TIP_2]
- 🚀 [PERFORMANCE_TIP_3]

## Validation

### Testing Approach
```[LANGUAGE]
# Example validation/test
[VALIDATION_CODE]
```

### Manual Verification
1. [VERIFICATION_STEP_1]
2. [VERIFICATION_STEP_2]
3. [VERIFICATION_STEP_3]

## Related Resources

### Related Rules
- [[RULE_ID_1]]: [How they interact]
- [[RULE_ID_2]]: [How they interact]
- [[RULE_ID_3]]: [How they interact]

### Documentation
- [Design Document]: [LINK_OR_PATH]
- [Architecture Decision]: [LINK_OR_PATH]
- [User Guide]: [LINK_OR_PATH]

### External References
- [Article/Standard]: [LINK] - [Why relevant]
- [Tool/Library]: [LINK] - [How it's used]
- [Best Practice Guide]: [LINK] - [Key takeaways]

## Rule Evolution

### Version History
- **v[VERSION]:** [Initial implementation]
- **v[VERSION]:** [What changed and why]
- **v[VERSION]:** [What changed and why]

### Planned Improvements
- [ ] [FUTURE_ENHANCEMENT_1]
- [ ] [FUTURE_ENHANCEMENT_2]
- [ ] [FUTURE_ENHANCEMENT_3]

## Notes

### Implementation Notes
[Any special considerations, warnings, or context for implementers]

### Maintenance Notes
[Information for rule maintainers about tricky aspects or things to watch]

### Historical Context
[Why this rule was created, what problem it solved, lessons learned]

---
*Generated by Bootstrap [COMMAND] v[VERSION] on [DATE]*
