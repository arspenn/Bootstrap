# Design Feature

## Feature file: $ARGUMENTS

Interactive software design exploration for feature implementation. This command guides you through requirements gathering, architecture decisions, and design trade-offs to produce comprehensive design documentation that seamlessly integrates with PRP generation.

## When to Use This Command

**Use `design-feature` when:**
- Feature requirements are unclear or complex
- Multiple implementation approaches exist with different trade-offs
- The feature impacts multiple system components
- Non-functional requirements are critical (performance, security, scale)
- Stakeholders need to review before implementation

**Skip and use `generate-prp` directly when:**
- Requirements are crystal clear and simple
- Implementation approach is obvious and standard
- Feature is isolated with minimal system impact
- Similar features already exist as patterns to follow

## Design Process

1. **Load Context**
   - Read the feature file to understand requirements
   - Check for `PLANNING.md` to understand project architecture
   - Review `CLAUDE.md` for project-specific conventions
   - Check `TASK.md` for any related tasks
   - Identify existing patterns and constraints

2. **Interactive Requirements Gathering**
   
   Ask clarifying questions to fully understand the feature:
   
   **Functional Requirements:**
   - What is the primary user goal for this feature?
   - Who are the users/stakeholders?
   - What are the key user interactions?
   - What data will be processed?
   - What are the expected outputs?
   - Are there specific workflows or user journeys?
   
   **Non-Functional Requirements:**
   - What is the expected load/scale (users, requests/sec, data volume)?
   - What are the performance requirements (response time, throughput)?
   - Are there security considerations (authentication, authorization, data privacy)?
   - Are there compliance requirements (GDPR, HIPAA, etc.)?
   - What is the availability requirement (uptime, disaster recovery)?
   
   **Integration & Dependencies:**
   - Which existing components will this interact with?
   - Are there external service dependencies?
   - What are the database/storage requirements?
   - Are there API contracts that need to be defined?
   - How will this integrate with existing authentication/authorization?
   
   **Constraints & Assumptions:**
   - What technical constraints exist (language, framework, infrastructure)?
   - What are the timeline constraints?
   - What assumptions are we making?
   - Are there budget or resource constraints?

3. **Codebase Analysis**
   - Search for similar existing features using Grep/Glob
   - Identify patterns used in the codebase
   - Find potential integration points
   - Note any anti-patterns to avoid
   - Document relevant existing components
   
   Key areas to investigate:
   - Similar feature implementations
   - Data models and schemas
   - API patterns and conventions
   - Testing approaches
   - Error handling patterns
   - Configuration management

4. **Architecture Exploration**
   
   Document the system architecture at different levels:
   
   **System Context (C4 Level 1):**
   - External users and systems
   - High-level interactions
   - System boundaries
   
   **Container Diagram (C4 Level 2):**
   - Applications and data stores
   - Communication protocols
   - Technology choices
   
   **Component Diagram (C4 Level 3):**
   - Major components within containers
   - Responsibilities and relationships
   - Key interfaces

5. **Design Alternatives**
   
   Document 2-3 alternative approaches:
   
   **For each alternative:**
   - High-level approach description
   - Key components and their responsibilities
   - Data flow and interactions
   - Technology choices and rationale
   
   **Trade-off Analysis:**
   - Performance implications
   - Complexity and maintainability
   - Development effort
   - Scalability considerations
   - Security implications
   - Cost (development and operational)
   
   **Recommendation:**
   - Preferred approach and why
   - Key factors in the decision
   - Mitigation strategies for downsides

6. **Architecture Decision Records (ADRs)**
   
   Create ADRs for significant decisions:
   
   **When to create an ADR:**
   - Choosing between fundamentally different approaches
   - Decisions with long-term implications
   - Trade-offs that affect multiple components
   - Deviations from standard patterns
   
   **ADR Template:**
   ```markdown
   # ADR-{number}: {title}
   
   ## Status
   {Proposed|Accepted|Deprecated|Superseded}
   
   ## Context
   {What is the issue that we're seeing that is motivating this decision?}
   
   ## Decision
   {What is the change that we're proposing and/or doing?}
   
   ## Consequences
   ### Positive
   - {What becomes easier?}
   
   ### Negative
   - {What becomes more difficult?}
   
   ### Neutral
   - {What changes but is neither good nor bad?}
   ```

7. **Risk Assessment**
   
   Identify and document risks:
   
   **Technical Risks:**
   - Performance bottlenecks
   - Scalability limits
   - Security vulnerabilities
   - Technical debt implications
   
   **Project Risks:**
   - Timeline risks
   - Resource dependencies
   - Integration complexities
   - Testing challenges
   
   **Mitigation Strategies:**
   - How to address each risk
   - Monitoring and early warning signs
   - Fallback options

8. **Create Design Artifacts**
   
   **Mermaid Diagrams:**
   
   System Context Diagram:
   ```mermaid
   C4Context
       title System Context diagram for {Feature Name}
       
       Person(user, "User", "Description of user")
       System(system, "Our System", "Description")
       System_Ext(ext_system, "External System", "Description")
       
       Rel(user, system, "Uses", "HTTPS")
       Rel(system, ext_system, "Sends data to", "API")
   ```
   
   Component Diagram:
   ```mermaid
   graph TB
       subgraph "Container"
           A[Component A]
           B[Component B]
           C[Component C]
       end
       
       A --> B
       B --> C
   ```
   
   Sequence Diagram (for complex flows):
   ```mermaid
   sequenceDiagram
       participant U as User
       participant S as System
       participant D as Database
       
       U->>S: Request
       S->>D: Query
       D-->>S: Result
       S-->>U: Response
   ```

9. **Generate Design Document**
   
   Create comprehensive design document with structure:
   
   ```markdown
   # {Feature Name} Design Document
   
   ## Executive Summary
   Brief overview of the feature and design approach
   
   ## Requirements
   ### Functional Requirements
   - Gathered from interactive session
   
   ### Non-Functional Requirements
   - Performance, security, scale requirements
   
   ## Current State Analysis
   - Existing patterns and components
   - Integration points identified
   
   ## Proposed Design
   ### Overview
   High-level description of chosen approach
   
   ### Architecture
   - System context
   - Components and responsibilities
   - Data flow
   
   ### Design Decisions
   - Key decisions and rationale
   - Links to ADRs
   
   ## Alternative Approaches Considered
   - Other options evaluated
   - Why they weren't chosen
   
   ## Implementation Plan
   - High-level tasks
   - Dependencies
   - Suggested order
   
   ## Risks and Mitigations
   - Identified risks
   - Mitigation strategies
   
   ## Success Criteria
   - How we'll know the design is working
   - Metrics and monitoring
   ```

10. **Validation Checklist**
    
    Before completing, ensure:
    - [ ] All requirements are clearly documented
    - [ ] At least 2 design alternatives were considered
    - [ ] Trade-offs are explicitly documented
    - [ ] Key architectural decisions have ADRs
    - [ ] Integration points are identified
    - [ ] Risks are assessed with mitigations
    - [ ] Diagrams clearly show system structure
    - [ ] Design aligns with existing patterns
    - [ ] Implementation tasks are identified
    - [ ] Design is ready for PRP generation

## Output Structure

Save artifacts in organized structure:
```
.sdlc/designs/
├── {feature-name}-design.md          # Main design document
├── {feature-name}-adrs/              # Architecture Decision Records
│   ├── ADR-001-{decision-name}.md
│   └── ADR-002-{decision-name}.md
└── {feature-name}-diagrams/          # Mermaid diagram files
    ├── context-diagram.mmd
    ├── component-diagram.mmd
    └── sequence-diagram.mmd
```

## Integration with Project Docs

- If `PLANNING.md` exists, update with new architectural decisions
- Create entries in `TASK.md` for implementation tasks identified
- Ensure design respects conventions in `CLAUDE.md`
- Design document should provide all context needed for `generate-prp`

## Next Steps

After design is complete:
1. Review design with stakeholders if needed
2. Use `generate-prp` command with the design document as input
3. Design provides context for comprehensive PRP generation
4. PRP enables one-pass implementation success

Remember: Good design prevents costly refactoring and ensures successful implementation.