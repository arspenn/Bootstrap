## FEATURE: SDLC Directory Consolidation

- Consolidate all Software Development Life Cycle artifacts under a single SDLC/ directory
- Move features/, designs/, PRPs/, responses/, benchmarks/, docs/, and templates/ into SDLC/
- Create SDLC/planning/ for project management files (TASK.md, PLANNING.md, ROADMAP.md)
- Preserve git history for all moved files using git mv
- Update all references and rules to work with new structure
- Make framework easily separable from production code for deployment

## EXAMPLES:

- `.gitignore` patterns that exclude `SDLC/` for production deployments
- `docker/` projects that copy only src/, tests/, and configs
- Similar pattern: `node_modules/` contains dev dependencies separate from source

## DOCUMENTATION:

- [Deployment Best Practices]: https://12factor.net/
- [Project Structure Best Practices]: https://docs.python-guide.org/writing/structure/
- Internal: `.claude/rules/project/` - Project organization rules

## OTHER CONSIDERATIONS:

- **Migration Strategy**: Use git mv to preserve history for all relocated files
- **Rule Updates**: All Bootstrap rules must be updated to reference new paths
- **Command Updates**: Commands (design-feature, generate-prp) must work with new structure
- **Backwards Compatibility**: Consider symlinks temporarily for smooth transition
- **Documentation**: Update all documentation to reflect new structure
- CRITICAL: Preserve all git history during migration

## CONTEXT:

Currently, SDLC artifacts are scattered across the root directory, mixing development process files with production code. This makes it difficult to:
1. Identify what to deploy vs what's for development
2. Create clean production builds
3. Understand project structure for new developers
4. Separate Bootstrap framework from the actual application

By consolidating under SDLC/, we create a clear separation between:
- **SDLC/**: Development process artifacts (can be excluded from production)
- **.claude/**: Bootstrap framework (can be removed after development)
- **src/, tests/, scripts/**: Actual application code (deployed)

## SUCCESS METRICS:

- All SDLC artifacts accessible under single SDLC/ directory
- Git history preserved for all moved files
- All Bootstrap commands and rules work with new structure
- Clear `.gitignore` pattern for excluding SDLC/ from production
- Documentation updated to reflect new structure
- Zero broken references after migration

## OUT OF SCOPE:

- Moving .claude/ directory (framework stays separate)
- Changing production code structure (src/, tests/, scripts/)
- Modifying root configuration files (README.md, LICENSE, etc.)
- Creating deployment automation (future feature)

## PROPOSED STRUCTURE:

```
SDLC/                        # All development lifecycle artifacts
├── features/               # Feature requests and specifications
├── designs/                # Design documents, ADRs, diagrams
├── PRPs/                   # Project Requirements Prompts
├── responses/              # Requirements gathering responses
├── benchmarks/             # Performance and analysis documents
├── docs/                   # Project documentation and ADRs
├── templates/              # Project-specific templates
├── planning/               # Project management
│   ├── TASK.md
│   ├── PLANNING.md
│   └── ROADMAP.md
└── README.md               # Explains SDLC structure

.claude/                     # Bootstrap framework (unchanged)
src/                        # Production source code
tests/                      # Test files
scripts/                    # Utility scripts

# Root files (remain in root):
README.md                   # Project readme
LICENSE                     # License file
CHANGELOG.md               # Change history
CLAUDE.md                  # Claude configuration
requirements.txt           # Dependencies
.gitignore                 # Git ignore patterns
```

## MIGRATION TASKS:

1. Create SDLC/ directory structure
2. Move directories with git mv:
   - features/ → SDLC/features/
   - designs/ → SDLC/designs/
   - PRPs/ → SDLC/PRPs/
   - responses/ → SDLC/responses/
   - benchmarks/ → SDLC/benchmarks/
   - docs/ → SDLC/docs/
   - templates/ → SDLC/templates/
3. Create SDLC/planning/ and move:
   - TASK.md → SDLC/planning/TASK.md
   - PLANNING.md → SDLC/planning/PLANNING.md
   - ROADMAP.md → SDLC/planning/ROADMAP.md
4. Update all internal references
5. Update Bootstrap rules to reference new paths
6. Update Bootstrap commands to work with new structure
7. Create SDLC/README.md explaining the structure
8. Update root README.md to reference new structure
9. Add SDLC/ exclusion pattern to .gitignore example