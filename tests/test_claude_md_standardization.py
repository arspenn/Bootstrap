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