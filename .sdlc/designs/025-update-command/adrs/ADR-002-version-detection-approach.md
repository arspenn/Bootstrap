# ADR-002: Version Detection Approach

## Status
Accepted

## Context
The update command needs to determine when and how to bump the project version. Users may provide:
- Explicit version directives (e.g., "--version major" or "v2.0.0")
- Brief descriptions that hint at version changes (e.g., "breaking change to API")
- No version information at all

We need a system that can intelligently suggest version bumps while respecting user intent and maintaining semantic versioning principles.

## Decision
Implement a multi-layered version detection system that analyzes both user input and actual file changes to suggest appropriate version bumps.

**Detection Hierarchy**:
1. Explicit version in input (highest priority)
   - Direct version: "v1.2.0" → use exactly
   - Version type: "--version major" → bump accordingly
   
2. Keywords in brief description (medium priority)
   - "breaking" → suggest major
   - "feature", "add" → suggest minor
   - "fix", "patch" → suggest patch
   
3. File change analysis (fallback)
   - Analyze actual changes to detect patterns
   - Look for API changes, new features, bug fixes
   - Use Claude's understanding of code impact

**User Interaction**:
- Always show version suggestion in summary
- Allow user to modify before commit
- Never force a version bump without confirmation
- Default to patch if uncertain

## Consequences

### Positive
- Intelligent suggestions reduce cognitive load
- Respects explicit user intent
- Learns from actual changes, not just descriptions
- Maintains semantic versioning standards
- User maintains full control

### Negative
- May occasionally suggest incorrect version
- Requires code analysis capabilities
- Adds complexity to the command

### Neutral
- Similar to how npm version works
- Provides automation with escape hatches
- Transparent about reasoning

## Implementation Examples

```python
# Input: "fix: resolve login timeout issue"
# Changes: Modified auth.py (bug fix)
# Suggestion: "patch" (0.10.1 → 0.10.2)

# Input: "major refactor of command system"
# Changes: Deleted old commands, new structure
# Suggestion: "major" (0.10.1 → 1.0.0)

# Input: "add insight capture"
# Changes: New command file, new feature
# Suggestion: "minor" (0.10.1 → 0.11.0)
```

## Version Detection Heuristics

### Major (Breaking Changes)
- Deleted public APIs or commands
- Changed command signatures
- Incompatible configuration changes
- Explicit "breaking" in message

### Minor (New Features)
- New commands added
- New configuration options
- New capabilities
- "feat" or "add" in message

### Patch (Bug Fixes)
- Bug fixes
- Documentation updates
- Internal refactoring
- "fix" in message or small changes