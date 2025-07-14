# Features Folder Structure

## Purpose
This folder contains feature request documents that describe desired functionality before design and implementation.

## Structure
```
features/
├── FEATURE_{NAME}.md    # Feature request document (REQUIRED)
└── archive/            # Completed features (OPTIONAL)
```

## Naming Conventions
- Pattern: `FEATURE_{SCREAMING_SNAKE_CASE}.md`
- Examples: 
  - FEATURE_TASK_MANAGEMENT.md
  - FEATURE_GIT_CONTROL.md

## Required Contents
Each feature file must include:
- FEATURE section with bullet points
- EXAMPLES section with references
- DOCUMENTATION section with relevant links
- OTHER CONSIDERATIONS section
- CONTEXT section (optional)

## Relationship to Other Folders
- **Designs**: Features lead to designs in `/designs`
- **PRPs**: Designs lead to PRPs in `/PRPs`
- **Tasks**: Implementation tracked in TASK.md