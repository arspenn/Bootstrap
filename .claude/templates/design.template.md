---
name: "Design Template"
description: "Standard design template for feature architecture and planning"
---

# Design: [FEATURE_NAME]

## Design Overview

**Feature:** [FEATURE_NAME]
**Requirements Reference:** [REQUIREMENTS_DOC_PATH]
**Design Status:** [DRAFT/REVIEW/APPROVED]
**Complexity:** [HIGH/MEDIUM/LOW]
**Estimated Effort:** [TIME_ESTIMATE]

### Purpose
[Clear statement of what this design accomplishes and why it's needed]

### Design Goals
- [GOAL_1]: [DESCRIPTION]
- [GOAL_2]: [DESCRIPTION]
- [GOAL_3]: [DESCRIPTION]

### Non-Goals
- [NON_GOAL_1]: [WHY_EXCLUDED]
- [NON_GOAL_2]: [WHY_EXCLUDED]

## Architecture

### High-Level Architecture
[Describe the overall architecture in prose - components, layers, and interactions]

### Component Design

#### Component 1: [COMPONENT_NAME]
**Purpose:** [WHAT_IT_DOES]
**Responsibilities:**
- [RESPONSIBILITY_1]
- [RESPONSIBILITY_2]
- [RESPONSIBILITY_3]

**Interfaces:**
```[LANGUAGE]
[INTERFACE_DEFINITION]
```

#### Component 2: [COMPONENT_NAME]
**Purpose:** [WHAT_IT_DOES]
**Responsibilities:**
- [RESPONSIBILITY_1]
- [RESPONSIBILITY_2]

**Interfaces:**
```[LANGUAGE]
[INTERFACE_DEFINITION]
```

### Data Model

#### Entity: [ENTITY_NAME]
```[LANGUAGE]
[ENTITY_DEFINITION]
```

**Relationships:**
- [RELATIONSHIP_1]
- [RELATIONSHIP_2]

**Constraints:**
- [CONSTRAINT_1]
- [CONSTRAINT_2]

### API Design

#### Endpoint: [ENDPOINT_NAME]
**Method:** [HTTP_METHOD]
**Path:** [URL_PATH]
**Purpose:** [WHAT_IT_DOES]

**Request:**
```json
{
  "[FIELD_1]": "[TYPE]",
  "[FIELD_2]": "[TYPE]"
}
```

**Response:**
```json
{
  "[FIELD_1]": "[TYPE]",
  "[FIELD_2]": "[TYPE]"
}
```

**Error Codes:**
- [CODE]: [MEANING]
- [CODE]: [MEANING]

## Technical Decisions

### Technology Choices
| Component | Technology | Rationale |
|-----------|------------|-----------|
| [COMPONENT] | [TECHNOLOGY] | [WHY_CHOSEN] |
| [COMPONENT] | [TECHNOLOGY] | [WHY_CHOSEN] |

### Design Patterns
- **[PATTERN_NAME]**: Used for [PURPOSE]
  - Implementation: [HOW_APPLIED]
  - Benefits: [ADVANTAGES]

### Trade-offs
| Option | Pros | Cons | Decision |
|--------|------|------|----------|
| [OPTION_A] | [PROS] | [CONS] | [CHOSEN/REJECTED] |
| [OPTION_B] | [PROS] | [CONS] | [CHOSEN/REJECTED] |

## Implementation Plan

### Development Phases
1. **Phase 1: [PHASE_NAME]** ([DURATION])
   - [DELIVERABLE_1]
   - [DELIVERABLE_2]

2. **Phase 2: [PHASE_NAME]** ([DURATION])
   - [DELIVERABLE_1]
   - [DELIVERABLE_2]

3. **Phase 3: [PHASE_NAME]** ([DURATION])
   - [DELIVERABLE_1]
   - [DELIVERABLE_2]

### Dependencies
- **Internal Dependencies:**
  - [DEPENDENCY_1]: [WHAT_NEEDED]
  - [DEPENDENCY_2]: [WHAT_NEEDED]

- **External Dependencies:**
  - [DEPENDENCY_1]: [WHAT_NEEDED]
  - [DEPENDENCY_2]: [WHAT_NEEDED]

### Migration Strategy
If replacing existing functionality:
1. [MIGRATION_STEP_1]
2. [MIGRATION_STEP_2]
3. [MIGRATION_STEP_3]

## Testing Strategy

### Test Approach
- **Unit Testing:** [APPROACH]
- **Integration Testing:** [APPROACH]
- **Performance Testing:** [APPROACH]
- **Security Testing:** [APPROACH]

### Test Scenarios
1. **[SCENARIO_NAME]**
   - Setup: [TEST_SETUP]
   - Action: [TEST_ACTION]
   - Expected: [EXPECTED_RESULT]

2. **[SCENARIO_NAME]**
   - Setup: [TEST_SETUP]
   - Action: [TEST_ACTION]
   - Expected: [EXPECTED_RESULT]

### Performance Targets
- **Response Time:** [TARGET]
- **Throughput:** [TARGET]
- **Resource Usage:** [TARGET]

## Security Considerations

### Security Requirements
- [REQUIREMENT_1]: [HOW_ADDRESSED]
- [REQUIREMENT_2]: [HOW_ADDRESSED]

### Threat Model
| Threat | Impact | Likelihood | Mitigation |
|--------|---------|------------|------------|
| [THREAT_1] | [H/M/L] | [H/M/L] | [MITIGATION] |
| [THREAT_2] | [H/M/L] | [H/M/L] | [MITIGATION] |

### Data Privacy
- **PII Handling:** [APPROACH]
- **Data Retention:** [POLICY]
- **Access Control:** [MECHANISM]

## Operational Considerations

### Deployment
- **Strategy:** [DEPLOYMENT_STRATEGY]
- **Rollback Plan:** [ROLLBACK_APPROACH]
- **Feature Flags:** [FLAG_STRATEGY]

### Monitoring
- **Metrics to Track:**
  - [METRIC_1]: [WHY_IMPORTANT]
  - [METRIC_2]: [WHY_IMPORTANT]
- **Alerts:**
  - [ALERT_1]: [TRIGGER_CONDITION]
  - [ALERT_2]: [TRIGGER_CONDITION]

### Maintenance
- **Expected Maintenance:** [DESCRIPTION]
- **Documentation Needs:** [WHAT_DOCS_NEEDED]
- **Training Requirements:** [WHO_NEEDS_TRAINING]

## Risks & Mitigations

### Technical Risks
1. **[RISK_NAME]**
   - Description: [RISK_DESCRIPTION]
   - Impact: [HIGH/MEDIUM/LOW]
   - Probability: [HIGH/MEDIUM/LOW]
   - Mitigation: [MITIGATION_STRATEGY]

### Business Risks
1. **[RISK_NAME]**
   - Description: [RISK_DESCRIPTION]
   - Impact: [HIGH/MEDIUM/LOW]
   - Probability: [HIGH/MEDIUM/LOW]
   - Mitigation: [MITIGATION_STRATEGY]

## Success Criteria

### Technical Success
- [ ] [CRITERION_1]
- [ ] [CRITERION_2]
- [ ] [CRITERION_3]

### Business Success
- [ ] [CRITERION_1]
- [ ] [CRITERION_2]

## Alternatives Considered

### Alternative 1: [NAME]
**Description:** [WHAT_IT_IS]
**Pros:** [ADVANTAGES]
**Cons:** [DISADVANTAGES]
**Why Not Chosen:** [REASON]

### Alternative 2: [NAME]
**Description:** [WHAT_IT_IS]
**Pros:** [ADVANTAGES]
**Cons:** [DISADVANTAGES]
**Why Not Chosen:** [REASON]

## Future Enhancements

### Planned Improvements
- [ENHANCEMENT_1]: [DESCRIPTION]
- [ENHANCEMENT_2]: [DESCRIPTION]

### Potential Extensions
- [EXTENSION_1]: [DESCRIPTION]
- [EXTENSION_2]: [DESCRIPTION]

## References

### Internal Documents
- [DOCUMENT_1]: [LINK/PATH]
- [DOCUMENT_2]: [LINK/PATH]

### External Resources
- [RESOURCE_1]: [LINK]
- [RESOURCE_2]: [LINK]

### Related Designs
- [RELATED_DESIGN_1]: [LINK/PATH]
- [RELATED_DESIGN_2]: [LINK/PATH]

## Appendix

### Glossary
- **[TERM_1]:** [DEFINITION]
- **[TERM_2]:** [DEFINITION]

### Open Questions
- [QUESTION_1] - Owner: [WHO] - Due: [WHEN]
- [QUESTION_2] - Owner: [WHO] - Due: [WHEN]

### Decision Log
| Date | Decision | Rationale | Impact |
|------|----------|-----------|---------|
| [DATE] | [DECISION] | [WHY] | [WHAT_CHANGED] |

---
*Generated by Bootstrap /design v[VERSION] on [DATE]*