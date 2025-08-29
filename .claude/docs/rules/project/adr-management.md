# Architecture Decision Records Management Rule Documentation

## Overview

The `adr-management` rule ensures that significant architectural decisions are properly documented using Architecture Decision Records (ADRs). This rule guides when to create ADRs, where to place them, and how to maintain them, ensuring critical design choices are captured for future reference.

## Rule Definition

```yaml
- ID: project/adr-management
- Status: Active
- Security Level: Low
- Token Impact: ~35 tokens per operation
- Priority: 650
- Dependencies: ["project/design-structure"]
```

## Rationale

Documenting architectural decisions provides:
- **Historical Context**: Understand why decisions were made
- **Avoid Repetition**: Prevent relitigating past decisions
- **Onboarding**: Help new team members understand the architecture
- **Evolution Tracking**: See how the system has changed over time
- **Decision Accountability**: Clear record of who made decisions and when

## When This Rule Triggers

The rule activates when:
1. Making technology stack decisions
2. Choosing between architectural patterns
3. Establishing project-wide conventions
4. Making security or performance trade-offs
5. Selecting major dependencies or frameworks

## ADR Placement Criteria

### Project-Wide ADRs (docs/ADRs/)
Place ADRs here when they:
- Affect multiple features or the entire codebase
- Establish conventions or standards
- Define technology choices or architectural patterns
- Set security, performance, or workflow policies

### Design-Specific ADRs (designs/*/adrs/)
Place ADRs here when they:
- Only affect that specific feature implementation
- Document trade-offs unique to that feature
- Explain implementation choices within established conventions

## Examples

### Example 1: Technology Selection (Project-Wide)
```markdown
# ADR-010: Use FastAPI for REST API Framework

## Status
Accepted

## Context
We need to choose a Python web framework for our REST API that supports async operations, automatic API documentation, and type hints.

## Decision
We will use FastAPI as our REST API framework.

## Consequences

### Positive
- Automatic OpenAPI/Swagger documentation
- Native async/await support
- Pydantic integration for validation

### Negative
- Smaller ecosystem than Flask/Django
- Team needs to learn new framework

### Neutral
- Different middleware patterns than traditional frameworks
```

### Example 2: Feature Implementation (Design-Specific)
```markdown
# ADR-001: Use Webhooks for Payment Status Updates

## Status
Accepted

## Context
The payment processing feature needs to handle asynchronous payment confirmations from external providers.

## Decision
Implement webhook endpoints to receive payment status updates rather than polling.

## Consequences

### Positive
- Real-time updates
- Reduced API calls to payment provider

### Negative
- Need to handle webhook security/validation
- Requires reliable webhook delivery handling
```

### Example 3: Convention Establishment (Project-Wide)
```markdown
# ADR-015: Adopt Domain-Driven Design Principles

## Status
Accepted

## Context
Our codebase is becoming difficult to navigate as it grows. We need clear organizational principles.

## Decision
Adopt Domain-Driven Design with bounded contexts for major business domains.

## Consequences

### Positive
- Clear separation of business domains
- Easier to understand and modify specific domains

### Negative
- Initial refactoring effort required
- May introduce some code duplication
```

## ADR Template Usage

```markdown
# ADR-{number}: {Title}

## Status
{Proposed|Accepted|Deprecated|Superseded}

## Context
{What is the issue that we're seeing that is motivating this decision or change?}

## Decision
{What is the change that we're proposing and/or doing?}

## Consequences

### Positive
- {Positive consequence}

### Negative
- {Negative consequence}

### Neutral
- {Neutral consequence}
```

## Best Practices

1. **Write ADRs Promptly**: Document decisions while context is fresh
2. **Be Concise**: Focus on the key points, not implementation details
3. **Include Alternatives**: Mention options that were considered but rejected
4. **Link Related ADRs**: Reference ADRs that influence or are influenced by this decision
5. **Update Status**: Mark ADRs as deprecated/superseded when decisions change

## Index Management

The ADR Index (docs/ADRs/INDEX.md) should be updated whenever creating a new ADR:

```markdown
# ADR Index

## Active ADRs
- [ADR-001: Git Rules Architecture](./ADR-001-git-rules-architecture.md)
- [ADR-010: Use FastAPI for REST API](./ADR-010-fastapi-selection.md)

## Deprecated ADRs
- [ADR-003: Monolithic Architecture](./ADR-003-monolithic-architecture.md) - Superseded by ADR-015

## By Category

### Architecture
- ADR-001: Git Rules Architecture
- ADR-015: Domain-Driven Design

### Technology Choices
- ADR-010: FastAPI Selection
```

## Validation Tools

Use the ADR tools to validate your ADRs:

```bash
# Validate all ADRs
python scripts/adr-tools.py validate

# Create new ADR with proper numbering
python scripts/adr-tools.py create "Use Redis for Caching"

# Update index
python scripts/adr-tools.py update-index
```

## Common Scenarios

### Scenario 1: Choosing a Database
```
1. Significant decision: Database affects entire application
2. Create project-wide ADR: docs/ADRs/ADR-XXX-database-selection.md
3. Document options considered (PostgreSQL, MySQL, MongoDB)
4. Explain decision criteria and final choice
5. Update INDEX.md
```

### Scenario 2: Feature-Specific Algorithm
```
1. Decision only affects search feature
2. Create design-specific ADR: designs/005-search-feature/adrs/ADR-001-search-algorithm.md
3. Document why choosing Elasticsearch over database full-text search
4. Link to project-wide technology ADRs if relevant
```

### Scenario 3: Changing Previous Decision
```
1. New requirements invalidate previous ADR
2. Create new ADR documenting the change
3. Update old ADR status to "Superseded"
4. Reference old ADR in new one
5. Update INDEX.md to reflect status change
```

## Configuration

```yaml
project:
  rules:
    adr-management: enabled
  config:
    adr_template: "templates/design-templates/adr.template.md"
    project_adr_path: "docs/ADRs/"
    design_adr_path: "designs/*/adrs/"
    index_file: "docs/ADRs/INDEX.md"
    validation_tool: "scripts/adr-tools.py"
```

## Troubleshooting

### Issue: Unsure if Decision Needs ADR
**Solution**: If you spend more than 30 minutes debating, it needs an ADR

### Issue: ADR Numbering Conflicts
**Solution**: Use adr-tools.py to auto-generate next number

### Issue: Unclear Placement (Project vs Design)
**Solution**: Ask "Does this establish a pattern others will follow?" If yes, project-wide

## Related Rules

- `project/design-structure`: ADRs are part of design documentation
- `project/planning-context`: Major ADRs influence PLANNING.md
- `documentation/standards`: ADRs follow documentation standards

## When NOT to Create ADRs

Don't create ADRs for:
- Implementation details that can easily change
- Temporary workarounds
- Personal coding preferences
- Decisions with no long-term impact
- Obvious choices with no alternatives

## Implementation Notes

This rule has priority 650 because:
1. ADRs capture critical project knowledge
2. Must run when architectural decisions are made
3. Depends on design-structure for placement
4. Influences how code is written but doesn't directly modify it

The dependency on `project/design-structure` ensures that the design folder structure exists before attempting to place design-specific ADRs.

---

📚 **Rule Definition**: [.claude/rules/project/adr-management.md](../../../.claude/rules/project/adr-management.md)