# Configuration Guide

## Overview

Bootstrap framework configuration is managed through several key files that control Claude's behavior, rule loading, and project settings.

## Configuration Hierarchy

1. **CLAUDE.md** - Main entry point
2. **MASTER_IMPORTS.md** - Rule loading manifest
3. **config.yaml** - Framework configuration
4. **Rule files** - Individual rule configurations

## CLAUDE.md Configuration

The root `CLAUDE.md` file is the main configuration that Claude reads first. It establishes the framework context and loads rules.

### Structure
```markdown
# Claude Configuration

## Rule Loading
@.claude/MASTER_IMPORTS.md

## Project Context
Loaded from: .claude/config.yaml

## AI Behavior Rules
[Universal Claude behavior instructions that apply to all interactions]
```

### Key Sections

**Rule Loading**: Imports all active rules via MASTER_IMPORTS.md

**Project Context**: References config.yaml for detailed settings

**AI Behavior Rules**: Universal Claude behaviors such as:
- Context verification patterns
- Library and import safety checks
- File system operation standards
- Code modification safety requirements
- Communication standards

## MASTER_IMPORTS.md

Located at `.claude/MASTER_IMPORTS.md`, this file controls which rules are active.

### Example Structure
```markdown
# Claude Rule Imports

## Git Rules
@.claude/rules/git/git-add-safety.md
@.claude/rules/git/git-commit-format.md
@.claude/rules/git/git-push-validation.md

## Project Management Rules
@.claude/rules/project/changelog-update.md
@.claude/rules/project/version-management.md

## Testing Rules
@.claude/rules/testing/pytest-requirements.md
```

### Managing Rules
- Comment out rules to disable: `# @.claude/rules/git/git-add-safety.md`
- Add new rules by including their path
- Order matters for conflicting rules (later rules override)

## config.yaml Structure

The `.claude/config.yaml` file contains framework configuration values.

### Example Configuration
```yaml
framework:
  version: "1.0.0"
  name: "Bootstrap"

git:
  commit_format: "conventional"
  subject_max_length: 250
  body_line_length: 72
  commit_types:
    - feat
    - fix
    - docs
    - style
    - refactor
    - test
    - chore
  require_body_for:
    - feat
    - fix
    - refactor
  branch_pattern: "^(main|develop|feature/.+|bugfix/.+|hotfix/.+)$"
  protected_branches:
    - main
    - develop

project:
  changelog_format: "keepachangelog"
  version_file: "version.txt"
  test_directory: "tests/"
  documentation_directory: "docs/"
```

## Rule Configuration

Each rule file contains its own configuration section:

### Rule Metadata
```yaml
# Rule: Git Commit Format

## Instructions

### Rule Metadata
- ID: git/git-commit-format
- Status: Active
- Security Level: Medium
- Token Impact: ~30 tokens per operation
- Priority: 400
- Dependencies: []

### Rule Configuration
trigger: "git commit"
conditions:
  - command_contains: ["commit"]
actions:
  - enforce_format: "{{config.git.commit_format:conventional}}"
  - use_template: ".claude/templates/commit-message.template"
validations:
  - format: "<type>(<scope>): <subject>"
```

### Configuration Variables

Rules can reference config.yaml values using template syntax:
- `{{config.git.commit_format:conventional}}` - Uses git.commit_format from config.yaml, defaults to "conventional"
- `{{config.project.test_directory:tests/}}` - Uses project.test_directory, defaults to "tests/"

## Priority System

Rules have priority levels that determine execution order:

- **1000-900**: Critical security rules
- **800-700**: Git safety rules
- **600-500**: Project management rules
- **400-300**: Code quality rules
- **200-100**: Documentation rules
- **99-0**: Optional/suggestion rules

Higher priority rules execute first and can block lower priority rules.

## Security Levels

Rules define security levels that indicate their importance:

- **Critical**: Must never be bypassed
- **High**: Requires explicit override
- **Medium**: Standard enforcement
- **Low**: Suggestions and best practices

## Adding Custom Rules

### Step 1: Create the Rule File

Create a new rule file in the appropriate category:
```bash
# Create the rule
.claude/rules/custom/my-custom-rule.md
```

Rule file structure:
```markdown
# Rule: My Custom Rule

## Instructions

### Rule Metadata
- ID: custom/my-custom-rule
- Status: Active
- Security Level: Medium
- Token Impact: ~20 tokens per operation
- Priority: 300
- Dependencies: []

### Rule Configuration
[Your rule configuration here]

### Behavior
- What the rule does
- When it triggers
- What it validates

---

📚 **Full Documentation**: [.claude/docs/rules/custom/my-custom-rule.md](../../docs/rules/custom/my-custom-rule.md)
```

### Step 2: Create Rule Documentation

Create detailed documentation for the rule:
```bash
# Create the documentation
.claude/docs/rules/custom/my-custom-rule.md
```

Documentation structure:
```markdown
# My Custom Rule Documentation

## Purpose
Detailed explanation of why this rule exists and what problem it solves.

## When It Applies
Specific conditions and triggers for the rule.

## Examples
### Good Example
[Code or command that follows the rule]

### Bad Example
[Code or command that violates the rule]

## Configuration Options
List any configuration variables the rule uses.

## Related Rules
- Links to related rules
- Dependencies or conflicts
```

### Step 3: Add to MASTER_IMPORTS.md

Add your rule to the import manifest:
```markdown
## Custom Rules
@.claude/rules/custom/my-custom-rule.md
```

### Step 4: Test the Rule

Verify the rule loads and works correctly:
```bash
# Check if rule is loaded
grep "my-custom-rule" .claude/MASTER_IMPORTS.md

# Test the behavior the rule enforces
```

## Debugging Configuration

### Check Active Rules
```bash
# See all loaded rules
grep "^@" .claude/MASTER_IMPORTS.md

# Check if a specific rule is active
grep "git-commit-format" .claude/MASTER_IMPORTS.md
```

### Rule Conflicts

If rules conflict, check:
1. Rule priorities (higher executes first)
2. Load order in MASTER_IMPORTS.md
3. Rule dependencies listed in metadata

## Best Practices

1. **Follow the dual-structure pattern** - Create both concise rule and detailed documentation
2. **Use appropriate priorities** - Don't set unnecessarily high priorities
3. **Document configuration options** - Explain what can be customized
4. **Test rules thoroughly** - Verify they work as expected
5. **Keep rules focused** - Each rule should do one thing well

## Troubleshooting

**Rules not applying**: Check MASTER_IMPORTS.md includes the rule

**Conflicting behaviors**: Review rule priorities and load order

**Config not loading**: Validate file paths and syntax

**Unexpected defaults**: Check template variable syntax in rules

For more details on the rule system, see the [Rule System Guide](rule-system.md).