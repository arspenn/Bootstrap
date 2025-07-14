# Templates Folder Structure

## Purpose
This folder contains all project templates used for creating standardized documents, designs, and other project artifacts.

## Structure
```
templates/
├── design-templates/       # Templates for design documents (REQUIRED)
│   ├── feature-design.template.md
│   ├── refactor-design.template.md
│   ├── fix-design.template.md
│   ├── spike-design.template.md
│   ├── system-design.template.md
│   ├── adr.template.md
│   └── README.template.md
└── prp-templates/         # Templates for PRPs (OPTIONAL)
```

## Naming Conventions
- Pattern: `{type}.template.md`
- Examples: 
  - feature-design.template.md
  - adr.template.md
  - prp-standard.template.md

## Required Contents
- All templates must include clear placeholder markers
- Templates should have usage instructions in comments
- Maintain consistent formatting across all templates

## Relationship to Other Folders
- **Designs**: Design templates used when creating new designs
- **PRPs**: PRP templates used for implementation planning
- **.claude**: Claude-specific templates are in `.claude/templates/`, NOT here

## ⚠️ IMPORTANT NOTE ⚠️
**This folder is for PROJECT templates only. Claude-specific templates (rules, commands) belong in `.claude/templates/`.**