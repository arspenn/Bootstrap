# ADR-010: 4D+1 Workflow Architecture

## Status
ACCEPTED

## Context
Bootstrap evolved from a collection of Git safety rules to a comprehensive project management framework. The original workflow relied on scattered commands (`/design-feature`, `/generate-prp`, `/execute-prp`) that lacked cohesion and required extensive rule loading. This approach hit fundamental token limitations and provided poor user experience.

The spec-kit project demonstrated that simple, memorable workflows could guide complex projects effectively, but lacked Bootstrap's safety mechanisms and depth.

## Decision
We adopt the **4D+1 Workflow** as Bootstrap's core architecture:

```
/init (once) → /determine → /design → /define → /do
                    ↑__________________________|
                    (cycle for each feature)
```

Each command:
1. Is self-contained with embedded rules (no external loading)
2. Follows section-by-section interaction for user feedback
3. Leverages multi-agent orchestration for comprehensive analysis
4. Uses deterministic scripts for critical operations
5. Produces structured artifacts in `.sdlc/` directories

## Rationale

### Why 4D+1?
- **Memorable**: Five simple verbs starting with 'D' (plus init)
- **Progressive**: Each phase builds on the previous
- **Universal**: Pattern applies beyond software (health, policy, events)
- **Complete**: Covers entire project lifecycle

### Command Philosophy
- **Init**: One-time setup establishing project charter
- **Determine**: What needs to be built (requirements)
- **Design**: How to build it (architecture)
- **Define**: Detailed implementation plan (DIPs)
- **Do**: Execute the plan (implementation)

## Consequences

### Positive
- Self-contained execution (no rule loading failures)
- Works immediately without setup
- Clear progression through project phases
- Supports iteration and refinement
- Enables domain adaptation beyond SDLC

### Negative
- Commands are large (~600-1600 tokens each)
- Requires migration from old commands
- More opinionated workflow than before
- Initial learning curve for the pattern

### Neutral
- Commands become larger but self-contained
- Shifts complexity from rules to commands
- Templates become critical for consistency

## Trade-offs
We accept larger command sizes (600-1600 tokens) in exchange for:
- Guaranteed execution without rule loading
- Complete context in each command
- No dependency on MASTER_IMPORTS.md working
- Embedded safety and best practices

## Implementation Notes
- Commands live in `.claude/commands/`
- Each command is 200-400 lines of structured markdown
- Supporting scripts in `.claude/scripts/` for deterministic operations
- Templates in `.claude/templates/` for artifact generation

## References
- Design document: `.sdlc/designs/026-refactor-command-architecture/design.md`
- Related ADRs from design: `.sdlc/designs/026-refactor-command-architecture/adrs/`

---
*Decided on: 2024-09-24*
*Decided by: Bootstrap Development Team*