---
title: Design Standardization - Diagram Migration Addendum
status: approved
created: 2025-01-13
updated: 2025-01-13
type: addendum
author: Bootstrap Team
tags: [design-structure, diagrams, migration, temporary-addendum]
integration_target: design.md
integration_timeline: next-revision
---

# Design Addendum: Diagram Folder Migration

## ⚠️ TEMPORARY ADDENDUM - INTEGRATION PENDING ⚠️

**This addendum is a temporary document that will be integrated into the main design.md file in the next revision. Claude Code should treat this as an extension of the parent design until integration is complete.**

### Integration Instructions for Claude Code:
1. When reading this design, also check for `design-addendum-*.md` files
2. Apply addendum requirements as if they were part of the main design
3. When updating the design, integrate addendum content into the main design.md

## Context

During the implementation of the standardized designs folder structure, the existing diagram folders were not properly migrated into their respective design folders. This addendum addresses this gap and ensures diagram folder requirements are properly documented.

## Issue Identified

The following diagram folders remain in the root designs directory:
- `git-control-diagrams/`
- `claude-memory-integration-diagrams/`
- `changelog-management-diagrams/`

These should be moved to:
- `001-feature-git-control/diagrams/`
- `002-feature-claude-memory/diagrams/`
- `003-feature-changelog-management/diagrams/`

## Updated Requirements

### Folder Structure Clarification

Each design folder MUST follow this structure:
```
{sequence}-{type}-{description}/
├── design.md           # Main design document (REQUIRED)
├── adrs/              # Architecture Decision Records (OPTIONAL)
│   ├── ADR-001-{decision}.md
│   └── ADR-002-{decision}.md
└── diagrams/          # Visual documentation (OPTIONAL)
    ├── {diagram-name}.mmd
    └── {diagram-name}.png
```

### Diagram Folder Specifications

1. **Naming**: Always use `diagrams/` (plural, lowercase)
2. **Location**: Always inside the design folder, never at root level
3. **Contents**: 
   - Mermaid diagram source files (`.mmd`)
   - Exported images if needed (`.png`, `.svg`)
   - Related visual documentation

## Migration Tasks

1. Move `git-control-diagrams/` → `001-feature-git-control/diagrams/`
2. Move `claude-memory-integration-diagrams/` → `002-feature-claude-memory/diagrams/`
3. Move `changelog-management-diagrams/` → `003-feature-changelog-management/diagrams/`
4. Update any references to diagram files in design documents
5. Update design-structure.md rule to emphasize diagram folder placement
6. Update design templates to include diagram folder guidance

## Success Criteria

- [ ] All diagram folders are inside their respective design folders
- [ ] No diagram folders exist at the designs root level
- [ ] All references to diagrams use relative paths
- [ ] Design templates mention the diagrams/ folder
- [ ] Design-structure rule explicitly states diagram folder requirements