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
    """Phase 3: Language Rules Migration Tests"""
    
    def test_python_rules_exist(self):
        """Test that Python rules are created with metadata."""
        root = get_project_root()
        
        # Check code-style rule
        code_style = root / ".claude/rules/python/code-style.md"
        assert code_style.exists()
        content = code_style.read_text()
        assert "Priority: 600" in content
        assert 'Dependencies: ["python/environment-management"]' in content
        
        # Check environment-management rule
        env_mgmt = root / ".claude/rules/python/environment-management.md"
        assert env_mgmt.exists()
        content = env_mgmt.read_text()
        assert "Priority: 700" in content
        assert "venv_linux" in content
    
    def test_documentation_rules_exist(self):
        """Test that documentation rules are created."""
        root = get_project_root()
        
        docstring = root / ".claude/rules/documentation/docstring-format.md"
        assert docstring.exists()
        content = docstring.read_text()
        assert "Priority: 500" in content
        assert 'Dependencies: ["python/code-style"]' in content
        assert "Google" in content or "google" in content
    
    def test_testing_rules_exist(self):
        """Test that testing rules are created."""
        root = get_project_root()
        
        pytest_rule = root / ".claude/rules/testing/pytest-requirements.md"
        assert pytest_rule.exists()
        content = pytest_rule.read_text()
        assert "Priority: 600" in content
        assert "happy_path" in content
        assert "edge_case" in content
        assert "error_case" in content
    
    def test_all_phase3_docs_exist(self):
        """Test that all documentation files exist."""
        root = get_project_root()
        
        docs = [
            "docs/rules/python/code-style.md",
            "docs/rules/python/environment-management.md",
            "docs/rules/documentation/docstring-format.md",
            "docs/rules/testing/pytest-requirements.md"
        ]
        
        for doc_path in docs:
            doc_file = root / doc_path
            assert doc_file.exists(), f"{doc_path} not found"
    
    def test_master_imports_has_new_sections(self):
        """Test that MASTER_IMPORTS has new sections."""
        root = get_project_root()
        imports = root / ".claude/MASTER_IMPORTS.md"
        
        content = imports.read_text()
        assert "## Python Rules" in content
        assert "## Documentation Rules" in content
        assert "## Testing Rules" in content
        assert "@.claude/rules/python/code-style.md" in content

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

def test_existing_tests_still_pass():
    """Ensure our changes don't break existing functionality."""
    # This is a sanity check - actual test is running pytest on all tests
    root = get_project_root()
    assert (root / ".claude/rules/git").exists()
    assert (root / ".claude/rules/project").exists()