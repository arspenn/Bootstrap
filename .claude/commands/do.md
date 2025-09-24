# Do - Implementation Execution

## Arguments: $ARGUMENTS

Execute the Detailed Implementation Prompt (DIP) to build the solution. Accepts optional task number or range to execute specific tasks.

## When to Use This Command

**Use `/do` when:**
- DIP is ready and reviewed
- Environment is set up correctly
- Ready to write actual code
- Executing specific tasks from TASK.md
- Implementing test-first development

**Skip when:**
- No DIP exists (run `/define` first)
- Environment not configured
- Dependencies not installed
- Design not approved

## Multi-Agent Architecture

### Primary Agent: Requirements Engineer
You are the Requirements Engineer overseeing implementation. Think hard about following specifications exactly, maintaining code quality, and ensuring all validation passes.

### Agent Team for Complex Tasks
When encountering complex implementation challenges, launch specialists:
- Senior Developer for algorithm implementation
- Test Engineer for test creation
- Performance Engineer for optimization
- Security Engineer for secure coding
- Code Reviewer for quality checks

## Process

### 1. **Initial Assessment**

```bash
# Check for DIP
if [ ! -d ".sdlc/implementation" ] || [ -z "$(ls -A .sdlc/implementation/)" ]; then
    echo "ERROR: No DIP found. Run '/define' first."
    exit 1
fi

# Find most recent DIP
DIP_DIR=$(ls -dt .sdlc/implementation/*/ | head -1)
echo "Found DIP: $DIP_DIR"

# Check for TASK.md
if [ ! -f "TASK.md" ]; then
    echo "WARNING: TASK.md not found. Tasks won't be tracked."
fi

# Environment check
./.claude/scripts/check-environment.sh
if [ $? -ne 0 ]; then
    echo "ERROR: Environment check failed. Fix issues before proceeding."
    exit 1
fi
```

Parse arguments:
- Empty: Execute all tasks in sequence
- Task number (e.g., "5"): Execute specific task
- Task range (e.g., "3-7"): Execute task range
- DIP file: Use specific DIP

### 2. **DIP Loading and Analysis**

```bash
# Identify DIP file(s)
if [ -f "$DIP_DIR/dip.md" ]; then
    echo "Single DIP mode"
    DIP_FILES="$DIP_DIR/dip.md"
elif ls $DIP_DIR/*-dip.md > /dev/null 2>&1; then
    echo "Phased DIP mode"
    DIP_FILES=$(ls $DIP_DIR/*-dip.md | sort)
else
    echo "ERROR: No DIP files found in $DIP_DIR"
    exit 1
fi
```

Read DIP and extract:
- Task list
- Test strategy
- Validation requirements
- Git commit guidelines

### 3. **Task Execution Flow**

For each task in DIP (or specified range):

**Step 1: Task Preparation**
```markdown
echo "Starting Task $TASK_NUM: $TASK_NAME"
echo "Files to create/modify:"
[List files from DIP]

# Mark task as in-progress in TASK.md (if exists)
if [ -f "TASK.md" ]; then
    sed -i "s/- \[ \] $TASK_NAME/- \[🔄\] $TASK_NAME/" TASK.md
fi
```

**Step 2: Test Creation (if test-first)**
```bash
if [ "$TEST_STRATEGY" = "test-first" ]; then
    echo "Creating tests first..."
    # Create test files as specified in DIP
    # Tests should fail initially
fi
```

**Step 3: Implementation**
Based on task complexity, either implement directly or launch specialists:

```
# For complex algorithms or security-critical code
Use Task tool:
- description: "Implement $TASK_NAME with validation"
- subagent_type: "general-purpose"
- prompt: "You are a Senior Developer. Think hard about code quality and correctness.

  Task: Implement $TASK_NAME

  Specifications from DIP:
  [Include exact specifications from DIP]

  Requirements:
  1. Follow existing code patterns in: [reference files]
  2. Include comprehensive error handling
  3. Add inline documentation
  4. Ensure thread safety if applicable
  5. Optimize for [performance/memory/readability]

  Files to create/modify:
  [List from DIP]

  Validation must pass:
  - All tests in [test file]
  - Linting with project standards
  - Type checking if applicable

  Return the complete implementation with explanations."
```

**Step 4: Code Creation**
- Read existing files before modifying (CRITICAL)
- Follow patterns from codebase
- Include error handling
- Add appropriate logging
- Write clean, documented code

**Step 5: Validation**
```bash
# Run tests for this task
./.claude/scripts/run-tests.sh $TEST_FILE
if [ $? -ne 0 ]; then
    echo "ERROR: Tests failed for $TASK_NAME"
    echo "Fix the implementation and retry"
    # DO NOT mark task complete
    exit 1
fi

# Run linting
./.claude/scripts/lint-check.sh $FILES_MODIFIED
if [ $? -ne 0 ]; then
    echo "WARNING: Linting issues detected"
    echo "Fix before committing"
fi
```

**Step 6: Task Completion**
```bash
# Mark task complete in TASK.md (if exists)
if [ -f "TASK.md" ]; then
    sed -i "s/- \[.*\] $TASK_NAME/- \[x\] $TASK_NAME/" TASK.md
    echo "✓ Task $TASK_NUM complete: $TASK_NAME"
else
    echo "✓ Task $TASK_NUM complete (not tracked in TASK.md)"
fi
```

### 4. **Multi-Agent Code Review** (for critical code)

For security-critical or complex implementations:

```
Use Task tool:
- description: "Review implementation for quality and security"
- subagent_type: "general-purpose"
- prompt: "You are a Code Reviewer. Think hard about finding issues.

  Review this implementation:
  - Files changed: [list]
  - Purpose: $TASK_NAME

  Check for:
  1. Security vulnerabilities
  2. Performance issues
  3. Error handling gaps
  4. Code style violations
  5. Missing edge cases
  6. Documentation completeness

  Return:
  - Issues found (if any)
  - Suggestions for improvement
  - Security assessment
  - Performance notes"
```

### 5. **Progressive Implementation**

Continue through tasks sequentially:
1. Complete Task 1
2. Verify it works independently
3. Proceed to Task 2
4. Ensure Task 2 doesn't break Task 1
5. Continue until all tasks complete

### 6. **Final Validation**

After all tasks complete:

```bash
echo "Running final validation suite..."

# Full test run
./.claude/scripts/run-tests.sh
TEST_RESULT=$?

# Linting check
./.claude/scripts/lint-check.sh
LINT_RESULT=$?

# Environment verification
./.claude/scripts/check-environment.sh
ENV_RESULT=$?

if [ $TEST_RESULT -eq 0 ] && [ $LINT_RESULT -eq 0 ] && [ $ENV_RESULT -eq 0 ]; then
    echo "✓ All validation passed!"
else
    echo "✗ Validation issues detected. Review and fix."
fi
```

### 7. **Safe Staging**

```bash
# Stage only safe files
echo "Staging safe files..."
./.claude/scripts/git-safe-add.sh $FILES_CREATED $FILES_MODIFIED

# Show what's staged
git status

echo "Ready to commit. Use git commit with message format:"
echo "  feat($COMPONENT): implement $FEATURE_NAME"
echo ""
echo "Include in commit message:"
echo "  - Main changes"
echo "  - Tests added"
echo "  - Any known limitations"
```

## Embedded Rules

### From `test-first`:
- Write tests before implementation when specified
- Tests should fail initially
- Implementation complete when tests pass

### From `code-structure.md`:
- Max 500 lines per file
- Logical separation of concerns
- Follow existing patterns

### From `git-safe-file-operations.md`:
- Never stage sensitive files
- Use git-safe-add.sh for staging
- Review staged files before commit

### From `task-management.md`:
- Update TASK.md in real-time (if exists)
- Mark tasks complete only when validated
- Track discovered issues separately

## Error Handling

### Test Failures
When tests fail:
1. **Do NOT** mark task complete
2. Show exact failure message
3. Suggest debugging approach:
   ```bash
   # Run specific failing test
   pytest path/to/test.py::TestClass::test_method -vv

   # Check implementation against DIP specs
   # Fix implementation (not tests unless specs wrong)
   ```

### Linting Errors
When linting fails:
```bash
# Show specific issues
./.claude/scripts/lint-check.sh --verbose

# Common fixes:
# - Format with black (Python)
# - Fix with eslint --fix (JavaScript)
# - Follow project style guide
```

### Environment Issues
When environment check fails:
```bash
# Missing dependencies
echo "Install with: pip install -r requirements.txt"

# Wrong Python version
echo "Switch with: pyenv local 3.9.0"

# Missing tools
echo "Install: [specific tool]"
```

### Partial Implementation
If blocked on a task:
1. Mark as blocked in TASK.md: `- [⚠️] Task name - BLOCKED: [reason]`
2. Document issue in comments
3. Continue with next independent task
4. Return to blocked task later

### Git Conflicts
If git-safe-add.sh blocks files:
```bash
# Check why blocked
./.claude/scripts/git-safe-add.sh --dry-run $FILE

# If false positive, add manually with caution
# If real issue, fix before staging
```

## Argument Patterns

```markdown
/do                          # Execute all tasks
/do 5                       # Execute task 5 only
/do 3-7                     # Execute tasks 3 through 7
/do backend                 # Execute backend tasks only
/do --continue              # Continue from last incomplete task
/do --validate-only         # Run validation without implementation
```

## Progress Tracking

Monitor implementation progress:
```bash
# Check TASK.md for status (if exists)
if [ -f "TASK.md" ]; then
    echo "Progress:"
    echo "  Completed: $(grep -c "^\- \[x\]" TASK.md)"
    echo "  In Progress: $(grep -c "^\- \[🔄\]" TASK.md)"
    echo "  Blocked: $(grep -c "^\- \[⚠️\]" TASK.md)"
    echo "  Remaining: $(grep -c "^\- \[ \]" TASK.md)"
else
    echo "Progress tracking not available (TASK.md not found)"
fi
```

## Quality Guidelines

### Code Quality Checklist
- [ ] Tests written and passing
- [ ] Error handling comprehensive
- [ ] Documentation/comments added
- [ ] Logging appropriate
- [ ] Security considered
- [ ] Performance acceptable
- [ ] Follows project patterns
- [ ] No hardcoded values

### When to Request Review
Request human or AI review when:
- Implementing security features
- Modifying critical path code
- Uncertain about approach
- Performance-critical sections
- Complex algorithms

## Discovered Work

Track new tasks discovered during implementation using template:
**Template:** `.claude/templates/task-discovered.template.md`

```markdown
## Discovered During Implementation
- [ ] Refactor X for better performance
- [ ] Add additional validation for Y
- [ ] Create helper function for Z
- [ ] Update documentation for new feature
```

Add these to TASK.md under separate section (if TASK.md exists) for future work.

---
Generated with Bootstrap v0.12.0