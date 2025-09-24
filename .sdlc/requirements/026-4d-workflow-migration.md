# Requirements: 4D+1 Workflow Migration

## Metadata
- **ID**: REQ-026
- **Feature**: 4D+1 Workflow Migration
- **Priority**: P0 (Critical)
- **Created**: 2025-09-24
- **Updated**: 2025-09-24
- **Status**: DRAFT

## Executive Summary

This document captures requirements for migrating Bootstrap from its current passive rule-based architecture to an active command-driven execution model using the 4D+1 workflow (Init → Determine → Design → Define → Do). The migration addresses fundamental context window limitations discovered during real-world usage while preserving Bootstrap's valuable safety mechanisms and SDLC structure.

The new architecture embeds intelligence directly into commands, leverages multi-agent orchestration for comprehensive analysis, and uses deterministic scripts for critical operations. This represents a fundamental shift in how Bootstrap operates, moving from requiring AI agents to load and interpret rules to providing self-contained workflow instructions with embedded best practices.

Key drivers include the discovery that rule loading fails reliably in production, commands can be 600-1600 tokens (not <500 as originally thought), and the need for immediate functionality without complex initialization sequences.

## Problem Statement

**Current Problems:**
- Rules don't load reliably in AI context windows, causing unpredictable behavior
- Complex initialization (`/load-rules` requirement) creates poor user experience
- Over-engineered for simple tasks, under-powered for complex ones
- Poor discoverability of features and workflows
- Token-heavy rule system consumes context without providing value
- Scattered commands lack cohesion and memorable patterns

**Who Experiences These Problems:**
- Developers using Bootstrap with AI assistants (primary users)
- New users attempting to understand the framework
- Contributors trying to extend Bootstrap capabilities
- Bootstrap itself when self-hosting development

**Impact:**
- Failed executions due to rule loading failures
- Frustrated users abandoning the framework
- Inability to compete with simpler alternatives like spec-kit
- Lost development time troubleshooting context issues

## Stakeholders

### Primary Stakeholders
- **Bootstrap Development Team**: Framework architects and maintainers
- **Software Developers**: End users building projects with AI assistance
- **AI Agents**: Claude, GPT, and other models executing commands

### Secondary Stakeholders
- **Open Source Contributors**: Community members extending Bootstrap
- **Project Managers**: Users of the project management features
- **Future Domain Adapters**: Teams adapting Bootstrap to non-SDLC domains

### Stakeholder Needs
- **Developers need**: Reliable, fast, intuitive workflows that work immediately
- **AI Agents need**: Self-contained instructions without external dependencies
- **Contributors need**: Clear architecture and extension patterns
- **Project Managers need**: Predictable, auditable project artifacts

## User Scenarios

### Scenario 1: New User First Experience
**As a** new developer
**I want to** start using Bootstrap immediately
**So that** I can be productive without learning complex setup

**Acceptance Criteria:**
- User can run `/init` without any prior setup
- First command execution succeeds without rule loading
- Clear guidance on next steps after initialization

### Scenario 2: Complex Feature Development
**As a** developer working on a complex feature
**I want to** leverage multi-agent analysis
**So that** I get comprehensive perspectives on requirements, design, and implementation

**Acceptance Criteria:**
- `/determine` launches specialized agents for requirements analysis
- Agents work in parallel for efficiency
- Single point of interaction through Requirements Engineer

### Scenario 3: Self-Hosting Development
**As a** Bootstrap maintainer
**I want to** use Bootstrap to develop Bootstrap
**So that** we validate our own workflows and patterns

**Acceptance Criteria:**
- All Bootstrap development uses 4D+1 workflow
- Commands can iterate on their own output
- Design and implementation documents follow Bootstrap patterns

### Scenario 4: Safety-Critical Operations
**As a** developer making git commits
**I want to** have deterministic safety checks
**So that** I never accidentally commit sensitive files

**Acceptance Criteria:**
- Scripts handle all git operations deterministically
- AI provides judgment but scripts enforce safety
- Clear error messages when operations are blocked

### Scenario 5: Project Migration
**As a** user of Bootstrap v0.11.x
**I want to** migrate to the new 4D+1 workflow
**So that** I can benefit from improved reliability

**Acceptance Criteria:**
- Migration guide documents changes clearly
- Old commands remain available during transition
- Existing project artifacts remain compatible

## Functional Requirements

### P0 - Must Have (Critical for MVP)

#### Core Commands
- **FR-001**: Implement `/init` command for project initialization
  - Create CHARTER.md with mode selection (prototype/draft/ratified)
  - Detect project stack automatically
  - Generate `.sdlc/` directory structure
  - Support idempotent execution

- **FR-002**: Implement `/determine` command for requirements gathering
  - Interactive section-by-section gathering
  - Launch multi-agent analysis team
  - Generate sequentially numbered requirements documents
  - Validate against charter principles

- **FR-003**: Implement `/design` command for architecture planning
  - Evaluate minimum 2 alternatives
  - Support phased design for complex features
  - Create design documents with diagrams
  - Generate ADRs for key decisions

- **FR-004**: Implement `/define` command for implementation planning
  - Accept design output as primary argument (from `/design` command)
  - Support additional user specifications for file-specific instructions
  - Generate Detailed Implementation Prompts (DIPs)
  - Support splitting complex implementations
  - Extract tasks to TASK.md
  - Include test specifications

- **FR-005**: Implement `/do` command for implementation execution
  - Execute DIPs with progress tracking
  - Run validation after each component
  - Update TASK.md checkboxes
  - Track discovered issues

#### Supporting Infrastructure
- **FR-006**: Create 15+ deterministic safety scripts
  - Structure creation scripts
  - Git safety operations
  - Environment detection
  - Test and lint execution

- **FR-007**: Develop comprehensive template library
  - Charter templates (3 modes)
  - Requirements, design, DIP templates
  - Agent personality templates
  - Diagram templates

- **FR-008**: Implement multi-agent orchestration
  - Requirements Engineer as primary interface
  - Project Manager for coordination (2 sub-agent maximum due to memory constraints)
  - Specialized domain agents (generate new ones as needed, store in .claude/agents/)
  - Parallel execution capability (limited to 2 agents per phase)
  - Define JSON schema for agent-to-agent data passing
  - Implement conflict resolution hierarchy for contradictory recommendations
  - Specify timeout/retry behavior (30s timeout, 2 retries)

### P1 - Should Have (High Value)

- **FR-009**: Command argument handling for flexibility
- **FR-010**: Iterative refinement capability (re-run on output)
- **FR-011**: Progress tracking and reporting
- **FR-012**: Automatic JSONL session logging
- **FR-013**: Context window management strategies
- **FR-014**: Implement rollback mechanisms for partial executions
  - Transaction-like behavior for /define and /do commands
  - Ability to revert to previous state on failure
  - Clear logging of rollback operations

### P2 - Nice to Have (Future Enhancement)

- **FR-015**: Advanced logging infrastructure with hooks
- **FR-016**: Domain-specific command adaptations
- **FR-017**: Integration with external project management tools
- **FR-018**: Real-time monitoring dashboard
- **FR-019**: Cross-session analysis tools
- **FR-020**: Progressive summarization for large codebases
- **FR-021**: Semantic vector embeddings for file tagging and retrieval

## Non-Functional Requirements

### Performance
- **NFR-001**: Commands execute with 600-1600 token overhead (not <500)
- **NFR-002**: Script execution completes in <2 seconds
- **NFR-003**: Multi-agent responses synthesized within single interaction
- **NFR-004**: No noticeable latency from command structure

### Reliability
- **NFR-005**: Commands work without external rule loading
- **NFR-006**: Deterministic script behavior for critical operations
- **NFR-007**: Graceful handling of script failures
- **NFR-008**: State preservation across context compaction
  - Must preserve: current command state, active todos, partial outputs
  - Recovery mechanism to restore from saved state
  - Maximum 5KB state size per compaction point

### Usability
- **NFR-009**: Memorable 4D+1 workflow pattern
- **NFR-010**: Progressive disclosure of complexity
- **NFR-011**: Clear error messages and recovery paths
- **NFR-012**: Single point of user interaction

### Compatibility
- **NFR-013**: Works with Claude, GPT, Cursor, and other AI models
- **NFR-014**: POSIX-compliant scripts for cross-platform support
- **NFR-015**: Supports all major programming languages/stacks
- **NFR-016**: Backward compatibility during transition period

### Maintainability
- **NFR-017**: Commands self-document their behavior
- **NFR-018**: Templates externalized for easy updates
- **NFR-019**: Clear separation of concerns (scripts vs AI)
- **NFR-020**: Version footers track generation source
- **NFR-021**: Commands include version number (e.g., v0.0.1) in their metadata

## Testing Requirements

### Test Coverage Standards
- **TR-001**: Minimum 80% code coverage for all command implementations (target for v1.0)
- **TR-002**: Test-first development for deterministic scripts; test-after for commands during pre-alpha
- **TR-003**: Unit tests for all script functions (required before merge)
- **TR-004**: Integration tests for command workflows (progressive implementation)
- **TR-005**: End-to-end tests for complete 4D+1 flow (post-MVP)

### Test Types Required
- **Unit Tests**: Individual function validation
- **Integration Tests**: Command interaction verification
- **System Tests**: Full workflow execution
- **Regression Tests**: Backward compatibility checks
- **Performance Tests**: Token usage and execution time

### Validation Criteria
- All tests must pass before command is considered complete
- Performance tests must meet NFR requirements
- Security tests for git operations must have 100% pass rate
- Multi-agent orchestration validated via manual testing and log analysis

## Acceptance Criteria

### Command Execution
- [ ] Each command executes successfully without rule loading
- [ ] Commands handle arguments for customization
- [ ] Error handling provides clear recovery paths
- [ ] Progress updates keep user informed

### Multi-Agent System
- [ ] Requirements Engineer maintains user interaction monopoly
- [ ] Project Manager successfully coordinates specialists
- [ ] Agents work in parallel when launched together
- [ ] Synthesis produces coherent recommendations

### Safety and Validation
- [ ] No accidental commits of sensitive files
- [ ] Scripts validate inputs before execution
- [ ] Clear blocking messages for dangerous operations
- [ ] Audit trail of all operations

### Self-Hosting
- [ ] Bootstrap can build its own enhancements
- [ ] Commands can iterate on their own output
- [ ] Design documents follow Bootstrap patterns
- [ ] All development uses 4D+1 workflow

### Documentation
- [ ] Each command fully documented
- [ ] Templates include clear placeholders
- [ ] Migration guide from old commands
- [ ] Examples demonstrate usage patterns

## Technical Constraints

### Platform Requirements
- Shell environment with standard Linux bash features
- Git version 2.0 or higher
- AI assistant with function calling capability
- File system access for artifact creation
- Additional shell tools must be added to project requirements if needed

### Integration Points
- Claude Code Task tool for multi-agent orchestration
- Git for version control operations
- Language-specific tools (pytest, npm, cargo, etc.)
- Markdown rendering for documentation

### Security Constraints
- No storage of credentials or secrets
- File operations restricted to project directory
- Git operations require explicit user confirmation
- Sensitive file patterns blocked by default

## Dependencies and Assumptions

### Dependencies
- **Claude Code**: Task tool for sub-agent invocation
- **Git**: Version control for project management
- **POSIX Shell**: Script execution environment
- **Markdown**: Documentation and command format

### Assumptions
- Users have basic familiarity with command-line interfaces
- AI agents have sufficient context window for commands (2K tokens)
- Projects follow standard directory structures
- Users want structured workflows over ad-hoc approaches

### Risks
- **Context window exhaustion**: Mitigated by efficient token usage
- **Multi-agent complexity**: Mitigated by Requirements Engineer interface
- **Script portability**: Mitigated by POSIX compliance
- **Learning curve**: Mitigated by progressive disclosure

## Success Metrics

### Quantitative Metrics
- Command execution success rate >95%
- User onboarding time <5 minutes
- Token usage 600-1600 per command (as designed)
- Zero git accidents from framework operations
- Average time from `/init` to first `/do` completion <30 minutes
- Percentage of DIPs requiring revision <20%
- Mean time between command failures >100 executions
- Test coverage maintained above 80%
- Project Manager sub-agent invocations ≤2 concurrent (multiple phases allowed)

### Qualitative Metrics
- User satisfaction with workflow clarity (measured via surveys)
- Developer productivity improvements (tracked via time-to-completion)
- Community adoption and contributions (GitHub stars, PRs)
- Successful self-hosting of development (Bootstrap builds itself)

### Validation Methods
- Automated testing of all commands
- User feedback sessions
- Performance benchmarking
- Self-hosting validation

## Migration Strategy

### Phase 1: Parallel Implementation
- Build new commands alongside old ones
- No breaking changes to existing workflows
- Document mapping from old to new commands

### Phase 2: Transition Period
- Encourage use of new commands
- Provide migration tooling
- Maintain backward compatibility

### Phase 3: Deprecation
- Mark old commands as deprecated
- Final warning period
- Complete removal in v0.13.0

## Open Questions

### For Requirements Clarification
- [x] Should commands support batch operations for multiple features? No - single feature focus for now
- [x] How should we handle partial command execution failures? User resumes with context
- [x] What level of customization should personality templates support? Current template is flexible enough; generate new agents as needed

### For Design Consideration
- [x] Should we support custom agent personalities beyond standard ones? Yes - generate and store in .claude/agents/ for consistency
- [x] How do we handle very large projects that exceed context windows? Future: progressive summarization + semantic embeddings (backlog)
- [x] Should commands be able to call other commands? Yes - `/define` accepts `/design` output

### For Implementation
- [x] Which shell features can we safely assume are available? Standard Linux bash features only
- [x] How do we test multi-agent orchestration effectively? Manual testing + log parsing script for analysis
- [x] What's the best way to version command changes? Semantic versioning aligned with project (start at 0.0.1)

## Appendices

### A. Command Token Analysis
Based on ADR-010, actual token usage:
- `/init`: ~800 tokens
- `/determine`: ~1200 tokens
- `/design`: ~1400 tokens
- `/define`: ~1000 tokens
- `/do`: ~1600 tokens

### B. Related Documents
- Design Document: `.sdlc/designs/026-refactor-command-architecture/design.md`
- Architecture ADRs: `.sdlc/designs/026-refactor-command-architecture/adrs/`
- Project ADR-010: `.sdlc/ADRs/ADR-010-4d-plus-1-workflow.md`
- Subagent Insights: `temp/2024-09-24-vital-subagent-personality-instructions.md`

### C. Glossary
- **4D+1**: The five-command workflow (init + determine/design/define/do)
- **DIP**: Detailed Implementation Prompt
- **Requirements Engineer**: Primary AI agent interfacing with user
- **CHARTER.md**: Project constitution defining principles and constraints
- **SDLC**: Software Development Lifecycle

---
Generated by Bootstrap v0.12.1 - /determine command