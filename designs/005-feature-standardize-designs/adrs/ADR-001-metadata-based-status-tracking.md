# ADR-001: Metadata-based Status Tracking

## Status
Proposed

## Context
We need a way to track the lifecycle status of design documents (draft, approved, implementing, completed, archived). The main approaches are:
1. Folder-based: Physically organize designs into status folders
2. Metadata-based: Keep designs in place and track status in file metadata
3. External database: Track status in a separate system

## Decision
We will use YAML frontmatter metadata within each design document to track status and other metadata.

## Consequences

### Positive
- Preserves Git history - files don't move as status changes
- Single source of truth - status lives with the design
- Token efficient - frontmatter is concise
- Supports rich metadata beyond just status
- Works well with static site generators (future possibility)

### Negative
- Status not immediately visible in file browser
- Requires parsing files to determine status
- Developers must remember to update frontmatter

### Neutral
- Requires tooling to aggregate status information
- Similar to Jekyll/Hugo patterns that developers know
- Can be extended with additional fields as needed