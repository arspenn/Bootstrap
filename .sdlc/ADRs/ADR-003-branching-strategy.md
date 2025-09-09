# ADR-003: Git Branching Strategy

## Status
Accepted

## Context
The project needs a clear branching strategy that:
- Supports feature development
- Maintains a stable main branch
- Is simple for users from novice to expert
- Provides clear naming conventions
- Integrates well with GitHub pull requests

The requirement specifies: "Name branches after the feature and the version of the main branch at the time of the branch."

## Decision
We will use a simplified feature branch workflow with the following conventions:

Branch Naming: `<type>/<feature-name>-<base-version>`

Where:
- `<type>` is one of: feature, fix, docs, refactor
- `<feature-name>` is a kebab-case description
- `<base-version>` is the short commit hash of main when branched

Example: `feature/git-rules-v1-b8964e0`

Workflow:
1. All development happens in feature branches
2. Feature branches are created from main
3. Changes are integrated via pull requests
4. Main branch remains stable and deployable

## Consequences

### Positive
- **Traceability**: Branch names include base version for easy tracking
- **Simplicity**: Single workflow pattern for all changes
- **Safety**: Main branch protected from direct commits
- **Clarity**: Descriptive names indicate purpose and origin

### Negative
- **Branch Name Length**: Names can become long with feature descriptions
- **Manual Versioning**: Developers must include base version

### Neutral
- **No Release Branches**: Simplified workflow may need enhancement for formal releases
- **Linear History**: Encourages frequent integration to avoid conflicts