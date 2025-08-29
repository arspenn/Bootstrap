# {Rule Name} Documentation

## Purpose

{Detailed explanation of why this rule exists and what problem it solves. Include context about what issues occur without this rule.}

## When It Applies

### Triggers
- {Specific trigger condition 1}
- {Specific trigger condition 2}

### Conditions
The rule activates when:
- {Detailed condition 1}
- {Detailed condition 2}
- {Detailed condition 3}

### Exclusions
The rule does NOT apply when:
- {Exception case 1}
- {Exception case 2}

## How It Works

### Step-by-Step Process
1. {What happens first when the rule triggers}
2. {What validation or check occurs}
3. {What action is taken}
4. {How the result is validated}

### Configuration Options
```yaml
# These values can be customized in config.yaml
{config_option_1}: {default_value}  # {Description}
{config_option_2}: {default_value}  # {Description}
```

## Examples

### Example 1: Following the Rule
```{language}
# Good example
{code that follows the rule}
```
**Why this is correct**: {Explanation}

### Example 2: Violating the Rule
```{language}
# Bad example
{code that violates the rule}
```
**Why this violates the rule**: {Explanation}
**How to fix**: {Solution}

## Common Issues and Solutions

### Issue: {Common Problem 1}
**Symptom**: {What the user sees}
**Cause**: {Why it happens}
**Solution**: {How to fix it}

### Issue: {Common Problem 2}
**Symptom**: {What the user sees}
**Cause**: {Why it happens}
**Solution**: {How to fix it}

## Configuration

### Using config.yaml
```yaml
{category}:
  {setting_1}: {value}
  {setting_2}: {value}
```

### Overriding in CLAUDE.md
```markdown
## Custom Override
- {How to override this specific rule}
```

## Related Rules

- [{Related Rule 1}](./{related-rule-1}.md) - {How they work together}
- [{Related Rule 2}](./{related-rule-2}.md) - {Relationship}

## Dependencies

This rule depends on:
- {Dependency 1} - {Why it's needed}

This rule is required by:
- {Dependent rule 1} - {How it uses this rule}

## Best Practices

1. **{Best Practice 1}** - {Details}
2. **{Best Practice 2}** - {Details}
3. **{Best Practice 3}** - {Details}

## Error Messages

### Error: "{Error Message 1}"
**Meaning**: {What this error means}
**Fix**: {How to resolve it}

### Error: "{Error Message 2}"
**Meaning**: {What this error means}
**Fix**: {How to resolve it}

## Testing the Rule

To verify this rule is working:
```bash
# Test command or scenario
{test_command}
```
Expected result: {What should happen}

## History and Rationale

{Optional: Background on why this rule was created, what problems it solved, any relevant ADRs}