---
name: "Command Template"
description: "Documentation template for Bootstrap commands"
---

# [COMMAND_NAME]

## Command: /[COMMAND_NAME]

**Arguments:** [ARGUMENT_LIST] (optional: specify if none)
**Category:** [4D Workflow | Supporting | Utility | Administrative]
**Version:** [VERSION_INTRODUCED]
**Status:** [Active | Beta | Deprecated]

## Purpose

[Clear, concise description of what the command does and why it exists - 2-3 sentences max]

## When to Use This Command

### Use `/[COMMAND_NAME]` when:
- [SPECIFIC_USE_CASE_1 - be very specific about the scenario]
- [SPECIFIC_USE_CASE_2 - include context about when this is appropriate]
- [SPECIFIC_USE_CASE_3 - describe the problem it solves]
- [SPECIFIC_USE_CASE_4 - if applicable]

### Don't use `/[COMMAND_NAME]` when:
- [ANTI_PATTERN_1 - explain what to use instead]
- [ANTI_PATTERN_2 - clarify the alternative approach]
- [ANTI_PATTERN_3 - if applicable]

### Prerequisites
- [ ] [PREREQUISITE_1] must exist/be configured
- [ ] [PREREQUISITE_2] must be completed first
- [ ] [PREREQUISITE_3] if applicable

## Process

### Phase 1: [PHASE_NAME]
1. **[STEP_1_NAME]**
   - Action: [What the command does]
   - Validation: [What is checked]
   - Output: [What is produced]
   - Error Handling: [How failures are managed]

2. **[STEP_2_NAME]**
   - Action: [What the command does]
   - Validation: [What is checked]
   - Output: [What is produced]
   - Error Handling: [How failures are managed]

### Phase 2: [PHASE_NAME]
3. **[STEP_3_NAME]**
   - Action: [What the command does]
   - Validation: [What is checked]
   - Output: [What is produced]
   - Error Handling: [How failures are managed]

4. **[STEP_4_NAME]**
   - Action: [What the command does]
   - Validation: [What is checked]
   - Output: [What is produced]
   - Error Handling: [How failures are managed]

### Phase 3: [PHASE_NAME]
5. **[STEP_5_NAME]**
   - Action: [What the command does]
   - Validation: [What is checked]
   - Output: [What is produced]
   - Error Handling: [How failures are managed]

## Output

### Files Created
```
[OUTPUT_LOCATION]/
├── [FILE_1]                    # [Description of contents and purpose]
├── [DIRECTORY_1]/              # [Description of directory purpose]
│   ├── [FILE_2]               # [Description of contents]
│   └── [FILE_3]               # [Description of contents]
└── [FILE_4]                    # [Description of contents and purpose]
```

### File Details

#### [FILE_1]
- **Purpose:** [What this file is for]
- **Format:** [File format/structure]
- **Key Sections:** [Important parts of the file]
- **Template:** [TEMPLATE_NAME.template.md]

#### [FILE_2]
- **Purpose:** [What this file is for]
- **Format:** [File format/structure]
- **Key Sections:** [Important parts of the file]
- **Template:** [TEMPLATE_NAME.template.md]

### Updates to Existing Files
- **[EXISTING_FILE_1]:** [What gets added/modified]
- **[EXISTING_FILE_2]:** [What gets added/modified]

## Integration

### Workflow Position
```
[PREVIOUS_COMMAND] → /[COMMAND_NAME] → [NEXT_COMMAND]
          ↑                                      ↓
   [INPUT_ARTIFACT]                    [OUTPUT_ARTIFACT]
```

### Dependencies
- **Upstream Commands:**
  - `/[COMMAND_1]` - Provides [WHAT_IT_PROVIDES]
  - `/[COMMAND_2]` - Generates [WHAT_IT_GENERATES]

- **Downstream Commands:**
  - `/[COMMAND_3]` - Consumes [WHAT_IT_CONSUMES]
  - `/[COMMAND_4]` - Requires [WHAT_IT_REQUIRES]

### Related Commands
- `/[RELATED_COMMAND_1]` - [How they relate]
- `/[RELATED_COMMAND_2]` - [How they relate]

## Configuration

### Command Options
```yaml
option_1: [DEFAULT_VALUE]        # [Description of what this controls]
option_2: [DEFAULT_VALUE]        # [Description of what this controls]
option_3: [DEFAULT_VALUE]        # [Description of what this controls]
```

### Templates Used
- `[TEMPLATE_1.template.md]` - [When/how it's used]
- `[TEMPLATE_2.template.md]` - [When/how it's used]

### Scripts Used
- `[SCRIPT_1.sh]` - [Purpose and when it runs]
- `[SCRIPT_2.py]` - [Purpose and when it runs]

## Validation & Safety

### Pre-Execution Checks
- ✓ [CHECK_1]: [What is validated and why]
- ✓ [CHECK_2]: [What is validated and why]
- ✓ [CHECK_3]: [What is validated and why]

### During Execution
- ✓ [VALIDATION_1]: [What is monitored]
- ✓ [VALIDATION_2]: [What is monitored]

### Post-Execution Verification
- ✓ [VERIFICATION_1]: [What is confirmed]
- ✓ [VERIFICATION_2]: [What is confirmed]

### Safety Rules
- 🛡️ [SAFETY_RULE_1]: [Protection mechanism]
- 🛡️ [SAFETY_RULE_2]: [Protection mechanism]
- 🛡️ [SAFETY_RULE_3]: [Protection mechanism]

## Error Handling

### Common Errors

#### Error: [ERROR_NAME_1]
- **Cause:** [What triggers this error]
- **Solution:** [How to fix it]
- **Prevention:** [How to avoid it]

#### Error: [ERROR_NAME_2]
- **Cause:** [What triggers this error]
- **Solution:** [How to fix it]
- **Prevention:** [How to avoid it]

### Recovery & Rollback
1. [RECOVERY_STEP_1]
2. [RECOVERY_STEP_2]
3. [RECOVERY_STEP_3]

```bash
# Rollback commands if needed
[ROLLBACK_COMMAND_1]
[ROLLBACK_COMMAND_2]
```

## Examples

### Example 1: [SCENARIO_NAME]
```bash
/[COMMAND_NAME] [ARGUMENTS]
```

**Context:** [When you would use this]
**Result:** [What this produces]

```
# Output
[EXAMPLE_OUTPUT]
```

### Example 2: [SCENARIO_NAME]
```bash
/[COMMAND_NAME] [DIFFERENT_ARGUMENTS]
```

**Context:** [When you would use this variation]
**Result:** [What this produces differently]

## Best Practices

### DO:
- ✅ [BEST_PRACTICE_1] - [Why this is important]
- ✅ [BEST_PRACTICE_2] - [Why this is important]
- ✅ [BEST_PRACTICE_3] - [Why this is important]
- ✅ [BEST_PRACTICE_4] - [Why this is important]

### DON'T:
- ❌ [ANTI_PATTERN_1] - [What problems this causes]
- ❌ [ANTI_PATTERN_2] - [What problems this causes]
- ❌ [ANTI_PATTERN_3] - [What problems this causes]

### Tips for Success
1. **[TIP_1_TITLE]:** [Detailed tip explanation]
2. **[TIP_2_TITLE]:** [Detailed tip explanation]
3. **[TIP_3_TITLE]:** [Detailed tip explanation]

## Troubleshooting

### Issue: [ISSUE_1]
- **Symptoms:** [What you observe]
- **Diagnosis:** [How to confirm the issue]
- **Solution:** [Steps to resolve]

### Issue: [ISSUE_2]
- **Symptoms:** [What you observe]
- **Diagnosis:** [How to confirm the issue]
- **Solution:** [Steps to resolve]

## Command Evolution

### Version History
- **v[VERSION]:** Initial implementation
- **v[VERSION]:** [Change description]
- **v[VERSION]:** [Change description]

### Future Evolution
- [ ] [PLANNED_IMPROVEMENT_1]
- [ ] [PLANNED_IMPROVEMENT_2]
- **Deprecation:** [Any features being phased out or changed]

## Related Documentation
- [Design Document]: [LINK_OR_PATH]
- [Architecture Decision]: [LINK_OR_PATH]
- [User Guide]: [LINK_OR_PATH]
- [API Reference]: [LINK_OR_PATH]

---
*Generated by Bootstrap [COMMAND] v[VERSION] on [DATE]*
