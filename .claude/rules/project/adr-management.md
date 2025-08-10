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