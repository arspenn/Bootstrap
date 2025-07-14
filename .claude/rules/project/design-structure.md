# Rule: Design Document Structure

## Instructions

### Rule Metadata
- ID: project/design-structure
- Status: Active
- Security Level: Low
- Token Impact: ~50 tokens per design operation

### Rule Configuration
```yaml
trigger: "design document operations"
conditions:
  - creating_design: true
  - organizing_designs: true
actions:
  - enforce_naming: "{sequence}-{type}-{description}/"
  - require_frontmatter: true
  - create_structure: ["design.md", "adrs/", "diagrams/"]
validations:
  - sequence_format: "^\\d{3}$"
  - valid_types: [feature, refactor, fix, spike, system]
  - frontmatter_required:
      - title
      - status
      - created
      - updated
      - type
      - author
      - tags
      - estimated_effort
  - status_values: [draft, approved, implementing, completed, archived]
  - diagram_location: "diagrams/ folder MUST be inside design folder, never at designs root"
```

### Structure Requirements
- Folder pattern: `{sequence}-{type}-{description}/`
- Main file: `design.md` with YAML frontmatter
- Optional: `adrs/` folder for Architecture Decision Records  
- Optional: `diagrams/` folder for visual documentation (Mermaid, images)
  - **MUST be inside the design folder** (e.g., `001-feature-name/diagrams/`)
  - **NEVER at designs root level** (e.g., NOT `designs/feature-diagrams/`)
  - Use relative paths in references (e.g., `[diagram](diagrams/file.mmd)`)

### Example Structure
```
designs/
└── 001-feature-authentication/
    ├── design.md              # Main design document
    ├── adrs/                  # Architecture decisions
    │   └── ADR-001-auth-method.md
    └── diagrams/              # Visual documentation
        ├── auth-flow.mmd      # Mermaid diagram
        └── architecture.png   # Exported image
```

---

📚 **Full Documentation**: [docs/rules/project/design-structure.md](../../../docs/rules/project/design-structure.md)