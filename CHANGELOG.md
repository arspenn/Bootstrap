# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.7.0] - 2025-08-30

### Added
- **Enhanced Task Management System** - Structured task tracking with metadata
  - Created task-management rule for enforcing TASK.md format
  - Created task-discovery rule for tracking work discovered during implementation  
  - Created task-commit-integration rule for linking commits to tasks
  - Added 4 task commands: `/task-add`, `/task-update`, `/task-summary`, `/task-audit`
  - Added task templates (task.template.md, task-commit.template.md, task-discovered.template.md)
  - Implemented sequential task ID system (TASK-XXX format)

- **Rule Loading Command** - Dynamic rule loading and context management
  - Created `/load-rules` command for refreshing rule context
  - Provides loading reports with success/failure counts
  - Supports graceful degradation for missing rules

### Changed
- **TASK.md Structure** - Migrated to enhanced structured format
  - Reorganized ~120 tasks from unstructured list to structured format with metadata
  - Tasks now organized by status (Current/Backlog/Completed) and priority levels
  - Each task includes Priority, Created date, Estimate, and Status fields
  - Consolidated duplicate sections and removed redundant items

- **Git Commit Format** - Enhanced for task integration
  - Updated subject line limit from 50 to 250 characters
  - Added task reference support in commit footers (Completed: TASK-XXX, Refs: TASK-XXX)

### Fixed
- MASTER_IMPORTS.md updated to include new task-related rules
- Identified and documented already-implemented items from legacy task list
- Reorganized miscellaneous tasks into appropriate categories

### Developer Experience
- Systematic task tracking with unique IDs prevents duplicates
- Task discovery during implementation is now standardized
- Git commits can reference tasks for better traceability
- Migration tool (`/task-audit --migrate`) preserves task history

## [0.6.0] - 2025-08-28

### Added
- **Framework Documentation Separation** - Complete reorganization of documentation
  - Created `.claude/docs/` as central location for all framework documentation
  - Added 5 core framework guides (getting-started, configuration, rule-system, command-system, workflow)
  - Added 5 framework templates for rules, commands, and configuration
  - Created comprehensive documentation index at `.claude/docs/README.md`
- **CLAUDE.md Standardization** - Transformed into minimal rule loader (170 lines from 600+)
  - Extracted all rules to modular `.claude/rules/` system
  - Created `.claude/config.yaml` for centralized configuration
  - Implemented MASTER_IMPORTS.md for rule management
  - Enhanced AI behavior rules with specific validation patterns
- **Git Rules Alignment** - Standardized all git rules to consistent format
  - Added comprehensive rule metadata (priority, security level, token impact)
  - Implemented dual-structure: concise rules + detailed documentation
  - Created rule templates for consistency
- **ADR Standardization** - Established consistent ADR format and numbering
  - Created ADR index for navigation
  - Added ADR template for future decisions
  - Documented key architectural decisions (ADR-008, ADR-009)

### Changed
- **Documentation Structure** - Moved all rule documentation from `/docs/rules/` to `.claude/docs/rules/`
  - Preserved git history for all 20 moved files
  - Updated all references throughout codebase
  - Removed empty directories after migration
- **Rule System** - Enhanced with comprehensive metadata and configuration
  - All rules now include priority levels (0-1000)
  - Added security levels (Critical, High, Medium, Low)
  - Implemented token impact tracking
  - Added dependency management between rules

### Fixed
- Rule documentation references now correctly point to `.claude/docs/rules/`
- Test files updated to validate new documentation structure
- Consistent formatting across all rule files

### Developer Experience
- Clear separation between framework documentation (reusable) and project documentation (specific)
- Bootstrap framework now fully self-contained in `.claude/` directory
- Improved token efficiency through concise rule structure
- Comprehensive templates for creating new rules and commands

## [0.5.0] - 2025-07-14

### Added
- Critical git-safe file operations rule system to prevent accidental data loss
  - Intercepts rm, rmdir, and mv commands on tracked files
  - Suggests git-safe alternatives (git rm, git mv)
  - Blocks operations on files with uncommitted changes
  - Provides --force-unsafe override for advanced users
- Comprehensive design documentation (007-feature-git-safe-file-operations)
  - ADR-001: No automatic fallback to unsafe operations
  - ADR-002: Medium security level for user override capability
  - ADR-003: Path-specific git status checks for performance
- Integration documentation for git-safe file operations
- Migration guide for updating project documentation to use git-safe commands
- Test scenarios for validating git-safe operations
- Design structure standardization rule for consistent design folders

### Changed
- Design folder structure standardized to `{sequence}-{type}-{description}/` format
- Existing designs migrated to new numbered structure:
  - 001-feature-git-control
  - 002-feature-claude-memory
  - 003-feature-changelog-management
  - 004-system-standards-documentation
  - 005-feature-standardize-designs
  - 006-feature-analyze-command
  - 007-feature-git-safe-file-operations

### Security
- Default file operations now use git-safe commands to prevent accidental deletion of tracked files with uncommitted changes

## [0.4.0] - 2025-07-12

### Added
- Comprehensive changelog management system with semi-automated approach ([7938310](../../commit/7938310))
- Project management rules for changelog updates, format validation, and version management
- Test file location rule to ensure tests are properly organized
- Changelog entry template for consistent changelog entries
- ROADMAP.md outlining 10-phase development plan for comprehensive AI framework
- CREDITS.md acknowledging key inspirations and dependencies
- ADR-006 documenting pivot to comprehensive framework vision
- ADR-007 documenting semi-automated changelog approach
- Initial designs for Git merge control feature

### Changed
- README.md updated to reflect Bootstrap as comprehensive AI development framework
- Template files standardized to use .template extension
- Git documentation updated with clickable rule definition links

## [0.3.0] - 2025-07-12

### Added
- Claude memory integration using @import mechanism ([fd47d3b](../../commit/fd47d3b))
- MASTER_IMPORTS.md for centralized rule management
- Comprehensive token usage benchmarks showing 83.6% reduction
- Separation of rule instructions from documentation

### Changed
- Rule files restructured to contain only direct instructions
- Documentation moved to separate files in .claude/docs/rules/
- Token overhead reduced from 5,400 to 900 tokens

## [0.2.0] - 2025-07-12

### Added
- Comprehensive Git control rules system ([c9d297b](../../commit/c9d297b))
  - git-add-safety: Prevents accidental staging of sensitive files
  - git-commit-format: Enforces Conventional Commits standard
  - git-push-validation: Pre-push safety checks
  - git-pull-strategy: Smart pull and rebase strategies
  - git-branch-naming: Structured branch naming conventions
- User preferences system for rule configuration
- Commit message and branch name templates
- Comprehensive rule documentation
- ADR-001 through ADR-005 documenting architectural decisions

### Changed
- Project scope expanded from simple Git rules to comprehensive AI framework

### Fixed
- Security model updated to allow user preference overrides ([ad87b9f](../../commit/ad87b9f))

## [0.1.0] - 2025-07-11

### Added
- Initial Bootstrap template structure ([b8964e0](../../commit/b8964e0))
- Design-first workflow with commands:
  - design-feature: Create comprehensive feature designs
  - generate-prp: Generate implementation blueprints
  - execute-prp: Execute implementation with validation
- CLAUDE.md for AI development conventions
- PLANNING.md for project architecture
- TASK.md for task management
- Feature template system
- Virtual environment support
- Basic project structure and workflows

[Unreleased]: https://github.com/user/repo/compare/v0.7.0...HEAD
[0.7.0]: https://github.com/user/repo/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/user/repo/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/user/repo/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/user/repo/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/user/repo/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/user/repo/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/user/repo/releases/tag/v0.1.0