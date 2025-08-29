# Framework Templates

This directory contains templates for creating Bootstrap framework components.

## Available Templates

### rule.template.md
Template for creating new rules in `.claude/rules/`.

**Usage**: Copy and fill in the placeholders to create a new rule.

### command.template.md
Template for creating new Claude commands in `.claude/commands/`.

**Usage**: Define new commands following this structure.

### rule-doc.template.md
Template for creating rule documentation in `.claude/docs/rules/`.

**Usage**: Create comprehensive documentation for each rule.

### config-section.template.yaml
Template for adding new configuration sections to `.claude/config.yaml`.

**Usage**: Add new configuration categories following this pattern.

## Using Templates

1. **Copy the appropriate template**
   ```bash
   cp .claude/templates/rule.template.md .claude/rules/category/new-rule.md
   ```

2. **Replace placeholders**
   - Replace `{placeholder}` with actual values
   - Remove optional sections if not needed
   - Ensure all links and references are correct

3. **Follow the patterns**
   - Maintain consistent formatting
   - Use appropriate metadata values
   - Include all required sections

## Template Placeholders

Common placeholders used:
- `{Rule Name}` - Human-readable rule name
- `{rule-name}` - Kebab-case rule identifier
- `{category}` - Rule category (git, project, testing, etc.)
- `{Priority}` - Rule priority (0-1000)
- `{default_value}` - Default configuration value

## Creating New Templates

When creating new templates:
1. Follow existing template patterns
2. Include clear placeholders with descriptive names
3. Add usage instructions in comments
4. Update this README with the new template

## Best Practices

- Keep templates comprehensive but not overwhelming
- Include examples where helpful
- Maintain consistency with existing components
- Document all required and optional sections