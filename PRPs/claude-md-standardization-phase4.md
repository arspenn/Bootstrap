name: "CLAUDE.md Standardization - Phase 4: Configuration and Finalization"
description: |

## Purpose
Create the configuration system, enhance AI Behavior Rules, and finalize CLAUDE.md transformation into a minimal loader. This is the final phase (4 of 4) for the CLAUDE.md standardization project.

## Core Principles
1. **Configuration Separation**: Project settings in config.yaml
2. **Enhanced AI Rules**: Specific, actionable guidelines
3. **Minimal CLAUDE.md**: Reduced to loader and AI rules
4. **Complete Migration**: Remove extracted rules from CLAUDE.md
5. **Global rules**: Follow all rules in CLAUDE.md until updated

---

## Goal
Complete the CLAUDE.md standardization by:
- Creating `.claude/config.yaml` for project configuration
- Enhancing AI Behavior Rules with specific actions
- Updating CLAUDE.md to minimal loader format
- Removing all extracted rules from CLAUDE.md
- Final validation of entire system

## Why
- **Clean Separation**: Configuration vs rules vs AI behavior
- **Specific Guidance**: Vague AI rules become actionable
- **Token Efficiency**: Minimal CLAUDE.md reduces overhead
- **Project Complete**: Fully modular rule system

## What
Configuration file creation and CLAUDE.md transformation to final state.

### Success Criteria
- [ ] .claude/config.yaml created with project settings
- [ ] AI Behavior Rules enhanced with specific actions
- [ ] CLAUDE.md reduced to <100 lines
- [ ] All extracted rules removed from CLAUDE.md
- [ ] All tests pass (Phases 1-4)
- [ ] Full system integration validated

## Prerequisites
- [ ] Phases 1-3 completed successfully
- [ ] All 7 rules created and documented
- [ ] MASTER_IMPORTS.md updated
- [ ] Tests passing for all previous phases

## All Needed Context

### Documentation & References
```yaml
- file: /home/arspenn/Dev/Bootstrap/CLAUDE.md
  why: File to be transformed - contains rules to remove and AI rules to enhance
  
- file: /home/arspenn/Dev/Bootstrap/designs/009-feature-claude-md-standardization/design.md
  why: Configuration structure and enhanced AI rules specifications
  sections:
    - "Configuration Separation" (lines 113-130)
    - "AI Behavior Rules Enhancement" (lines 132-162)
    
- file: /home/arspenn/Dev/Bootstrap/designs/009-feature-claude-md-standardization/example-enhanced-claude-md.md
  why: Example of final CLAUDE.md structure
  
- file: /home/arspenn/Dev/Bootstrap/.claude/MASTER_IMPORTS.md
  why: Import system that CLAUDE.md will reference
  
- file: /home/arspenn/Dev/Bootstrap/designs/009-feature-claude-md-standardization/adrs/ADR-004-configuration-separation.md
  why: Configuration strategy decision
  
- file: /home/arspenn/Dev/Bootstrap/designs/009-feature-claude-md-standardization/adrs/ADR-005-ai-behavior-rules-location.md
  why: Decision to keep AI rules in CLAUDE.md
```

### Current AI Behavior Rules to Enhance
```markdown
### 🧠 AI Behavior Rules
- **Never assume missing context. Ask questions if uncertain.**
- **Never hallucinate libraries or functions** – only use known, verified Python packages.
- **Always confirm file paths and module names** exist before referencing them in code or tests.
- **Never delete or overwrite existing code** unless explicitly instructed to or if part of a task from `TASK.md`.
```

### Rules Already Extracted (to be removed from CLAUDE.md)
1. Project Awareness & Context → project/planning-context.md
2. Code Structure & Modularity → project/code-structure.md
3. Testing & Reliability → testing/pytest-requirements.md
4. Task Completion → (keep in CLAUDE.md as workflow)
5. Style & Conventions → python/code-style.md
6. Documentation (docstrings) → documentation/docstring-format.md
7. Architecture Decision Records → project/adr-management.md

## Implementation Blueprint

### Task 1: Create .claude/config.yaml
CREATE .claude/config.yaml:
```yaml
# Claude Configuration File
# Project-specific settings and rule overrides

project:
  name: "Bootstrap"
  description: "Bootstrap template for software design and development with Claude AI"
  language: "python"
  environment: "venv_linux"
  version: "0.4.0"

defaults:
  # Code structure defaults
  max_line_limit: 500
  preferred_line_limit: 400
  module_organization: "feature-based"
  
  # Testing defaults
  test_framework: "pytest"
  test_directory: "tests/"
  min_test_cases: 3
  coverage_target: 80
  
  # Documentation defaults
  docstring_style: "google"
  documentation_language: "english"
  readme_format: "markdown"
  
  # Python defaults
  python_version: "3.12"
  formatter: "black"
  linter: "ruff"
  type_checker: "mypy"
  package_manager: "pip"

# Rule-specific overrides
overrides:
  # Example: Override line limit for specific rule
  # "project/code-structure":
  #   max_line_limit: 600
  
  # Example: Disable specific rule
  # "documentation/docstring-format":
  #   enabled: false

# Feature flags
features:
  auto_format_on_save: true
  auto_lint_on_commit: true
  strict_type_checking: false
  require_tests_for_pr: true
  auto_generate_docstrings: false

# Environment variables
environment:
  PYTHONPATH: "${project_root}"
  DJANGO_SETTINGS_MODULE: "config.settings.local"  # If Django project
  FLASK_ENV: "development"  # If Flask project

# Tool configurations
tools:
  black:
    line_length: 88
    target_version: ["py312"]
  
  ruff:
    line_length: 88
    select: ["E", "F", "W", "C90", "I", "N", "UP", "YTT", "ANN", "S", "BLE", "B", "A", "COM", "C4", "DTZ", "T10", "ISC", "ICN", "INP", "PIE", "T20", "PYI", "PT", "Q", "RET", "SIM", "TID", "ARG", "ERA", "PD", "PGH", "PL", "TRY", "NPY", "RUF"]
    ignore: ["E501", "ANN101", "ANN102"]
  
  mypy:
    python_version: "3.12"
    warn_return_any: true
    warn_unused_configs: true
    disallow_untyped_defs: false

# Project paths
paths:
  source_root: "."
  tests_root: "tests/"
  docs_root: "docs/"
  designs_root: "designs/"
  features_root: "features/"
  prps_root: "PRPs/"
```

### Task 2: Update CLAUDE.md with Enhanced AI Rules
EDIT CLAUDE.md - Replace entire content with:
```markdown
# Claude Configuration

## Rule Loading
@.claude/MASTER_IMPORTS.md

## Project Context
Loaded from: .claude/config.yaml

## AI Behavior Rules

### Context Verification
- **When file paths are ambiguous**: 
  - Use `Glob` to list possible matches with pattern
  - Present numbered options to user with full paths
  - Example: "Did you mean: 1) /src/main.py 2) /tests/test_main.py?"
  
- **When requirements are unclear**: 
  - State your interpretation explicitly
  - Ask: "I understand you want to [interpretation]. Is this correct?"
  - Wait for confirmation before proceeding
  
- **When multiple approaches exist**: 
  - Present 2-3 options with trade-offs
  - Format: "Option A: [approach] - Pros: [list] Cons: [list]"
  - Include factors: performance, complexity, maintainability, time

### Library and Import Safety
- **Before using any library**: 
  - Check requirements.txt or pyproject.toml with `Read` tool
  - If not found, ask: "This requires {library}. Should I add it to requirements.txt?"
  - Show install command: `pip install {library}=={version}`
  
- **Before importing modules**: 
  - Verify file exists with `LS` or `Glob` tool
  - For ambiguous imports, show file structure: "Found modules: ..."
  
- **When suggesting new libraries**: 
  - Include exact command: `pip install pandas==2.1.0`
  - Mention why this library vs alternatives
  - Check PyPI for latest stable version

### File System Operations
- **Before any file operation**: 
  - Use `Read` to check current content
  - Handle "file not found" gracefully
  - Show relevant portion of current content before changes
  
- **Before creating files**: 
  - Use `LS` on parent directory
  - Confirm: "Creating {file} in {directory}. Proceed?"
  - Show what will be created
  
- **For all paths**: 
  - Convert to absolute: `Path(path).resolve()`
  - Show resolved path in operations
  - Handle path errors with suggestions
  
- **After file changes**: 
  - Show diff-style output: "Changed lines X-Y:"
  - Include 2 lines of context above/below
  - Confirm: "{X} lines modified in {file}"

### Code Modification Safety
- **Requirement for deletion**: 
  - User must use: "delete", "remove", "clean up", or "get rid of"
  - Confirm: "This will delete {target}. Continue?"
  - Show what will be deleted
  
- **Requirement for overwrite**: 
  - User must use: "overwrite", "replace entirely", "start fresh"
  - Show current content first
  - Confirm: "This will replace all content. Continue?"
  
- **Exception**: 
  - When TASK.md lists: "Delete {file}" or "Replace {file}"
  - Still show what will be affected
  
- **Git awareness**: 
  - Run `git status {file}` before operations
  - Warn if file has uncommitted changes
  - Suggest: "Commit changes first?"

### Efficiency and Progress
- **Tool batching**: 
  - Group related operations: `Read` multiple files in one call
  - Example: Read all test files together
  - Combine file operations when logical
  
- **Task tracking**: 
  - Use `TodoWrite` for tasks with 3+ steps
  - Update status as you progress
  - Mark complete immediately when done
  
- **Error handling**: 
  - Show exact error message
  - Explain what it means
  - Provide specific fix: "Try: {command}"
  
- **Validation**: 
  - After code changes: `ruff check && mypy {file}`
  - After tests: `pytest {test_file} -v`
  - Show validation output

### Communication Standards
- **Ambiguity resolution**: 
  - Never guess - always clarify
  - Use: "Do you mean X or Y?"
  - Provide examples of each option
  
- **Progress updates**: 
  - For multi-step tasks: "Step 2/5: Creating test file..."
  - Report completion: "✓ Tests created and passing"
  
- **Error transparency**: 
  - Show full error with context
  - Include relevant log lines
  - Explain technical terms
  
- **Change confirmation**: 
  - Use unified diff format when appropriate
  - Summarize: "Added: X lines, Removed: Y lines, Modified: Z lines"

### Testing and Validation
- **After creating functions**: 
  - Create test file immediately
  - Include 3 test cases minimum
  - Run tests before claiming complete
  
- **After modifying logic**: 
  - Check: "Do existing tests cover this change?"
  - Update tests if needed
  - Show test output
  
- **Before claiming completion**: 
  - Run: `pytest`, `ruff check`, `mypy`
  - Only claim success if all pass
  
- **Test failure handling**: 
  - Show exact failure
  - Fix the code, not the test
  - Explain what was wrong

### Documentation Practices
- **Function creation**: 
  - Write docstring first
  - Include parameter types
  - Add usage example if complex
  
- **Complex logic**: 
  - Add comment: "# This works because..."
  - Explain non-obvious decisions
  
- **API changes**: 
  - Update relevant .md files
  - Include migration notes
  
- **Examples**: 
  - Show both input and output
  - Include edge cases
  - Make them copy-pasteable

## Override Hierarchy
1. User instructions (highest priority)
2. TASK.md requirements
3. Individual rule files (by priority)
4. Config file defaults
5. AI Behavior Rules (baseline)
```

### Task 3: Update Phase 4 Tests
EDIT tests/test_claude_md_standardization.py - Implement Phase 4 tests:
```python
class TestPhase4Configuration:
    """Phase 4: Configuration and Finalization Tests"""
    
    def test_config_yaml_exists(self):
        """Test that config.yaml is created and valid."""
        root = get_project_root()
        config = root / ".claude/config.yaml"
        
        assert config.exists(), "config.yaml not found"
        
        # Validate YAML
        with open(config) as f:
            data = yaml.safe_load(f)
        
        assert "project" in data
        assert data["project"]["name"] == "Bootstrap"
        assert data["project"]["environment"] == "venv_linux"
        
        assert "defaults" in data
        assert data["defaults"]["max_line_limit"] == 500
        assert data["defaults"]["test_framework"] == "pytest"
        
        assert "features" in data
        assert "tools" in data
    
    def test_claude_md_updated(self):
        """Test that CLAUDE.md is properly updated."""
        root = get_project_root()
        claude_md = root / "CLAUDE.md"
        content = claude_md.read_text()
        
        # Check it's minimal
        lines = content.split('\n')
        assert len(lines) < 200, f"CLAUDE.md too large: {len(lines)} lines"
        
        # Check key sections exist
        assert "## Rule Loading" in content
        assert "@.claude/MASTER_IMPORTS.md" in content
        assert "## Project Context" in content
        assert ".claude/config.yaml" in content
        assert "## AI Behavior Rules" in content
        
        # Check AI rules are enhanced
        assert "When file paths are ambiguous" in content
        assert "Use `Glob` to list possible matches" in content
        assert "Check requirements.txt or pyproject.toml" in content
        assert "Use `Read` to check current content" in content
        assert "Run `git status {file}`" in content
        
        # Check removed content
        assert "**Never create a file longer than 500 lines" not in content
        assert "**Follow PEP8**" not in content
        assert "**Always create Pytest unit tests" not in content
        assert "Architecture Decision Records" not in content
    
    def test_all_rules_extracted(self):
        """Test that all planned rules were extracted."""
        root = get_project_root()
        
        extracted_rules = [
            ".claude/rules/project/planning-context.md",
            ".claude/rules/project/code-structure.md",
            ".claude/rules/project/adr-management.md",
            ".claude/rules/python/code-style.md",
            ".claude/rules/python/environment-management.md",
            ".claude/rules/documentation/docstring-format.md",
            ".claude/rules/testing/pytest-requirements.md"
        ]
        
        for rule_path in extracted_rules:
            rule_file = root / rule_path
            assert rule_file.exists(), f"{rule_path} not found"
    
    def test_master_imports_complete(self):
        """Test that MASTER_IMPORTS.md is complete."""
        root = get_project_root()
        imports = root / ".claude/MASTER_IMPORTS.md"
        content = imports.read_text()
        
        # Check all sections exist
        sections = [
            "## Git Rules",
            "## Project Management Rules", 
            "## Python Rules",
            "## Documentation Rules",
            "## Testing Rules"
        ]
        
        for section in sections:
            assert section in content, f"Section '{section}' missing"
        
        # Check specific imports
        assert content.count("@.claude/rules/") >= 16, "Missing imports"
    
    def test_full_system_integration(self):
        """Test that the entire system works together."""
        root = get_project_root()
        
        # All key files exist
        assert (root / "CLAUDE.md").exists()
        assert (root / ".claude/config.yaml").exists()
        assert (root / ".claude/MASTER_IMPORTS.md").exists()
        
        # All rule directories populated
        assert len(list((root / ".claude/rules/git").glob("*.md"))) >= 6
        assert len(list((root / ".claude/rules/project").glob("*.md"))) >= 8
        assert len(list((root / ".claude/rules/python").glob("*.md"))) >= 2
        assert len(list((root / ".claude/rules/documentation").glob("*.md"))) >= 1
        assert len(list((root / ".claude/rules/testing").glob("*.md"))) >= 1
        
        # Documentation complete
        assert (root / "docs/rules").exists()
        assert (root / "docs/patterns/enhanced-rule-metadata.md").exists()
```

### Task 4: Clean up temporary files
```bash
# Remove any backup files created during migration
rm -f CLAUDE.md.backup
rm -f .claude/MASTER_IMPORTS.md.backup

# Ensure all directories have proper READMEs
ls -la .claude/rules/*/README.md
```

## Validation Loop

### Level 1: Configuration Validation
```bash
# Verify config.yaml is valid YAML
python -c "import yaml; yaml.safe_load(open('.claude/config.yaml'))"

# Check key sections exist
grep "project:" .claude/config.yaml
grep "defaults:" .claude/config.yaml
grep "features:" .claude/config.yaml
```

### Level 2: CLAUDE.md Validation
```bash
# Check CLAUDE.md is minimal
wc -l CLAUDE.md  # Should be under 200 lines

# Verify imports reference
grep "@.claude/MASTER_IMPORTS.md" CLAUDE.md

# Check enhanced AI rules
grep "Use \`Glob\`" CLAUDE.md
grep "git status" CLAUDE.md

# Verify extracted rules are gone
! grep "Follow PEP8" CLAUDE.md
! grep "500 lines" CLAUDE.md
```

### Level 3: Test All Phases
```bash
# Run all phase tests
pytest tests/test_claude_md_standardization.py -v

# Run specific phase 4 tests
pytest tests/test_claude_md_standardization.py::TestPhase4Configuration -v

# Ensure all other tests still pass
pytest tests/ -v
```

### Level 4: Integration Check
```bash
# Count total rules
find .claude/rules -name "*.md" -not -name "README.md" | wc -l  # Should be ~17+

# Verify all imports work
python -c "
from pathlib import Path
imports = Path('.claude/MASTER_IMPORTS.md').read_text()
missing = []
for line in imports.split('\n'):
    if line.startswith('@'):
        file = line.replace('@', '').strip()
        if not Path(file).exists():
            missing.append(file)
print(f'Missing files: {missing}' if missing else 'All imports valid')
"

# Check documentation completeness
find docs/rules -name "*.md" | wc -l  # Should match rule count
```

## Final Validation Checklist
- [ ] .claude/config.yaml created with all sections
- [ ] CLAUDE.md updated with enhanced AI rules
- [ ] CLAUDE.md under 200 lines
- [ ] All extracted rules removed from CLAUDE.md
- [ ] All 4 phase tests pass
- [ ] Total of 17+ rules in system
- [ ] All imports in MASTER_IMPORTS.md valid
- [ ] No regression in existing tests

---

## Anti-Patterns to Avoid
- ❌ Don't leave extracted rules in CLAUDE.md
- ❌ Don't make AI rules vague again
- ❌ Don't forget to test config.yaml validity
- ❌ Don't skip integration testing

## Project Completion
After Phase 4 completion:
1. Run full test suite: `pytest tests/ -v`
2. Commit with message: "feat(rules): complete CLAUDE.md standardization with config and enhanced AI rules"
3. Update TASK.md to mark project complete
4. Consider creating a migration guide for other projects

## PRP Confidence Score: 10/10

Highest confidence because:
- Final phase with clear requirements
- All patterns established in previous phases
- Comprehensive test coverage
- Clear example of final state
- Low risk as mostly file creation/updates