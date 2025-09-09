# ADR-001: Batch Processing Strategy

## Status
Accepted

## Context
The update command needs to handle potentially large numbers of file changes efficiently while maintaining safety and user understanding. We need to decide between:
- Bulk operations (git add . or git add -A) for speed
- Individual file operations for safety and control
- Some hybrid approach that balances both concerns

The git-add-safety rule explicitly forbids wildcard operations, but processing hundreds of files individually could be slow and provide poor user experience.

Additionally, Claude Code's confirmation mechanism shows a single approval dialog per command execution, so we need to optimize for minimal user interruption while maintaining clarity.

## Decision
Process files in intelligent groups for staging while respecting git safety rules and minimizing user confirmations.

**Staging Strategy**:
- Use single git add commands with multiple explicit file paths when logical
- Example: `git add file1.md file2.md file3.md` (single confirmation)
- NOT: `git add .` or `git add -A` (forbidden by safety rules)
- NOT: Multiple individual `git add file1.md` commands (too many confirmations)

**Grouping Logic**:
- Group files by logical relationship for single command execution
- Example groups:
  - All documentation updates: `git add README.md CHANGELOG.md docs/*.md`
  - Related feature files: `git add src/feature.py tests/test_feature.py`
  - Configuration changes: `git add .claude/config.yaml .claude/rules/*.md`

**User Confirmation**:
- Claude Code shows ONE confirmation dialog per git command
- The description must clearly summarize what's being staged
- Example: "Staging 5 documentation files including README and CHANGELOG updates"

## Consequences

### Positive
- Maintains compliance with git-add-safety rule (no wildcards)
- Minimizes user confirmation dialogs
- Efficient execution with fewer git commands
- User understands changes through clear descriptions
- Logical grouping helps contextualize changes

### Negative
- Must build explicit file lists (no wildcards)
- Need intelligent grouping logic
- Description must be comprehensive for user trust

### Neutral
- Similar to how IDEs handle batch operations
- Balances safety with usability
- Single confirmation per logical group maintains flow

## Implementation Notes

```bash
# Good - Single command, single confirmation
git add src/update-command.md tests/test-update.md docs/update-guide.md

# Bad - Multiple confirmations
git add src/update-command.md
git add tests/test-update.md
git add docs/update-guide.md

# Forbidden - Wildcard
git add .
git add *.md
```

The command description shown to user should be:
- Concise but complete
- Indicate the number and type of files
- Mention any important files explicitly
- Example: "Staging 12 files: 3 new commands, 5 rule updates, 4 documentation changes"