---
name: "Design Phase Template"
description: "Template for breaking large designs into manageable phases"
---

# Design Phase: [DESIGN_NAME] - Phase [PHASE_NUMBER]

## Phase Overview

**Parent Design:** [PARENT_DESIGN_PATH]
**Total Phases:** [TOTAL_PHASES]
**Current Phase:** [PHASE_NUMBER] of [TOTAL_PHASES]
**Phase Duration:** [ESTIMATED_DAYS] days
**Complexity:** [HIGH/MEDIUM/LOW]

### Phase Purpose
[What this phase specifically accomplishes within the larger design]

### Phase Dependencies
- **Depends On:** Phase [PREVIOUS_PHASES] (if applicable)
- **Enables:** Phase [SUBSEQUENT_PHASES] (if applicable)
- **External Dependencies:** [EXTERNAL_DEPENDENCIES]

## Phase Scope

### Components in This Phase
- [COMPONENT_1]: [DESCRIPTION]
- [COMPONENT_2]: [DESCRIPTION]
- [COMPONENT_3]: [DESCRIPTION]

### Deferred to Later Phases
- [DEFERRED_COMPONENT_1] → Phase [TARGET_PHASE]
- [DEFERRED_COMPONENT_2] → Phase [TARGET_PHASE]

## Technical Design for This Phase

### Architecture Components

#### Component 1: [COMPONENT_NAME]
**Purpose:** [COMPONENT_PURPOSE]
**Interfaces:**
```[LANGUAGE/FORMAT]
[INTERFACE_DEFINITION]
```
**Key Design Decisions:**
- [DECISION_1]: [RATIONALE]
- [DECISION_2]: [RATIONALE]

#### Component 2: [COMPONENT_NAME]
**Purpose:** [COMPONENT_PURPOSE]
**Interfaces:**
```[LANGUAGE/FORMAT]
[INTERFACE_DEFINITION]
```
**Key Design Decisions:**
- [DECISION_1]: [RATIONALE]
- [DECISION_2]: [RATIONALE]

### Data Model Changes
```[LANGUAGE/FORMAT]
[DATA_MODEL_DEFINITIONS]
```

### API Contracts
```[FORMAT]
[API_SPECIFICATIONS]
```

## Implementation Strategy

### Build Order
1. [COMPONENT_1] - Foundation component
2. [COMPONENT_2] - Depends on Component 1
3. [COMPONENT_3] - Depends on Components 1, 2
4. Integration points
5. Testing harness

### Critical Path
[Describe the critical path in prose - what must be done in sequence vs what can be parallelized]

### Parallel Work Streams
- **Stream A:** [WORK_DESCRIPTION]
  - Owner: [OWNER]
  - Duration: [DAYS]

- **Stream B:** [WORK_DESCRIPTION]
  - Owner: [OWNER]
  - Duration: [DAYS]

## Phase Validation

### Exit Criteria
Phase is complete when:
- [ ] All components implemented
- [ ] Unit tests passing (>=[COVERAGE]% coverage)
- [ ] Integration tests passing
- [ ] Performance benchmarks met
- [ ] Documentation updated
- [ ] Design review completed

### Test Strategy
- **Unit Tests:** [TEST_APPROACH]
- **Integration Tests:** [TEST_APPROACH]
- **Performance Tests:** [TEST_APPROACH]
- **User Acceptance:** [TEST_APPROACH]

### Quality Gates
| Gate | Criteria | Measurement |
|------|----------|-------------|
| Code Quality | [CRITERIA] | [HOW_MEASURED] |
| Performance | [CRITERIA] | [HOW_MEASURED] |
| Security | [CRITERIA] | [HOW_MEASURED] |

## Risk Management

### Phase-Specific Risks
1. **[RISK_NAME]**
   - Probability: [HIGH/MEDIUM/LOW]
   - Impact: [HIGH/MEDIUM/LOW]
   - Mitigation: [MITIGATION_STRATEGY]
   - Trigger: [WHAT_TO_WATCH]

2. **[RISK_NAME]**
   - Probability: [HIGH/MEDIUM/LOW]
   - Impact: [HIGH/MEDIUM/LOW]
   - Mitigation: [MITIGATION_STRATEGY]
   - Trigger: [WHAT_TO_WATCH]

### Contingency Plans
If [RISK_EVENT] occurs:
1. [CONTINGENCY_ACTION_1]
2. [CONTINGENCY_ACTION_2]
3. [CONTINGENCY_ACTION_3]

## Resource Requirements

### Team Allocation
- **Lead:** [PERSON/ROLE] - [ALLOCATION]%
- **Developer 1:** [PERSON/ROLE] - [ALLOCATION]%
- **Developer 2:** [PERSON/ROLE] - [ALLOCATION]%
- **QA:** [PERSON/ROLE] - [ALLOCATION]%

### Technical Resources
- [RESOURCE_1]: [SPECIFICATION]
- [RESOURCE_2]: [SPECIFICATION]

### Budget Impact
- Development: [HOURS/COST]
- Infrastructure: [COST]
- Tools/Licenses: [COST]

## Phase Timeline

### Milestones
| Milestone | Target Date | Actual Date | Status |
|-----------|-------------|-------------|---------|
| Phase Kickoff | [DATE] | [DATE] | [STATUS] |
| Design Complete | [DATE] | [DATE] | [STATUS] |
| Implementation Complete | [DATE] | [DATE] | [STATUS] |
| Testing Complete | [DATE] | [DATE] | [STATUS] |
| Phase Handoff | [DATE] | [DATE] | [STATUS] |

### Daily Targets
- Day 1-2: [TARGETS]
- Day 3-4: [TARGETS]
- Day 5-6: [TARGETS]
- Day 7+: [TARGETS]

## Interfaces & Integration

### APIs Exposed This Phase
```[FORMAT]
[API_DEFINITIONS]
```

### APIs Consumed This Phase
```[FORMAT]
[API_DEPENDENCIES]
```

### Temporary Interfaces
Interfaces that will change in future phases:
```[FORMAT]
# TEMPORARY - Will change in Phase [PHASE]
[TEMPORARY_INTERFACE]
```

## Documentation Requirements

### To Be Created This Phase
- [ ] [DOCUMENT_1]
- [ ] [DOCUMENT_2]
- [ ] [DOCUMENT_3]

### To Be Updated This Phase
- [ ] [EXISTING_DOC_1]
- [ ] [EXISTING_DOC_2]

## Phase Handoff

### Deliverables
What this phase delivers to the next:
- **Working Code:**
  - [DELIVERABLE_1]
  - [DELIVERABLE_2]
- **Documentation:**
  - [DOCUMENT_1]
  - [DOCUMENT_2]
- **Test Suite:**
  - [TEST_SUITE_1]
  - [TEST_SUITE_2]

### Known Limitations
To be addressed in future phases:
- [LIMITATION_1]: Plan to address in Phase [PHASE]
- [LIMITATION_2]: Plan to address in Phase [PHASE]

### Handoff Checklist
- [ ] Code review completed
- [ ] Tests passing
- [ ] Documentation updated
- [ ] Performance validated
- [ ] Security review done
- [ ] Next phase team briefed
- [ ] Retrospective completed

## Lessons & Notes

### Assumptions
- [ASSUMPTION_1]
- [ASSUMPTION_2]

### Decisions Log
| Decision | Date | Rationale | Impact |
|----------|------|-----------|---------|
| [DECISION] | [DATE] | [WHY] | [WHAT_CHANGED] |

### Open Questions
- [QUESTION_1] - Owner: [WHO] - Due: [WHEN]
- [QUESTION_2] - Owner: [WHO] - Due: [WHEN]

---
*Generated by Bootstrap /design v[VERSION] on [DATE]*