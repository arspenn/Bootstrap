# .claude Folder Structure

## Purpose
This folder contains Claude-specific configuration, rules, and system files that guide Claude Code's behavior when working with this project.

## Structure
```
.claude/
├── MASTER_IMPORTS.md       # Master list of rule imports (REQUIRED)
├── rules/                  # Rule definitions (REQUIRED)
│   ├── git/               # Git-related rules
│   ├── project/           # Project management rules
│   ├── testing/           # Testing rules
│   └── documentation/     # Documentation rules
├── templates/              # Claude-specific templates (OPTIONAL)
│   ├── rule.template.md   # Template for new rules
│   └── command.template.md # Template for new commands
└── memory/                 # Claude memory files (OPTIONAL)
```

## Naming Conventions
- Pattern: `{category}-{specific-rule}.md`
- Examples: 
  - git-commit-format.md
  - project-changelog-update.md
  - testing-coverage-requirements.md

## Required Contents
- MASTER_IMPORTS.md must list all active rules
- Each rule file must be self-contained and actionable
- Rules should be specific and enforceable

## Claude Templates vs Project Templates
- **Claude Templates** (in `.claude/templates/`): For creating new rules, commands, and Claude-specific configurations
- **Project Templates** (in `/templates/`): For creating project artifacts like designs, features, etc.

## Relationship to Other Folders
- **CLAUDE.md**: The root file imports MASTER_IMPORTS.md
- **All Folders**: Rules apply to all project activities
- **Templates**: Project templates are in `/templates`, NOT in `.claude`

## ⚠️ IMPORTANT NOTE ⚠️
**Project-specific templates (designs, features, etc.) belong in the root `/templates` folder, NOT in `.claude/templates/`. The `.claude/templates/` folder is only for Claude-specific templates like rule and command templates.**