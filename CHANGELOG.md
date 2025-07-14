# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
- Documentation moved to separate files in docs/rules/
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

[Unreleased]: https://github.com/user/repo/compare/v0.5.0...HEAD
[0.5.0]: https://github.com/user/repo/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/user/repo/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/user/repo/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/user/repo/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/user/repo/releases/tag/v0.1.0