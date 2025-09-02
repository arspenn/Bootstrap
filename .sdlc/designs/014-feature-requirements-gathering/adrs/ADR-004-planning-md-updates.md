# ADR-004: PLANNING.md Update Strategy

## Status
Proposed

## Context

The `/gather-project-requirements` command needs to handle both creating new PLANNING.md files and updating existing ones. Bootstrap itself already has a PLANNING.md that would need updating to match any new template format. Additionally, users may have external documents (reports, specs, etc.) that should inform the PLANNING.md generation.

Challenges:
- Preserving valuable existing content during updates
- Handling format migrations gracefully
- Incorporating information from external documents
- Avoiding destructive overwrites
- Maintaining project history

## Decision

We will implement an **argument-based input strategy** for PLANNING.md operations:

1. **No argument**: Create new PLANNING.md through interactive conversation
2. **PLANNING.md as argument**: Update existing file, preserving custom content
3. **Other document as argument**: Use as background context for generation

The command will:
```bash
/gather-project-requirements                    # New from conversation
/gather-project-requirements PLANNING.md        # Update existing
/gather-project-requirements report.pdf         # New from external doc
/gather-project-requirements specs.md           # New from external doc
```

For updates:
- Parse existing PLANNING.md into sections
- Interactive conversation focuses on what to change/add
- Preserve unmapped custom sections
- Create backup before updates (.backup-YYYY-MM-DD)

For external documents:
- Extract key information from provided document
- Use as context during interactive conversation
- Generate new PLANNING.md combining document + conversation

## Consequences

### Positive
- Clear, explicit control through arguments
- Preserves valuable existing documentation
- Leverages external documents effectively
- Non-destructive with backup creation
- Flexible input sources

### Negative
- More complex argument handling logic
- Need to detect and parse different file types
- External document parsing may be imperfect

### Neutral
- Creates different flows based on argument type
- Requires file type detection
- Success depends on document structure/quality
- May need to handle various document formats