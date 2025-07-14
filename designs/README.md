# Designs Folder Structure

## Purpose
This folder contains all Bootstrap project designs including architecture decisions, feature specifications, and implementation plans. Each design follows a standardized structure for consistency and discoverability.

## Naming Convention

All designs follow this pattern: `{sequence}-{type}-{description}/`

- **sequence**: Three-digit zero-padded number (001, 002, etc.)
- **type**: One of: `feature`, `refactor`, `fix`, `spike`, `system`
- **description**: Kebab-case meaningful name

### Examples
- `001-feature-task-management/`
- `002-refactor-auth-system/`
- `003-fix-token-overflow/`

## Folder Structure

Each design must follow this structure:

```
{sequence}-{type}-{description}/
├── design.md           # Main design document with YAML frontmatter (REQUIRED)
├── adrs/              # Architecture Decision Records (OPTIONAL)
│   ├── ADR-001-{decision}.md
│   └── ADR-002-{decision}.md
└── diagrams/          # Mermaid diagrams (OPTIONAL)
    ├── context.mmd
    └── components.mmd
```

## Required Frontmatter

Every `design.md` file must include YAML frontmatter:

```yaml
---
title: Human-readable title
status: draft|approved|implementing|completed|archived
created: YYYY-MM-DD
updated: YYYY-MM-DD
type: feature|refactor|fix|spike|system
author: Name or identifier
tags: [tag1, tag2]
estimated_effort: small|medium|large
actual_effort: small|medium|large  # Added after completion
---
```

## Status Lifecycle

1. **draft** - Initial creation, work in progress
2. **approved** - Reviewed and ready for implementation
3. **implementing** - Currently being built
4. **completed** - Implementation finished
5. **archived** - No longer relevant but kept for history

## Templates

Design templates are located in `/templates/design-templates/`

Available templates:
- `feature-design.template.md` - For new features
- `refactor-design.template.md` - For refactoring existing code
- `fix-design.template.md` - For bug fixes
- `spike-design.template.md` - For research/exploration
- `system-design.template.md` - For system-level changes
- `adr.template.md` - For Architecture Decision Records

## Creating a New Design

1. Create a new folder with the pattern: `{sequence}-{type}-{description}/`
2. Copy the appropriate template from `/templates/design-templates/`
3. Fill in all template placeholders
4. Ensure YAML frontmatter is complete

## Relationship to Other Folders

- **PRPs**: Each design typically generates one or more PRPs for implementation
- **Features**: Designs are created from feature requests in the `/features` folder
- **Tasks**: Implementation tasks from designs are tracked in TASK.md

## Design Discovery

Claude Code can find any design by:
- Listing folders with pattern `[0-9]{3}-{type}-*`
- Reading frontmatter for status and metadata
- Following this documented structure