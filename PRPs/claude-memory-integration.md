name: Claude Memory Integration - Rule Instruction Separation
description: |
  Implement Claude Code's @import memory feature to automatically load behavioral rules while separating instructions from documentation.
  
  This PRP implements the design from `designs/claude-memory-integration-design.md` to restructure our rule system for optimal token usage and clarity.
  
  Core principles:
  - Rules contain ONLY direct behavioral instructions (~500 bytes each)
  - Documentation moves to separate files with examples and rationale
  - Master import file provides single integration point
  - Maintain bidirectional references between rules and docs
  - Keep token overhead under 10%

## Goal

Transform our 5 Git control rules from mixed content files (~5KB each) into:
1. Lean instruction files that Claude can import directly (~500 bytes)
2. Comprehensive documentation files for user reference
3. A master import mechanism that keeps CLAUDE.md clean

The end state enables Claude to automatically load rules via @import while users can still access full documentation.

## Why

**Business Value**: Enable automatic rule loading without manual copy-paste
**User Impact**: Cleaner CLAUDE.md, easier rule management, better performance
**Integration Benefits**: Leverages Claude's native @import feature properly
**Token Efficiency**: Reduces rule overhead from ~24KB to ~2.5KB (90% reduction)

## What

User-visible behavior:
- CLAUDE.md contains single import: `@.claude/MASTER_IMPORTS.md`
- Rules automatically load when Claude starts
- Documentation remains accessible via cross-references
- User preferences control which rules are imported

### Success Criteria
- [ ] MASTER_IMPORTS.md created and imported by CLAUDE.md
- [ ] All 5 Git rules restructured to instructions-only format
- [ ] Documentation moved to .claude/docs/rules/git/ with full content
- [ ] Bidirectional references work (rules→docs, docs→rules)
- [ ] Token usage reduced by >80% for rule imports
- [ ] Import mechanism tested and functional
- [ ] User preference integration maintained

## All Needed Context

### Documentation & References
```yaml
design_docs:
  - path: designs/claude-memory-integration-design.md
    purpose: Complete design specification
  - path: designs/claude-memory-integration-adrs/ADR-004-rule-instruction-separation.md
    purpose: Decision to separate instructions from documentation
  - path: designs/claude-memory-integration-adrs/ADR-005-master-import-strategy.md
    purpose: Master import file approach

requirements:
  - path: responses/Requirements Gathering.md
    purpose: User decisions on format and structure

current_rules:
  - path: .claude/rules/git/git-add-safety.md
    size: 2908 bytes
  - path: .claude/rules/git/git-commit-format.md
    size: 5403 bytes
  - path: .claude/rules/git/git-push-validation.md
    size: 4648 bytes
  - path: .claude/rules/git/git-pull-strategy.md
    size: 4889 bytes
  - path: .claude/rules/git/git-branch-naming.md
    size: 6289 bytes

benchmarks:
  - path: benchmarks/baseline-pre-memory-integration.md
    purpose: Performance baseline before changes
```

### Current Codebase
```
.claude/
├── rules/
│   ├── git/
│   │   ├── git-add-safety.md (mixed content)
│   │   ├── git-commit-format.md (mixed content)
│   │   ├── git-push-validation.md (mixed content)
│   │   ├── git-pull-strategy.md (mixed content)
│   │   └── git-branch-naming.md (mixed content)
│   └── config/
│       └── user-preferences.yaml
└── templates/
    └── commit-message.md

CLAUDE.md (references but doesn't import rules)
```

### Desired Codebase
```
.claude/
├── MASTER_IMPORTS.md (NEW - single import point)
├── rules/
│   ├── git/
│   │   ├── git-add-safety.md (instructions only ~500 bytes)
│   │   ├── git-commit-format.md (instructions only)
│   │   ├── git-push-validation.md (instructions only)
│   │   ├── git-pull-strategy.md (instructions only)
│   │   └── git-branch-naming.md (instructions only)
│   └── config/
│       └── user-preferences.yaml
└── templates/
    └── commit-message.md

.claude/docs/rules/
└── git/
    ├── git-add-safety.md (NEW - full documentation)
    ├── git-commit-format.md (NEW - full documentation)
    ├── git-push-validation.md (NEW - full documentation)
    ├── git-pull-strategy.md (NEW - full documentation)
    └── git-branch-naming.md (NEW - full documentation)

CLAUDE.md (imports MASTER_IMPORTS.md)
```

### Known Gotchas & Library Quirks
- Claude's @import has 5-hop recursive limit (we use only 2)
- Import paths must be relative to CLAUDE.md location
- YAML in markdown requires proper indentation preservation
- User preferences file uses specific enable/disable format
- Rule IDs must maintain consistency across files

## Implementation Blueprint

### Data Models

**Instruction-Only Rule Format**:
```markdown
# Rule: [Rule Name]

## ID: [category]/[rule-name]
## Status: Active
## Security Level: [High|Medium|Low]
## Token Impact: ~[X] tokens per [operation]

## Instructions
```yaml
trigger: "[command pattern]"
conditions:
  - [condition list]
actions:
  - [action list]
validations:
  - [validation list]
```

See documentation: `.claude/docs/rules/[category]/[rule-name].md`
```

**Documentation Format**:
```markdown
# [Rule Name] - Documentation

## Rule Reference: `.claude/rules/[category]/[rule-name].md`

## Overview
[Previous description content]

## Rationale
[Previous rationale content]

## Examples
[All examples from original file]

## Best Practices
[Previous best practices]

## Common Scenarios
[Previous scenarios]

## Troubleshooting
[New section for common issues]
```

### List of Tasks (in order)

1. **Create master import infrastructure**
   - Create `.claude/MASTER_IMPORTS.md`
   - Update `CLAUDE.md` to import it
   - Test import mechanism

2. **Create documentation directory structure**
   - Create `.claude/docs/rules/git/` directory
   - Create index file for navigation

3. **Process git-add-safety rule**
   - Copy current file to `.claude/docs/rules/git/git-add-safety.md`
   - Extract instructions to keep in `.claude/rules/git/git-add-safety.md`
   - Add cross-references
   - Verify YAML formatting

4. **Process git-commit-format rule**
   - Copy to documentation
   - Extract instructions
   - Add cross-references
   - Preserve template reference

5. **Process git-push-validation rule**
   - Copy to documentation
   - Extract instructions
   - Add cross-references

6. **Process git-pull-strategy rule**
   - Copy to documentation
   - Extract instructions
   - Add cross-references

7. **Process git-branch-naming rule**
   - Copy to documentation
   - Extract instructions
   - Add cross-references

8. **Enhance documentation files**
   - Add troubleshooting sections
   - Improve navigation
   - Create comprehensive index

9. **Test import functionality**
   - Verify all imports work
   - Check token usage
   - Validate rule application

10. **Update task tracking**
    - Mark implementation complete
    - Document any discovered issues

### Per-Task Pseudocode

**Task 1: Create master import infrastructure**
```
1. Create .claude/MASTER_IMPORTS.md:
   - Add header explaining purpose
   - Add Git Rules section with all 5 imports
   - Add placeholder for future categories
   
2. Update CLAUDE.md:
   - Replace Git rules section with single import
   - Keep all other content unchanged
   
3. Test by checking if rules load properly
```

**Task 3-7: Process each rule**
```
For each rule file:
1. Read current content
2. Copy entire file to .claude/docs/rules/git/[name].md
3. In documentation file:
   - Add "Documentation" suffix to title
   - Add rule reference at top
   - Keep all existing content
   - Add troubleshooting section
   
4. In rule file:
   - Keep metadata headers
   - Keep Instructions/YAML section only
   - Remove all other sections
   - Add documentation reference at bottom
   - Reduce from ~5KB to ~500 bytes
```

### Integration Points
- CLAUDE.md: Single import line to MASTER_IMPORTS.md
- User preferences: Still control rule enable/disable
- Git commands: Rules apply when triggered
- Documentation: Accessible via file system navigation

## Validation Loop

### Level 1: Syntax & Style
```bash
# Check YAML syntax in all rule files
for f in .claude/rules/git/*.md; do
  echo "Checking $f"
  # Extract YAML block and validate
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

# Check file sizes
echo "Rule file sizes (should be ~500 bytes):"
ls -la .claude/rules/git/*.md

# Verify import syntax
grep -n "@.claude/" CLAUDE.md .claude/MASTER_IMPORTS.md
```

### Level 2: Unit Tests
```python
# test_imports.py
import os
import re

def test_master_import_exists():
    assert os.path.exists('.claude/MASTER_IMPORTS.md')

def test_claude_md_imports_master():
    with open('CLAUDE.md') as f:
        content = f.read()
    assert '@.claude/MASTER_IMPORTS.md' in content

def test_all_rules_imported():
    with open('.claude/MASTER_IMPORTS.md') as f:
        content = f.read()
    rules = ['git-add-safety', 'git-commit-format', 'git-push-validation', 
             'git-pull-strategy', 'git-branch-naming']
    for rule in rules:
        assert f'@.claude/rules/git/{rule}.md' in content

def test_bidirectional_references():
    for rule_name in ['git-add-safety', 'git-commit-format']:
        # Check rule references doc
        with open(f'.claude/rules/git/{rule_name}.md') as f:
            assert f'.claude/docs/rules/git/{rule_name}.md' in f.read()
        # Check doc references rule
        with open(f'.claude/docs/rules/git/{rule_name}.md') as f:
            assert f'.claude/rules/git/{rule_name}.md' in f.read()

def test_rule_size_reduction():
    for rule_name in ['git-add-safety']:
        rule_size = os.path.getsize(f'.claude/rules/git/{rule_name}.md')
        doc_size = os.path.getsize(f'.claude/docs/rules/git/{rule_name}.md')
        assert rule_size < 1000  # Under 1KB
        assert doc_size > 2000   # Documentation preserved
```

### Level 3: Integration Test
```bash
# Test actual import functionality
echo "Testing Claude import mechanism..."

# Create test script that simulates Claude reading imports
python3 -c "
def process_imports(file_path, depth=0):
    if depth > 5:
        print('ERROR: Import depth exceeded')
        return
    
    print(' ' * depth + f'Reading: {file_path}')
    
    try:
        with open(file_path) as f:
            for line in f:
                if line.strip().startswith('@'):
                    import_path = line.strip()[1:]
                    process_imports(import_path, depth + 1)
    except FileNotFoundError:
        print(f'ERROR: File not found: {file_path}')

process_imports('CLAUDE.md')
"

# Measure token impact
echo "Calculating token reduction..."
python3 -c "
import os
import tiktoken

enc = tiktoken.encoding_for_model('gpt-4')

# Calculate old token count (direct rules)
old_tokens = 0
for rule in ['git-add-safety', 'git-commit-format', 'git-push-validation', 
             'git-pull-strategy', 'git-branch-naming']:
    # Assuming we have backup of original files
    old_tokens += 1000  # Placeholder for original token count

# Calculate new token count (imported rules)
new_tokens = 0
for rule in os.listdir('.claude/rules/git/'):
    if rule.endswith('.md'):
        with open(f'.claude/rules/git/{rule}') as f:
            new_tokens += len(enc.encode(f.read()))

reduction = (1 - new_tokens/old_tokens) * 100
print(f'Token reduction: {reduction:.1f}%')
print(f'Target: >80%, Achieved: {reduction > 80}')
"
```

## Final Validation Checklist

Pre-implementation:
- [ ] All existing rules backed up
- [ ] Design document reviewed
- [ ] User requirements understood

Post-implementation:
- [ ] MASTER_IMPORTS.md created and functional
- [ ] All 5 Git rules converted to instructions-only
- [ ] All documentation moved with full content preserved
- [ ] Cross-references work in both directions
- [ ] Token usage reduced by >80%
- [ ] Import chain stays within 5-hop limit
- [ ] YAML syntax valid in all rule files
- [ ] File sizes: rules ~500 bytes, docs ~5KB
- [ ] User preferences still control rule activation
- [ ] No functionality lost from original rules

## Anti-Patterns to Avoid

1. **Don't mix content**: Keep instructions and documentation strictly separated
2. **Don't exceed depth**: Stay within 2-level import hierarchy
3. **Don't break YAML**: Preserve exact indentation when extracting
4. **Don't lose content**: Documentation must preserve ALL original content
5. **Don't forget references**: Every rule needs doc link and vice versa
6. **Don't hardcode paths**: Use relative paths for all imports
7. **Don't skip validation**: Test each rule after conversion

---
Success Score Estimate: 95/100 (Clear design, straightforward implementation, comprehensive validation)