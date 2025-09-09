# Workflow Guide

## Overview

Bootstrap implements a structured workflow that takes you from idea to implementation through well-defined phases. This workflow ensures quality, maintainability, and consistency.

## Core Workflow

### Phase 1: Feature Definition
Start by creating a feature request using the template:

```bash
cp FEATURE_TEMPLATE.md .sdlc/features/FEATURE_YOUR_FEATURE.md
```

Include:
- Clear description of what needs to be built
- Examples of similar features
- Relevant documentation
- Success criteria

### Phase 2: Design (Optional but Recommended)
For complex features, use the design command:

```bash
/design-feature .sdlc/features/FEATURE_YOUR_FEATURE.md
```

This produces:
- Design document with alternatives considered
- Architecture Decision Records (ADRs)
- Clear implementation approach

### Phase 3: PRP Generation
Transform your feature or design into an executable prompt:

```bash
# From design
/generate-prp .sdlc/designs/001-feature-your-feature/design.md

# Or directly from feature
/generate-prp .sdlc/features/FEATURE_YOUR_FEATURE.md
```

The PRP contains:
- All context needed for implementation
- Step-by-step tasks
- Validation commands
- Success criteria

### Phase 4: Implementation
Execute the PRP to implement the feature:

```bash
/execute-prp .sdlc/PRPs/your-feature.md
```

Claude will:
- Implement each task
- Run validations
- Fix any issues
- Ensure tests pass

### Phase 5: Verification
After implementation:
- Review the changes
- Run tests manually if desired
- Update CHANGELOG.md
- Commit changes

## When to Use Each Phase

### Skip Design Phase When:
- Requirements are crystal clear
- Implementation approach is obvious
- Feature is isolated with minimal impact
- Similar features exist as patterns

### Use Full Workflow When:
- Requirements need clarification
- Multiple approaches are possible
- Feature impacts multiple components
- Non-functional requirements are critical

## Workflow Patterns

### Standard Feature Development
```
Feature Request → Design → PRP → Implementation → Testing → Commit
```

### Quick Fix
```
Feature Request → PRP → Implementation → Commit
```

### Design Exploration Only
```
Feature Request → Design → Team Review → Refinement
```

### Implementation from Existing Design
```
External Design → PRP → Implementation → Testing → Commit
```

## File Organization

The workflow creates files in a structured manner:

```
.sdlc/features/     # Feature requests
├── FEATURE_AUTH.md
├── FEATURE_LOGGING.md

.sdlc/designs/      # Design documents
├── 001-feature-auth/
│   ├── design.md
│   └── adrs/
├── 002-feature-logging/
│   ├── design.md
│   └── adrs/

.sdlc/PRPs/        # Implementation prompts
├── auth.md
├── logging.md

src/               # Implementation
tests/             # Test files
docs/              # Documentation
```

## Rules Integration

Throughout the workflow, rules automatically enforce:
- Git safety (git-safe-file-operations)
- Commit standards (git-commit-format)
- Documentation updates (changelog-update)
- Test requirements (pytest-requirements)
- Code style (code-style)

## Best Practices

### Feature Requests
- Be specific about requirements
- Include examples and documentation
- Define clear success criteria
- Note any constraints

### Design Phase
- Answer all clarifying questions thoroughly
- Consider at least 2 alternatives
- Document trade-offs explicitly
- Create ADRs for significant decisions

### PRP Generation
- Review the generated PRP before execution
- Ensure all context is included
- Verify validation commands are appropriate

### Implementation
- Let execute-prp complete fully
- Trust the validation process
- Review changes before committing

## Common Scenarios

### Adding a New API Endpoint
1. Create feature request with endpoint specifications
2. Design if authentication/authorization is complex
3. Generate PRP with API patterns from codebase
4. Execute to create endpoint, tests, and documentation

### Refactoring Existing Code
1. Create feature request describing the refactoring
2. Design to explore approach and impact
3. Generate PRP with careful attention to breaking changes
4. Execute with thorough testing

### Bug Fix
1. Create minimal feature request describing the bug
2. Skip design (unless root cause is unclear)
3. Generate PRP focused on the fix
4. Execute and validate fix doesn't break other features

### Documentation Update
1. Create feature request for documentation needs
2. Skip design
3. Generate PRP for documentation changes
4. Execute to update docs

## Troubleshooting

### Feature Request Issues
- **Too vague**: Add specific examples and success criteria
- **Too large**: Break into smaller features
- **Missing context**: Add documentation links and examples

### Design Issues
- **Unclear requirements**: Re-run design-feature for clarification
- **Missing alternatives**: Manually add alternatives to consider
- **No decision made**: Create ADR to document choice

### PRP Issues
- **Missing context**: Add more documentation references
- **Validation failing**: Check validation commands are correct
- **Too complex**: Break into smaller PRPs

### Implementation Issues
- **Tests failing**: Let execute-prp fix automatically
- **Unexpected behavior**: Check PRP instructions are clear
- **Integration problems**: Verify design considered all touchpoints

## Tips for Success

1. **Start small** - Get familiar with the workflow on simple features
2. **Trust the process** - The workflow catches issues early
3. **Document decisions** - Future you will thank present you
4. **Use examples** - Reference existing code patterns
5. **Iterate** - Refine features and designs as you learn

The workflow is designed to be flexible while maintaining quality. Adapt it to your needs while preserving the core validation and documentation principles.