# ADR-006: CHARTER.md Governance and Flexibility

## Status
Proposed

## Context
PLANNING.md is overloaded with multiple responsibilities. We need a focused principles document that:
- All commands reference for foundational context
- Remains stable once established
- Allows for prototype/experimental work
- Can evolve through deliberate process, not casual edits

## Decision
Replace PLANNING.md with CHARTER.md that has three operational modes:

### 1. Prototype Mode (Default)
```yaml
status: prototype
stability: experimental
sections:
  purpose: optional
  principles: optional
  success_metrics: optional
  governance: optional
```
- Allows partial completion
- Commands work with whatever exists
- No modification restrictions

### 2. Draft Mode
```yaml
status: draft
stability: evolving
last_modified: date
review_needed: true
```
- All sections present but may change
- Commands warn about draft status
- Modifications require justification comment

### 3. Ratified Mode
```yaml
status: ratified
stability: stable
ratified_date: date
version: 1.0.0
```
- Considered stable and official
- Modifications require formal amendment process
- Commands treat as authoritative

## Amendment Process for Ratified Charters

1. **Proposal Phase**
   - Create `.sdlc/amendments/###-proposed-charter-change.md`
   - Document what changes and why
   - Impact analysis on existing designs/code

2. **Implementation**
   - `/design amendment-###` creates implementation plan
   - Changes applied to `CHARTER-draft.md`
   - Original remains unchanged during review

3. **Ratification**
   - Replace CHARTER.md with new version
   - Increment version number
   - Archive old version in `.sdlc/charters/archive/`

## Command Integration

All 4D commands must:
```yaml
/determine:
  - Read CHARTER.md status
  - If prototype: proceed with available sections
  - If draft: warn about stability
  - If ratified: treat as canonical

/design:
  - Validate against charter principles
  - Flag any conflicts
  - Suggest charter amendment if needed

/define:
  - Ensure implementation aligns with charter
  - Include charter version in DIP metadata

/do:
  - Final check against charter before implementation
```

## Consequences

### Positive
- Clear governance model for project principles
- Supports both experimentation and production
- Traceable evolution of project vision
- Commands have stable foundation when needed

### Negative
- Additional complexity in command logic
- More process for mature projects
- Risk of charter drift if not maintained

### Neutral
- Similar to version control for project vision
- Parallels constitutional amendment processes
- Provides flexibility spectrum rather than binary choice