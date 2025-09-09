# Template Management Rule

## When to Apply
When creating or managing templates in the Bootstrap framework.

## Rule Requirements
- location: All templates MUST be in .claude/templates/
- naming: {kebab-case-name}.template.{ext}
- exception: README.template.md keeps uppercase
- extensions: .md, .yaml, or no extension

## Actions
- enforce_location: true
- enforce_naming: true
- auto_fix: false