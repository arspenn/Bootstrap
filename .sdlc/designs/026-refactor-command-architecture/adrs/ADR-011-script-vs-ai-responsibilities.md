---
name: "Script vs AI Agent Responsibility Division"
description: "Clear boundaries between deterministic scripts and AI agent judgment"
---

# ADR-011: Script vs AI Agent Responsibility Division

## Metadata

**Status:** ACCEPTED
**Date:** 2025-01-21
**Decision Makers:** Framework Architecture Team
**Related ADRs:** ADR-003 (Deterministic Scripts), ADR-010 (Section-by-Section)
**Supersedes:** Partial update to ADR-003
**Superseded By:** None

## Summary

Scripts handle mechanical, repetitive tasks (file creation, structure generation, environment checks) while AI agents handle judgment-based tasks (content creation, complexity analysis, user interaction). This division reduces token usage and variability while preserving AI flexibility for decisions.

## Context and Problem Statement

We need clear boundaries between what should be handled by deterministic scripts versus AI agent judgment. Too many scripts reduce flexibility; too few scripts waste tokens and introduce variability.

### Current State
Mixed approach with some operations scripted and others left to AI interpretation, causing inconsistency.

### Requirements and Constraints
- Reduce AI token usage for repetitive tasks
- Maintain AI flexibility for judgment calls
- Ensure consistent output for mechanical operations
- Support multiple AI platforms (Claude, GPT, etc.)

### Assumptions
- Scripts can handle file/folder operations reliably
- AI agents are better at content and complexity judgment
- Users want consistency in structure, flexibility in content

## Decision Drivers

- **Token Efficiency:** Scripts save tokens for mechanical tasks
- **Consistency:** Structure should be identical across runs
- **Flexibility:** Content decisions need AI judgment
- **Maintainability:** Clear boundaries simplify debugging

## Considered Options

### Option 1: Maximum Scripting
**Description:** Script everything possible, AI only fills content
**Pros:**
- Maximum token savings
- Complete consistency
- Predictable behavior

**Cons:**
- Inflexible for edge cases
- Complex script maintenance
- Reduces AI agency

**Estimated Effort:** High
**Risk Level:** MEDIUM

### Option 2: Minimal Scripting
**Description:** Only script critical safety operations
**Pros:**
- Maximum flexibility
- Simple script maintenance
- AI can adapt to context

**Cons:**
- High token usage
- Inconsistent structure
- Variability in output

**Estimated Effort:** Low
**Risk Level:** MEDIUM

### Option 3: Balanced Division
**Description:** Scripts for structure/mechanics, AI for content/judgment
**Pros:**
- Optimal token usage
- Consistent structure
- Flexible content
- Clear responsibilities

**Cons:**
- Need to maintain boundary definitions
- Some edge cases may be ambiguous

**Estimated Effort:** Medium
**Risk Level:** LOW

## Decision Outcome

### Chosen Option
**Option 3: Balanced Division**

### Rationale
The balanced approach leverages scripts for what they do best (consistent mechanical operations) while preserving AI strengths (judgment, interaction, content). This reduces both developer and AI cognitive load while maintaining flexibility.

### Implementation Approach
1. Scripts handle all file/folder creation
2. Scripts generate empty templates with structure
3. AI fills content section by section
4. Scripts run deterministic validations (linting, tests)
5. AI makes judgment calls (complexity, quality)

## Consequences

### Positive Consequences
- ✅ Reduced token usage (est. 40-60% savings)
- ✅ Consistent project structure across all runs
- ✅ AI focuses on high-value content creation
- ✅ Easier to debug issues (structure vs content)
- ✅ Reduced cognitive load for both human and AI

### Negative Consequences
- ❌ More scripts to maintain
- ❌ Need clear documentation of boundaries
- ❌ Some edge cases may not fit cleanly

### Neutral Consequences
- ➖ Different workflow from pure AI approaches
- ➖ Requires script execution capability

### Technical Debt
- Scripts need maintenance as framework evolves
- Cross-platform compatibility for scripts

## Implementation Details

### Script Responsibilities
**Structure & Mechanics:**
- Create directories and files
- Generate sequential numbering
- Copy templates
- Check environment setup
- Run tests and linters
- Git safety checks

**What Scripts DON'T Do:**
- Make complexity judgments
- Evaluate quality
- Choose between options
- Interact with users
- Validate against principles
- Determine phasing needs

### AI Agent Responsibilities
**Content & Judgment:**
- Fill template content
- Analyze complexity
- Make design decisions
- Interact with users
- Ask clarifying questions
- Apply feedback

**What AI DOESN'T Do:**
- Create file structures
- Generate boilerplate
- Run deterministic checks
- Execute repetitive tasks

### Migration Strategy
Gradually move mechanical operations to scripts as identified, starting with structure generation.

### Rollback Plan
Scripts can be bypassed with manual AI operations if needed.

### Success Metrics
- [ ] Token usage reduction: Target 50%
- [ ] Structure consistency: Target 100%
- [ ] User satisfaction: Target >8/10

## Validation and Review

### Validation Approach
Monitor token usage before/after script implementation, track consistency metrics.

### Review Triggers
- Significant edge cases emerge
- Token savings not realized
- 3-month scheduled review

## References and Links

### Internal References
- Design Document: /026-refactor-command-architecture/design.md
- ADR-003: Deterministic Scripts for Safety

### External References
- Unix Philosophy: "Do one thing well"
- Separation of Concerns Principle

## Notes and Considerations

The key insight is that scripts reduce cognitive load for BOTH humans and AI agents by removing mechanical decisions from the interaction space. This allows both parties to focus on meaningful decisions.

### Example Division

**Creating a design document:**
1. Script: Creates `/027-feature-name/` folder
2. Script: Creates `design.md`, `adrs/`, `diagrams/` structure
3. Script: Copies empty templates
4. AI: Fills executive summary
5. Human: Reviews and provides feedback
6. AI: Incorporates feedback, fills next section
7. Script: Runs format validation
8. AI: Makes complexity judgment for phasing

## Approval

| Role | Name | Date | Status |
|------|------|------|--------|
| Technical Lead | [NAME] | 2025-01-21 | APPROVED |
| Architect | [NAME] | 2025-01-21 | APPROVED |
| Product Owner | [NAME] | 2025-01-21 | APPROVED |

---
*Generated by Bootstrap design v0.11.0 on 2025-01-21*