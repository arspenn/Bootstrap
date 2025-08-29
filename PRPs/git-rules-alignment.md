name: "Git Rules Alignment with Standardization Patterns"
description: |

## Purpose
Refactor all 6 Git rules to align with standardization patterns established in CLAUDE.md Phases 1-4. Implement config reference mechanism with inline defaults, add enhanced metadata, create comprehensive documentation, and update tests.

## Core Principles
1. **Config References with Inline Defaults**: `{{config.path:default}}` syntax
2. **Enhanced Metadata**: Add Priority and Dependencies fields
3. **Comprehensive Documentation**: Expand docs in `.claude/docs/rules/git/`
4. **Maintain Behavior**: Pure refactoring, no functional changes
5. **Token Efficiency**: Reduce rule size by 20-30%

---

## Goal
Align all Git rules with the standardization patterns, implementing a config reference mechanism that allows customization while maintaining reliability through inline defaults.

## Why
- **Consistency**: All rules follow same enhanced pattern
- **Maintainability**: Single source of truth for config
- **Token Efficiency**: Reduced redundancy in rules
- **Documentation**: Comprehensive guides for users

## What
Refactor 6 Git rules, add config section, update documentation, fix tests.

### Success Criteria
- [ ] All 6 Git rules have Priority and Dependencies metadata
- [ ] Config references with inline defaults implemented
- [ ] Git section added to config.yaml
- [ ] Comprehensive documentation for each rule
- [ ] All Git rule tests pass
- [ ] Token reduction of 20-30% achieved

## All Needed Context

### Current Git Rules (to refactor)
```yaml
Files to update:
- .claude/rules/git/git-add-safety.md
- .claude/rules/git/git-commit-format.md
- .claude/rules/git/git-push-validation.md
- .claude/rules/git/git-pull-strategy.md
- .claude/rules/git/git-branch-naming.md
- .claude/rules/git/git-safe-file-operations.md
```

### Target Pattern (from Phase 2-4 rules)
```yaml
# Example from project/code-structure.md
### Rule Metadata
- ID: project/code-structure
- Status: Active
- Security Level: Low
- Token Impact: ~25 tokens per operation
- Priority: 700
- Dependencies: []

### Rule Configuration
trigger: ["file creation", "file edit", "refactor request"]
conditions:
  - file_operation: ["create", "edit"]
actions:
  - enforce_line_limit: "{{config.project.max_line_limit:500}}"
validations:
  - max_lines_per_file: "{{config.project.max_line_limit:500}}"

### Behavior
- Never exceed 500 lines per file
- Split into logical modules by feature/responsibility

---

📚 **Full Documentation**: [.claude/docs/rules/project/code-structure.md](../../../.claude/docs/rules/project/code-structure.md)
```

### Priority Assignment Strategy
Based on security level and operational impact:
- **High Security (700-800)**:
  - git-add-safety: 750
  - git-push-validation: 700
- **Medium Security (400-600)**:
  - git-safe-file-operations: 650
  - git-pull-strategy: 500
  - git-commit-format: 400
- **Low Security (100-300)**:
  - git-branch-naming: 300

### Config Reference Syntax
Pattern: `{{config.path.to.value:default_value}}`

Examples:
- `{{config.git.max_file_size:10MB}}`
- `{{config.git.protected_branches:[main,master,develop]}}`
- `{{config.git.commit_format:conventional}}`

Arrays in defaults use comma separation without spaces.

### Documentation Template
Each rule gets comprehensive docs in `.claude/docs/rules/git/{rule-name}.md`:
```markdown
# Git Rule: {Rule Name}

## Overview
Brief description of the rule's purpose and importance.

## Trigger Conditions
- When this rule activates
- Specific Git commands monitored

## Actions
### What the Rule Does
- Step-by-step behavior
- Checks performed
- Validations applied

### Configuration Options
| Setting | Default | Config Path | Description |
|---------|---------|-------------|-------------|
| max_file_size | 10MB | git.max_file_size | Maximum file size allowed |

## Examples
### Good Practices
```bash
# Example of correct usage
git add specific-file.js
```

### Prevented Patterns
```bash
# What this rule prevents
git add .  # Blocked by rule
```

## Troubleshooting
### Common Issues
- Issue: "File too large" error
  - Solution: Check file size, consider .gitignore

## Security Considerations
- Why this rule exists
- Risks it mitigates

## Related Rules
- Links to related Git rules
```

## Implementation Blueprint

### Task 1: Add Git Section to config.yaml
UPDATE .claude/config.yaml - Add after `paths:` section:
```yaml
# Git-specific configuration
git:
  # Safety settings
  max_file_size: "10MB"
  forbidden_patterns: ["*.env", "*.key", "*.pem", "*_secret*", "*password*"]
  warn_on_binary: true
  
  # Branch management
  default_branch: "main"
  protected_branches: ["main", "master", "develop", "release/*"]
  branch_pattern: "^(feature|fix|docs|refactor|test|chore)/.+-[a-f0-9]{7}$"
  allowed_types: ["feature", "fix", "docs", "refactor", "test", "chore"]
  
  # Commit settings
  commit_format: "conventional"
  subject_max_length: 250
  body_line_length: 72
  commit_types: ["feat", "fix", "docs", "style", "refactor", "test", "chore", "perf", "ci", "build"]
  require_body_for: ["feat", "fix", "refactor"]
  
  # Pull/Push strategies
  prefer_rebase: true
  force_push_protection: true
  require_upstream_check: true
  default_pull_strategy: "--rebase"
  forbid_force_push_to: ["main", "master", "develop", "release/*"]
  
  # File operations
  require_git_check: true
  block_if_uncommitted: true
  check_working_directory: "clean"
  conflict_resolution_strategy: "manual"
```

### Task 2: Refactor git-add-safety.md
UPDATE .claude/rules/git/git-add-safety.md:
```yaml
# Rule: Git Add Safety

## Instructions

### Rule Metadata
- ID: git/git-add-safety
- Status: Active
- Security Level: High
- Token Impact: ~35 tokens per operation
- Priority: 750
- Dependencies: []

### Rule Configuration
```yaml
trigger: "git add"
conditions:
  - command_contains: ["add", "stage"]
actions:
  - require_status_check: true
  - forbid_commands: ["git add .", "git add -A", "git add --all"]
  - require_explicit_paths: true
  - check_file_patterns: "{{config.git.forbidden_patterns:[*.env,*.key,*.pem,*_secret*,*password*]}}"
validations:
  - max_file_size: "{{config.git.max_file_size:10MB}}"
  - warn_on_binary: "{{config.git.warn_on_binary:true}}"
  - require_diff_review: true
```

### Behavior
- Prevents accidental staging of sensitive files
- Blocks wildcard staging commands (git add ., git add -A)
- Checks file size before staging (default: 10MB max)
- Warns when binary files are staged
- Requires explicit file paths for safety

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-add-safety.md](../../../.claude/docs/rules/git/git-add-safety.md)
```

### Task 3: Refactor git-commit-format.md
UPDATE .claude/rules/git/git-commit-format.md:
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
```yaml
trigger: "git commit"
conditions:
  - command_contains: ["commit"]
actions:
  - enforce_format: "{{config.git.commit_format:conventional}}"
  - use_template: ".claude/templates/commit-message.template"
validations:
  - format: "<type>(<scope>): <subject>"
  - subject_max_length: "{{config.git.subject_max_length:250}}"
  - body_line_length: "{{config.git.body_line_length:72}}"
  - allowed_types: "{{config.git.commit_types:[feat,fix,docs,style,refactor,test,chore,perf,ci,build]}}"
  - require_body_for: "{{config.git.require_body_for:[feat,fix,refactor]}}"
```

### Behavior
- Enforces conventional commit format
- Validates commit message structure
- Limits subject line length (default: 250 chars)
- Requires body for significant changes
- Uses commit message template

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-commit-format.md](../../../.claude/docs/rules/git/git-commit-format.md)
```

### Task 4: Refactor git-push-validation.md
UPDATE .claude/rules/git/git-push-validation.md:
```yaml
# Rule: Git Push Validation

## Instructions

### Rule Metadata
- ID: git/git-push-validation
- Status: Active
- Security Level: High
- Token Impact: ~40 tokens per operation
- Priority: 700
- Dependencies: []

### Rule Configuration
```yaml
trigger: "git push"
conditions:
  - command_contains: ["push"]
actions:
  - check_remote_state: true
  - validate_branch_protection: true
  - prevent_force_push_to: "{{config.git.forbid_force_push_to:[main,master,develop,release/*]}}"
  - require_upstream_check: "{{config.git.require_upstream_check:true}}"
validations:
  - forbid_force_push_main: "{{config.git.force_push_protection:true}}"
  - check_commit_signatures: recommended
  - verify_no_large_files: true
  - max_file_size: "{{config.git.max_file_size:10MB}}"
  - warn_on_divergence: true
  - suggest_pull_before_push: true
```

### Behavior
- Validates push operations for safety
- Prevents force push to protected branches
- Checks for large files before push
- Warns about branch divergence
- Suggests pull before push when needed

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-push-validation.md](../../../.claude/docs/rules/git/git-push-validation.md)
```

### Task 5: Refactor git-pull-strategy.md
UPDATE .claude/rules/git/git-pull-strategy.md:
```yaml
# Rule: Git Pull Strategy

## Instructions

### Rule Metadata
- ID: git/git-pull-strategy
- Status: Active
- Security Level: Medium
- Token Impact: ~35 tokens per operation
- Priority: 500
- Dependencies: []

### Rule Configuration
```yaml
trigger: "git pull"
conditions:
  - command_contains: ["pull", "fetch"]
actions:
  - recommend_fetch_first: true
  - prefer_rebase: "{{config.git.prefer_rebase:true}}"
  - detect_conflicts_early: true
  - preserve_local_changes: true
validations:
  - check_working_directory: "{{config.git.check_working_directory:clean}}"
  - verify_current_branch: true
  - conflict_resolution_strategy: "{{config.git.conflict_resolution_strategy:manual}}"
  - default_strategy: "{{config.git.default_pull_strategy:--rebase}}"
  - protect_uncommitted_changes: true
```

### Behavior
- Recommends fetch before pull for safety
- Prefers rebase strategy (configurable)
- Protects uncommitted changes
- Detects conflicts early
- Ensures clean working directory

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-pull-strategy.md](../../../.claude/docs/rules/git/git-pull-strategy.md)
```

### Task 6: Refactor git-branch-naming.md
UPDATE .claude/rules/git/git-branch-naming.md:
```yaml
# Rule: Git Branch Naming

## Instructions

### Rule Metadata
- ID: git/git-branch-naming
- Status: Active
- Security Level: Low
- Token Impact: ~25 tokens per operation
- Priority: 300
- Dependencies: []

### Rule Configuration
```yaml
trigger: ["git branch", "git checkout -b"]
conditions:
  - command_contains: ["branch", "checkout -b"]
actions:
  - enforce_naming_pattern: true
  - auto_append_base_version: true
  - use_template: ".claude/templates/branch-name.template"
validations:
  - pattern: "{{config.git.branch_pattern:^(feature|fix|docs|refactor|test|chore)/.+-[a-f0-9]{7}$}}"
  - allowed_types: "{{config.git.allowed_types:[feature,fix,docs,refactor,test,chore]}}"
  - lowercase_only: true
  - use_hyphens: true
  - include_base_commit: true
```

### Behavior
- Enforces branch naming conventions
- Pattern: {type}/{description}-{commit-hash}
- Requires lowercase with hyphens
- Auto-appends base commit hash
- Uses branch name template

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-branch-naming.md](../../../.claude/docs/rules/git/git-branch-naming.md)
```

### Task 7: Refactor git-safe-file-operations.md
UPDATE .claude/rules/git/git-safe-file-operations.md:
```yaml
# Rule: Git-Safe File Operations

## Instructions

### Rule Metadata
- ID: git/git-safe-file-operations
- Status: Active
- Security Level: Medium
- Token Impact: ~40 tokens per operation
- Priority: 650
- Dependencies: []

### Rule Configuration
```yaml
trigger: "bash command execution"
conditions:
  - command_starts_with: ["rm", "rmdir", "mv"]
  - not_force_unsafe: true
actions:
  - check_git_repository: "{{config.git.require_git_check:true}}"
  - check_path_status: true
  - block_if_unsafe: "{{config.git.block_if_uncommitted:true}}"
  - suggest_alternatives: true
validations:
  - no_uncommitted_changes: true
  - no_untracked_files_in_deletion: true
  - prefer_git_commands: true
error_handling:
  - show_git_status: true
  - provide_solutions: true
  - no_automatic_fallback: true
```

### Behavior
- Checks Git status before file operations
- Blocks unsafe operations on tracked files
- Suggests Git alternatives (git rm, git mv)
- Protects uncommitted changes
- Shows clear error messages with solutions

---

📚 **Full Documentation**: [.claude/docs/rules/git/git-safe-file-operations.md](../../../.claude/docs/rules/git/git-safe-file-operations.md)
```

### Task 8: Create Comprehensive Documentation
For each rule, CREATE .claude/docs/rules/git/{rule-name}.md following the template.

Example for git-add-safety.md:
CREATE .claude/docs/rules/git/git-add-safety.md:
```markdown
# Git Rule: Add Safety

## Overview
Prevents accidental addition of sensitive files to Git staging area and enforces explicit file selection for better commit hygiene.

## Trigger Conditions
- Command contains `git add` or `git stage`
- Any file staging operation

## Actions

### What the Rule Does
1. Checks Git status before operations
2. Validates file patterns against forbidden list
3. Checks file size limits
4. Warns about binary files
5. Blocks wildcard operations

### Configuration Options
| Setting | Default | Config Path | Description |
|---------|---------|-------------|-------------|
| max_file_size | 10MB | git.max_file_size | Maximum file size allowed |
| forbidden_patterns | [*.env,*.key,*.pem] | git.forbidden_patterns | Patterns to block |
| warn_on_binary | true | git.warn_on_binary | Warn when adding binary files |

## Examples

### Good Practices
```bash
# Explicit file addition
git add src/main.py
git add README.md docs/

# Review before staging
git status
git diff src/main.py
git add src/main.py
```

### Prevented Patterns
```bash
# Blocked operations
git add .              # Too broad
git add -A             # Adds everything
git add *.env          # Sensitive file
git add large_file.zip # Over size limit
```

## Troubleshooting

### Common Issues
- **Issue**: "File too large" error
  - **Solution**: Check file size with `ls -lh filename`
  - Consider using Git LFS for large files
  - Add to .gitignore if not needed in repo

- **Issue**: "Forbidden pattern" error
  - **Solution**: File matches sensitive pattern
  - Use .gitignore for permanent exclusion
  - Override with explicit path if intentional

## Security Considerations
- Prevents secrets from entering repository
- Reduces risk of credential exposure
- Enforces deliberate file selection
- Protects against accidental data leaks

## Related Rules
- [git-commit-format](git-commit-format.md) - Commit message standards
- [git-push-validation](git-push-validation.md) - Push safety checks
```

### Task 9: Update Tests
UPDATE tests/test_git_rules.py - Add tests for new metadata:
```python
def test_git_rules_have_priority():
    """Test that all Git rules have Priority field."""
    root = get_project_root()
    git_rules_dir = root / ".claude" / "rules" / "git"
    
    for rule_file in git_rules_dir.glob("*.md"):
        if rule_file.name == "index.md":
            continue
        content = rule_file.read_text()
        assert "- Priority:" in content, f"{rule_file.name} missing Priority field"

def test_git_rules_have_dependencies():
    """Test that all Git rules have Dependencies field."""
    root = get_project_root()
    git_rules_dir = root / ".claude" / "rules" / "git"
    
    for rule_file in git_rules_dir.glob("*.md"):
        if rule_file.name == "index.md":
            continue
        content = rule_file.read_text()
        assert "- Dependencies:" in content, f"{rule_file.name} missing Dependencies field"

def test_git_config_section_exists():
    """Test that config.yaml has git section."""
    root = get_project_root()
    config = root / ".claude/config.yaml"
    
    with open(config) as f:
        data = yaml.safe_load(f)
    
    assert "git" in data, "Git section missing from config.yaml"
    assert "max_file_size" in data["git"]
    assert "protected_branches" in data["git"]

def test_git_rules_use_config_references():
    """Test that Git rules use config references with defaults."""
    root = get_project_root()
    git_rules_dir = root / ".claude" / "rules" / "git"
    
    for rule_file in git_rules_dir.glob("*.md"):
        if rule_file.name == "index.md":
            continue
        content = rule_file.read_text()
        # Check for at least one config reference
        if "{{config.git." in content:
            # Verify it has a default value
            assert ":" in content[content.find("{{config.git."):content.find("}}")], \
                f"{rule_file.name} has config reference without default"
```

### Task 10: Fix Additional Test Issues
UPDATE tests/test_git_rules.py - Remove/update failing assertions:
```python
# Remove or update this test as CLAUDE.md no longer needs Git Control section
def test_claude_md_updated():
    """Test that CLAUDE.md properly imports rules."""
    root = get_project_root()
    claude_md = root / "CLAUDE.md"
    
    content = claude_md.read_text()
    # Just check for rule import
    assert "@.claude/MASTER_IMPORTS.md" in content

# Update security level test to use list format
def test_rule_format_validation():
    """Test that all Git rules follow standardized format."""
    root = get_project_root()
    git_rules_dir = root / ".claude" / "rules" / "git"
    
    for rule_file in git_rules_dir.glob("*.md"):
        if rule_file.name == "index.md":
            continue
        content = rule_file.read_text()
        
        # Check metadata format
        assert "### Rule Metadata" in content
        assert "- ID:" in content
        assert "- Status:" in content
        assert "- Security Level:" in content  # List format
        assert "- Token Impact:" in content
        assert "- Priority:" in content
        assert "- Dependencies:" in content
```

## Validation Loop

### Level 1: Syntax Validation
```bash
# Check YAML syntax in config
python -c "import yaml; yaml.safe_load(open('.claude/config.yaml'))"

# Check YAML in each rule
for rule in .claude/rules/git/*.md; do
    echo "Checking $rule"
    # Extract and validate YAML blocks
done
```

### Level 2: Metadata Validation
```bash
# Verify all Git rules have required metadata
for rule in .claude/rules/git/*.md; do
    grep -q "- Priority:" "$rule" || echo "$rule missing Priority"
    grep -q "- Dependencies:" "$rule" || echo "$rule missing Dependencies"
done
```

### Level 3: Config Reference Validation
```bash
# Check for config references with defaults
grep -r "{{config\.git\." .claude/rules/git/ | grep -v ":.*}}" && echo "Found references without defaults"
```

### Level 4: Run Tests
```bash
# Run Git rule tests
pytest tests/test_git_rules.py -v

# Run all tests to ensure no regression
pytest tests/ -v
```

### Level 5: Token Measurement
```bash
# Measure token reduction
for rule in .claude/rules/git/*.md; do
    before=$(git show HEAD:$rule 2>/dev/null | wc -c)
    after=$(wc -c < $rule)
    reduction=$((100 * (before - after) / before))
    echo "$rule: $reduction% reduction"
done
```

## Anti-Patterns to Avoid
- ❌ Don't use config references without defaults
- ❌ Don't change rule behavior (pure refactoring)
- ❌ Don't forget to update all 6 rules
- ❌ Don't skip comprehensive documentation
- ❌ Don't use different syntax patterns

## Final Validation Checklist
- [ ] All 6 Git rules updated with enhanced metadata
- [ ] Config.yaml has complete git section
- [ ] All config references have inline defaults
- [ ] Comprehensive documentation for each rule
- [ ] All tests pass
- [ ] Token reduction achieved (measure before/after)

---

## PRP Confidence Score: 9/10

High confidence because:
- Clear pattern to follow from Phase 2-4 rules
- Detailed examples for each rule
- Comprehensive test updates included
- Config reference syntax well-defined
- Documentation templates provided

Minor risk:
- Config reference parser implementation not detailed (assumed to work)