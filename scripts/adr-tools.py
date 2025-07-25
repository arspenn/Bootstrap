#!/usr/bin/env python3
"""ADR Management Tools for Bootstrap Project"""

import os
import re
import sys
from pathlib import Path
from typing import List, Dict, Tuple, Optional
import argparse


class ADRManager:
    """Manages Architecture Decision Records (ADRs) in the Bootstrap project."""
    
    def __init__(self, project_root: Path):
        self.project_root = project_root
        self.docs_adr_dir = project_root / "docs" / "ADRs"
        self.designs_dir = project_root / "designs"
        self.index_path = self.docs_adr_dir / "INDEX.md"
        self.adr_pattern = re.compile(r'^#\s*ADR-(\d{3}):\s*(.+)$', re.MULTILINE)
        self.status_pattern = re.compile(r'^##\s*Status\s*\n(.+)$', re.MULTILINE)
        
    def find_all_adrs(self) -> Dict[str, List[Dict[str, str]]]:
        """Find all ADR files in the project."""
        adrs = {
            "project_wide": [],
            "design_specific": {}
        }
        
        # Find project-wide ADRs
        if self.docs_adr_dir.exists():
            for file in self.docs_adr_dir.glob("ADR-*.md"):
                if file.name != "INDEX.md":
                    adr_info = self._parse_adr_file(file)
                    if adr_info:
                        adrs["project_wide"].append(adr_info)
        
        # Find design-specific ADRs
        if self.designs_dir.exists():
            for design_dir in self.designs_dir.iterdir():
                if design_dir.is_dir() and design_dir.name.startswith(('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')):
                    adr_dir = design_dir / "adrs"
                    if adr_dir.exists():
                        design_adrs = []
                        for file in adr_dir.glob("ADR-*.md"):
                            adr_info = self._parse_adr_file(file)
                            if adr_info:
                                design_adrs.append(adr_info)
                        if design_adrs:
                            adrs["design_specific"][design_dir.name] = design_adrs
        
        return adrs
    
    def _parse_adr_file(self, file_path: Path) -> Optional[Dict[str, str]]:
        """Parse an ADR file and extract metadata."""
        try:
            content = file_path.read_text()
            
            # Extract ADR number and title
            title_match = self.adr_pattern.search(content)
            if not title_match:
                return None
                
            adr_number = title_match.group(1)
            title = title_match.group(2).strip()
            
            # Extract status
            status_match = self.status_pattern.search(content)
            status = status_match.group(1).strip() if status_match else "Unknown"
            
            return {
                "file_path": str(file_path),
                "number": adr_number,
                "title": title,
                "status": status,
                "location": "project_wide" if "docs/ADRs" in str(file_path) else "design_specific"
            }
        except Exception as e:
            print(f"Error parsing {file_path}: {e}")
            return None
    
    def validate_adr_format(self, filepath: Path) -> List[str]:
        """Validate that an ADR file follows the standard format."""
        errors = []
        
        if not filepath.exists():
            return [f"File does not exist: {filepath}"]
        
        content = filepath.read_text()
        
        # Check title format
        if not self.adr_pattern.search(content):
            errors.append("Missing or incorrect ADR title format (should be '# ADR-XXX: Title')")
        
        # Check required sections
        required_sections = ["## Status", "## Context", "## Decision", "## Consequences"]
        for section in required_sections:
            if section not in content:
                errors.append(f"Missing required section: {section}")
        
        # Check status value
        status_match = self.status_pattern.search(content)
        if status_match:
            valid_statuses = ["Proposed", "Accepted", "Deprecated", "Superseded"]
            if status_match.group(1).strip() not in valid_statuses:
                errors.append(f"Invalid status: {status_match.group(1).strip()}. Must be one of: {', '.join(valid_statuses)}")
        
        # Check consequences subsections
        if "## Consequences" in content:
            consequence_sections = ["### Positive", "### Negative", "### Neutral"]
            consequences_text = content.split("## Consequences")[1]
            for subsection in consequence_sections:
                if subsection not in consequences_text:
                    errors.append(f"Missing consequences subsection: {subsection}")
        
        return errors
    
    def validate_all(self) -> Dict[str, List[str]]:
        """Validate all ADR files in the project."""
        all_adrs = self.find_all_adrs()
        validation_results = {}
        
        # Validate project-wide ADRs
        for adr in all_adrs["project_wide"]:
            filepath = Path(adr["file_path"])
            errors = self.validate_adr_format(filepath)
            if errors:
                validation_results[str(filepath)] = errors
        
        # Validate design-specific ADRs
        for design_name, adrs in all_adrs["design_specific"].items():
            for adr in adrs:
                filepath = Path(adr["file_path"])
                errors = self.validate_adr_format(filepath)
                if errors:
                    validation_results[str(filepath)] = errors
        
        return validation_results
    
    def check_references(self) -> List[str]:
        """Check that all ADR references in the INDEX.md are valid."""
        errors = []
        
        if not self.index_path.exists():
            return ["INDEX.md file not found"]
        
        index_content = self.index_path.read_text()
        
        # Find all markdown links in the index
        link_pattern = re.compile(r'\[([^\]]+)\]\(([^)]+)\)')
        
        for match in link_pattern.finditer(index_content):
            link_text = match.group(1)
            link_path = match.group(2)
            
            # Skip external links
            if link_path.startswith(('http://', 'https://', '#')):
                continue
            
            # Resolve relative path from INDEX.md location
            if link_path.startswith('./'):
                full_path = self.index_path.parent / link_path[2:]
            elif link_path.startswith('../'):
                full_path = self.index_path.parent / link_path
            else:
                full_path = self.index_path.parent / link_path
            
            # Check if file exists
            if not full_path.exists():
                errors.append(f"Broken link in INDEX.md: {link_path} (link text: '{link_text}')")
        
        return errors
    
    def verify_index(self) -> List[str]:
        """Verify that the INDEX.md includes all ADRs."""
        errors = []
        
        if not self.index_path.exists():
            return ["INDEX.md file not found"]
        
        index_content = self.index_path.read_text()
        all_adrs = self.find_all_adrs()
        
        # Check project-wide ADRs
        for adr in all_adrs["project_wide"]:
            adr_filename = Path(adr["file_path"]).name
            if adr_filename not in index_content:
                errors.append(f"Missing from INDEX.md: {adr_filename} - {adr['title']}")
        
        # Check design-specific ADRs
        for design_name, adrs in all_adrs["design_specific"].items():
            for adr in adrs:
                # Check if the design is mentioned
                if design_name not in index_content:
                    errors.append(f"Design '{design_name}' not mentioned in INDEX.md")
                    break
                
                # Check if the specific ADR is referenced
                adr_filename = Path(adr["file_path"]).name
                expected_ref = f"{design_name}/adrs/{adr_filename}"
                if expected_ref not in index_content and adr['title'] not in index_content:
                    errors.append(f"Missing from INDEX.md: {expected_ref} - {adr['title']}")
        
        return errors
    
    def update_adr_index(self) -> None:
        """Update the INDEX.md file with all current ADRs."""
        all_adrs = self.find_all_adrs()
        
        # Sort project-wide ADRs by number
        all_adrs["project_wide"].sort(key=lambda x: x["number"])
        
        # Generate new index content
        content = ["# ADR Index\n"]
        content.append("## Overview\n")
        content.append("This index provides a comprehensive listing of all Architecture Decision Records (ADRs) in the Bootstrap project. ADRs document important architectural decisions and their rationale.\n")
        
        content.append("### ADR Organization\n")
        content.append("We use a hybrid approach for organizing ADRs:\n")
        content.append("- **Project-wide ADRs** are stored in `docs/ADRs/` and affect the entire framework\n")
        content.append("- **Design-specific ADRs** are stored with their features in `designs/*/adrs/` and document feature-specific decisions\n")
        
        content.append("\n### Classification Criteria\n")
        content.append("\n**Project-wide ADRs** include decisions that:\n")
        content.append("- Affect multiple features or the entire codebase\n")
        content.append("- Establish conventions or standards\n")
        content.append("- Define technology choices used across features\n")
        content.append("- Set security or performance policies\n")
        content.append("- Impact the development workflow\n")
        content.append("- Define architectural patterns or principles\n")
        
        content.append("\n**Design-specific ADRs** include decisions that:\n")
        content.append("- Only affect the specific feature implementation\n")
        content.append("- Document trade-offs unique to that feature\n")
        content.append("- Explain implementation choices within established conventions\n")
        content.append("- Describe optimizations specific to the feature\n")
        
        # Project-wide ADRs section
        content.append("\n## Project-wide ADRs\n")
        content.append("\nLocated in `docs/ADRs/`\n")
        
        if all_adrs["project_wide"]:
            # Group by category (simplified categorization based on ADR numbers/titles)
            architecture_adrs = []
            process_adrs = []
            
            for adr in all_adrs["project_wide"]:
                if any(keyword in adr['title'].lower() for keyword in ['architecture', 'framework', 'rule', 'import', 'strategy']):
                    architecture_adrs.append(adr)
                else:
                    process_adrs.append(adr)
            
            if architecture_adrs:
                content.append("\n### Architecture & Framework\n")
                for adr in architecture_adrs:
                    content.append(f"- [ADR-{adr['number']}](./{Path(adr['file_path']).name}) - {adr['title']}\n")
            
            if process_adrs:
                content.append("\n### Development Process\n")
                for adr in process_adrs:
                    content.append(f"- [ADR-{adr['number']}](./{Path(adr['file_path']).name}) - {adr['title']}\n")
        
        # Design-specific ADRs section
        content.append("\n## Design-specific ADRs\n")
        
        if all_adrs["design_specific"]:
            # Sort designs by number
            sorted_designs = sorted(all_adrs["design_specific"].items(), 
                                  key=lambda x: int(re.match(r'(\d+)', x[0]).group(1)))
            
            for design_name, adrs in sorted_designs:
                # Extract feature name from design directory name
                feature_match = re.match(r'\d+-(\w+)-(.+)', design_name)
                if feature_match:
                    feature_type = feature_match.group(1).title()
                    feature_desc = feature_match.group(2).replace('-', ' ').title()
                    content.append(f"\n### {feature_type}: {feature_desc} ({design_name.split('-')[0]})\n")
                else:
                    content.append(f"\n### {design_name}\n")
                
                content.append(f"Located in `designs/{design_name}/adrs/`\n")
                
                # Sort ADRs by number
                adrs.sort(key=lambda x: x["number"])
                
                for adr in adrs:
                    adr_filename = Path(adr["file_path"]).name
                    relative_path = f"../../designs/{design_name}/adrs/{adr_filename}"
                    content.append(f"- [ADR-{adr['number']}]({relative_path}) - {adr['title']}\n")
        
        # Quick Reference Table
        content.append("\n## Quick Reference\n")
        content.append("\n| ADR | Title | Location | Status |\n")
        content.append("|-----|-------|----------|--------|\n")
        
        # Add project-wide ADRs to table
        for adr in all_adrs["project_wide"]:
            content.append(f"| ADR-{adr['number']} | {adr['title']} | Project-wide | {adr['status']} |\n")
        
        # Add design-specific ADRs to table
        if all_adrs["design_specific"]:
            sorted_designs = sorted(all_adrs["design_specific"].items())
            for design_name, adrs in sorted_designs:
                design_number = design_name.split('-')[0]
                for adr in sorted(adrs, key=lambda x: x["number"]):
                    content.append(f"| {design_number}/ADR-{adr['number']} | {adr['title']} | Design-specific | {adr['status']} |\n")
        
        # Maintenance notes
        content.append("\n## Maintenance Notes\n")
        content.append("\n- This index should be updated whenever a new ADR is created\n")
        content.append("- Use the `scripts/adr-tools.py` script to validate and update this index\n")
        content.append("- When ADRs are superseded or deprecated, update their status and link to the replacement\n")
        
        # Write the updated index
        self.index_path.write_text(''.join(content))
        print(f"Updated {self.index_path}")


def main():
    """Main entry point for ADR tools."""
    parser = argparse.ArgumentParser(description="ADR Management Tools")
    parser.add_argument("command", choices=["validate-all", "check-references", "verify-index", "update-index"],
                       help="Command to execute")
    
    args = parser.parse_args()
    
    # Find project root
    current_dir = Path.cwd()
    project_root = current_dir
    
    # Look for project markers
    while project_root.parent != project_root:
        if (project_root / "CLAUDE.md").exists() or (project_root / ".git").exists():
            break
        project_root = project_root.parent
    
    if not (project_root / "CLAUDE.md").exists():
        print("Error: Could not find project root (no CLAUDE.md found)")
        sys.exit(1)
    
    manager = ADRManager(project_root)
    
    if args.command == "validate-all":
        results = manager.validate_all()
        if results:
            print("Validation errors found:")
            for filepath, errors in results.items():
                print(f"\n{filepath}:")
                for error in errors:
                    print(f"  - {error}")
            sys.exit(1)
        else:
            print("All ADR files are valid!")
    
    elif args.command == "check-references":
        errors = manager.check_references()
        if errors:
            print("Reference errors found:")
            for error in errors:
                print(f"  - {error}")
            sys.exit(1)
        else:
            print("All ADR references in INDEX.md are valid!")
    
    elif args.command == "verify-index":
        errors = manager.verify_index()
        if errors:
            print("Index verification errors:")
            for error in errors:
                print(f"  - {error}")
            sys.exit(1)
        else:
            print("INDEX.md is complete and up to date!")
    
    elif args.command == "update-index":
        manager.update_adr_index()
        print("INDEX.md has been updated successfully!")


if __name__ == "__main__":
    main()