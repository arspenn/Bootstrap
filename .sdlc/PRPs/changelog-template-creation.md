name: Changelog Entry Template Creation
description: |
  Create CHANGELOG_entry.md template to standardize and simplify changelog updates.
  
  This PRP implements a template that guides developers in writing consistent, well-formatted changelog entries that follow Keep a Changelog standards.
  
  Core objectives:
  - Create intuitive entry template
  - Include all necessary categories
  - Provide clear examples
  - Guide proper formatting
  - Reduce friction for updates

## Goal

Create a changelog entry template that:
1. Makes it easy to write proper changelog entries
2. Includes all Keep a Changelog categories
3. Provides examples for each type
4. Guides developers to user-focused language
5. Integrates with the changelog workflow

## Why

**Consistency**: All entries follow same format
**Efficiency**: No need to remember categories
**Quality**: Examples guide good descriptions
**Adoption**: Lower barrier to updating changelog
**Standards**: Enforces Keep a Changelog format

## What

### Success Criteria
- [ ] CHANGELOG_entry.md created in .claude/templates/
- [ ] All Keep a Changelog categories included
- [ ] Clear examples for each category
- [ ] Instructions for proper usage
- [ ] User-focused language guidance
- [ ] Integration with changelog rules
- [ ] Easy to copy and use

## All Needed Context

### Keep a Changelog Categories
- **Added**: New features
- **Changed**: Changes in existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Vulnerability fixes

### Good Entry Characteristics
- User-focused, not implementation-focused
- Clear and concise
- Start with verb (Added, Fixed, etc.)
- No technical jargon
- No commit hashes
- Complete sentences

### Integration Points
- Referenced by changelog-update rule
- Used when adding entries to CHANGELOG.md
- Supports semi-automated workflow

## Implementation Blueprint

### Use Existing Template Directory
The template will be placed in the existing `.claude/templates/` directory alongside commit-message.template and branch-name.template.

### Create CHANGELOG_entry.md
```markdown
# Changelog Entry Template

Use this template when adding entries to CHANGELOG.md. Copy the relevant sections to the Unreleased section of the changelog.

## Instructions

1. Choose the appropriate category for your change
2. Write a user-focused description
3. Add to the Unreleased section of CHANGELOG.md
4. Delete categories that don't apply
5. Keep descriptions concise but complete

## Template

Copy the sections below that apply to your changes:

### Added
- [Brief description of new feature or capability]
- [Another new feature if applicable]

Examples:
- Git merge control rules for safer branch integration
- Automated changelog reminders for significant changes
- Support for custom workflow patterns

### Changed
- [Brief description of changed functionality]
- [Another change if applicable]

Examples:
- Improved token efficiency by 83% through rule restructuring
- Updated Git commit format to support extended descriptions
- Enhanced error messages for failed operations

### Deprecated
- [Feature that will be removed in future version]
- [Include migration path if applicable]

Examples:
- Legacy import syntax (use @import instead)
- Manual rule loading (now automatic via imports)

### Removed
- [Feature or capability that was removed]
- [Explain why if not obvious]

Examples:
- Redundant configuration options
- Deprecated API endpoints
- Legacy file formats

### Fixed
- [Brief description of what was broken and is now fixed]
- [Another fix if applicable]

Examples:
- Git push validation now correctly handles force pushes
- Memory leak in rule processing resolved
- Incorrect error handling in branch operations

### Security
- [Security issue that was addressed]
- [DO NOT include exploit details]

Examples:
- Prevented accidental commit of sensitive files
- Enhanced validation of user inputs
- Updated dependencies to patch vulnerabilities

## Writing Guidelines

### DO:
- Write for users, not developers
- Use clear, simple language
- Start with what changed, not how
- Group related changes together
- Be specific but concise

### DON'T:
- Don't use technical implementation details
- Don't reference commit hashes or PR numbers
- Don't use developer jargon
- Don't write novels - keep it brief
- Don't combine different categories

## Examples of Good vs Bad Entries

❌ **Bad**: Fixed bug in utils.py line 42
✅ **Good**: Fixed error when processing files with special characters

❌ **Bad**: Refactored AbstractFactoryManager class
✅ **Good**: Improved performance of project initialization

❌ **Bad**: git commit -m "feat: stuff" now works
✅ **Good**: Added support for multiline commit messages

## Quick Checklist

Before adding your entry:
- [ ] Is it user-focused?
- [ ] Is the category correct?
- [ ] Is it clear and concise?
- [ ] Would a user understand it?
- [ ] Is it in the Unreleased section?

## Integration with Workflow

1. Make your changes
2. When prompted by changelog-update rule, use this template
3. Copy relevant sections to CHANGELOG.md
4. Commit both your changes and changelog update

---

Remember: The changelog is for users, not developers. Write accordingly!
```

### Create Supporting Documentation
Create a reference in the changelog rules documentation explaining how to use the template.

### Update Changelog Rule
Ensure changelog-update rule references the template:
```yaml
actions:
  - suggest_template: ".claude/templates/CHANGELOG_entry.md"
```

## Validation Loop

### Level 1: Template Structure
```bash
# Verify template exists
test -f .claude/templates/CHANGELOG_entry.md

# Check all categories present
grep -E "### Added|### Changed|### Deprecated|### Removed|### Fixed|### Security" .claude/templates/CHANGELOG_entry.md

# Verify examples exist
grep -E "Examples:" .claude/templates/CHANGELOG_entry.md | wc -l
# Should be 6 (one per category)
```

### Level 2: Content Quality
```python
# test_template_content.py
def test_template_completeness():
    """Ensure template has all required sections"""
    with open('.claude/templates/CHANGELOG_entry.md', 'r') as f:
        content = f.read()
    
    required_sections = [
        '## Instructions',
        '## Template', 
        '## Writing Guidelines',
        '## Examples of Good vs Bad',
        '## Quick Checklist'
    ]
    
    for section in required_sections:
        assert section in content, f"Missing section: {section}"

def test_category_examples():
    """Ensure each category has examples"""
    categories = ['Added', 'Changed', 'Deprecated', 'Removed', 'Fixed', 'Security']
    
    with open('.claude/templates/CHANGELOG_entry.md', 'r') as f:
        content = f.read()
    
    for category in categories:
        assert f'### {category}' in content
        assert content.count(f'### {category}') >= 1
```

### Level 3: Usability Test
```bash
# Simulate using the template
echo "Testing template usage..."

# Copy template section
grep -A 3 "### Added" .claude/templates/CHANGELOG_entry.md

# Check if it matches changelog format
# Should be easy to copy/paste into CHANGELOG.md
```

## Final Validation Checklist

- [ ] Template created in .claude/templates/
- [ ] All six categories included with examples
- [ ] Clear instructions provided
- [ ] Good/bad examples demonstrated
- [ ] Quick checklist included
- [ ] Integration with rules documented
- [ ] User-focused language emphasized
- [ ] Easy to use and understand

## Anti-Patterns to Avoid

1. **Don't make it too complex** - Keep it simple
2. **Don't include technical details** - Focus on users
3. **Don't make it too long** - Quick reference
4. **Don't forget examples** - Show, don't just tell
5. **Don't make categories optional** - Include all six

---
Success Score Estimate: 95/100 (Simple template creation with clear examples)