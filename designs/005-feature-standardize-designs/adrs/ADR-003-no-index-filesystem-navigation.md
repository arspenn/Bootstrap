# ADR-003: No Index File - Direct Filesystem Navigation

## Status
Proposed

## Context
We need an efficient way for Claude Code to find and track designs. Options considered:
1. Markdown README with manual updates
2. JSON index file
3. YAML index file
4. SQLite database
5. No index - rely on filesystem structure and naming conventions

## Decision
We will NOT use any index file. Instead, we rely on:
- Clear naming conventions (`{sequence}-{type}-{description}/`)
- YAML frontmatter in each design for metadata
- README.md files documenting folder structures
- Claude Code's ability to navigate filesystem patterns

## Consequences

### Positive
- No merge conflicts from index files
- No need to regenerate indexes
- Simpler implementation (no indexing tools needed)
- Single source of truth (the files themselves)
- Claude Code can directly navigate using patterns
- No synchronization issues between index and files

### Negative
- Must scan directories to find all designs
- Slightly slower to get aggregate statistics
- Requires consistent naming discipline

### Neutral
- Similar to how developers naturally browse filesystems
- Can still generate reports by scanning when needed
- Aligns with "convention over configuration" principle