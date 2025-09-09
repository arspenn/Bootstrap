# Rule System Guide

## Overview

The Bootstrap rule system provides automated enforcement of best practices, safety checks, and project standards. Rules are lightweight, token-efficient instructions that guide Claude's behavior during development.

## How Rules Work

### Dual-Structure Design

Bootstrap uses a dual-structure approach for rules:

1. **Rule Files** (`.claude/rules/`) - Concise, actionable instructions
2. **Rule Documentation** (`.claude/docs/rules/`) - Detailed explanations and examples

This separation allows:
- Efficient token usage during execution
- Comprehensive documentation when needed
- Clear separation between "what to do" and "why/how to do it"

### Rule Loading Process

1. CLAUDE.md loads MASTER_IMPORTS.md
2. MASTER_IMPORTS.md imports individual rule files
3. Rules are parsed and activated based on priority
4. Higher priority rules execute before lower priority ones
5. Rules can reference config.yaml for customizable values

## Rule Structure

### Rule File Format

```markdown
# Rule: [Rule Name]

## Instructions

### Rule Metadata
- ID: category/rule-name
- Status: Active|Inactive|Deprecated
- Security Level: Critical|High|Medium|Low
- Token Impact: ~XX tokens per operation
- Priority: [0-1000]
- Dependencies: [list of rule IDs]

### Rule Configuration
trigger: [when the rule activates]
conditions:
  - [conditions that must be met]
actions:
  - [what Claude should do]
validations:
  - [what to check]

### Behavior
- [Brief description of what the rule does]
- [When it triggers]
- [What it validates]

---

📚 **Full Documentation**: [.claude/docs/rules/category/rule-name.md](../../docs/rules/category/rule-name.md)
```

### Rule Documentation Format

```markdown
# [Rule Name] Documentation

## Purpose
Why this rule exists and what problem it solves.

## When It Applies
Specific triggers and conditions.

## How It Works
Detailed explanation of the rule's behavior.

## Examples
### Following the Rule
[Good example with explanation]

### Violating the Rule
[Bad example with explanation]

## Configuration
Available configuration options and their defaults.

## Common Issues
Known problems and their solutions.

## Related Rules
Links to related or dependent rules.
```

## Rule Categories

### Git Rules (`git/`)
Ensure safe and consistent Git operations:
- `git-add-safety` - Validates files before staging
- `git-commit-format` - Enforces commit message standards
- `git-push-validation` - Checks before pushing
- `git-safe-file-operations` - Protects tracked files
- `git-branch-naming` - Enforces branch name patterns

### Project Rules (`project/`)
Maintain project standards:
- `changelog-update` - Ensures CHANGELOG stays current
- `version-management` - Handles version updates
- `test-file-location` - Enforces test organization
- `adr-management` - Manages architectural decisions
- `design-structure` - Maintains design documentation

### Testing Rules (`testing/`)
Enforce testing standards:
- `pytest-requirements` - Python testing standards

### Documentation Rules (`documentation/`)
Maintain documentation quality:
- `docstring-format` - Enforces documentation standards

### Python Rules (`python/`)
Python-specific standards:
- `environment-management` - Virtual environment handling
- `code-style` - Code formatting standards

## Rule Metadata

### Status Values
- **Active**: Rule is enforced
- **Inactive**: Rule is loaded but not enforced
- **Deprecated**: Rule will be removed in future versions

### Security Levels
- **Critical**: Security-critical, never bypassed
- **High**: Important safety checks
- **Medium**: Standard best practices
- **Low**: Suggestions and recommendations

### Priority Ranges
- **1000-900**: Security and safety critical
- **800-700**: Git and version control safety
- **600-500**: Project integrity
- **400-300**: Code quality
- **200-100**: Documentation
- **99-0**: Optional suggestions

### Token Impact
Indicates approximate token usage:
- **~10-20 tokens**: Minimal impact
- **~30-40 tokens**: Standard rule
- **~50+ tokens**: Complex rule with multiple checks

## Rule Configuration

### Using Config Variables

Rules can reference `config.yaml` values:
```yaml
actions:
  - enforce_format: "{{config.git.commit_format:conventional}}"
  - max_length: "{{config.git.subject_max_length:250}}"
```

Syntax: `{{config.path.to.value:default}}`

### Conditional Logic

Rules can include conditions:
```yaml
conditions:
  - command_contains: ["commit", "push"]
  - file_extension: [".py", ".js"]
  - not_in_directory: ["vendor/", "node_modules/"]
```

### Dependencies

Rules can depend on other rules:
```yaml
Dependencies: [git/git-add-safety, project/test-file-location]
```

Dependent rules execute after their dependencies.

## Rule Execution

### Trigger Points

Rules can trigger on:
- Commands: `git commit`, `npm install`
- File operations: create, edit, delete
- Specific patterns: file extensions, paths
- Task completion: tests passing, builds completing

### Validation Flow

1. **Pre-validation**: Check conditions before action
2. **Action**: Perform the required behavior
3. **Post-validation**: Verify success
4. **Error handling**: Provide solutions if validation fails

### Conflict Resolution

When rules conflict:
1. Higher priority rule takes precedence
2. Later imports override earlier ones
3. Dependencies are resolved first
4. Explicit overrides in CLAUDE.md win

## Creating Custom Rules

### Step 1: Identify the Need
- What problem are you solving?
- When should the rule apply?
- What should it enforce?

### Step 2: Choose a Category
- Use existing categories when possible
- Create new categories for unique domains

### Step 3: Write the Rule
- Keep instructions concise
- Focus on actionable items
- Include clear triggers and validations

### Step 4: Document Thoroughly
- Explain the why, not just the what
- Provide good and bad examples
- List configuration options

### Step 5: Test the Rule
- Verify it triggers correctly
- Check it doesn't conflict with existing rules
- Ensure documentation links work

## Best Practices

### Writing Rules
1. **Be specific** - Clear triggers and conditions
2. **Be actionable** - Tell Claude exactly what to do
3. **Be efficient** - Minimize token usage
4. **Be complete** - Include error handling

### Documentation
1. **Explain the why** - Context is crucial
2. **Show examples** - Good and bad patterns
3. **List exceptions** - When the rule doesn't apply
4. **Link related rules** - Show the bigger picture

### Testing Rules
1. **Test positive cases** - Rule enforces correctly
2. **Test negative cases** - Rule doesn't over-trigger
3. **Test edge cases** - Unusual conditions
4. **Test conflicts** - Interaction with other rules

## Common Patterns

### Safety Rules
```yaml
trigger: "dangerous command"
conditions:
  - requires_confirmation: true
actions:
  - check_prerequisites
  - show_warning
  - require_explicit_confirmation
validations:
  - prerequisites_met
  - user_confirmed
```

### Format Rules
```yaml
trigger: "file creation"
conditions:
  - file_type: [".md", ".py"]
actions:
  - apply_template
  - validate_format
validations:
  - matches_template
  - passes_linter
```

### Process Rules
```yaml
trigger: "task completion"
conditions:
  - task_type: "feature"
actions:
  - update_documentation
  - run_tests
  - update_changelog
validations:
  - docs_updated
  - tests_passing
  - changelog_current
```

## Troubleshooting

### Rule Not Triggering
- Check trigger conditions
- Verify rule is in MASTER_IMPORTS.md
- Check rule status is "Active"
- Review dependencies

### Rule Over-Triggering
- Refine conditions
- Add exclusions
- Adjust priority

### Rule Conflicts
- Check priorities
- Review load order
- Look for overlapping triggers
- Consider dependencies

### Performance Issues
- Check token impact
- Simplify complex conditions
- Split into multiple rules
- Use config variables

## Advanced Topics

### Rule Composition
Combine simple rules for complex behaviors:
- Use dependencies to chain rules
- Create rule groups for related behaviors
- Use shared configuration values

### Dynamic Rules
Rules that adapt based on context:
- Environment detection
- Project type awareness
- User preference adaptation

### Rule Metrics
Track rule effectiveness:
- How often rules trigger
- How often they prevent issues
- Token usage optimization

For specific rule documentation, see `.claude/docs/rules/`.