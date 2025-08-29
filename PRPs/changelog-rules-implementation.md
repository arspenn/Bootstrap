name: Changelog Management Rules Implementation
description: |
  Implement Git and project management rules for semi-automated changelog updates.
  
  This PRP creates rules that remind developers to update the changelog, enforce format standards, and manage version numbers.
  
  Core objectives:
  - Create project management rules category
  - Implement changelog-update rule for reminders
  - Implement changelog-format rule for standards
  - Implement version-management rule for releases
  - Integrate with existing Git workflow

## Goal

Create a semi-automated changelog management system through rules that:
1. Detect when changelog updates are needed
2. Enforce Keep a Changelog format
3. Guide version number management
4. Integrate seamlessly with Git workflow
5. Provide helpful reminders without being intrusive

## Why

**Consistency**: Ensure changelog is updated regularly
**Quality**: Maintain professional documentation standards
**Automation**: Reduce manual effort while preserving control
**Integration**: Work within existing Git rule framework

## What

### Success Criteria
- [ ] Project rules directory created at `.claude/rules/project/`
- [ ] changelog-update.md rule implemented
- [ ] changelog-format.md rule implemented
- [ ] version-management.md rule implemented
- [ ] Rules imported via MASTER_IMPORTS.md
- [ ] Documentation created in `.claude/docs/rules/project/`
- [ ] Integration with Git workflow tested
- [ ] User preferences support added

## All Needed Context

### Rule Structure Pattern
From existing Git rules:
```markdown
# Rule: [Name]

## Instructions

### Rule Metadata
- ID: project/[rule-name]
- Status: Active
- Security Level: Low
- Token Impact: ~20 tokens per operation

### Rule Configuration
```yaml
trigger: "[operation]"
conditions:
  - [conditions]
actions:
  - [actions]
validations:
  - [validations]
```

---

📚 **Full Documentation**: [.claude/docs/rules/project/[rule-name].md](../../../.claude/docs/rules/project/[rule-name].md)
```

### Integration Points
- Git commit operations
- Task completion in TASK.md
- PR/merge operations
- Version tagging

### Keep a Changelog Rules
- Types: Added, Changed, Deprecated, Removed, Fixed, Security
- Format: `- Description of change`
- No commit hashes in entries
- User-focused language

## Implementation Blueprint

### Task 1: Create Project Rules Directory
```bash
mkdir -p .claude/rules/project
mkdir -p .claude/docs/rules/project
```

### Task 2: Implement changelog-update.md
```markdown
# Rule: Changelog Update

## Instructions

### Rule Metadata
- ID: project/changelog-update
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation

### Rule Configuration
```yaml
trigger: ["git commit", "task complete"]
conditions:
  - significant_change: true
  - changelog_worthy:
      - new_feature: true
      - breaking_change: true
      - bug_fix: true
      - deprecation: true
actions:
  - check_changelog_updated: true
  - suggest_entry_if_missing: true
  - remind_on_pr: true
validations:
  - entry_exists_or_acknowledged: true
```

---

📚 **Full Documentation**: [.claude/docs/rules/project/changelog-update.md](../../../.claude/docs/rules/project/changelog-update.md)
```

### Task 3: Implement changelog-format.md
```markdown
# Rule: Changelog Format

## Instructions

### Rule Metadata
- ID: project/changelog-format
- Status: Active
- Security Level: Low
- Token Impact: ~25 tokens per operation

### Rule Configuration
```yaml
trigger: "changelog edit"
conditions:
  - file_path: "CHANGELOG.md"
standards:
  - format: "keep_a_changelog_1.1.0"
  - sections_required: ["Unreleased"]
  - valid_categories: ["Added", "Changed", "Deprecated", "Removed", "Fixed", "Security"]
actions:
  - validate_format: true
  - suggest_corrections: true
  - check_version_format: "semver"
validations:
  - markdown_valid: true
  - categories_valid: true
  - version_format_valid: true
```

---

📚 **Full Documentation**: [.claude/docs/rules/project/changelog-format.md](../../../.claude/docs/rules/project/changelog-format.md)
```

### Task 4: Implement version-management.md
```markdown
# Rule: Version Management

## Instructions

### Rule Metadata
- ID: project/version-management
- Status: Active
- Security Level: Medium
- Token Impact: ~35 tokens per operation

### Rule Configuration
```yaml
trigger: ["version bump", "release prepare"]
conditions:
  - on_main_branch: true
  - changelog_updated: true
strategy:
  - versioning: "semver"
  - bump_rules:
      - breaking_change: "major"
      - new_feature: "minor"
      - bug_fix: "patch"
actions:
  - update_version_file: true
  - move_unreleased_to_version: true
  - create_version_tag: true
  - update_changelog_links: true
validations:
  - changelog_has_unreleased_content: true
  - version_not_duplicate: true
  - tests_passing: true
```

---

📚 **Full Documentation**: [.claude/docs/rules/project/version-management.md](../../../.claude/docs/rules/project/version-management.md)
```

### Task 5: Create Documentation Files
For each rule, create comprehensive documentation following the pattern from Git rules:
- Overview and rationale
- Examples of when rule triggers
- Best practices
- Common scenarios
- Troubleshooting

### Task 6: Update MASTER_IMPORTS.md
```markdown
## Project Management Rules
@.claude/rules/project/changelog-update.md
@.claude/rules/project/changelog-format.md
@.claude/rules/project/version-management.md
```

### Task 7: Update User Preferences Template
Add section for project rules:
```yaml
project:
  rules:
    changelog-update: enabled
    changelog-format: enabled
    version-management: enabled
  config:
    changelog_reminder_level: "suggest"  # suggest, warn, require
    auto_version_bump: false
```

## Validation Loop

### Level 1: Rule Syntax Validation
```bash
# Check YAML syntax in all project rules
for f in .claude/rules/project/*.md; do
  echo "Checking $f"
  python3 -c "
import yaml
import re
with open('$f') as file:
    content = file.read()
    yaml_match = re.search(r'```yaml\n(.*?)\n```', content, re.DOTALL)
    if yaml_match:
        yaml.safe_load(yaml_match.group(1))
        print('✓ Valid YAML')
"
done
```

### Level 2: Integration Testing
```python
# test_changelog_rules.py
def test_changelog_update_trigger():
    """Test that significant commits trigger changelog reminder"""
    # Simulate commit with feature
    assert rule_triggers("feat: add new capability")
    # Simulate commit with fix
    assert rule_triggers("fix: resolve critical bug")
    # Simulate trivial commit
    assert not rule_triggers("chore: update dependencies")

def test_format_validation():
    """Test changelog format validation"""
    valid_entry = "### Added\n- New feature description"
    assert validate_changelog_format(valid_entry)
    
    invalid_entry = "### Additions\n- Wrong category name"
    assert not validate_changelog_format(invalid_entry)

def test_version_bump_logic():
    """Test version bump decision logic"""
    assert get_version_bump("feat:") == "minor"
    assert get_version_bump("fix:") == "patch"
    assert get_version_bump("feat!:") == "major"
```

### Level 3: Workflow Testing
```bash
# Test complete workflow
echo "Test: Making a feature commit"
git add .
git commit -m "feat: test feature"
# Should see changelog reminder

echo "Test: Editing changelog"
echo "### Added\n- Test feature" >> CHANGELOG.md
# Should validate format

echo "Test: Version bump"
# Simulate version bump command
# Should check changelog has content
```

## Final Validation Checklist

- [ ] All three rules created and valid
- [ ] YAML syntax correct in all rules
- [ ] Documentation complete for each rule
- [ ] MASTER_IMPORTS.md updated
- [ ] User preferences template updated
- [ ] Integration with Git workflow confirmed
- [ ] Tests pass for all scenarios
- [ ] No conflicts with existing rules

## Anti-Patterns to Avoid

1. **Don't be too aggressive** - Reminders, not blockers
2. **Don't auto-generate entries** - Human judgment needed
3. **Don't enforce on all commits** - Only significant changes
4. **Don't block emergency fixes** - Allow overrides
5. **Don't complicate the workflow** - Keep it simple

---
Success Score Estimate: 90/100 (New rule category, but follows established patterns)