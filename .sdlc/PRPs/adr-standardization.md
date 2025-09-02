# PRP: ADR Standardization

## Overview
Implement a hybrid ADR (Architecture Decision Record) organization system that keeps project-wide ADRs centralized while maintaining design-specific ADRs with their features. Create a comprehensive index for all ADRs and establish clear guidelines for ADR placement.

## Context and Research

### Current State Analysis
The Bootstrap project currently has 17 ADRs scattered across the codebase:
- 5 ADRs in `docs/ADRs/` (project-wide decisions)
- 10 ADRs in various design folders
- 2 orphaned ADRs in `designs/claude-memory-integration-adrs/`

### Existing ADR Template
Location: `/home/arspenn/Dev/Bootstrap/templates/design-templates/adr.template.md`
```markdown
# ADR-{number}: {Title}

## Status
{Proposed|Accepted|Deprecated|Superseded}

## Context
{What is the issue that we're seeing that is motivating this decision or change?}

## Decision
{What is the change that we're proposing and/or doing?}

## Consequences

### Positive
- {Positive consequence}
- {What becomes easier or better?}

### Negative
- {Negative consequence}
- {What becomes more difficult?}

### Neutral
- {Neutral consequence}
- {What changes without being clearly good or bad?}
```

### Key References
- Design document: `/home/arspenn/Dev/Bootstrap/designs/008-feature-adr-standardization/design.md`
- ADR best practices: https://adr.github.io/
- Google Cloud ADR guide: https://cloud.google.com/architecture/architecture-decision-records
- AWS ADR best practices: https://aws.amazon.com/blogs/architecture/master-architecture-decision-records-adrs-best-practices-for-effective-decision-making/

### Important Patterns to Follow
1. All ADRs use the standard template format
2. ADR numbering is sequential within each location (XXX format)
3. Status tracking includes: Proposed, Accepted, Deprecated, Superseded
4. Cross-references use relative paths for maintainability
5. Markdown format for version control compatibility

## Implementation Blueprint

### Phase 1: Create ADR Index Structure

1. **Create INDEX.md**
   ```python
   # Pseudocode for index generation
   def create_adr_index():
       index_content = generate_index_header()
       
       # Add project-wide ADRs
       project_adrs = scan_directory("docs/ADRs/")
       index_content += format_project_adrs(project_adrs)
       
       # Add design-specific ADRs
       design_adrs = scan_designs_for_adrs("designs/")
       index_content += format_design_adrs(design_adrs)
       
       write_file("docs/ADRs/INDEX.md", index_content)
   ```

2. **Index Template Structure**
   - Header with purpose and navigation
   - Project-wide ADRs section with categories
   - Design-specific ADRs grouped by feature
   - Quick reference table with status indicators

### Phase 2: Migrate Orphaned ADRs

1. **Identify Migration Targets**
   ```bash
   # Orphaned ADRs to migrate:
   # ADR-004-rule-instruction-separation.md → docs/ADRs/ADR-008-rule-instruction-separation.md
   # ADR-005-master-import-strategy.md → docs/ADRs/ADR-009-master-import-strategy.md
   ```

2. **Update ADR Numbers**
   - Renumber to continue sequence in docs/ADRs/ (starting at ADR-008)
   - Preserve original content and metadata
   - Add migration note in header comment

### Phase 3: Update References

1. **Search and Replace References**
   ```python
   # Files that reference ADRs:
   # - CHANGELOG.md
   # - Various design.md files
   # - Test files (test_git_rules.py)
   
   references_to_update = [
       ("ADR-004-rule-instruction-separation", "ADR-008-rule-instruction-separation"),
       ("ADR-005-master-import-strategy", "ADR-009-master-import-strategy"),
       # Update paths for moved ADRs
   ]
   ```

### Phase 4: Create ADR Management Script

1. **Create `scripts/adr-tools.py`**
   ```python
   # Key functions:
   # - validate_adr_format(filepath)
   # - update_adr_index()
   # - check_adr_references()
   # - create_new_adr(title, location)
   ```

### Phase 5: Update Documentation

1. **Update CLAUDE.md**
   - Add ADR location guidelines
   - Include classification criteria
   - Reference the INDEX.md

2. **Update Design Template**
   - Add ADR section guidance
   - Include decision criteria for ADR placement

## Task List (In Order)

1. Create `docs/ADRs/INDEX.md` with initial structure
2. Create backup of orphaned ADRs before migration
3. Move and renumber orphaned ADRs to `docs/ADRs/`
4. Update all references to moved ADRs in codebase
5. Populate INDEX.md with all existing ADRs
6. Create `scripts/adr-tools.py` for ADR management
7. Update CLAUDE.md with ADR guidelines
8. Update design template with ADR guidance
9. Test all ADR links and references
10. Remove orphaned ADR directory after verification

## Validation Gates

```bash
# Syntax/Style Check
ruff check --fix scripts/adr-tools.py && mypy scripts/adr-tools.py

# Verify all ADR files follow template
python scripts/adr-tools.py validate-all

# Check all ADR references are valid
python scripts/adr-tools.py check-references

# Verify INDEX.md is complete
python scripts/adr-tools.py verify-index

# Run existing tests to ensure no breakage
pytest tests/test_git_rules.py tests/test_design_command.py -v

# Manual verification checklist
echo "Manual checks:"
echo "[ ] All ADRs accessible via INDEX.md"
echo "[ ] No broken links in ADR references"
echo "[ ] Orphaned ADR directory removed"
echo "[ ] CLAUDE.md updated with guidelines"
echo "[ ] Design template includes ADR section"
```

## Error Handling Strategy

1. **File Operations**
   - Always create backups before moving/renaming
   - Use git mv for tracked files
   - Verify file exists before operations

2. **Reference Updates**
   - Use precise regex patterns to avoid false matches
   - Preview changes before applying
   - Maintain mapping of old→new references

3. **Index Generation**
   - Handle missing ADR metadata gracefully
   - Report malformed ADRs but continue
   - Include validation warnings in index

## Success Criteria
- All 17 ADRs properly organized
- No orphaned ADRs remaining
- Central INDEX.md accurately lists all ADRs
- All references updated and working
- Clear guidelines in CLAUDE.md
- ADR management script functional
- All tests passing

## PRP Confidence Score: 9/10

**Rationale**: This PRP has comprehensive context including file locations, existing patterns, and external best practices. The implementation is clearly broken down into phases with specific tasks. The validation gates are executable and thorough. The only minor gap is that we don't have existing Python scripts to pattern match for the adr-tools.py implementation, but the pseudocode and requirements are clear enough for successful implementation.