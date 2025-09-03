# ADR-003: File Organization Strategy

## Status
Accepted

## Context
Insights need to be saved in a way that makes them easy to find, browse, and share. Options considered:

1. **Hierarchical by type**: `exports/insights/{bug|enhancement|limitation}/YYYY-MM-DD-title.md`
2. **Flat with date prefix**: `exports/insights/YYYY-MM-DD-title.md`
3. **Sequential numbering**: `exports/insights/001-title.md`
4. **Category prefix**: `exports/insights/bug-YYYY-MM-DD-title.md`

Key considerations:
- Chronological browsing (see what was discovered when)
- Easy sorting and finding recent insights
- Simple to implement and maintain
- Clear at a glance

## Decision
Use flat directory structure with date prefixes: `exports/insights/YYYY-MM-DD-{title-slug}.md`

## Consequences

### Positive
- **Chronological ordering**: Natural sort shows timeline of discoveries
- **Simple browsing**: One directory to check
- **Easy recent access**: Latest insights appear at bottom
- **Cross-category view**: See all insights together
- **Simple implementation**: No subdirectory management

### Negative
- **May accumulate many files**: Directory could get crowded over time
- **No automatic grouping**: Can't easily see all bugs together
- **Manual categorization**: Must open file to see type

### Neutral
- Can add search/filter tools later if needed
- File naming includes descriptive slug for context
- Category is in file metadata, can grep if needed
- Could migrate to subdirectories later if volume demands