name: "Git Control Rules Implementation"
description: |

## Purpose
Implement a comprehensive Git control rules system for Claude Code that provides secure-by-default, modular rules for Git and GitHub operations following the design document.

## Core Principles
1. **Security First**: All rules are immutable and secure by default
2. **One Rule Per File**: Clear boundaries and easy maintenance
3. **Conventional Standards**: Follow industry standards (Conventional Commits)
4. **Minimal Overhead**: Keep token usage under 10% increase
5. **Global rules**: Follow all rules in CLAUDE.md

---

## Goal
Create a structured rule system under `.claude/rules/` that guides Claude Code in performing Git operations consistently and safely, with comprehensive documentation linking to official Git references.

## Why
- **Consistency**: Ensures all Git operations follow best practices
- **Safety**: Prevents accidental commits of sensitive data or destructive operations
- **Scalability**: Modular system allows future expansion without clutter
- **User Experience**: Clear guidance for users from novice to expert levels

## What
A rule-based system that intercepts Git commands and applies safety checks, formatting standards, and best practices before execution.

### Success Criteria
- [ ] Claude Code correctly implements full range of basic Git operations (add, commit, push, pull)
- [ ] All commits follow Conventional Commits standard
- [ ] Branch names follow feature-version convention
- [ ] Comprehensive documentation with links to Git official docs
- [ ] Token overhead remains under 10%
- [ ] All rules are immutable (users can enable/disable rules via preferences)

## All Needed Context

### Documentation & References
```yaml
# MUST READ - Include these in your context window
- url: https://git-scm.com/docs
  why: Official Git documentation for command references
  sections:
    - git-add: https://git-scm.com/docs/git-add
    - git-commit: https://git-scm.com/docs/git-commit
    - git-push: https://git-scm.com/docs/git-push
    - git-pull: https://git-scm.com/docs/git-pull
    - git-branch: https://git-scm.com/docs/git-branch
  
- url: https://www.conventionalcommits.org/en/v1.0.0/
  why: Conventional Commits specification for commit message format
  critical: Types (feat, fix, docs, style, refactor, test, chore, perf, ci, build)
  
- url: https://about.gitlab.com/topics/version-control/version-control-best-practices/
  why: Git best practices reference
  
- file: /home/arspenn/Dev/Bootstrap/CLAUDE.md
  why: Current conventions to integrate with
  
- file: /home/arspenn/Dev/Bootstrap/designs/git-control-design.md
  why: Complete design document with architecture and decisions

- file: /home/arspenn/Dev/Bootstrap/docs/ADRs/ADR-001-git-rules-architecture.md
  why: Architecture decision for one-rule-per-file

- file: /home/arspenn/Dev/Bootstrap/docs/ADRs/ADR-002-git-commit-standards.md
  why: Commit message standards decision

- file: /home/arspenn/Dev/Bootstrap/docs/ADRs/ADR-003-branching-strategy.md
  why: Branching strategy decision
```

### Current Codebase Structure
```bash
Bootstrap/
├── CLAUDE.md                # Main conventions file (needs update)
├── PLANNING.md             # Project planning
├── TASK.md                 # Task tracking
├── README.md               # Project documentation
├── designs/                # Design documents
│   ├── git-control-design.md
│   └── git-control-diagrams/
├── docs/                   # Documentation
│   └── ADRs/              # Architecture decisions
├── features/              # Feature requests
├── PRPs/                  # Project requirement plans
├── responses/             # User responses
└── tests/                 # Test files
```

### Desired Codebase Structure (additions)
```bash
Bootstrap/
├── .claude/                        # Claude-specific configurations
│   ├── rules/                     # All behavior rules
│   │   ├── README.md             # Navigation and index
│   │   ├── git/                  # Git-specific rules
│   │   │   ├── index.md         # Git rules overview
│   │   │   ├── git-add-safety.md       # Rule: Safe staging
│   │   │   ├── git-commit-format.md    # Rule: Commit formatting
│   │   │   ├── git-push-validation.md  # Rule: Push checks
│   │   │   ├── git-pull-strategy.md    # Rule: Pull strategy
│   │   │   └── git-branch-naming.md    # Rule: Branch naming
│   │   └── config/              # Configuration
│   │       ├── user-preferences.yaml   # User overrides
│   │       └── conflict-log.md        # Conflict tracking
│   └── templates/               # Reusable templates
│       ├── commit-message.template    # Commit format
│       └── branch-name.template      # Branch naming
├── docs/
│   └── git-control/            # Feature documentation
│       └── README.md           # User guide
└── tests/
    └── test_git_rules.py       # Rule validation tests
```

### Known Gotchas
```yaml
# CRITICAL: Rules must be markdown files with specific YAML frontmatter
# CRITICAL: User preferences CAN disable security rules but rules themselves are immutable
# CRITICAL: All rules must include Security Level indicator
# CRITICAL: Token Impact must be estimated for each rule
# CRITICAL: Rules are loaded alphabetically - use consistent naming
```

## Implementation Blueprint

### Data Models and Structure

The rule format structure:
```markdown
# Rule: [Name]

## ID: [category/filename]
## Status: Active|Experimental|Deprecated  
## Security Level: High|Medium|Low
## Token Impact: [Estimated tokens]

## Description
[What the rule does]

## Rule Definition
```yaml
trigger: [command pattern]
conditions: [when to apply]
actions: [what to do]
validations: [checks to perform]
```

## Rationale
[Why this exists]

## Examples
✅ Good: [example]
❌ Bad: [example]

## Related Rules
- [links to related rules]
```

### List of tasks to complete (in order)

```yaml
Task 1 - Create Directory Structure:
CREATE .claude/:
  - Create all directories as per desired structure
  - Ensure proper permissions (755 for dirs, 644 for files)

Task 2 - Update CLAUDE.md:
MODIFY CLAUDE.md:
  - FIND pattern: "### 🧠 AI Behavior Rules"
  - INJECT after this section:
    ### 📋 Git Control Rules
    - **Load Git behavior rules from `.claude/rules/git/`**
    - Rules define safe Git operations and standards
    - User preferences in `.claude/rules/config/user-preferences.yaml`
    - Templates in `.claude/templates/` for consistency
    - See `.claude/rules/README.md` for navigation

Task 3 - Create Rules Navigation:
CREATE .claude/rules/README.md:
  - Master index of all rule categories
  - Quick navigation links
  - Rule loading order explanation
  - How to add new rules

Task 4 - Create Git Rules Index:
CREATE .claude/rules/git/index.md:
  - Overview of Git rules
  - List of active rules
  - Links to each rule file
  - Git documentation references

Task 5 - Implement git-add-safety Rule:
CREATE .claude/rules/git/git-add-safety.md:
  - Prevents `git add .` and `git add -A`
  - Requires explicit file paths
  - Checks for sensitive file patterns
  - Links to: https://git-scm.com/docs/git-add

Task 6 - Implement git-commit-format Rule:
CREATE .claude/rules/git/git-commit-format.md:
  - Enforces Conventional Commits
  - Character limits (250 recommended, 2000 max)
  - Template usage
  - Links to: https://www.conventionalcommits.org/

Task 7 - Implement git-push-validation Rule:
CREATE .claude/rules/git/git-push-validation.md:
  - Pre-push validations
  - Branch protection awareness
  - Force push prevention on main
  - Links to: https://git-scm.com/docs/git-push

Task 8 - Implement git-pull-strategy Rule:
CREATE .claude/rules/git/git-pull-strategy.md:
  - Default to --rebase for cleaner history
  - Conflict detection
  - Fetch before pull recommendation
  - Links to: https://git-scm.com/docs/git-pull

Task 9 - Implement git-branch-naming Rule:
CREATE .claude/rules/git/git-branch-naming.md:
  - Format: <type>/<feature>-<base-version>
  - Types: feature, fix, docs, refactor
  - Base version from main branch
  - Links to: https://git-scm.com/docs/git-branch

Task 10 - Create Templates:
CREATE .claude/templates/commit-message.template:
  - Conventional Commits format
  - Placeholders for type, scope, description

CREATE .claude/templates/branch-name.template:
  - Branch naming pattern
  - Examples for each type

Task 11 - Create User Configuration:
CREATE .claude/rules/config/user-preferences.yaml:
  - Example configuration
  - Comments explaining options
  - Security rule immutability note

CREATE .claude/rules/config/conflict-log.md:
  - Template for logging conflicts
  - Example entry

Task 12 - Create Documentation:
CREATE docs/git-control/README.md:
  - User guide for Git control rules
  - How rules work
  - Configuration options
  - Common scenarios

Task 13 - Create Tests:
CREATE tests/test_git_rules.py:
  - Test rule file format validation
  - Test directory structure
  - Test CLAUDE.md integration
  - Test template existence
```

### Per Task Details

```python
# Task 1 - Directory Creation
# Use os.makedirs with exist_ok=True
# Set permissions: dirs=755, files=644

# Task 2 - CLAUDE.md Update  
# Preserve existing content
# Add new section with clear formatting
# Maintain markdown structure

# Tasks 5-9 - Rule Implementation
# Each rule must have:
# - Unique ID based on filepath
# - Security level assessment
# - Token impact estimate
# - Clear trigger conditions
# - Examples with Git commands
# - Links to official docs

# Task 10 - Templates
# Use placeholders: <TYPE>, <SCOPE>, <DESCRIPTION>
# Include comments for guidance
# Keep templates minimal but clear

# Task 11 - Configuration
# YAML format with comments
# Show example preferences
# Emphasize rule immutability (not preferences)

# Task 12 - Documentation
# User-friendly language
# Real-world examples
# Troubleshooting section
# Links to design docs

# Task 13 - Tests
# Follow pytest patterns
# Test file existence
# Validate markdown format
# Check required sections
```

### Integration Points
```yaml
CLAUDE.md:
  - add to: After "AI Behavior Rules" section
  - pattern: New "Git Control Rules" section
  
Directory Structure:
  - create: .claude/rules/ hierarchy
  - pattern: One rule per file
  
Documentation:
  - create: docs/git-control/README.md
  - update: README.md with Git control feature note
```

## Validation Loop

### Level 1: Structure Validation
```bash
# Check directory structure created correctly
ls -la .claude/rules/git/
ls -la .claude/templates/

# Expected: All rule files and templates exist
```

### Level 2: File Format Validation
```python
# Test each rule file has required sections
def test_rule_format(rule_file):
    """Validate rule file format."""
    with open(rule_file, 'r') as f:
        content = f.read()
        assert "# Rule:" in content
        assert "## ID:" in content  
        assert "## Status:" in content
        assert "## Security Level:" in content
        assert "## Token Impact:" in content
        assert "## Rule Definition" in content
```

### Level 3: Integration Test
```bash
# Test CLAUDE.md updated correctly
grep -n "Git Control Rules" CLAUDE.md

# Test rules are loadable (simulate)
find .claude/rules/git -name "*.md" -type f | sort

# Expected: All rules listed alphabetically
```

### Level 4: Documentation Test
```bash
# Verify documentation exists
test -f docs/git-control/README.md && echo "Docs exist"

# Check for user guide sections
grep -E "(How it works|Configuration|Examples)" docs/git-control/README.md
```

## Final Validation Checklist
- [ ] All directories created under .claude/
- [ ] CLAUDE.md updated with Git Control Rules section
- [ ] All 5 git rules implemented with proper format
- [ ] Templates created for commits and branches
- [ ] User configuration examples provided
- [ ] Documentation complete in docs/git-control/
- [ ] Tests pass: `python -m pytest tests/test_git_rules.py -v`
- [ ] No broken links to external documentation
- [ ] All rules marked as immutable (but can be disabled via preferences)
- [ ] Token impact documented for each rule

---

## Anti-Patterns to Avoid
- ❌ Don't modify rule definitions (they must remain immutable)
- ❌ Don't create rules longer than one concept
- ❌ Don't forget external documentation links
- ❌ Don't use complex YAML in rules (keep it simple)
- ❌ Don't hardcode paths - use relative references
- ❌ Don't skip Token Impact estimates

## Risk Mitigation
- Start with basic rules, test thoroughly
- Each rule should be independent
- Include examples for every rule
- Link to official Git docs for authority
- Test with real Git commands locally

## Success Score: 9/10
High confidence due to:
- Clear design document as foundation
- Well-defined file structures
- Simple markdown/YAML formats
- Comprehensive validation approach
- No complex code logic required