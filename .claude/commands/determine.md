# Determine - Requirements Gathering

## Arguments: $ARGUMENTS

Establish what needs to be built and why through comprehensive requirements gathering. Accepts optional feature name or requirements file for iteration.

## When to Use This Command

**Use `/determine` when:**
- Starting a new feature or capability
- Gathering requirements before design phase
- Need to document user stories and acceptance criteria
- Establishing success metrics for a feature
- Updating or refining existing requirements

**Skip when:**
- Requirements are already fully documented
- Making minor bug fixes or patches
- Requirements are dictated by external specification

## Multi-Agent Architecture

### Primary Agent: Requirements Engineer
You are the Requirements Engineer with PhD-level expertise in requirements elicitation and analysis. Think hard about uncovering both functional and non-functional requirements, identifying edge cases, and ensuring completeness.

### Agent Team
After initial context gathering, launch Project Manager to coordinate specialists:
**Project Manager personality:** `.claude/agents/project-manager.md`
- Business Analyst for user stories and business logic
- Technical Architect for technical constraints and dependencies
- QA Specialist for acceptance criteria and testability
- Domain Expert for industry-specific requirements (if applicable)
- Security Expert for security and compliance requirements

## Process

### 1. **Initial Assessment**

```bash
# Check prerequisites
if [ ! -f "CHARTER.md" ]; then
    echo "ERROR: CHARTER.md not found. Run '/init' first to initialize project."
    exit 1
fi

# Check for existing requirements
ls .sdlc/requirements/*.md 2>/dev/null || echo "No existing requirements found"
```

Parse arguments:
- If $ARGUMENTS is empty: Start fresh requirements gathering
- If $ARGUMENTS is a file path: Read and iterate on existing requirements
- If $ARGUMENTS is text: Use as feature/capability name

**Important:** Before gathering requirements:
1. Read CHARTER.md to understand project context, principles, and constraints
2. Check .sdlc/ADRs/ for existing architectural decisions that may impact requirements
3. Review any related design ADRs in .sdlc/designs/*/adrs/ if iterating on existing features

### 2. **Interactive Gathering** (Section-by-Section)

**Step 1: Feature Identification**
"What feature or capability are we gathering requirements for?"
(Use $ARGUMENTS if provided, otherwise ask)

**Step 2: Problem Statement**
"What problem does this feature solve? Who experiences this problem?"

**Step 3: Stakeholders**
"Who are the stakeholders? (comma-separated: end users, admins, developers, etc.)"

**Step 4: Success Criteria**
"How will we measure success? Provide 2-3 measurable criteria:
- Example: 'Response time < 2 seconds'
- Example: 'User completion rate > 90%'
- Example: '0 critical security vulnerabilities'"

**Step 5: Scope Boundaries**
"What's explicitly IN scope? What's OUT of scope?"

### 3. **Script Execution**

```bash
# Create requirements document structure
FEATURE_NAME=$(echo "$FEATURE" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')
./.claude/scripts/create-requirements.sh "$FEATURE_NAME"
# Output: "✓ Created: .sdlc/requirements/001-{feature-name}.md"
```

### 4. **Multi-Agent Requirements Analysis**

Launch comprehensive requirements analysis team:

```
Use Task tool:
- description: "Coordinate comprehensive requirements analysis"
- subagent_type: "general-purpose"
- prompt: "You are a Project Manager coordinating requirements analysis. Think hard about completeness and clarity.

  Your task:
  1. Launch these specialists using Task tool (follow .claude/rules/project/sub-agent-limits.md):
     Phase 1 (max 2 agents in parallel):
     - Business Analyst: Extract user stories, workflows, business rules
     - Technical Architect: Identify technical constraints, dependencies, integration points

     Phase 2 (max 2 agents in parallel):
     - QA Specialist: Define acceptance criteria, test scenarios, quality metrics
     - Security Expert: Specify security requirements, compliance needs
  2. Synthesize all perspectives into cohesive requirements
  3. Identify conflicts or gaps for user clarification
  4. Return structured requirements with priorities

  Context:
  - Feature: $FEATURE_NAME
  - Problem: $PROBLEM_STATEMENT
  - Stakeholders: $STAKEHOLDERS
  - Success Criteria: $SUCCESS_CRITERIA
  - Charter Principles: [Read CHARTER.md and extract relevant principles]

  Each specialist should provide:
  - Must-have requirements (P0)
  - Should-have requirements (P1)
  - Nice-to-have requirements (P2)
  - Risks and assumptions

  Reference: Load Project Manager personality from .claude/agents/project-manager.md"
```

### 5. **Content Creation** (Section-by-Section)

**Template:** Use `.claude/templates/requirements.template.md` as structure guide

Fill requirements document progressively with user feedback:

1. **Executive Summary**
   - Write 2-3 paragraph summary
   - Get user feedback: "Does this capture the essence?"

2. **User Scenarios**
   - Document 3-5 key scenarios
   - Get user feedback: "Are these the right scenarios?"

3. **Functional Requirements**
   - List requirements from multi-agent synthesis
   - Organize by priority (P0, P1, P2)
   - Get user feedback: "Any missing requirements?"

4. **Non-Functional Requirements**
   - Performance, security, usability, reliability
   - Get user feedback: "Are these constraints acceptable?"

5. **Acceptance Criteria**
   - Specific, measurable, testable criteria
   - Get user feedback: "Will these prove success?"

6. **Dependencies and Assumptions**
   - Technical dependencies
   - Business assumptions
   - Get user feedback: "Are these assumptions valid?"

Apply learnings from each section to improve the next. Never fill the entire document at once.

### 6. **Validation & Reporting**

```bash
# Verify requirements document was created
REQ_FILE=$(ls -t .sdlc/requirements/*.md | head -1)
echo "✓ Requirements documented in: $REQ_FILE"

# Report completeness
echo "Requirements Summary:"
echo "  - Functional requirements: $(grep -c '^- ' $REQ_FILE || echo 0)"
echo "  - User scenarios: $(grep -c '^### Scenario' $REQ_FILE || echo 0)"
echo "  - Acceptance criteria: $(grep -c '^- \[' $REQ_FILE || echo 0)"
```

Report next steps:
```
✓ Requirements gathering complete!
  - Document: $REQ_FILE
  - Stakeholders identified: $STAKEHOLDER_COUNT
  - Requirements captured: $REQUIREMENT_COUNT

Next steps:
1. Review requirements with stakeholders
2. Use '/design' to create architecture plan
3. Consider creating ADR for key decisions
```

## Embedded Rules

### From `sub-agent-limits.md`:
- Maximum 2 sub-agents can execute in parallel
- Use phased execution with complementary agent pairs
- JavaScript memory constraints require sequential phases

### From `sequential-file-naming.md`:
- Requirements files use pattern: ###-{kebab-case-feature}.md
- Sequential numbering starts at 001, increments by 1
- Find next available number automatically

### From `sdlc-directory-structure.md`:
- All requirements stored in `.sdlc/requirements/`
- Never store requirements in project root
- Maintain consistent structure across projects

### From `planning-context.md`:
- Requirements must align with charter principles
- Flag any conflicts for amendment consideration
- Maintain traceability to charter

## Error Handling

### Script Failures
- **create-requirements.sh fails**:
  ```bash
  # Manually create file structure
  mkdir -p .sdlc/requirements
  NEXT_NUM=$(ls .sdlc/requirements/*.md 2>/dev/null | wc -l | xargs printf "%03d")
  touch ".sdlc/requirements/${NEXT_NUM}-${FEATURE_NAME}.md"
  ```

### Missing Prerequisites
- **No CHARTER.md**: Direct user to run `/init` first
- **No .sdlc/ structure**: Run `init-structure.sh` to create

### Multi-Agent Failures
- If Task tool fails: Proceed with manual requirements gathering
- If specialists timeout: Use available results, note gaps
- If synthesis conflicts: Present alternatives to user

### File Conflicts
- **Requirements file exists**:
  - Ask: "Requirements exist for this feature. Update or create new?"
  - If update: Use MultiEdit tool
  - If new: Increment number, create new file

## Argument Patterns

```markdown
# Examples of argument handling:
/determine                          # Interactive mode
/determine "user authentication"   # With feature name
/determine 001-auth.md             # Iterate on existing
/determine 001-auth.md "add SSO"  # Refine with specific addition
```

## Command Validation

Success criteria:
1. Requirements document created in `.sdlc/requirements/`
2. Document contains all required sections
3. Sequential numbering maintained
4. Alignment with CHARTER.md verified
5. Multi-agent synthesis included

---
Generated with Bootstrap v0.12.0