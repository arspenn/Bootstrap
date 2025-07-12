"""
Tests for the design-feature Claude command.
"""
import os
import pytest


def test_command_file_exists():
    """Command file is in correct location."""
    command_path = ".claude/commands/design-feature.md"
    assert os.path.exists(command_path), f"Command file not found at {command_path}"


def test_designs_directory_created():
    """Designs directory exists for outputs."""
    designs_path = "designs/"
    assert os.path.exists(designs_path), f"Designs directory not found at {designs_path}"
    assert os.path.isdir(designs_path), f"{designs_path} is not a directory"


def test_command_structure():
    """Command follows Claude command patterns."""
    with open(".claude/commands/design-feature.md", "r") as f:
        content = f.read()
        
        # Check for required header
        assert "# Design Feature" in content, "Missing command header"
        
        # Check for $ARGUMENTS variable
        assert "$ARGUMENTS" in content, "Missing $ARGUMENTS variable"
        
        # Check for main sections
        assert "## Design Process" in content, "Missing Design Process section"
        assert "## When to Use This Command" in content, "Missing When to Use section"
        assert "## Output Structure" in content, "Missing Output Structure section"
        
        # Check for numbered process steps
        assert "1. **Load Context**" in content, "Missing numbered process steps"
        assert "2. **Interactive Requirements Gathering**" in content, "Missing requirements gathering"
        assert "3. **Codebase Analysis**" in content, "Missing codebase analysis"
        assert "4. **Architecture Exploration**" in content, "Missing architecture exploration"
        assert "5. **Design Alternatives**" in content, "Missing design alternatives"
        assert "6. **Architecture Decision Records" in content, "Missing ADR section"
        assert "7. **Risk Assessment**" in content, "Missing risk assessment"
        assert "8. **Create Design Artifacts**" in content, "Missing design artifacts"
        assert "9. **Generate Design Document**" in content, "Missing design document"
        assert "10. **Validation Checklist**" in content, "Missing validation checklist"


def test_interactive_questions_present():
    """Command includes comprehensive interactive questions."""
    with open(".claude/commands/design-feature.md", "r") as f:
        content = f.read()
        
        # Functional requirements questions
        assert "What is the primary user goal" in content
        assert "What are the key user interactions" in content
        assert "What data will be processed" in content
        
        # Non-functional requirements questions
        assert "expected load/scale" in content
        assert "performance requirements" in content
        assert "security considerations" in content
        
        # Integration questions
        assert "existing components" in content
        assert "external service dependencies" in content
        assert "database/storage requirements" in content


def test_adr_template_included():
    """Command includes proper ADR template."""
    with open(".claude/commands/design-feature.md", "r") as f:
        content = f.read()
        
        assert "# ADR-{number}: {title}" in content
        assert "## Status" in content
        assert "## Context" in content
        assert "## Decision" in content
        assert "## Consequences" in content


def test_mermaid_diagrams_included():
    """Command includes Mermaid diagram examples."""
    with open(".claude/commands/design-feature.md", "r") as f:
        content = f.read()
        
        assert "```mermaid" in content
        assert "C4Context" in content
        assert "sequenceDiagram" in content


def test_design_document_template():
    """Command includes design document template."""
    with open(".claude/commands/design-feature.md", "r") as f:
        content = f.read()
        
        assert "# {Feature Name} Design Document" in content
        assert "## Executive Summary" in content
        assert "## Requirements" in content
        assert "## Proposed Design" in content
        assert "## Alternative Approaches" in content
        assert "## Risks and Mitigations" in content


def test_output_structure_defined():
    """Command defines clear output structure."""
    with open(".claude/commands/design-feature.md", "r") as f:
        content = f.read()
        
        assert "{feature-name}-design.md" in content
        assert "{feature-name}-adrs/" in content
        assert "{feature-name}-diagrams/" in content


def test_integration_with_project_docs():
    """Command mentions integration with project documentation."""
    with open(".claude/commands/design-feature.md", "r") as f:
        content = f.read()
        
        assert "PLANNING.md" in content
        assert "TASK.md" in content
        assert "CLAUDE.md" in content


def test_workflow_integration():
    """Command explains integration with PRP workflow."""
    with open(".claude/commands/design-feature.md", "r") as f:
        content = f.read()
        
        assert "generate-prp" in content
        assert "Next Steps" in content or "next steps" in content


if __name__ == "__main__":
    pytest.main([__file__, "-v"])