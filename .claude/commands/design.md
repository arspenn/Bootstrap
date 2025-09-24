# Design - Architecture Planning

## Arguments: $ARGUMENTS

Create architectural design with multiple alternatives evaluated. Accepts optional requirements file or existing design for iteration.

## When to Use This Command

**Use `/design` when:**
- Planning architecture for new feature or system
- Need to evaluate multiple implementation approaches
- Making significant architectural decisions
- Refactoring existing architecture
- Creating technical specifications before implementation

**Skip when:**
- Design is already complete and approved
- Making trivial changes that don't affect architecture
- Following predetermined technical specification

## Multi-Agent Architecture

### Primary Agent: Requirements Engineer
You are the Requirements Engineer transitioning to design phase. Think hard about translating requirements into architectural solutions, considering trade-offs, and ensuring all requirements are addressed.

### Agent Team Selection
Based on complexity assessment, launch appropriate team:
**Project Manager personality:** `.claude/agents/project-manager.md`

**For Complex Projects (>5 days or >5 components):**
- Technical Architect for system design
- Performance Engineer for scalability considerations
- Security Specialist for threat modeling
- Database Architect for data layer design
- DevOps Engineer for deployment architecture
- Domain Expert for business logic validation

**For Standard Projects:**
- Technical Architect for system design
- QA Specialist for testability concerns
- DevOps Engineer for deployment considerations

## Process

### 1. **Initial Assessment**

```bash
# Check for requirements
if [ ! -d ".sdlc/requirements" ] || [ -z "$(ls -A .sdlc/requirements/)" ]; then
    echo "WARNING: No requirements found. Consider running '/determine' first."
    echo "Proceeding with design based on provided context..."
fi

# List available requirements
echo "Available requirements:"
ls -la .sdlc/requirements/*.md 2>/dev/null || echo "  None found"

# Check for existing designs
echo "Existing designs:"
ls -la .sdlc/designs/ 2>/dev/null || echo "  None found"
```

Parse arguments:
- Empty: Ask which requirements to design for
- File path: Use specified requirements or iterate on existing design
- Text: Search for matching requirements

### 2. **Interactive Gathering** (Section-by-Section)

**Step 1: Design Target**
"What are we designing? (feature name or requirements file)"

**Step 2: Complexity Assessment**
"Estimate the complexity:
- How many days of development? (number)
- How many distinct components? (number)
- Integration points needed? (list)"

Based on answers, determine if phasing needed:
```
if (days > 5 OR components > 5):
    use_phased_design = true
    specialist_team = "complex"
else:
    use_phased_design = false
    specialist_team = "standard"
```

**Step 3: Key Constraints**
"What are the key constraints?
- Performance requirements?
- Security requirements?
- Technology limitations?
- Budget/time constraints?"

**Step 4: Success Metrics**
"How will we measure if the design is successful?"

### 3. **Script Execution**

```bash
# Create design structure
DESIGN_NAME=$(echo "$FEATURE" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
./.claude/scripts/create-design-structure.sh "$DESIGN_NAME"
# Output: "✓ Created: .sdlc/designs/001-{design-name}/"
# Creates: design.md, diagrams/, adrs/
```

### 4. **Multi-Agent Architecture Analysis**

Launch architecture team based on complexity:

```
Use Task tool:
- description: "Coordinate architectural design with alternatives"
- subagent_type: "general-purpose"
- prompt: "You are a Project Manager coordinating architectural design. Think hard about creating robust, scalable solutions.

  Your task:
  1. Launch these specialists IN PARALLEL using Task tool:
     $(if complex_project):
     - Technical Architect: Design overall system architecture
     - Performance Engineer: Analyze scalability and performance
     - Security Specialist: Identify security considerations
     - Database Architect: Design data models and storage
     - DevOps Engineer: Plan deployment and infrastructure
     - Domain Expert: Validate business logic architecture
     $(else):
     - Technical Architect: Design system architecture
     - QA Specialist: Ensure testability
     - DevOps Engineer: Plan deployment

  2. Each specialist must provide:
     - Primary recommended approach
     - At least one alternative approach
     - Trade-offs for each approach
     - Risk assessment

  3. Synthesize into design alternatives:
     - Alternative A: [Recommended approach]
     - Alternative B: [Second approach]
     - Alternative C: [If applicable]

  4. Create comparison matrix of alternatives

  Context:
  - Feature: $FEATURE_NAME
  - Requirements: [Load from requirements file]
  - Constraints: $CONSTRAINTS
  - Complexity: $COMPLEXITY_ASSESSMENT
  - Technology Stack: [From CHARTER.md]

  Consider these architectural patterns:
  - Microservices vs Monolith
  - Synchronous vs Asynchronous
  - REST vs GraphQL vs gRPC
  - SQL vs NoSQL
  - Caching strategies
  - Security patterns

  Reference: Load Project Manager from .claude/agents/project-manager.md"
```

### 5. **Content Creation** (Section-by-Section)

**Templates to use:**
- Primary: `.claude/templates/design.template.md` (for standard designs)
- Alternative: `.claude/templates/design-phase.template.md` (for phased designs)
- Diagrams: `.claude/templates/diagram-*.template.md` (architecture, flow, sequence, ER)
- ADRs: `.claude/templates/adr.template.md` (for architectural decisions)

Fill design document progressively:

1. **Executive Summary**
   - Problem statement and solution overview
   - Get feedback: "Does this capture the design intent?"

2. **Requirements Analysis**
   - Map requirements to design decisions
   - Get feedback: "Are all requirements addressed?"

3. **Architecture Overview**
   - High-level architecture from synthesis
   - Get feedback: "Is this the right level of abstraction?"

4. **Design Alternatives** (CRITICAL SECTION)
   - **Alternative A**: Recommended approach
     - Description, pros, cons, risks
   - **Alternative B**: Second approach
     - Description, pros, cons, risks
   - **Alternative C**: (if applicable)
     - Description, pros, cons, risks
   - Get feedback: "Which alternative do you prefer?"

5. **Detailed Design** (for chosen alternative)
   - Component specifications
   - Interface definitions
   - Data models
   - Get feedback: "Any concerns with this design?"

6. **Architecture Decision Records (ADRs)**
   For each key decision:
   ```bash
   # Create ADR for key decision
   echo "Creating ADR for: $DECISION"
   # Generate ADR-001-{decision-name}.md in designs/###-name/adrs/
   ```

7. **Diagrams** (if needed)
   - System architecture diagram
   - Data flow diagram
   - Sequence diagrams for key flows
   - Get feedback: "Do these diagrams clarify the design?"

8. **Phasing Plan** (if complex)
   - Phase 1: MVP components
   - Phase 2: Enhanced features
   - Phase 3: Optimization
   - Get feedback: "Is this phasing realistic?"

### 6. **Validation & Reporting**

```bash
# Verify design structure created
DESIGN_DIR=$(ls -dt .sdlc/designs/*/ | head -1)
echo "✓ Design created in: $DESIGN_DIR"

# Check completeness
echo "Design artifacts:"
echo "  - design.md: $(test -f $DESIGN_DIR/design.md && echo '✓' || echo '✗')"
echo "  - ADRs: $(ls $DESIGN_DIR/adrs/*.md 2>/dev/null | wc -l)"
echo "  - Diagrams: $(ls $DESIGN_DIR/diagrams/*.md 2>/dev/null | wc -l)"
```

Report summary:
```
✓ Design complete!
  - Location: $DESIGN_DIR
  - Alternatives evaluated: $ALTERNATIVE_COUNT
  - ADRs created: $ADR_COUNT
  - Chosen approach: $CHOSEN_ALTERNATIVE

Next steps:
1. Review design with stakeholders
2. Get approval on chosen alternative
3. Use '/define' to create implementation plan (DIP)
4. Consider creating prototype for validation
```

## Embedded Rules

### From `design-structure.md`:
- Design folder structure: ###-{type}-{name}/
- Must contain: design.md, diagrams/, adrs/
- Diagrams as separate markdown files in diagrams/
- Each ADR in adrs/ subdirectory

### From `adr-management.md`:
- Document all significant decisions as ADRs
- Format: ADR-###-{decision-name}.md
- Include: context, decision, consequences
- Status: Proposed → Accepted/Rejected

### From `sequential-file-naming.md`:
- Design folders: ###-{kebab-case-name}/
- Sequential numbering maintained
- Type prefix: feature-, system-, refactor-

## Error Handling

### Script Failures
- **create-design-structure.sh fails**:
  ```bash
  # Manual creation
  mkdir -p .sdlc/designs/001-$DESIGN_NAME/{diagrams,adrs}
  touch .sdlc/designs/001-$DESIGN_NAME/design.md
  echo "✓ Manually created design structure"
  ```

### Multi-Agent Issues
- **Specialists conflict**: Present all viewpoints to user
- **Timeout**: Use partial results, note incomplete analysis
- **No consensus**: Default to simplest viable approach

### Complexity Misjudgment
- If design grows beyond initial assessment:
  - Prompt: "Complexity exceeds estimate. Switch to phased design?"
  - Rerun with additional specialists if needed

### File Conflicts
- **Design exists**:
  - Ask: "Design exists. Create new version or update?"
  - Versioning: 001-feature-v2/

## Argument Patterns

```markdown
/design                              # Interactive mode
/design "user authentication"       # With feature name
/design .sdlc/requirements/001-auth.md  # From specific requirements
/design 001-auth-design/design.md "improve scalability"  # Iterate with focus
```

## Special Considerations

### Phased Design Triggers
Automatically suggest phasing when:
- Development estimate > 5 days
- Components > 5 distinct parts
- Multiple integration points
- Significant technical risk

### Alternative Evaluation Matrix
Always create comparison table:
| Criteria | Alternative A | Alternative B | Alternative C |
|----------|--------------|--------------|--------------|
| Performance | High | Medium | High |
| Complexity | Medium | Low | High |
| Cost | $$ | $ | $$$ |
| Risk | Low | Medium | Low |
| Time to Market | 3 weeks | 2 weeks | 4 weeks |

### Design Patterns Library
Consider standard patterns:
- MVC, MVP, MVVM for UI architecture
- Repository, Unit of Work for data access
- Observer, Pub/Sub for event handling
- Factory, Builder for object creation
- Strategy, Command for behavior

---
Generated with Bootstrap v0.12.0