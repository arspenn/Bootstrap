# Define - Implementation Definition

## Arguments: $ARGUMENTS

Generate Detailed Implementation Prompts (DIPs) that can be executed by AI agents. Accepts optional design document or specific component to define.

## When to Use This Command

**Use `/define` when:**
- Ready to create implementation plan from design
- Need detailed technical specifications
- Breaking down complex implementation into phases
- Creating executable instructions for development
- Defining test specifications and validation

**Skip when:**
- No design exists (run `/design` first)
- Implementation is trivial (< 50 LOC)
- Following external implementation guide

## Multi-Agent Architecture

### Primary Agent: Requirements Engineer
You are the Requirements Engineer finalizing implementation specifications. Think hard about creating self-contained, executable instructions that any AI agent could follow successfully.

### Agent Team
Launch Project Manager to coordinate DIP creation with:
**Project Manager personality:** `.claude/agents/project-manager.md`
- Technical Architect for implementation approach
- Lead Developer for code structure and patterns
- QA Specialist for test specifications
- DevOps Engineer for deployment requirements
- Documentation Specialist for inline docs and README updates

## Process

### 1. **Initial Assessment**

```bash
# Check for design
if [ ! -d ".sdlc/designs" ] || [ -z "$(ls -A .sdlc/designs/)" ]; then
    echo "ERROR: No designs found. Run '/design' first."
    exit 1
fi

# List available designs
echo "Available designs:"
ls -la .sdlc/designs/*/design.md 2>/dev/null

# Check for existing DIPs
echo "Existing DIPs:"
ls -la .sdlc/implementation/*.md 2>/dev/null || echo "  None found"
```

Parse arguments:
- Empty: Ask which design to implement
- Design path: Use specified design
- Component name: Define specific component only

### 2. **Complexity Analysis**

Read design and assess implementation complexity:

**Complexity Factors:**
- Lines of Code estimate
- Number of components/modules
- Number of integration points
- Database changes required
- API endpoints to create
- Test coverage requirements

**Decision Logic:**
```python
# Pseudocode for splitting decision
estimated_loc = analyze_design_complexity()
component_count = count_distinct_components()
integration_points = count_external_dependencies()

needs_splitting = (
    estimated_loc > 500 OR
    component_count > 3 OR
    integration_points > 2
)

if needs_splitting:
    print("Complex implementation detected. Creating phased DIPs...")
    dip_mode = "phased"
else:
    print("Standard implementation. Creating single DIP...")
    dip_mode = "single"
```

### 3. **Interactive Gathering**

**Step 1: Design Selection**
If not in arguments:
"Which design should we implement? (provide path or number)"

**Step 2: Implementation Review**
"Review the design scope:
- Components: [list from design]
- Estimated LOC: [calculated]
- Complexity: [Simple/Medium/Complex]
Proceed with this scope? (yes/no/adjust)"

**Step 3: Splitting Strategy** (if complex)
"This implementation is complex. Suggested phases:
- Phase A: [Core functionality]
- Phase B: [Enhanced features]
- Phase C: [Optimization/Polish]
Accept this phasing? (yes/no/customize)"

**Step 4: Testing Strategy**
"What testing approach?
- test-first: Write tests before implementation
- test-with: Write tests alongside code
- test-after: Write tests after implementation
Choose: [test-first recommended]"

### 4. **Script Execution**

```bash
# Create DIP structure
DESIGN_NAME=$(basename $(dirname $DESIGN_PATH))
./.claude/scripts/create-dip-structure.sh "$DESIGN_NAME"
# Output: "✓ Created: .sdlc/implementation/001-{name}/"

# Store DIP location
DIP_DIR=".sdlc/implementation/001-$DESIGN_NAME"
```

### 5. **Multi-Agent DIP Generation**

Launch implementation planning team:

```
Use Task tool:
- description: "Generate detailed implementation prompts"
- subagent_type: "general-purpose"
- prompt: "You are a Project Manager coordinating DIP creation. Think hard about creating clear, executable instructions.

  Your task:
  1. Launch these specialists IN PARALLEL using Task tool:
     - Technical Architect: Define implementation architecture and patterns
     - Lead Developer: Specify code structure, files, functions
     - QA Specialist: Define test cases and validation criteria
     - DevOps Engineer: Specify configuration and deployment
     - Documentation Specialist: Define documentation requirements

  2. Each specialist provides for their domain:
     - Detailed task breakdowns
     - File-by-file specifications
     - Code patterns to follow
     - Validation criteria
     - Error handling requirements

  3. Synthesize into DIP sections:
     - Context & Constraints
     - Prerequisites
     - Implementation Tasks (detailed)
     - Testing Specifications
     - Validation Gates
     - Git commit guidelines

  Context:
  - Design: $DESIGN_PATH
  - Components: $COMPONENT_LIST
  - Technology Stack: [from CHARTER.md]
  - Code Style: [from project conventions]
  - Complexity: $COMPLEXITY_ASSESSMENT
  - Phasing: $DIP_MODE

  For each implementation task include:
  - Task number and name
  - Files to create/modify (exact paths)
  - Functions/classes to implement
  - Test cases to write
  - Validation command
  - Estimated time

  Make instructions so clear that an AI agent with no prior context
  except the codebase could execute them successfully.

  Reference: Load Project Manager from .claude/agents/project-manager.md"
```

### 6. **DIP Content Creation**

**Templates to use:**
- Single DIP: `.claude/templates/dip.template.md`
- Phased DIPs: `.claude/templates/dip-phase.template.md`
- Task list: `.claude/templates/task.template.md`
- Discovered tasks: `.claude/templates/task-discovered.template.md`

Based on mode, create appropriate DIP structure:

#### Single DIP Mode
Create `$DIP_DIR/dip.md`:

```markdown
# DIP: [Feature Name]

## Context & Constraints
[From design document]
- Technology stack: [list]
- Dependencies: [list]
- Performance requirements: [list]

## Prerequisites
- [ ] Design approved: $DESIGN_PATH
- [ ] Environment setup complete
- [ ] Dependencies installed

## Implementation Tasks

### Task 1: [Component Name]
**Files to create:**
- `path/to/file1.py` - [purpose]
- `path/to/file2.py` - [purpose]

**Implementation details:**
[Specific instructions, patterns to follow]

**Test specifications:**
- Test case 1: [description]
- Test case 2: [description]

**Validation:**
```bash
# Run tests
pytest path/to/test_file.py -v
```

### Task 2: [Next Component]
[Similar structure...]

## Git Guidelines
- Commit after each task completion
- Format: "feat(component): implement [specific feature]"
- Include test files in same commit

## Validation Gates
1. All tests passing
2. Code coverage > 80%
3. No linting errors
4. Documentation complete
```

#### Phased DIP Mode
Create multiple DIPs:
- `$DIP_DIR/a-core-dip.md` - Core functionality
- `$DIP_DIR/b-enhanced-dip.md` - Enhanced features
- `$DIP_DIR/c-optimization-dip.md` - Polish and optimization

### 7. **Task List Generation**

```bash
# Extract tasks from DIP(s) to create/update TASK.md
./.claude/scripts/extract-tasks-from-dip.sh "$DIP_DIR"
# Output: "✓ Extracted 12 tasks to TASK.md"

# Show task summary
echo "Task Summary:"
grep "^- \[ \]" TASK.md | head -5
echo "..."
echo "Total tasks: $(grep -c "^- \[ \]" TASK.md)"
```

### 8. **Validation & Reporting**

```bash
# Verify DIP creation
echo "✓ DIP(s) created successfully!"
echo "Location: $DIP_DIR"
ls -la $DIP_DIR/*.md

# Report task breakdown
echo ""
echo "Implementation Plan:"
echo "  - DIPs created: $(ls $DIP_DIR/*.md | wc -l)"
echo "  - Total tasks: $(grep -c "^### Task" $DIP_DIR/*.md)"
echo "  - Test cases: $(grep -c "Test case" $DIP_DIR/*.md)"
```

Report next steps:
```
✓ Implementation defined!
  - DIP location: $DIP_DIR
  - Mode: $DIP_MODE
  - Tasks created: $TASK_COUNT
  - Estimated effort: $EFFORT_ESTIMATE

Next steps:
1. Review DIPs for completeness
2. Use '/do' to execute implementation
3. Or use '/do task-1' to execute specific tasks
4. Monitor progress in TASK.md
```

## Embedded Rules

### From `task-management.md`:
- Tasks in TASK.md as simple checklist
- Format: `- [ ] Task description`
- Mark complete with `- [x]`
- Track discovered tasks separately

### From `sequential-file-naming.md`:
- DIP folders: ###-{name}/
- Match design folder naming
- Maintain number sequence

### From `code-structure.md`:
- Enforce max 500 lines per file
- Logical separation of concerns
- Follow existing patterns in codebase

## Error Handling

### Script Failures
- **create-dip-structure.sh fails**:
  ```bash
  mkdir -p .sdlc/implementation/001-$NAME
  touch .sdlc/implementation/001-$NAME/dip.md
  ```

- **extract-tasks-from-dip.sh fails**:
  ```bash
  # Manual task extraction
  grep "^### Task" $DIP_DIR/*.md > tasks.tmp
  # Format into TASK.md manually
  ```

### Design Issues
- **No design found**: Direct to `/design` command
- **Design incomplete**: Warn but proceed with available info
- **Design too vague**: Request clarification on specific points

### Complexity Misjudgment
- If single DIP grows too large during creation:
  - Prompt: "DIP exceeds recommended size. Split into phases?"
  - Regenerate as phased DIPs

### Multi-Agent Conflicts
- **Different task estimates**: Use conservative (larger) estimate
- **Conflicting approaches**: Present options to user
- **Missing expertise**: Note gaps, proceed with available input

## Argument Patterns

```markdown
/define                                    # Interactive selection
/define .sdlc/designs/001-auth            # Specific design
/define 001-auth "backend only"          # Partial implementation
/define --force-single                    # Override splitting logic
```

## DIP Quality Criteria

A good DIP has:
1. **Self-contained context** - No need to read other docs
2. **Exact file paths** - No ambiguity about where code goes
3. **Test specifications** - Clear about what to test
4. **Validation commands** - Executable verification
5. **Code patterns** - References to follow in codebase
6. **Error handling** - What to do when things fail
7. **Git guidelines** - How to commit the work

## Special Considerations

### Atomic Tasks
Each task should be:
- Completable in one sitting (< 2 hours)
- Independently testable
- Committable on its own
- Not dependent on later tasks for basic functionality

### Test-First Encouragement
When test-first chosen:
1. Each task lists tests BEFORE implementation
2. Include test file creation as first subtask
3. Provide test examples that should fail initially

### Pattern References
Always include:
```markdown
**Follow patterns from:**
- Authentication: see `src/auth/login.py`
- API endpoints: see `src/api/users.py`
- Tests: see `tests/test_auth.py`
```

---
Generated with Bootstrap v0.12.0