# ADR-003: Path-Specific Git Status Checks

## Status
Proposed

## Context

When checking if a file operation is safe, we need to run `git status`. We have two options:
1. Run `git status` for the entire repository
2. Run `git status <specific-path>` for only affected files

In large repositories, full status checks can be slow (several seconds), while path-specific checks are much faster.

## Decision

Implement path-specific git status checks:
```bash
# Instead of:
git status --porcelain

# Use:
git status --porcelain -- path/to/file
```

This approach:
- Checks only the paths being operated on
- Scales better with repository size
- Provides focused, relevant information
- Reduces performance impact

## Consequences

### Positive
- Minimal performance impact (<100ms for most operations)
- Scales to large repositories
- More relevant error messages
- Faster user feedback

### Negative
- Might miss repository-wide issues (like merge conflicts)
- More complex implementation
- Multiple status calls for batch operations

### Neutral
- Trade-off between completeness and performance
- Aligns with principle of minimal overhead
- Can be enhanced later if needed