# ADR-002: Sequential Numbering Scheme

## Status
Proposed

## Context
We need a consistent way to identify and order designs. Options considered:
1. Date-based: YYYY-MM-DD-feature-name
2. Sequential: 001-feature-name
3. UUID-based: Random unique identifiers
4. Category-based: feature/task-management

## Decision
We will use sequential three-digit numbering with type prefix: `{sequence}-{type}-{description}/`

Example: `001-feature-task-management/`

## Consequences

### Positive
- Easy to reference in conversation ("design 001")
- Clear chronological ordering
- Simple to determine next number
- Short paths that are Git-friendly
- Type prefix aids categorization

### Negative
- Doesn't indicate when design was created
- Potential conflicts if multiple people create designs simultaneously
- No inherent grouping of related designs

### Neutral
- Requires maintaining sequence counter
- Similar to ADR numbering patterns
- Can add date to frontmatter for time tracking