---
name: "Design Implementation Prompt (DIP) - Phase 1D Agent Personalities"
description: "Implementation of core agent personality templates for multi-agent architecture"
---

# DIP: Phase 1D - Core Agent Personalities

## Implementation Context

**Design Reference:** `.sdlc/designs/026-refactor-command-architecture/design.md` (lines 887-1106)
**Requirements Reference:** Multi-Agent Architecture (ADR-012)
**Target Branch:** main
**Estimated Effort:** 2 hours
**Priority:** HIGH

## Objective

Create the foundational agent personality templates that will be referenced by the 4D+1 workflow commands to provide consistent, role-specific behavior for sub-agents in Bootstrap's multi-agent architecture.

### Success Criteria
- [ ] 4 core agent personalities created/updated in `.claude/agents/`
- [ ] 1 domain expert template created in `.claude/templates/`
- [ ] All agents include "think hard" directive
- [ ] All agents follow existing template structure
- [ ] No placeholders remain in concrete agents

## Context & Constraints

### Technical Context
- **Language/Version:** Markdown agent definitions
- **Key Dependencies:** Claude Code Task tool, General-purpose subagent_type
- **Target Environment:** `.claude/agents/` (concrete agents), `.claude/templates/` (domain template)
- **Performance Targets:** Agents under 100 lines each

### Existing Code Context
- **Related Files:**
  - `.claude/templates/`: Existing template directory
  - Design document: Phase 1D specification (lines 887-1106)
- **Patterns to Follow:**
  - Use existing `agent-personality.template.md` structure
  - Agent naming: `{role}.md` in `.claude/agents/`
  - Template naming: `{name}.template.md` in `.claude/templates/`

### Known Constraints
- Maximum 2 agents can run in parallel (ADR-013)
- Templates must trigger "think hard" mode
- JSONL session logging happens automatically

## Implementation Tasks

### Task 1: Create Requirements Engineer Agent
**File:** `.claude/agents/requirements-engineer.md`
**Action:** CREATE

Implement the Requirements Engineer personality using the existing template at `.claude/templates/agent-personality.template.md`. This is the primary agent that interfaces with users.

**Template already exists - use it to create agent with these values:**
- `[AGENT_NAME]`: Requirements Engineer
- `[ROLE_TITLE]`: Requirements Engineer
- `[EXPERTISE_LEVEL]`: PhD-level
- `[DOMAIN]`: the project's primary domain
- `[FOCUS_AREA]`: understanding user needs completely before any implementation
- Include YAML frontmatter like the template

### Task 2: Update Project Manager Agent
**File:** `.claude/agents/project-manager.md`
**Action:** MODIFY

Update the existing Project Manager to align with Phase 1D specifications while preserving valuable existing content.

**Preservation Required:**
- Keep existing sections 1-4 (Core Responsibilities through Communication)
- Keep existing Task Focus and Output sections

**Key updates needed:**
- ADD to Core Identity: "Think hard about keeping all team members aligned and productive"
- ADD to Operating Framework: "Maximum 2 agents can execute in parallel (ADR-013)"
- ADD new subsection under Interaction Style: "### Synthesis Requirements"
  - "Synthesize all agent outputs before returning to Requirements Engineer"
  - "Present consensus recommendation with alternatives when agents disagree"
- MODIFY Decision Making: Add "Synthesis before returning results" to priorities

### Task 3: Create Technical Architect Agent
**File:** `.claude/agents/technical-architect.md`
**Action:** CREATE

Implement the Technical Architect personality using the template.

**Key Implementation Points:**
- Must include "Think hard about scalability, maintainability, and technical excellence"
- Focus on architecture patterns and technology selection
- Balance ideal design with practical constraints
- Include ADR creation in outputs
- Document non-functional requirements consideration

### Task 4: Create QA Specialist Agent
**File:** `.claude/agents/qa-specialist.md`
**Action:** CREATE

Implement the Quality Assurance Specialist personality.

**Key Implementation Points:**
- Must include "Think hard about what could go wrong and how to prevent it"
- Think like both user and breaker
- Focus on risk-based testing
- Quality is non-negotiable principle
- Include edge case identification

### Task 5: Create Domain Expert Template
**File:** `.claude/templates/agent-domain-expert.template.md`
**Action:** CREATE

Create a flexible, parameterized template for domain-specific experts.

**Template Parameters:**
- `[DOMAIN]` - The specific domain (e.g., healthcare, finance, aerospace)
- `[INDUSTRY/ACADEMIC]` - Type of expertise background
- `[SPECIFIC_FIELD]` - Detailed area of study
- `[DOMAIN_SPECIFIC_INSIGHTS]` - Unique perspective from this domain

**Key Implementation Points:**
- Must be adaptable to any domain
- Include compliance/regulatory considerations
- Bridge domain knowledge to technical requirements
- Use clear placeholder markers throughout

### Task 6: Verify Template Structure
**Action:** VERIFY

Ensure the base template exists and all agents follow its structure.

**Verification Steps:**
1. Confirm `.claude/templates/agent-personality.template.md` exists
2. Verify all created agents use the template structure
3. Check that all `[PLACEHOLDER]` markers are replaced in agents
4. Ensure no placeholders remain in concrete agent files

**Required Examples:**
```markdown
## Basic Usage with Task Tool
Use Task tool:
- description: "Analyze requirements"
- subagent_type: "general-purpose"
- prompt: "Load personality from .claude/templates/agent-requirements-engineer.md
  [Include full personality content]
  Additional context: [specific task details]"

## Domain Expert Customization
For healthcare project:
- Replace [DOMAIN] with "Healthcare"
- Replace [SPECIFIC_FIELD] with "HIPAA Compliance"
- Add context about specific regulations

## Multi-Agent Coordination
Requirements Engineer launches Project Manager:
- Project Manager then launches specialists
- Maximum 2 specialists in parallel
- Synthesis before returning to Requirements Engineer
```

## Validation Requirements

### Level 1: File Structure Validation
```bash
# Verify all agent files exist in correct location
ls -la .claude/agents/requirements-engineer.md && echo "✓ Requirements Engineer created"
ls -la .claude/agents/project-manager.md && echo "✓ Project Manager exists"
ls -la .claude/agents/technical-architect.md && echo "✓ Technical Architect created"
ls -la .claude/agents/qa-specialist.md && echo "✓ QA Specialist created"

# Verify template files
ls -la .claude/templates/agent-personality.template.md && echo "✓ Base template exists"
ls -la .claude/templates/agent-domain-expert.template.md && echo "✓ Domain expert template created"
```

### Level 2: Content Validation
```bash
# Check for "think hard" directives in all agents
for file in .claude/agents/requirements-engineer.md \
           .claude/agents/project-manager.md \
           .claude/agents/technical-architect.md \
           .claude/agents/qa-specialist.md; do
    if [ -f "$file" ]; then
        grep -qi "think hard" "$file" && echo "✓ $(basename $file) has think directive" || echo "✗ $(basename $file) missing think directive"
    fi
done

# Verify domain expert template has placeholders
grep -q "\[DOMAIN\]" .claude/templates/agent-domain-expert.template.md && echo "✓ Domain expert is parameterized"

# Verify no placeholders remain in concrete agents
for file in .claude/agents/*.md; do
    if [ -f "$file" ]; then
        ! grep -q "\[.*\]" "$file" && echo "✓ $(basename $file) has no placeholders" || echo "✗ $(basename $file) still has placeholders"
    fi
done
```

### Level 3: Integration Verification
```bash
# Verify agents follow template structure
for file in .claude/agents/requirements-engineer.md \
           .claude/agents/technical-architect.md \
           .claude/agents/qa-specialist.md; do
    if [ -f "$file" ]; then
        grep -q "## Core Identity" "$file" && \
        grep -q "## Expertise" "$file" && \
        grep -q "## Task Focus" "$file" && \
        echo "✓ $(basename $file) follows template structure" || \
        echo "✗ $(basename $file) missing required sections"
    fi
done

# Verify Project Manager has synthesis requirements
grep -q "Synthesis Requirements" .claude/agents/project-manager.md && echo "✓ PM has synthesis section"
grep -q "2 agents" .claude/agents/project-manager.md && echo "✓ PM documents parallel limit"
```

## Git Commit Requirements

### Commit Structure
```
feat(agents): implement core agent personality templates for phase 1d

- Create base personality template structure
- Implement 5 core agent personalities (Requirements Engineer, PM, Architect, QA, Domain Expert)
- Add usage documentation with Task tool examples
- All personalities include "think hard" directive

Implements: Phase 1D of command refactoring design
```

### Commit Guidelines
- Single commit for all personality templates (they're interdependent)
- Ensure all validation checks pass before committing
- No need to update CHANGELOG.md during implementation phase

## Common Pitfalls to Avoid

- ❌ Don't forget the "think hard" directive in each personality
- ❌ Don't make templates too long (keep under 100 lines)
- ❌ Don't hardcode domain-specific information in the base templates
- ✅ Instead: Use parameterized templates for flexibility

## Dependencies & Integration Points

### Command Integration
The personality templates will be referenced by:
- `/init.md` - Uses Requirements Engineer to assess project
- `/determine.md` - Requirements Engineer leads elicitation
- `/design.md` - Technical Architect leads design
- `/define.md` - Project Manager coordinates DIP creation
- `/do.md` - Specialized implementers for components

### Task Tool Usage
Templates are loaded into Task tool prompts:
```javascript
// Example from command
Use Task tool:
- subagent_type: "general-purpose"
- prompt: "[Load full personality content from template file]"
```

## Documentation Requirements

### Code Documentation
- All public functions must have docstrings
- Complex logic must include inline comments
- README updates if applicable

### User Documentation
- [ ] Update user guide if user-facing
- [ ] Update API documentation if applicable
- [ ] Update changelog

## Rollback Plan

If implementation fails or causes issues:
1. [ROLLBACK_STEP_1]
2. [ROLLBACK_STEP_2]
3. [ROLLBACK_STEP_3]

## Definition of Done

- [ ] Requirements Engineer agent created in `.claude/agents/`
- [ ] Project Manager agent updated with synthesis requirements
- [ ] Technical Architect agent created in `.claude/agents/`
- [ ] QA Specialist agent created in `.claude/agents/`
- [ ] Domain expert template created in `.claude/templates/`
- [ ] All agents include "think hard" directive
- [ ] All agents follow existing template structure
- [ ] All validation commands pass successfully

## Additional Resources

- **Design Patterns:** [REFERENCE_LINK]
- **API Documentation:** [REFERENCE_LINK]
- **Testing Guide:** [REFERENCE_LINK]
- **Style Guide:** [REFERENCE_LINK]

## Notes for Implementer

[ANY_SPECIAL_INSTRUCTIONS_OR_CONTEXT]

---
*Generated by Bootstrap /define v[VERSION] on 2025-09-24*