# Feature: Insight Capture Command

**Date**: 2025-09-02
**Priority**: High
**Status**: Requirements Gathered
**INVEST Score**: I:✓ N:✓ V:✓ E:✓ S:✓ T:✓
**Ambiguity Level**: Low
**Completeness**: 95%

## User Story

As a Bootstrap framework developer
I want to capture insights about functionality and limitations as I discover them
So that I can improve the framework without losing valuable discoveries during testing

## Acceptance Criteria

### Scenario 1: Capture Current Discussion
- **Given** I've discovered an issue or limitation while testing Bootstrap
- **When** I run `/insight-capture "what we were just talking about"`
- **Then** Claude analyzes the conversation context and creates a structured insight document

### Scenario 2: Natural Language References
- **Given** I want to document a discovery using natural language
- **When** I run `/insight-capture "this bug"` or `/insight-capture "the issue we found"`
- **Then** Claude interprets the reference and captures the relevant context

### Scenario 3: Manual Insight Description
- **Given** I want to explicitly describe an insight
- **When** I run `/insight-capture "The /reset-framework command doesn't handle symlinks properly"`
- **Then** Claude creates an insight document with the provided information

### Scenario 4: Categorization and Structure
- **Given** An insight has been captured
- **When** The export file is generated
- **Then** It includes type (Bug/Enhancement/Limitation/Discovery), severity, impact, and proposed solutions

## Boundaries and Constraints

### In Scope
- Capture insights from conversation context
- Interpret natural language references
- Auto-categorize discoveries (bug, enhancement, limitation, insight)
- Generate structured documentation
- Include reproduction steps when applicable
- Suggest workarounds and solutions
- Create actionable tasks for TASK.md

### Out of Scope
- Modifying existing TASK.md entries
- Exporting existing tasks (use task-export for that)
- Cross-project synchronization
- Automatic fix implementation
- Git operations or commits

### System Limits
- Conversation context limited to current session
- Cannot access previous Claude sessions
- File output only (no database or API calls)

### Edge Cases
- Ambiguous references → Ask for clarification
- No recent relevant context → Prompt for explicit description
- Multiple issues in conversation → Focus on most recent or ask which one

## Dependencies

### Requires (Upstream)
- Access to conversation history/context
- .claude/config.yaml for project metadata
- File system write access

### Required By (Downstream)
- Framework improvement workflow
- Task creation from insights
- Documentation updates

### Integration Points
- Could optionally update TASK.md with new tasks
- Exports complement design documents
- Insights feed into feature requests

## Technical Implementation

### Command Interface
```
/insight-capture                           # Interactive mode
/insight-capture "what we just discussed"  # Context reference
/insight-capture "specific description"    # Direct capture
```

### Export Format
```markdown
# Bootstrap Insight: {Generated Title}

**Type**: {Bug|Enhancement|Limitation|Discovery}
**Date Discovered**: YYYY-MM-DD
**Project**: {from config.yaml}
**Framework Version**: {from config.yaml}
**Severity**: {High|Medium|Low}

## Summary
{One-line description}

## Context
**What was being attempted:**
{Description of the task or goal}

**What happened:**
{Description of the issue or discovery}

## Details
{Full explanation with examples}

## Reproduction Steps (if applicable)
1. {Step}
2. {Step}

## Impact
- **Development**: {How this affects workflow}
- **Framework**: {Impact on Bootstrap}
- **Users**: {Impact on future users}

## Proposed Solution
{Suggested fix or enhancement}

## Workaround
{Temporary solution if available}

## Action Items
- [ ] Create task in TASK.md
- [ ] Update documentation
- [ ] Implement fix
```

### File Organization
- Save to: `exports/insights/YYYY-MM-DD-{title-slug}.md`
- Alternative: `exports/insights/{type}/YYYY-MM-DD-{title}.md`
- Generate descriptive slugs from insight summary

## Context Analysis Features

### Natural Language Processing
- Understand references: "this", "that issue", "what we discussed"
- Identify temporal references: "just now", "earlier", "when we tried"
- Extract problem statements from conversation
- Identify attempted solutions and their outcomes

### Auto-Categorization Logic
- **Bug**: Something not working as documented
- **Enhancement**: Missing functionality that would improve workflow
- **Limitation**: Design constraints or architectural boundaries
- **Discovery**: Useful patterns or unexpected capabilities

### Severity Assessment
- **High**: Blocks development or causes data loss
- **Medium**: Workaround exists but impacts productivity
- **Low**: Minor inconvenience or cosmetic issue

## Value Proposition

### Primary Benefits
1. **Zero-friction capture**: Document insights without breaking flow
2. **Context preservation**: Never lose important discoveries
3. **Framework improvement**: Systematic collection of enhancement opportunities
4. **Knowledge transfer**: Share discoveries across Bootstrap instances

### Success Metrics
- Time from discovery to documentation: < 30 seconds
- Context completeness: > 90% of relevant information captured
- Actionability: Each insight generates at least one task
- Discoverability: Insights easily found and understood later

## Open Questions

1. Should insights automatically create TASK.md entries?
2. Should we support batch capture of multiple insights?
3. How to handle insights that span multiple categories?
4. Should there be a review/confirmation step before export?

## Examples

### Example 1: Bug Discovery
```
/insight-capture "what we just discussed about the config file"

→ Creates: exports/insights/2025-09-02-config-yaml-django-settings-bug.md
```

### Example 2: Enhancement Idea
```
/insight-capture "It would be helpful if commands could share context"

→ Creates: exports/insights/2025-09-02-shared-command-context-enhancement.md
```

### Example 3: Framework Limitation
```
/insight-capture "the issue with parallel command execution"

→ Creates: exports/insights/2025-09-02-parallel-execution-limitation.md
```

---
*Generated by gather-feature-requirements command*
*Ready for design phase: `/design-feature .sdlc/features/024-insight-capture-command.md`*