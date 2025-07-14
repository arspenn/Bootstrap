# PRPs Folder Structure

## Purpose
This folder contains Phased Rollout Plans (PRPs) that provide detailed, step-by-step implementation guides for executing approved designs.

## Structure
```
PRPs/
├── {descriptive-name}.md    # PRP document (REQUIRED)
└── archive/                 # Completed PRPs (OPTIONAL)
```

## Naming Conventions
- Pattern: `{descriptive-kebab-case-name}.md`
- Examples: 
  - standardize-designs-implementation.md
  - git-control-system-rollout.md
  - changelog-management-setup.md

## Required Contents
Each PRP must include:
- Title and creation date
- Link to source design
- Implementation phases with:
  - Prerequisites
  - Step-by-step actions
  - Validation steps
  - Rollback procedures
- Success criteria
- Risk assessment

## Relationship to Other Folders
- **Designs**: Each PRP implements an approved design from `/designs`
- **Features**: PRPs ultimately fulfill feature requests from `/features`
- **Tasks**: PRP execution is tracked in TASK.md
- **Templates**: May reference templates for consistent implementation