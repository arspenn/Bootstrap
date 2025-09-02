# Quick-Feature Command Design Document

## Executive Summary

The quick-feature command provides a streamlined path for defining small features, bug fixes, and documentation updates. It operates as a parallel implementation to gather-feature-requirements, optimized for speed and simplicity while maintaining compatibility with the design-feature workflow.

## Requirements

### Functional Requirements
- Accept minimal input to generate feature specifications
- Complete feature definition in 2-3 questions maximum
- Detect complexity and escalate to full requirements gathering when needed
- Generate feature files compatible with design-feature command
- Preserve context when escalating to full process
- Auto-generate sequential feature file names (###-feature-title.md)

### Non-Functional Requirements
- **Performance**: Complete interaction in under 30 seconds for simple features
- **Usability**: Minimize cognitive load for developers
- **Compatibility**: Full compatibility with existing design-feature command
- **Intelligence**: Use Claude's analysis to detect complexity and test requirements
- **Flexibility**: Allow override if user insists on quick-feature for complex items

## Current State Analysis

### Existing Components
- `/gather-feature-requirements`: Full requirements gathering command
- `/design-feature`: Consumes feature files for design phase
- Template system in `.claude/templates/`
- Feature file directory structure in `features/`
- Sequential numbering pattern in designs (###-name)

### Integration Points
- Feature file format must match design-feature expectations
- Templates shared between commands
- Sequential numbering scheme to be standardized

## Proposed Design

### Overview
Quick-feature will be implemented as an independent command that shares templates and file formats with gather-feature-requirements. It uses intelligent analysis to determine feature complexity and either proceeds with minimal questions or escalates to the full process.

### Architecture

#### Component Responsibilities

**Input Parser**
- Extract available information from user input
- Identify user story components if present
- Detect technical context and constraints

**Complexity Analyzer**
- Use Claude's understanding to assess feature scope
- Check for multi-file impact indicators
- Detect test requirement signals
- Identify patterns that suggest complexity (initially empty, grows over time)

**Question Generator**
- Determine missing essential information
- Generate 1-2 targeted questions maximum
- Skip questions if information can be inferred

**File Generator**
- Apply feature-quick.template.md
- Generate sequential filename (###-feature-title.md)
- Ensure design-feature compatibility

**Escalation Handler**
- Generate comprehensive context summary
- Include discovered user story elements
- Format for gather-feature-requirements consumption
- Provide clear handoff message

### Data Flow

1. User invokes `/quick-feature` with optional description
2. Input parser extracts available information
3. Complexity analyzer evaluates scope
4. Based on complexity:
   - **Simple**: Generate 1-2 questions, create file
   - **Complex**: Generate context summary, suggest escalation
   - **Complete**: Generate file directly
5. Output feature file to `features/` directory

### Design Decisions

See [ADR-001: Parallel Implementation](adrs/ADR-001-parallel-implementation.md)

**Key Decisions**:
- Parallel implementation over wrapper or modular approach
- Claude's intelligent analysis over pattern matching
- Natural language context summaries for escalation
- Sequential numbering following design pattern (###-title)

## Alternative Approaches Considered

### Alternative 1: Minimal Wrapper
- Would reuse gather-feature-requirements code
- Rejected due to unnecessary complexity inheritance
- Less flexibility for quick-feature optimizations

### Alternative 3: Modular Service Approach
- Would extract shared functionality into modules
- Deferred due to uncertainty about Claude Code's module support
- Added to backlog for future consideration

## Implementation Plan

### Phase 1: Core Implementation
1. Create `/quick-feature` command file
2. Implement input parsing logic
3. Build complexity analyzer with Claude's intelligence
4. Create question generation for minimal interaction
5. Implement file generation with template

### Phase 2: Escalation Flow
1. Build escalation detection logic
2. Create context summary generator
3. Implement handoff to gather-feature-requirements
4. Add override capability for user insistence

### Phase 3: Enhancement
1. Add pattern learning section (initially empty)
2. Implement file naming rule
3. Update gather-feature-requirements with same naming rule
4. Create tests for both paths

### Suggested Order
1. Start with basic command structure
2. Add simple path (input → questions → file)
3. Add complexity detection
4. Add escalation path
5. Refine based on usage patterns

## Risks and Mitigations

### Technical Risks

**Risk**: Incorrect complexity assessment
- **Impact**: Users forced through full process unnecessarily
- **Mitigation**: Allow override option, learn from usage patterns

**Risk**: Inconsistent file formats between commands
- **Impact**: design-feature compatibility issues
- **Mitigation**: Shared templates, validation testing

**Risk**: Code divergence over time
- **Impact**: Maintenance burden, inconsistent behavior
- **Mitigation**: Document shared patterns, consider future refactoring

### Project Risks

**Risk**: User confusion about which command to use
- **Impact**: Poor user experience
- **Mitigation**: Clear documentation, intelligent suggestions

## Success Criteria

- Quick-feature completes in <30 seconds for simple features
- 90% of simple features need ≤2 questions
- Correct complexity detection 80% of the time
- Zero compatibility issues with design-feature
- Clear escalation path preserves all context
- Users report improved workflow for small changes

## Complexity Detection Patterns

### Initial Patterns (to be expanded)
```markdown
## Patterns Indicating Complexity
(This section starts empty and grows from experience)

### Keywords/Phrases
- (To be added as discovered)

### Structural Indicators
- (To be added as discovered)

### Domain Patterns
- (To be added as discovered)
```

## File Naming Rule

### Format: `###-feature-title.md`

**Implementation**:
1. Get next sequential number from existing features/
2. Convert feature title to kebab-case
3. Combine: `{number:03d}-{kebab-title}.md`

**Examples**:
- "Fix login button" → `001-fix-login-button.md`
- "Update API docs" → `002-update-api-docs.md`
- "Add user avatar" → `003-add-user-avatar.md`

This rule will be implemented in both quick-feature and gather-feature-requirements for consistency.

---
*Design document for quick-feature command implementation*