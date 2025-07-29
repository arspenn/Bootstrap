name: "CLAUDE.md Standardization - Phase 2: Core Rules Migration"
description: |

## Purpose
Extract and migrate core project management rules from CLAUDE.md into standardized format files with enhanced metadata. This is Phase 2 of 4 for the CLAUDE.md standardization project.

## Core Principles
1. **Enhanced Metadata**: Include priority and dependencies in all rules
2. **Dual Documentation**: Create both rule definition and full documentation
3. **Preserve Functionality**: Extracted rules must work identically
4. **Test Each Rule**: Validate after each extraction
5. **Global rules**: Follow all rules in CLAUDE.md

---

## Goal
Extract three core project rules from CLAUDE.md:
- `project/planning-context.md` - PLANNING.md and TASK.md requirements
- `project/code-structure.md` - 500 line limit, module organization
- `project/adr-management.md` - ADR creation and organization

Each rule will have enhanced metadata and comprehensive documentation.

## Why
- **Core Functionality**: These rules are fundamental to project management
- **High Priority**: These rules have priority 650-800 (highest tier)
- **Foundation**: Other rules may depend on these
- **Testing Ground**: Validate the migration process with critical rules

## What
Three core rules extracted with full metadata, documentation, and testing.

### Success Criteria
- [ ] Three core rules extracted from CLAUDE.md
- [ ] Each rule has priority and dependencies metadata
- [ ] Full documentation created for each rule
- [ ] MASTER_IMPORTS.md updated
- [ ] Tests pass for Phase 2
- [ ] Original functionality preserved

## Prerequisites
- [ ] Phase 1 completed (infrastructure in place)
- [ ] Test file exists: `tests/test_claude_md_standardization.py`
- [ ] Pattern documented: `docs/patterns/enhanced-rule-metadata.md`

## All Needed Context

### Documentation & References
```yaml
- file: /home/arspenn/Dev/Bootstrap/CLAUDE.md
  why: Source file containing rules to extract
  sections:
    - "Project Awareness & Context" (lines 6-10)
    - "Code Structure & Modularity" (lines 12-21)
    - "Architecture Decision Records" (lines 62-75)
    
- file: /home/arspenn/Dev/Bootstrap/docs/patterns/enhanced-rule-metadata.md
  why: Pattern to follow for enhanced metadata (from Phase 1)
  
- file: /home/arspenn/Dev/Bootstrap/.claude/rules/project/test-file-location.md
  why: Example of existing project rule format
  
- file: /home/arspenn/Dev/Bootstrap/docs/rules/project/test-file-location.md
  why: Example of full documentation format
  
- file: /home/arspenn/Dev/Bootstrap/designs/009-feature-claude-md-standardization/design.md
  why: Specifications for each rule
  sections:
    - "Migration Phases" (lines 77-95)
    - "Example Migrated Rule" (lines 270-311)
```

### Rules to Extract from CLAUDE.md

#### 1. Planning Context (lines 6-10)
```markdown
- **Always read `PLANNING.md`** at the start of a new conversation
- **Check `TASK.md`** before starting a new task
- **Use consistent naming conventions, file structure, and architecture patterns**
- **Use venv_linux** (the virtual environment)
```

#### 2. Code Structure (lines 12-21)
```markdown
- **Never create a file longer than 500 lines of code**
- **Organize code into clearly separated modules**
  For agents this looks like:
    - `agent.py` - Main agent definition
    - `tools.py` - Tool functions
    - `prompts.py` - System prompts
- **Use clear, consistent imports** (prefer relative imports)
- **Use python_dotenv and load_env()** for environment variables
```

#### 3. ADR Management (lines 62-75)
```markdown
- **Use ADRs to document significant architectural decisions**
- **Project-wide ADRs** go in `docs/ADRs/`
- **Design-specific ADRs** stay with their feature in `designs/*/adrs/`
- **Follow the ADR template** in `templates/design-templates/adr.template.md`
- **Update the ADR Index** at `docs/ADRs/INDEX.md`
- **Use the ADR tools** to validate: `python scripts/adr-tools.py --help`
```

## Implementation Blueprint

### Task 1: Create project/planning-context.md
CREATE .claude/rules/project/planning-context.md:
```markdown
# Rule: Planning Context Management

## Instructions

### Rule Metadata
- ID: project/planning-context
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 800
- Dependencies: []

### Rule Configuration
```yaml
trigger: ["new conversation", "context check", "start task"]
conditions:
  - conversation_start: true
  - task_initiation: true
  - explicit_request: ["check planning", "review context", "load context"]
actions:
  - read_file: "PLANNING.md"
  - read_file: "TASK.md"
  - validate_existence: true
  - create_if_missing: true
  - use_content_for_context: true
validations:
  - planning_md_exists: true
  - task_md_exists: true
  - format_compliance: true
  - consistent_patterns: true
environment:
  python_env: "venv_linux"
templates:
  - planning: ".claude/templates/planning.template"
  - task: ".claude/templates/task.template"
```

### Behavior
- Always read PLANNING.md at conversation start
- Check TASK.md before starting new tasks
- Add new tasks to TASK.md if not listed
- Create files with templates if missing
- Use consistent naming conventions and patterns
- Use venv_linux for Python execution

---

📚 **Full Documentation**: [docs/rules/project/planning-context.md](../../../docs/rules/project/planning-context.md)
```

CREATE docs/rules/project/planning-context.md:
[Full documentation following the pattern from test-file-location.md, including:
- Description
- Rule Definition
- Rationale
- Examples (Good/Bad)
- File Templates
- Common Scenarios
- Troubleshooting
- Related Rules
- References]

### Task 2: Create project/code-structure.md
CREATE .claude/rules/project/code-structure.md:
```markdown
# Rule: Code Structure and Modularity

## Instructions

### Rule Metadata
- ID: project/code-structure
- Status: Active
- Security Level: Low
- Token Impact: ~25 tokens per operation
- Priority: 700
- Dependencies: []

### Rule Configuration
```yaml
trigger: ["file creation", "file edit", "refactor request"]
conditions:
  - file_operation: ["create", "edit"]
  - line_count_check: true
  - language: ["python", "javascript", "typescript"]
actions:
  - enforce_line_limit: 500
  - suggest_refactor: true
  - enforce_module_structure: true
  - check_import_style: true
  - require_dotenv: true
validations:
  - max_lines_per_file: 500
  - clear_module_separation: true
  - consistent_imports: true
  - proper_file_organization: true
  - dotenv_usage: true
patterns:
  agent_structure:
    - "agent.py"      # Main agent definition
    - "tools.py"      # Tool functions
    - "prompts.py"    # System prompts
  import_style: "relative"  # Prefer relative imports
environment:
  dotenv_module: "python-dotenv"
```

### Module Organization
- Never exceed 500 lines per file
- Split into logical modules by feature/responsibility
- Use clear, descriptive file names
- Prefer relative imports within packages
- Use python-dotenv for environment variables

---

📚 **Full Documentation**: [docs/rules/project/code-structure.md](../../../docs/rules/project/code-structure.md)
```

CREATE docs/rules/project/code-structure.md:
[Full documentation with examples of good/bad structure, refactoring strategies, etc.]

### Task 3: Create project/adr-management.md
CREATE .claude/rules/project/adr-management.md:
```markdown
# Rule: Architecture Decision Records Management

## Instructions

### Rule Metadata
- ID: project/adr-management
- Status: Active
- Security Level: Low
- Token Impact: ~35 tokens per operation
- Priority: 650
- Dependencies: ["project/design-structure"]

### Rule Configuration
```yaml
trigger: ["architectural decision", "design choice", "technology selection"]
conditions:
  - significant_decision: true
  - affects_multiple_components: true
  - long_term_implications: true
actions:
  - create_adr: true
  - follow_template: "templates/design-templates/adr.template.md"
  - update_index: "docs/ADRs/INDEX.md"
  - validate_with_tools: "python scripts/adr-tools.py"
locations:
  project_wide: "docs/ADRs/"
  design_specific: "designs/*/adrs/"
validations:
  - proper_numbering: true
  - status_valid: ["proposed", "accepted", "deprecated", "superseded"]
  - template_compliance: true
  - index_updated: true
criteria:
  project_wide_when:
    - "Affects multiple features"
    - "Establishes conventions"
    - "Defines technology choices"
    - "Sets policies"
  design_specific_when:
    - "Only affects specific feature"
    - "Documents feature trade-offs"
    - "Within established conventions"
```

### ADR Guidelines
- Use for significant architectural decisions
- Follow the template strictly
- Update the index after creation
- Link related ADRs
- Use validation tools

---

📚 **Full Documentation**: [docs/rules/project/adr-management.md](../../../docs/rules/project/adr-management.md)
```

CREATE docs/rules/project/adr-management.md:
[Full documentation with ADR examples, template usage, etc.]

### Task 4: Update MASTER_IMPORTS.md
EDIT .claude/MASTER_IMPORTS.md - Add after existing project rules:
```markdown
@.claude/rules/project/planning-context.md
@.claude/rules/project/code-structure.md
@.claude/rules/project/adr-management.md
```

### Task 5: Update Phase 2 Tests
EDIT tests/test_claude_md_standardization.py - Update Phase 2 tests:
```python
class TestPhase2CoreRules:
    """Phase 2: Core Rules Migration Tests"""
    
    def test_planning_context_rule_exists(self):
        """Test that planning-context rule is created with metadata."""
        root = get_project_root()
        rule_file = root / ".claude/rules/project/planning-context.md"
        
        assert rule_file.exists(), "planning-context rule not found"
        content = rule_file.read_text()
        
        # Check enhanced metadata
        assert "Priority: 800" in content
        assert "Dependencies: []" in content
        assert "project/planning-context" in content
        
        # Check documentation exists
        doc_file = root / "docs/rules/project/planning-context.md"
        assert doc_file.exists(), "planning-context documentation not found"
    
    def test_code_structure_rule_exists(self):
        """Test that code-structure rule is created with metadata."""
        root = get_project_root()
        rule_file = root / ".claude/rules/project/code-structure.md"
        
        assert rule_file.exists(), "code-structure rule not found"
        content = rule_file.read_text()
        
        # Check enhanced metadata
        assert "Priority: 700" in content
        assert "Dependencies: []" in content
        assert "max_lines_per_file: 500" in content
        
        # Check documentation exists
        doc_file = root / "docs/rules/project/code-structure.md"
        assert doc_file.exists(), "code-structure documentation not found"
    
    def test_adr_management_rule_exists(self):
        """Test that adr-management rule is created with metadata."""
        root = get_project_root()
        rule_file = root / ".claude/rules/project/adr-management.md"
        
        assert rule_file.exists(), "adr-management rule not found"
        content = rule_file.read_text()
        
        # Check enhanced metadata
        assert "Priority: 650" in content
        assert 'Dependencies: ["project/design-structure"]' in content
        assert "docs/ADRs/" in content
        
        # Check documentation exists
        doc_file = root / "docs/rules/project/adr-management.md"
        assert doc_file.exists(), "adr-management documentation not found"
    
    def test_master_imports_updated_phase2(self):
        """Test that MASTER_IMPORTS.md includes Phase 2 rules."""
        root = get_project_root()
        imports_file = root / ".claude/MASTER_IMPORTS.md"
        
        content = imports_file.read_text()
        assert "@.claude/rules/project/planning-context.md" in content
        assert "@.claude/rules/project/code-structure.md" in content
        assert "@.claude/rules/project/adr-management.md" in content
```

## Validation Loop

### Level 1: File Creation
```bash
# Verify rule files created
ls -la .claude/rules/project/planning-context.md
ls -la .claude/rules/project/code-structure.md  
ls -la .claude/rules/project/adr-management.md

# Verify documentation created
ls -la docs/rules/project/planning-context.md
ls -la docs/rules/project/code-structure.md
ls -la docs/rules/project/adr-management.md
```

### Level 2: Metadata Validation
```bash
# Check each rule has priority
grep "Priority:" .claude/rules/project/planning-context.md
grep "Priority:" .claude/rules/project/code-structure.md
grep "Priority:" .claude/rules/project/adr-management.md

# Check dependencies
grep "Dependencies:" .claude/rules/project/adr-management.md
```

### Level 3: Test Execution
```bash
# Run Phase 2 tests
pytest tests/test_claude_md_standardization.py::TestPhase2CoreRules -v

# Ensure Phase 1 still passes
pytest tests/test_claude_md_standardization.py::TestPhase1Infrastructure -v

# Run all tests
pytest tests/ -v
```

### Level 4: Import Validation
```bash
# Check MASTER_IMPORTS.md updated
grep "planning-context" .claude/MASTER_IMPORTS.md
grep "code-structure" .claude/MASTER_IMPORTS.md
grep "adr-management" .claude/MASTER_IMPORTS.md
```

## Final Validation Checklist
- [ ] Three core rules created with enhanced metadata
- [ ] Each rule has priority (650-800 range)
- [ ] adr-management has dependency on design-structure
- [ ] Documentation files created for all three rules
- [ ] MASTER_IMPORTS.md updated with new rules
- [ ] Phase 2 tests pass
- [ ] All existing tests still pass

---

## Anti-Patterns to Avoid
- ❌ Don't remove rules from CLAUDE.md yet (that's Phase 4)
- ❌ Don't forget documentation files
- ❌ Don't skip updating MASTER_IMPORTS.md
- ❌ Don't use priorities outside specified ranges

## Next Phase
After Phase 2 completion:
- Commit changes with message: "feat(rules): migrate core project rules with enhanced metadata"
- Proceed to Phase 3: Language Rules Migration

## PRP Confidence Score: 9/10

High confidence because:
- Clear source material in CLAUDE.md
- Established patterns from Phase 1
- Comprehensive test coverage
- Examples to follow from existing rules