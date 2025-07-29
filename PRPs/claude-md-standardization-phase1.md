name: "CLAUDE.md Standardization - Phase 1: Infrastructure Enhancement"
description: |

## Purpose
Implement the infrastructure enhancements needed to support enhanced rule metadata (priority and dependencies) and create the testing framework for validation. This is Phase 1 of 4 for the CLAUDE.md standardization project.

## Core Principles
1. **No Breaking Changes**: Existing rules continue to work
2. **Test-Driven**: Create tests before implementation
3. **Documentation First**: Document patterns before using
4. **Incremental Progress**: Complete foundation before migration
5. **Global rules**: Follow all rules in CLAUDE.md

---

## Goal
Establish the infrastructure for enhanced rule metadata including:
- Document the enhanced metadata pattern with priority and dependencies
- Create comprehensive test suite for validation
- Prepare project structure for new rule categories
- Set foundation for subsequent migration phases

## Why
- **Foundation**: Subsequent phases depend on this infrastructure
- **Validation**: Tests ensure each phase completes successfully
- **Pattern Establishment**: Clear patterns prevent inconsistencies
- **Risk Mitigation**: Infrastructure issues caught early

## What
Infrastructure enhancements that don't change existing rules but prepare for migration.

### Success Criteria
- [ ] Enhanced metadata pattern documented and ready to use
- [ ] Test file created with comprehensive validation
- [ ] New rule directories created (python/, testing/, documentation/)
- [ ] All existing tests still pass
- [ ] Ready for Phase 2 implementation

## All Needed Context

### Documentation & References
```yaml
- file: /home/arspenn/Dev/Bootstrap/designs/009-feature-claude-md-standardization/design.md
  why: Complete design document with metadata specifications
  
- file: /home/arspenn/Dev/Bootstrap/.claude/rules/git/git-commit-format.md
  why: Example of current metadata format (without priority/dependencies)
  
- file: /home/arspenn/Dev/Bootstrap/tests/test_git_rules.py
  why: Testing pattern to follow for new tests
  
- file: /home/arspenn/Dev/Bootstrap/designs/009-feature-claude-md-standardization/adrs/ADR-002-priority-metadata-system.md
  why: Priority system design (0-1000 scale)
  
- file: /home/arspenn/Dev/Bootstrap/designs/009-feature-claude-md-standardization/adrs/ADR-003-dependency-management-design.md
  why: Dependency array specification
```

### Current Codebase Structure
```bash
Bootstrap/
├── .claude/
│   ├── rules/
│   │   ├── git/          # Existing category
│   │   └── project/      # Existing category
│   └── templates/
├── tests/
│   └── test_git_rules.py # Existing test pattern
└── designs/
    └── 009-feature-claude-md-standardization/
```

### Desired Structure After Phase 1
```bash
Bootstrap/
├── .claude/
│   ├── rules/
│   │   ├── git/          # Existing
│   │   ├── project/      # Existing
│   │   ├── python/       # NEW: Empty directory
│   │   ├── testing/      # NEW: Empty directory
│   │   └── documentation/ # NEW: Empty directory
├── tests/
│   ├── test_git_rules.py
│   └── test_claude_md_standardization.py # NEW
└── docs/
    └── patterns/
        └── enhanced-rule-metadata.md # NEW: Pattern documentation
```

### Enhanced Metadata Pattern
```yaml
# Current metadata format
### Rule Metadata
- ID: category/rule-name
- Status: Active
- Security Level: Low|Medium|High
- Token Impact: ~N tokens per operation

# Enhanced metadata format (to document)
### Rule Metadata
- ID: category/rule-name
- Status: Active
- Security Level: Low|Medium|High
- Token Impact: ~N tokens per operation
- Priority: 100-800  # NEW FIELD
- Dependencies: []   # NEW FIELD (array of rule IDs)
```

## Implementation Blueprint

### Task 1: Create Pattern Documentation
CREATE docs/patterns/enhanced-rule-metadata.md:
```markdown
# Enhanced Rule Metadata Pattern

## Overview
This document defines the enhanced metadata pattern for Claude rules, adding priority and dependency management.

## Metadata Fields

### Required Fields (Existing)
- **ID**: Unique identifier in format `category/rule-name`
- **Status**: Current status (Active, Deprecated, Experimental)
- **Security Level**: Risk level (Low, Medium, High)
- **Token Impact**: Estimated tokens per operation

### New Required Fields
- **Priority**: Integer 100-800 determining precedence
- **Dependencies**: Array of rule IDs that must load first

## Priority Scale
- 800-700: Critical project rules (planning, structure)
- 699-600: Language-specific rules (Python, JavaScript)
- 599-500: Style and documentation rules
- 499-400: Testing and quality rules
- 399-300: Optional enhancement rules
- 299-100: Low-priority suggestions

## Dependency Format
```yaml
Dependencies: []  # No dependencies
Dependencies: ["project/planning-context"]  # Single dependency
Dependencies: ["python/environment", "project/structure"]  # Multiple
```

## Example Enhanced Rule
```markdown
### Rule Metadata
- ID: python/code-style
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 600
- Dependencies: ["python/environment-management"]
```

## Override Hierarchy
1. User instructions (implicit priority: 1000)
2. TASK.md requirements (implicit priority: 900)
3. Individual rules (explicit priority: 100-800)
4. CLAUDE.md defaults (implicit priority: 100)

## Validation Rules
- Priority must be integer between 100-800
- Dependencies must reference existing rule IDs
- No circular dependencies allowed
- Dependencies array can be empty
```

### Task 2: Create Directory Structure
```bash
# Create new rule category directories
mkdir -p .claude/rules/python
mkdir -p .claude/rules/testing
mkdir -p .claude/rules/documentation
mkdir -p docs/patterns

# Create placeholder README files
echo "# Python Rules\n\nPython-specific rules will be added in Phase 3." > .claude/rules/python/README.md
echo "# Testing Rules\n\nTesting rules will be added in Phase 3." > .claude/rules/testing/README.md
echo "# Documentation Rules\n\nDocumentation rules will be added in Phase 3." > .claude/rules/documentation/README.md
```

### Task 3: Create Comprehensive Test Suite
CREATE tests/test_claude_md_standardization.py:
```python
"""
Tests for CLAUDE.md standardization implementation.
Tests are organized by phase for incremental validation.
"""
import pytest
from pathlib import Path
import yaml
import re

def get_project_root():
    """Get the project root directory."""
    return Path(__file__).parent.parent

class TestPhase1Infrastructure:
    """Phase 1: Infrastructure Enhancement Tests"""
    
    def test_new_rule_directories_exist(self):
        """Test that new rule category directories are created."""
        root = get_project_root()
        
        new_dirs = [
            ".claude/rules/python",
            ".claude/rules/testing", 
            ".claude/rules/documentation"
        ]
        
        for dir_path in new_dirs:
            path = root / dir_path
            assert path.exists(), f"Directory {dir_path} not found"
            assert path.is_dir(), f"{dir_path} is not a directory"
            # Check for README
            readme = path / "README.md"
            assert readme.exists(), f"README.md missing in {dir_path}"
    
    def test_pattern_documentation_exists(self):
        """Test that enhanced metadata pattern is documented."""
        root = get_project_root()
        pattern_doc = root / "docs/patterns/enhanced-rule-metadata.md"
        
        assert pattern_doc.exists(), "Pattern documentation not found"
        
        content = pattern_doc.read_text()
        assert "Priority:" in content
        assert "Dependencies:" in content
        assert "Priority Scale" in content
        assert "100-800" in content
    
    def test_metadata_pattern_validation(self):
        """Test that we can validate enhanced metadata format."""
        # This tests our ability to parse enhanced metadata
        sample_metadata = """
        ### Rule Metadata
        - ID: test/sample-rule
        - Status: Active
        - Security Level: Low
        - Token Impact: ~20 tokens per operation
        - Priority: 500
        - Dependencies: ["test/other-rule"]
        """
        
        # Extract fields
        id_match = re.search(r'- ID: (.+)', sample_metadata)
        priority_match = re.search(r'- Priority: (\d+)', sample_metadata)
        deps_match = re.search(r'- Dependencies: \[(.*?)\]', sample_metadata)
        
        assert id_match and id_match.group(1) == "test/sample-rule"
        assert priority_match and int(priority_match.group(1)) == 500
        assert deps_match is not None

class TestPhase2CoreRules:
    """Phase 2: Core Rules Migration Tests (placeholder)"""
    
    @pytest.mark.skip(reason="Phase 2 not yet implemented")
    def test_planning_context_rule_exists(self):
        """Test that planning-context rule is created."""
        pass
    
    @pytest.mark.skip(reason="Phase 2 not yet implemented")
    def test_code_structure_rule_exists(self):
        """Test that code-structure rule is created."""
        pass
    
    @pytest.mark.skip(reason="Phase 2 not yet implemented")
    def test_adr_management_rule_exists(self):
        """Test that adr-management rule is created."""
        pass

class TestPhase3LanguageRules:
    """Phase 3: Language Rules Migration Tests (placeholder)"""
    
    @pytest.mark.skip(reason="Phase 3 not yet implemented")
    def test_python_rules_exist(self):
        """Test that Python rules are created."""
        pass
    
    @pytest.mark.skip(reason="Phase 3 not yet implemented")
    def test_documentation_rules_exist(self):
        """Test that documentation rules are created."""
        pass
    
    @pytest.mark.skip(reason="Phase 3 not yet implemented")
    def test_testing_rules_exist(self):
        """Test that testing rules are created."""
        pass

class TestPhase4Configuration:
    """Phase 4: Configuration and Finalization Tests (placeholder)"""
    
    @pytest.mark.skip(reason="Phase 4 not yet implemented")
    def test_config_yaml_exists(self):
        """Test that config.yaml is created."""
        pass
    
    @pytest.mark.skip(reason="Phase 4 not yet implemented")
    def test_claude_md_updated(self):
        """Test that CLAUDE.md is properly updated."""
        pass
    
    @pytest.mark.skip(reason="Phase 4 not yet implemented")
    def test_master_imports_updated(self):
        """Test that MASTER_IMPORTS.md includes new rules."""
        pass

def test_existing_tests_still_pass():
    """Ensure our changes don't break existing functionality."""
    # This is a sanity check - actual test is running pytest on all tests
    root = get_project_root()
    assert (root / ".claude/rules/git").exists()
    assert (root / ".claude/rules/project").exists()
```

## Validation Loop

### Level 1: Directory Structure
```bash
# Verify directories created
ls -la .claude/rules/python/
ls -la .claude/rules/testing/
ls -la .claude/rules/documentation/
ls -la docs/patterns/

# Check README files exist
cat .claude/rules/python/README.md
cat .claude/rules/testing/README.md
cat .claude/rules/documentation/README.md
```

### Level 2: Pattern Documentation
```bash
# Verify pattern documentation
cat docs/patterns/enhanced-rule-metadata.md | grep "Priority:"
cat docs/patterns/enhanced-rule-metadata.md | grep "Dependencies:"
```

### Level 3: Test Execution
```bash
# Run only Phase 1 tests
pytest tests/test_claude_md_standardization.py::TestPhase1Infrastructure -v

# Verify existing tests still pass
pytest tests/test_git_rules.py -v

# Run all tests to ensure nothing broken
pytest tests/ -v
```

## Final Validation Checklist
- [ ] Pattern documentation created at `docs/patterns/enhanced-rule-metadata.md`
- [ ] New directories created: python/, testing/, documentation/
- [ ] Each new directory has a placeholder README.md
- [ ] Test file created with Phase 1 tests passing
- [ ] All existing tests still pass
- [ ] No changes to existing rules (backward compatible)

---

## Anti-Patterns to Avoid
- ❌ Don't modify existing rules in Phase 1
- ❌ Don't skip creating test infrastructure
- ❌ Don't forget placeholder READMEs in new directories
- ❌ Don't implement actual rules yet (that's Phase 2-3)

## Next Phase
After Phase 1 completion:
- Run all validation steps
- Commit changes
- Proceed to Phase 2: Core Rules Migration

## PRP Confidence Score: 10/10

Very high confidence because:
- Minimal changes (just infrastructure)
- No modifications to existing files
- Clear test criteria
- Low risk of breaking existing functionality