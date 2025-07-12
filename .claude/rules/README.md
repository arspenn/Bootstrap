# Claude Rules Navigation

This directory contains behavior rules that guide Claude Code in performing various operations. Rules are organized by category and loaded automatically.

## Rule Categories

### Active Categories
- **[Git](git/index.md)** - Git version control operations and standards
  - Safe file staging practices
  - Commit message formatting
  - Branch naming conventions
  - Push/pull strategies

### Future Categories (Planned)
- **Testing** - Test creation and execution rules
- **Documentation** - Documentation standards and generation
- **Deployment** - Deployment procedures and checks
- **Security** - Security scanning and best practices

## Rule System Overview

### How Rules Work
1. Each rule is a single markdown file with a specific format
2. Rules are loaded alphabetically within each category
3. Rules define triggers, conditions, actions, and validations
4. User preferences can enable/disable specific rules
5. Rule definitions are immutable (cannot be modified)

### Rule Format
Each rule file contains:
- **ID**: Unique identifier based on filepath
- **Status**: Active, Experimental, or Deprecated
- **Security Level**: High, Medium, or Low
- **Token Impact**: Estimated tokens per operation
- **Rule Definition**: YAML block with trigger conditions
- **Examples**: Good and bad usage examples
- **Related Rules**: Links to related rules

### User Configuration
- User preferences: `config/user-preferences.yaml`
- Conflict log: `config/conflict-log.md`
- Templates: `.claude/templates/`

## Adding New Rules

### To add a new rule:
1. Create a markdown file in the appropriate category directory
2. Follow the standard rule format (see existing rules)
3. Include all required metadata fields
4. Add examples and documentation links
5. Update the category's index.md file
6. Test the rule thoroughly

### Rule Naming Convention
- Use lowercase with hyphens: `git-add-safety.md`
- Be descriptive but concise
- Group related rules with common prefixes

## Rule Loading Order
Rules are loaded in this order:
1. Categories are loaded alphabetically
2. Within each category, rules load alphabetically
3. User preferences are applied last
4. Conflicts are logged in `config/conflict-log.md`

## Best Practices
- Keep rules focused on a single concept
- Include clear examples for each rule
- Link to official documentation
- Estimate token impact accurately
- Mark security-critical rules appropriately
- Test rules with real-world scenarios

## Troubleshooting
- If a rule isn't being applied, check user preferences
- For conflicts between rules, check the conflict log
- Ensure rule files follow the correct format
- Verify rule status is "Active"

## Related Documentation
- [Git Control User Guide](../../docs/rules/git/README.md)
- [CLAUDE.md](../../CLAUDE.md) - Main conventions file
- [Design Document](../../designs/git-control-design.md)