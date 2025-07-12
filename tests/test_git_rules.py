"""
Tests for Git control rules implementation.
"""
import os
import pytest
import yaml
from pathlib import Path


def get_project_root():
    """Get the project root directory."""
    return Path(__file__).parent.parent


def test_claude_directory_structure():
    """Test that .claude directory structure exists."""
    root = get_project_root()
    
    # Check main directories
    assert (root / ".claude").exists(), ".claude directory not found"
    assert (root / ".claude" / "rules").exists(), ".claude/rules directory not found"
    assert (root / ".claude" / "rules" / "git").exists(), ".claude/rules/git directory not found"
    assert (root / ".claude" / "rules" / "config").exists(), ".claude/rules/config directory not found"
    assert (root / ".claude" / "templates").exists(), ".claude/templates directory not found"


def test_claude_md_updated():
    """Test that CLAUDE.md has Git Control Rules section."""
    root = get_project_root()
    claude_md = root / "CLAUDE.md"
    
    assert claude_md.exists(), "CLAUDE.md not found"
    
    content = claude_md.read_text()
    assert "### 📋 Git Control Rules" in content, "Git Control Rules section not found in CLAUDE.md"
    assert "Load Git behavior rules from `.claude/rules/git/`" in content
    assert "User preferences in `.claude/rules/config/user-preferences.yaml`" in content
    assert "Templates in `.claude/templates/`" in content
    assert "See `.claude/rules/README.md` for navigation" in content


def test_rules_navigation_exists():
    """Test that rules navigation files exist."""
    root = get_project_root()
    
    # Master navigation
    rules_readme = root / ".claude" / "rules" / "README.md"
    assert rules_readme.exists(), ".claude/rules/README.md not found"
    
    content = rules_readme.read_text()
    assert "Claude Rules Navigation" in content
    assert "Rule Categories" in content
    assert "How Rules Work" in content
    
    # Git rules index
    git_index = root / ".claude" / "rules" / "git" / "index.md"
    assert git_index.exists(), ".claude/rules/git/index.md not found"
    
    content = git_index.read_text()
    assert "Git Rules Index" in content
    assert "Active Rules" in content


def test_all_git_rules_exist():
    """Test that all 5 Git rules are implemented."""
    root = get_project_root()
    git_rules_dir = root / ".claude" / "rules" / "git"
    
    expected_rules = [
        "git-add-safety.md",
        "git-commit-format.md",
        "git-push-validation.md",
        "git-pull-strategy.md",
        "git-branch-naming.md"
    ]
    
    for rule_file in expected_rules:
        rule_path = git_rules_dir / rule_file
        assert rule_path.exists(), f"Rule file {rule_file} not found"


def test_rule_format_validation():
    """Test that each rule file has required format."""
    root = get_project_root()
    git_rules_dir = root / ".claude" / "rules" / "git"
    
    required_sections = [
        "# Rule:",
        "## ID:",
        "## Status:",
        "## Security Level:",
        "## Token Impact:",
        "## Description",
        "## Rule Definition",
        "## Rationale",
        "## Examples",
        "## Related Rules"
    ]
    
    for rule_file in git_rules_dir.glob("git-*.md"):
        content = rule_file.read_text()
        
        for section in required_sections:
            assert section in content, f"Section '{section}' missing in {rule_file.name}"
        
        # Check for valid status
        assert any(status in content for status in ["Active", "Experimental", "Deprecated"]), \
            f"Valid status not found in {rule_file.name}"
        
        # Check for valid security level
        assert any(level in content for level in ["High", "Medium", "Low"]), \
            f"Valid security level not found in {rule_file.name}"
        
        # Check for examples
        assert "✅ Good:" in content, f"Good examples missing in {rule_file.name}"
        assert "❌ Bad:" in content, f"Bad examples missing in {rule_file.name}"


def test_templates_exist():
    """Test that commit and branch templates exist."""
    root = get_project_root()
    templates_dir = root / ".claude" / "templates"
    
    # Commit message template
    commit_template = templates_dir / "commit-message.template"
    assert commit_template.exists(), "commit-message.template not found"
    
    content = commit_template.read_text()
    assert "<TYPE>" in content, "TYPE placeholder missing in commit template"
    assert "<SCOPE>" in content, "SCOPE placeholder missing in commit template"
    assert "<SUBJECT>" in content, "SUBJECT placeholder missing in commit template"
    
    # Branch name template
    branch_template = templates_dir / "branch-name.template"
    assert branch_template.exists(), "branch-name.template not found"
    
    content = branch_template.read_text()
    assert "<TYPE>" in content, "TYPE placeholder missing in branch template"
    assert "<DESCRIPTION>" in content, "DESCRIPTION placeholder missing in branch template"
    assert "<BASE-VERSION>" in content, "BASE-VERSION placeholder missing in branch template"


def test_user_configuration_files():
    """Test that user configuration files exist and are valid."""
    root = get_project_root()
    config_dir = root / ".claude" / "rules" / "config"
    
    # User preferences
    user_prefs = config_dir / "user-preferences.yaml"
    assert user_prefs.exists(), "user-preferences.yaml not found"
    
    # Validate YAML
    with open(user_prefs) as f:
        prefs = yaml.safe_load(f)
    
    assert "git" in prefs, "git section missing in user preferences"
    assert "rules" in prefs["git"], "rules section missing in git preferences"
    
    # Check all rules are configured
    expected_rules = [
        "git-add-safety",
        "git-commit-format",
        "git-push-validation",
        "git-pull-strategy",
        "git-branch-naming"
    ]
    
    for rule in expected_rules:
        assert rule in prefs["git"]["rules"], f"{rule} missing in user preferences"
        assert prefs["git"]["rules"][rule] in ["enabled", "disabled"], \
            f"Invalid value for {rule} in preferences"
    
    # Conflict log
    conflict_log = config_dir / "conflict-log.md"
    assert conflict_log.exists(), "conflict-log.md not found"
    
    content = conflict_log.read_text()
    assert "Rule Conflict Log" in content
    assert "Log Format" in content


def test_documentation_exists():
    """Test that user documentation exists."""
    root = get_project_root()
    docs_dir = root / "docs" / "rules" / "git"
    
    assert docs_dir.exists(), "docs/rules/git directory not found"
    
    readme = docs_dir / "README.md"
    assert readme.exists(), "docs/rules/git/README.md not found"
    
    content = readme.read_text()
    assert "Git Control Rules User Guide" in content
    assert "Quick Start" in content
    assert "Active Rules" in content
    assert "Configuration" in content
    assert "Common Scenarios" in content
    assert "Troubleshooting" in content


def test_rule_references():
    """Test that rules have proper cross-references."""
    root = get_project_root()
    git_rules_dir = root / ".claude" / "rules" / "git"
    
    rule_files = list(git_rules_dir.glob("git-*.md"))
    rule_names = [f.stem for f in rule_files]
    
    for rule_file in rule_files:
        content = rule_file.read_text()
        
        # Check for related rules section
        if "## Related Rules" in content:
            # Should reference at least one other rule
            referenced = False
            for other_rule in rule_names:
                if other_rule != rule_file.stem and other_rule in content:
                    referenced = True
                    break
            assert referenced, f"No related rules referenced in {rule_file.name}"


def test_git_documentation_links():
    """Test that rules link to official Git documentation."""
    root = get_project_root()
    git_rules_dir = root / ".claude" / "rules" / "git"
    
    git_docs_url = "https://git-scm.com/docs"
    
    for rule_file in git_rules_dir.glob("git-*.md"):
        content = rule_file.read_text()
        
        # Each rule should have at least one link to Git docs
        assert git_docs_url in content or "conventionalcommits.org" in content, \
            f"No documentation links found in {rule_file.name}"


def test_security_levels_distribution():
    """Test that security levels are appropriately distributed."""
    root = get_project_root()
    git_rules_dir = root / ".claude" / "rules" / "git"
    
    security_levels = {"High": 0, "Medium": 0, "Low": 0}
    
    for rule_file in git_rules_dir.glob("git-*.md"):
        content = rule_file.read_text()
        
        for level in security_levels:
            if f"## Security Level: {level}" in content:
                security_levels[level] += 1
    
    # We should have at least one of each level
    assert security_levels["High"] >= 2, "Expected at least 2 high security rules"
    assert security_levels["Medium"] >= 2, "Expected at least 2 medium security rules"
    assert security_levels["Low"] >= 1, "Expected at least 1 low security rule"


def test_adrs_exist():
    """Test that ADRs related to Git rules exist."""
    root = get_project_root()
    adrs_dir = root / "docs" / "ADRs"
    
    expected_adrs = [
        "ADR-001-git-rules-architecture.md",
        "ADR-002-git-commit-standards.md",
        "ADR-003-branching-strategy.md"
    ]
    
    for adr in expected_adrs:
        adr_path = adrs_dir / adr
        assert adr_path.exists(), f"ADR {adr} not found"


def test_task_md_updated():
    """Test that TASK.md includes Git control tasks."""
    root = get_project_root()
    task_md = root / "TASK.md"
    
    if task_md.exists():
        content = task_md.read_text()
        assert "Git Control" in content or "git control" in content.lower(), \
            "Git control tasks not found in TASK.md"


if __name__ == "__main__":
    pytest.main([__file__, "-v"])