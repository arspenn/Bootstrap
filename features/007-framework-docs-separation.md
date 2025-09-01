## FEATURE: Framework Documentation Separation

- Separate Bootstrap framework documentation from project implementation documentation
- Establish .claude/ as the single source of truth for framework documentation
- Move all framework-specific guides, rules, and technical docs to .claude/docs/
- Keep project implementation documentation (ADRs, designs, PRPs) in main project folders
- Create clear boundaries between "how to use the framework" vs "what we built with it"
- Implement proper cross-referencing system between framework and project docs

## EXAMPLES:

- `.claude/docs/framework/` - Framework usage guides, rule explanations, configuration docs
- `.claude/rules/` - Already properly separated rule definitions
- `docs/ADRs/` - Project-specific architectural decisions (keep in main project)
- `designs/` - Project feature designs (keep in main project)
- Similar pattern: VSCode's `.vscode/` contains editor config while project docs remain in root

## DOCUMENTATION:

- [Conventional Documentation Structure]: https://www.writethedocs.org/guide/docs-as-code/
- [Framework vs Project Documentation]: https://documentation.divio.com/
- Internal patterns: `.claude/README.md` (framework overview)
- Internal patterns: `docs/README.md` (project documentation overview)

## OTHER CONSIDERATIONS:

- Migration strategy for existing mixed documentation
- Backward compatibility with existing references
- Clear naming conventions to avoid confusion
- Search and discovery - ensure both doc sets are easily findable
- Integration with CLAUDE.md rule loading system
- CRITICAL: Maintain clear separation - framework docs explain "how to use Bootstrap", project docs explain "what we built"

## CONTEXT:

Currently, documentation is mixed between framework usage (how to use Bootstrap's features) and project implementation (what we're building). This creates confusion about:
- What is part of the reusable framework vs specific to this project
- Where to look for framework guides vs project decisions
- What documentation to include when Bootstrap is used as a template

The Bootstrap framework is intended to be a reusable software engineering framework. Its documentation should be self-contained within .claude/ so that when projects use Bootstrap as a template, they get all framework documentation but can maintain their own project documentation separately.

## SUCCESS METRICS:

- Clear delineation: Can instantly identify if a doc is framework or project-specific
- Portability: .claude/ folder contains everything needed to understand the framework
- No duplication: Each piece of information has one canonical location
- Easy navigation: Users can find what they need without confusion
- Template-ready: New projects using Bootstrap get complete framework docs

## OUT OF SCOPE:

- Changing the existing rule structure (already well-organized in .claude/rules/)
- Modifying CLAUDE.md or rule loading mechanisms
- Creating new documentation content (focus on reorganization)
- Changing project documentation structure (docs/, designs/, PRPs/ remain as-is)

## PROPOSED STRUCTURE:

```
.claude/
├── docs/                      # All framework documentation
│   ├── framework/            # How to use Bootstrap framework
│   │   ├── getting-started.md
│   │   ├── configuration.md
│   │   ├── rule-system.md
│   │   └── commands.md
│   ├── guides/              # Step-by-step guides
│   │   ├── creating-features.md
│   │   ├── writing-rules.md
│   │   └── prp-workflow.md
│   └── reference/           # Technical reference
│       ├── rule-metadata.md
│       ├── config-schema.md
│       └── api.md
├── rules/                   # Rule definitions (already organized)
├── commands/                # Command definitions (already organized)
├── config.yaml             # Framework configuration
├── MASTER_IMPORTS.md       # Rule import manifest
└── README.md               # Framework overview

Project Root/
├── docs/                   # Project-specific documentation
│   ├── ADRs/              # Architectural decisions for this project
│   └── ...
├── designs/               # Feature designs for this project
├── PRPs/                  # Project refactoring plans
├── features/              # Feature requests for this project
└── responses/             # Design responses and discussions
```

## MIGRATION TASKS:

1. Audit existing documentation to categorize as framework vs project
2. Create .claude/docs/ structure with framework/, guides/, and reference/ subdirectories
3. Move framework documentation from project folders to .claude/docs/
4. Update all internal references and links
5. Create index files for easy navigation
6. Update CLAUDE.md to reference new documentation structure
7. Add README files explaining the documentation organization
8. Test that rule loading and imports still work correctly
9. Verify no broken links or missing references
10. Document the new structure in .claude/docs/framework/documentation-structure.md