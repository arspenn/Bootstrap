# ADR-002: Git Commit Message Standards

## Status
Accepted

## Context
The project needs standardized commit messages for consistency and automation. Requirements include:
- Messages must be highly informative but concise
- Character limit of 250 (recommended) to 2000 (maximum)
- Must integrate with GitHub
- Should follow industry standards
- Need to support future automation (CI/CD, changelog generation)

## Decision
We will adopt the Conventional Commits v1.0.0 standard (https://www.conventionalcommits.org/) with the following specifications:

Format: `<type>(<scope>): <subject>`

Types:
- feat: New feature
- fix: Bug fix
- docs: Documentation changes
- style: Code style changes (formatting, etc.)
- refactor: Code refactoring
- test: Test additions or modifications
- chore: Maintenance tasks
- perf: Performance improvements
- ci: CI/CD changes
- build: Build system changes

The scope is optional but recommended for clarity.

## Consequences

### Positive
- **Automation Ready**: Supports automatic changelog generation
- **GitHub Integration**: Works well with GitHub's commit parsing
- **Industry Standard**: Widely adopted and understood
- **Clear Categories**: Easy to understand commit purposes
- **Searchable**: Consistent format enables effective git log searching

### Negative
- **Learning Required**: Users must learn the convention
- **Initial Friction**: May slow down initial commits

### Neutral
- **Enforcement**: Requires tooling or discipline to maintain consistency
- **Flexibility**: Standard allows for project-specific extensions