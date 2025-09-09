# ADR-003: Changelog Integration

## Status
Accepted

## Context
The update command needs to maintain the CHANGELOG.md file according to Keep a Changelog format. We need to decide:
- When to update the changelog (before/after commit)
- How to generate entries (from commit message or file changes)
- How to handle version sections
- Level of user interaction required

The changelog is critical for users to understand what changed between versions, and maintaining it manually is often forgotten or done inconsistently.

## Decision
Update the changelog inline as part of the commit process, using the commit message as the primary source with file change analysis for context.

**Update Flow**:
1. Generate changelog entries BEFORE commit
2. Show proposed changes to user (via Claude Code's edit confirmation)
3. Update CHANGELOG.md with new entries
4. Include changelog update in the same commit

**Entry Generation**:
- Primary source: Commit message (user's description of intent)
- Secondary source: File analysis (what actually changed)
- Categorization: Based on change type (Added, Changed, Fixed, etc.)
- Format: User-focused, not technical implementation details

**Version Handling**:
- If version bump: Move Unreleased to new version section
- If no version bump: Add to Unreleased section
- Add commit hash link to current version header
- Check previous version for missing commit link and add if needed
- Format: `## [0.11.0] - 2025-09-02 [abc123f]`
- Always maintain comparison links at bottom

## Consequences

### Positive
- Changelog always stays up-to-date
- Single atomic commit includes code and changelog
- User reviews changelog entry before commit
- Consistent formatting maintained
- No separate changelog maintenance step

### Negative
- Commit takes longer to complete
- Potential for changelog conflicts in team environment
- Need to parse and modify existing changelog

### Neutral
- Similar to conventional-changelog tools
- Follows Keep a Changelog standard
- Single source of truth for changes

## Implementation Notes

### Example Changelog Update
```markdown
## [Unreleased]

## [0.11.0] - 2025-09-02 [f3a4b5c](https://github.com/user/repo/commit/f3a4b5c)

### Added
- Update command for unified staging, changelog, and commit workflow
- Intelligent version detection based on changes
- Batch file processing with safety checks

### Changed
- Improved commit workflow to include automatic changelog updates

## [0.10.0] - 2025-09-01 [7fe95ab](https://github.com/user/repo/commit/7fe95ab)
<!-- Previous version updated with commit link if it was missing -->
```

### Entry Generation Rules
1. Use active voice ("Add" not "Added" in commit, but "Added" in changelog)
2. Focus on user impact, not implementation
3. Group related changes together
4. Keep entries concise but complete
5. Include command names and feature names

### Categorization Mapping
- `feat:` → Added
- `fix:` → Fixed
- `docs:` → Changed (if user-facing)
- `refactor:` → Changed (if user-visible)
- `perf:` → Changed
- `chore:` → Usually omitted unless user-impacting
- `breaking:` → Changed with BREAKING CHANGE note