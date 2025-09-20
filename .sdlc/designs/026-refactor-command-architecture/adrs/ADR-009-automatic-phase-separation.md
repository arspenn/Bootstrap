# ADR-009: Automatic Phase Separation

## Status
Proposed

## Context
Large designs and implementations often exceed what can be reasonably done in a single DIP or implementation session. Without automatic separation:
- DIPs become overwhelming and unfocused
- Token limits are exceeded
- Error recovery becomes difficult
- Progress tracking loses granularity

## Decision
Commands automatically separate large work into phases and multiple DIPs.

### Design Phase Separation
The `/design` command creates phases when:
- Estimated effort > 1 week
- Component count > 5
- Dependencies suggest natural boundaries
- Multiple architectural layers involved

Output structure:
```
.sdlc/designs/001-feature-name/
├── design.md           # Master design with phase breakdown
├── phase-1-core.md     # Phase-specific details
├── phase-2-integration.md
└── phase-3-polish.md
```

### DIP Generation Strategy
The `/define` command creates separate DIPs based on:

1. **Complexity Threshold**
   - Single DIP: <500 LOC estimated
   - Multiple DIPs: >500 LOC or >3 components

2. **Atomicity Requirements**
   - Keep atomic operations in single DIP
   - Split where natural test boundaries exist
   - Respect transactional boundaries

3. **Output Pattern**
```
.sdlc/implementation/001-feature-name/
├── 001-a-database-schema-dip.md
├── 001-b-api-endpoints-dip.md
├── 001-c-frontend-components-dip.md
└── 001-d-integration-tests-dip.md
```

### Automatic Separation Rules

**For /design command:**
```yaml
if estimated_effort > 5_days OR components > 5:
    create_phases = true
    phase_size = 2-3 days max
    ensure_phase_independence where possible
```

**For /define command:**
```yaml
if design_has_phases:
    one_dip_per_phase minimum
if phase_complexity > threshold:
    split_phase_into_sub_dips
maintain_atomicity_requirements
```

## Consequences

### Positive
- Manageable implementation chunks
- Better error recovery
- More granular progress tracking
- Respects token limits
- Natural pause/resume points

### Negative
- More files to manage
- Need to track dependencies between DIPs
- Potential for inconsistency across phases

### Neutral
- Creates natural review points
- Enables parallel work on independent DIPs
- More commits but clearer history