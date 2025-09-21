---
title: Bootstrap Command Refactoring Design
status: draft
created: 2025-09-20
updated: 2025-09-20
type: system
author: AI Assistant
tags: [refactor, architecture, commands, framework]
estimated_effort: 4 weeks
---

# Bootstrap Command Refactoring Design Document

## Executive Summary

This refactoring represents a fundamental architectural shift from passive rule-based context loading to active command-driven execution. By merging Bootstrap's comprehensive SDLC framework with spec-kit's simplicity and embedding behavioral rules directly into commands, we create a system that actually works within AI context limitations while maintaining safety and structure.

## Requirements

### Functional Requirements
- **Command Execution**: AI agents execute commands with embedded safety and validation
- **Workflow Clarity**: Clear 4D+1 workflow (Init → Determine → Design → Define → Do)
- **Rule Integration**: Rules become actionable prompts within commands, not passive context
- **Multi-Agent Support**: Commands work across Claude, GPT, Cursor, etc.
- **Deterministic Safety**: Critical operations use scripts, not AI interpretation

### Non-Functional Requirements
- **Token Efficiency**: <500 tokens per command execution
- **Zero Context Pollution**: No persistent rule loading required
- **Immediate Functionality**: Works from first command, no setup
- **Progressive Disclosure**: Simple for beginners, powerful for experts
- **Self-Documenting**: Commands explain themselves when invoked

## Current State Analysis

### Current Bootstrap Strengths
- 26+ comprehensive behavioral rules
- Git safety controls that prevent disasters
- 6+ months of battle-tested workflows
- Strong SDLC structure and organization
- Self-bootstrapping philosophy

### Current Bootstrap Weaknesses
- Rules don't load reliably in AI context
- Complex initialization (`/load-rules` requirement)
- Over-engineered for simple tasks
- Poor discoverability of features
- Token-heavy rule system

### Spec-Kit Strengths
- Dead simple workflow
- Works immediately without setup
- Clear command progression
- Good marketing/documentation
- Multi-agent focus

### Spec-Kit Weaknesses
- No actual implementation (just templates)
- No safety controls
- No automation
- Relies entirely on AI interpretation

## Proposed Design

### Overview

The refactored Bootstrap uses the **4D+1 Workflow** with embedded intelligence:

```
/init (once) → /determine → /design → /define → /do
                     ↑__________________________|
                     (cycle for each feature)
```

Each command contains:
1. **Core prompt** (what to do)
2. **Embedded rules** (how to do it safely)
3. **Validation scripts** (deterministic checks)
4. **Template references** (external .template.md files)
5. **Version footer** (track what generated each artifact)

### Architecture

See [Architecture Diagram](diagrams/architecture.mmd) for the complete system architecture.

The architecture consists of five main layers:
1. **User Interface** - Command line interface for user interaction
2. **Context Layer** - CLAUDE.md and MASTER_IMPORTS.md (always loaded)
3. **4D+1 Command Layer** - The five primary workflow commands (init, determine, design, define, do)
4. **Embedded Intelligence** - Command prompts with embedded rules and template references
5. **Deterministic Layer** - Scripts and validators for guaranteed safety

### Command Philosophy

Commands are **detailed workflow instructions** for AI agents, not executable programs. Each command:
- Provides human-level instructions (not machine code)
- Emphasizes **interactive, conversational execution**
- Uses **decision hierarchy**: User instructions → AI judgment → Ask for clarity
- Leverages scripts for structure generation to reduce token usage
- Implements **section-by-section workflows** for granular feedback

Key principles:
1. **Scripts handle structure**: Create files, directories, boilerplate
2. **AI handles content**: Fill templates, make decisions, interact with user
3. **One question at a time**: Maintain conversational flow
4. **Progressive context**: Each section informed by previous interactions
5. **"I don't know" is better than guessing**

### Command Structure

#### /init (Project Initialization)
New command - not a direct merge but inspired by:
- Bootstrap: `/reset-framework` (cleanup logic) , `/gather-project-requirements` (create charter)
- Spec-kit: `/constitution` (principles establishment)

```yaml
Core Function: One-time project setup and charter creation
Interactive Process:
  - Ask user: "What charter mode? (prototype/draft/ratified)"
  - Ask user: "Project name and description?"
  - Detect stack automatically, confirm with user
  - Migrate PLANNING.md if exists (ask permission)
Section-by-Section:
  - Create structure via script first
  - Fill charter sections one at a time
  - Get user feedback after each section
  - Apply learnings to subsequent sections
Scripts:
  - init-structure.sh: Creates .sdlc/ directories
  - detect-stack.sh: Identifies languages/tools
  - create-charter-template.sh: Generates empty charter
Embedded Rules:
  - Progressive validation based on mode
  - File safety checks before operations
  - Git awareness for existing repos
Outputs:
  - CHARTER.md in root (for visibility)
  - .sdlc/ directory structure
  - Initial configuration files
Templates:
  - charter-{mode}.template.md (prototype/draft/ratified)
Note: Idempotent - safe to run multiple times
```

#### /determine (Requirements Gathering)
Merges:
- Bootstrap: `/gather-feature-requirements`
- Spec-kit: `/specify` (requirements gathering portion)

```yaml
Core Function: Establish what needs to be built and why
Prerequisites:
  - CHARTER.md must exist (run /init first)
  - Validates against charter principles
Interactive Process:
  - Ask: "What feature/capability are we gathering requirements for?"
  - Ask: "Who are the stakeholders?" (one at a time if multiple)
  - Ask: "What problem does this solve?"
  - Build requirements through conversation
Section-by-Section:
  - Script creates structure: requirements file with empty sections
  - Fill Executive Summary → get feedback
  - Fill User Scenarios → get feedback
  - Fill Functional Requirements → get feedback
  - Continue through all sections
Scripts:
  - create-requirements.sh: Generate numbered file structure with empty template
Embedded Rules:
  - Sequential numbering (###-kebab-case pattern)
  - Use [NEEDS CLARIFICATION] markers liberally
  - Stakeholder sign-off tracking
  - Success criteria must be measurable
Question Tracking:
  - Add all uncertainties to TodoWrite
  - Ask one at a time
  - User answers may eliminate later questions
Output: .sdlc/requirements/{number}-{name}.md
Templates:
  - requirements.template.md
Integration:
  - Checks charter compatibility
  - Links requirements to charter principles
  - Flags conflicts for amendment consideration
```

#### /design (Architecture Planning)
Merges:
- Bootstrap: `/design-feature`, `/generate-prp`
- Spec-kit: `/plan`

```yaml
Core Function: Decide how to build it
Interactive Process:
  - Ask: "What are we designing? (feature/system/refactor)"
  - Ask: "What's the estimated complexity?"
  - AI judges if phasing needed (>5 days or >5 components)
  - Explore alternatives through conversation
Section-by-Section:
  - Script creates: design folder, empty templates, ADR stubs
  - Fill Executive Summary → get feedback
  - Fill Requirements Analysis → get feedback
  - Explore 2+ alternatives → discuss trade-offs
  - Fill chosen approach details → get feedback
  - Create diagrams as needed → review
Scripts:
  - create-design-structure.sh: Generate numbered folder with templates
  - init-design-templates.sh: Create design.md, ADRs, diagram stubs
Embedded Rules:
  - Sequential numbering (###-{type}-{name}/)
  - Always evaluate minimum 2 alternatives
  - Performance/security addressed explicitly
  - AI suggests phasing for complex designs
  - Diagrams in subfolder, not root
Decision Points:
  - User can override phasing suggestions
  - User picks from alternatives or suggests new ones
  - User approves final design before proceeding
Output: .sdlc/designs/{number}-{type}-{name}/design.md
Templates:
  - design.template.md
  - design-phase.template.md (for phased work)
  - adr.template.md (for ADRs)
  - diagram-*.template.md (for visuals)
Integration: Validates against CHARTER.md principles
```

#### /define (Implementation Definition)
Merges:
- Bootstrap: `/generate-prp` (primary function)
- Bootstrap: `/task-add`, `/task-update` (lightweight tracking)
- Spec-kit: `/tasks` (breakdown concept)

```yaml
Core Function: Generate implementation prompts (DIPs)
Interactive Process:
  - Review design with user
  - AI analyzes complexity and suggests splitting approach
  - Discuss natural boundaries for splitting
  - Confirm implementation approach
Section-by-Section:
  - Script creates: implementation folder, DIP templates
  - Fill Context & Constraints → review
  - Define implementation tasks → get feedback
  - Add test specifications → review
  - Create validation requirements → confirm
  - Generate TASK.md checklist → review
Scripts:
  - create-dip-structure.sh: Generate implementation folder
  - generate-task-checklist.sh: Create TASK.md entries
Embedded Rules:
  - AI judges when to split (>500 LOC or >3 components)
  - Preserve atomicity for transactions
  - Test specifications required
  - Git commit guidelines included
  - Self-contained instructions
Key Principle:
  - DIP should be executable by another AI with minimal context
  - But still allow for questions during execution
Outputs:
  - Always: .sdlc/implementation/{number}-{name}/
  - Single DIP: dip.md
  - Multiple DIPs: {letter}-{component}-dip.md
  - TASK.md updates (lightweight checklist)
Templates:
  - dip.template.md (single phase)
  - dip-phase.template.md (multi phase)
Note: This is the least interactive command since DIPs are meant to be comprehensive
```

#### /do (Implementation)
Merges:
- Bootstrap: `/execute-prp` (core implementation)
- Spec-kit: `/implement` (task execution)

```yaml
Core Function: Execute the DIP to build the solution
Interactive Process:
  - Read DIP with user
  - Confirm understanding of requirements
  - Ask clarification if DIP has ambiguities
  - Report progress at each major step
  - Ask for help when blocked
Execution Flow:
  - Implement each DIP task sequentially
  - Write tests first (if applicable)
  - Implement code to pass tests
  - Run validation after each component
  - Update TASK.md checkboxes as completed
  - Track discovered issues/tasks
Scripts:
  - check-environment.sh: Validate stack setup
  - run-tests.sh: Execute test suite
  - lint-check.sh: Run code quality checks
Embedded Rules:
  - Test-first development preferred
  - Read files before modification
  - Code style per stack standards
  - Progress updates in TASK.md
  - No automatic commits/pushes
Interaction Points:
  - When tests fail: Ask for guidance
  - When requirements unclear: Seek clarification
  - When discovering new tasks: Confirm with user
  - When blocked: Explain issue, ask for help
Integration:
  - Updates TASK.md checkboxes as tasks complete
  - Adds discovered tasks to separate section
  - NO commits, NO pushes, NO changelog updates
Note: User maintains control over git operations
```

### Future Supporting Commands

Beyond the core 4D workflow, additional commands will handle:

```yaml
/review: Code review and validation
  - Run all tests and linters
  - Check coverage metrics
  - Validate against design specs
  - Generate review report

/commit: Safe git operations
  - Enforces conventional commit format
  - Includes task references
  - Blocks sensitive files
  - Updates changelog when appropriate
  Scripts: git-safe-add.sh, validate-commit.sh

/debug: Troubleshooting assistance
  - Error analysis
  - Log examination
  - Test failure diagnosis

/deploy: Release management
  - Version bumping
  - Release notes generation
  - Deployment scripts
```

### Deterministic Safety Scripts

Critical operations move from rules to scripts:

```bash
# git-safe-add.sh
#!/bin/bash
# Prevents accidental sensitive file commits
BLOCKED_PATTERNS=(".env" ".aws" "*.key" "*.pem")
for pattern in "${BLOCKED_PATTERNS[@]}"; do
    if [[ $1 == *"$pattern"* ]]; then
        echo "ERROR: Cannot add $pattern files"
        exit 1
    fi
done
git add "$@"
```

## Alternative Approaches Considered

### Alternative 1: Pure Spec-Kit Fork
- **Approach**: Abandon Bootstrap, use spec-kit as-is
- **Pros**: Immediate simplicity, GitHub backing
- **Cons**: Lose all safety controls, no real implementation
- **Rejected**: Too much valuable work lost

### Alternative 2: Incremental Rule Enhancement
- **Approach**: Keep trying to make rule-loading work better
- **Pros**: Preserves existing investment
- **Cons**: Fundamental context window limitation unsolvable
- **Rejected**: Technical limitation can't be overcome

### Alternative 3: Full Rewrite
- **Approach**: Start completely fresh, new framework
- **Pros**: Clean slate, no technical debt
- **Cons**: Lose 6+ months of learning, repeat mistakes
- **Rejected**: Bootstrap's lessons are valuable

## Implementation Plan

### Phase 1: Command Creation (Week 1)

#### 1A: Template Refresh (Days 1-2) ✅ COMPLETE
1. **Audit existing templates** ✅
   - Reviewed all in `.claude/templates/`
   - Identified gaps for new commands
   - Incorporated spec-kit clarity

2. **Create new templates** ✅
   - `charter-prototype.template.md` (minimal for rapid prototyping)
   - `charter-draft.template.md` (comprehensive for active development)
   - `charter-ratified.template.md` (formal with amendment process)
   - `amendment.template.md` (for charter changes)
   - `requirements.template.md` (comprehensive requirements gathering)
   - `dip.template.md` (single-phase implementation prompt)
   - `dip-phase.template.md` (multi-phase implementation)
   - `design-phase.template.md` (for phased design work)
   - `diagram-*.template.md` (architecture, flow, sequence, ER diagrams)

3. **Update existing templates** ✅
   - Added version footers to all
   - Updated adr, task, command, rule templates to new comprehensive style
   - Trimmed redundancy while keeping essential information

4. **Template naming convention** ✅
   - `{artifact-type}.template.md` for primary templates
   - `{artifact-type}-{variant}.template.md` for variants

#### 1B: Command Implementation (Days 3-5)

**Key Implementation Insights from Phase 1A:**

1. **Smart Template Selection**
   - `/init` must ask or intelligently detect which charter mode (prototype/draft/ratified)
   - `/define` must detect when to split into phases (>500 LOC or >3 components)
   - `/design` must auto-split large designs into phases (>5 days or >5 components)
   - Commands should handle partial template filling with TODO placeholders

2. **Lightweight Task Integration**
   - TASK.md becomes simple DIP checklist only
   - Don't over-engineer task tracking in commands
   - Future comprehensive task system will use database + MCP
   - Task references in DIPs should be minimal checkboxes

3. **Template Validation Levels**
   - **Prototype mode**: Allow TODO placeholders, minimal validation
   - **Draft mode**: Warn on missing sections but allow proceed
   - **Ratified mode**: Strict validation, no missing required fields
   - Progressive validation based on project maturity

**Command Implementation Plan:**

1. **Create `/init` command**
   - Reference `charter-*.template.md` variants
   - Detect existing project structure
   - Offer charter mode selection (prototype → draft → ratified)
   - Create .sdlc/ directory structure
   - Handle PLANNING.md migration if exists

2. **Create `/determine` command**
   - Reference `requirements.template.md`
   - Validate against charter principles
   - Auto-generate sequential numbering
   - Support [NEEDS CLARIFICATION] markers
   - Create lightweight task entries

3. **Create `/design` command**
   - Reference `design.template.md` and `design-phase.template.md`
   - Auto-detect when phasing needed (complexity thresholds)
   - Create proper subfolder structure with diagrams/
   - Link to requirements and charter

4. **Create `/define` command**
   - Reference `dip.template.md` and `dip-phase.template.md`
   - Auto-split large implementations
   - Generate minimal task checklists
   - Preserve atomic operation boundaries
   - Embed test specifications

5. **Create `/do` command**
   - Reference DIPs for implementation
   - Update lightweight task checkboxes
   - Enforce test-first development
   - No commits/pushes (user control)
   - Track discovered tasks separately

6. **Build support scripts**
   - **Structure generation scripts** (reduce AI token usage):
     - `init-structure.sh`: Create .sdlc/ directories
     - `create-charter-template.sh`: Generate empty charter file
     - `create-requirements.sh`: Generate numbered requirements file
     - `create-design-structure.sh`: Generate design folder with subfolders
     - `init-design-templates.sh`: Create empty design.md, ADRs, diagrams
     - `create-dip-structure.sh`: Generate implementation folder
     - `generate-task-checklist.sh`: Create TASK.md entries
   - **Detection & validation scripts**:
     - `detect-stack.sh`: Identify project languages/tools
     - `check-environment.sh`: Validate stack setup (python venv, node_modules, etc)
   - **Execution scripts**:
     - `run-tests.sh`: Execute stack-appropriate test suite
     - `lint-check.sh`: Run stack-appropriate linters
   - **Safety scripts**:
     - `git-safe-add.sh`: Prevent sensitive file commits (.env, .key, etc)
   - Cross-platform compatibility (POSIX + Python fallbacks)

### Phase 2: CLAUDE.md & Rule System Evolution (2-3 days)

#### 2A: CLAUDE.md Reorganization
1. **Keep Universal Behaviors Only**
   - Code Modification Safety (critical: no unnecessary information removal)
   - Context Verification (always clarify ambiguity, never guess)
   - Error Transparency (show full errors with context)
   - Communication Standards (conciseness, progress updates)

2. **Move Out Project/Stack-Specific Items**
   - Library/Import Safety → new rule: `.claude/rules/stack/library-management.md`
   - Python path resolution → new rule: `.claude/rules/stack/python-paths.md`
   - Validation commands (ruff, mypy) → new rule: `.claude/rules/stack/validation-commands.md`
   - File size limits → CHARTER.md project constraints
   - Task.md management → embed in `/define` and `/do` commands

3. **Convert Removed Items to Individual Rules**
   - Create granular rules for each removed behavior
   - Rules become reference documentation, not loaded context
   - Unlimited rule creation since they're not all loaded
   - Stack-specific rules in `.claude/rules/stack/` directory
   - Project-type rules in `.claude/rules/project-types/` directory

#### 2B: MASTER_IMPORTS.md Transformation
1. **Convert to Quick Reference Guide**
   ```markdown
   # Bootstrap Rule Reference
   # One-line summaries of embedded behaviors
   # Full rules in .claude/rules/ for reference only

   ## Git Safety (embedded in /commit command)
   - git-add-safety: Blocks wildcard adds, prevents sensitive file commits
   - git-commit-format: Enforces conventional commits with task references
   - git-push-validation: Prevents force push to protected branches

   ## Project Structure (embedded in /init and /design)
   - sequential-naming: ###-kebab-case for features/designs
   - design-structure: Enforces subfolder structure with design.md
   - sdlc-directory: All artifacts in .sdlc/ subdirectories

   ## Implementation (embedded in /do command)
   - test-first: Write tests before implementation
   - code-structure: Max 500 lines per file, logical separation
   - environment-management: Use venv_linux for Python

   ## Documentation (embedded in all commands)
   - docstring-format: Google style for Python functions
   - changelog-update: Track significant changes
   ```

2. **Leverage One-Layer Import Capability**
   - CLAUDE.md can import MASTER_IMPORTS.md directly
   - MASTER_IMPORTS.md provides quick lookup without full rule loading
   - Acts as a "cheat sheet" that actually loads into context
   - References point to full rules for human lookup when needed

3. **Separate Config Concerns**
   - Keep `.claude/config.yaml` for framework info only (version, status, capabilities)
   - Project-specific info moves to CHARTER.md or project root config
   - `/init` handles project configuration
   - `/update` only touches framework config
   - Clear boundary between framework and project

### Phase 3: Rule Expansion & Documentation (Week 2)

#### 3A: Rule System Transformation
1. **From Constraints to References**
   - Rules no longer need to be loaded into context
   - Can create unlimited granular rules
   - Each rule becomes comprehensive documentation
   - Include examples, edge cases, and rationale

2. **New Rule Categories**
   ```
   .claude/rules/
   ├── core/           # Universal behaviors (kept minimal)
   ├── git/            # Git operations (existing)
   ├── project/        # Project management (existing)
   ├── stack/          # Stack-specific (NEW)
   │   ├── python/
   │   ├── nodejs/
   │   ├── rust/
   │   └── generic/
   ├── project-types/  # Project type specific (NEW)
   │   ├── api/
   │   ├── cli/
   │   ├── web-app/
   │   └── library/
   └── patterns/       # Design patterns (NEW)
       ├── testing/
       ├── deployment/
       └── architecture/
   ```

3. **Rule Creation from CLAUDE.md Extraction**
   - Each removed section becomes one or more rules
   - Example transformations:
     - "Library and Import Safety" → 3 rules:
       - `stack/generic/dependency-check.md`
       - `stack/generic/import-verification.md`
       - `stack/generic/library-selection.md`
     - "File System Operations" → 4 rules:
       - `core/file-read-before-write.md`
       - `core/directory-verification.md`
       - `core/path-resolution.md`
       - `core/change-confirmation.md`

#### 3B: Documentation Enhancement
1. **Merge Rule + Docs**
   - Single source of truth per rule
   - No separate docs directory needed
   - Self-contained rule files

2. **Rule Template Structure**
   ```markdown
   # Rule: [Name]

   ## Quick Summary
   [One-line description for MASTER_IMPORTS.md]

   ## When Applied
   [Which commands embed this rule]

   ## Detailed Behavior
   [Full description with examples]

   ## Stack Variants
   [Language-specific implementations]

   ## Common Issues
   [Troubleshooting guide]
   ```

3. **Create Stack Templates**
   - Design modular rule structure
   - Create template for language/tool patterns
   - Prototype with Python → generic pattern

### Phase 4: Stack Modularization (Week 3)
1. **Implement Multi-Stack Support**
   - Convert language-specific rules to patterns
   - Add configuration sections per stack
   - Create stack detection logic

2. **Migration Scripts**
   - Rule-to-command extraction helpers
   - Legacy format converters
   - Validation tools

### Phase 5: Polish (Week 4)
1. Multi-agent testing
2. Documentation overhaul
3. Marketing materials
4. Example projects

## Risks and Mitigations

### Risk: Users confused by new workflow
- **Mitigation**: Clear migration guide, command aliases for old names

### Risk: Lost functionality during migration
- **Mitigation**: Careful rule extraction, comprehensive testing

### Risk: Scripts don't work cross-platform
- **Mitigation**: POSIX compliance, Python alternatives

### Risk: Commands become too complex
- **Mitigation**: Progressive disclosure, sensible defaults

## Success Criteria

### Technical Success
- Commands work without `/load-rules`
- <500 tokens per command execution
- Zero failed git operations due to safety
- Works on Claude, GPT, Cursor

### User Success
- New user productive in <5 minutes
- Migration from v1 in <1 hour
- Clear improvement in workflow speed
- Positive feedback on simplicity

## Architecture Decision Records

The following Architecture Decision Records document the key design choices:

- [ADR-001: Embed Rules in Commands](adrs/ADR-001-embed-rules-in-commands.md) - Why rules are embedded rather than loaded
- [ADR-002: 4D Workflow](adrs/ADR-002-4d-workflow.md) - Rationale for the Determine/Design/Define/Do progression
- [ADR-003: Deterministic Scripts for Safety](adrs/ADR-003-deterministic-scripts.md) - Using scripts for critical safety operations
- [ADR-004: Critical Missing Concepts](adrs/ADR-004-critical-missing-concepts.md) - Essential patterns from rules that must be preserved
- [ADR-005: Rule System Evolution](adrs/ADR-005-rule-system-evolution.md) - Transform rules into comprehensive reference specs with stack support
- [ADR-006: Charter Governance](adrs/ADR-006-charter-governance.md) - CHARTER.md modes and amendment process for stable project principles
- [ADR-007: Command Versioning](adrs/ADR-007-command-versioning.md) - Version footers track what generated each artifact without retroactive updates
- [ADR-008: Template Architecture](adrs/ADR-008-template-architecture.md) - External templates referenced by commands for maintainability
- [ADR-009: Automatic Phase Separation](adrs/ADR-009-automatic-phase-separation.md) - Smart splitting of large designs and DIPs into manageable chunks
- [ADR-010: Section-by-Section Interaction](adrs/ADR-010-section-by-section-interaction.md) - Granular feedback loops for document creation and AI learning
- [ADR-011: Script vs AI Responsibilities](adrs/ADR-011-script-vs-ai-responsibilities.md) - Clear boundaries between deterministic scripts and AI agent judgment

## Implementation Strategy

### Refactoring Approach
Since Bootstrap is still in pre-alpha (v0.x.x), this is an internal refactoring:

1. **No migration needed** - Bootstrap itself is the only "user"
2. **Incremental replacement** - Old commands remain while new ones are built
3. **Self-testing** - Use Bootstrap to refactor Bootstrap
4. **Version bump** - This represents a v0.12.0 enhancement, not a major version

### Development Process
1. Build new 4D commands alongside existing ones
2. Test thoroughly using Bootstrap's own development
3. Gradually deprecate old commands
4. Update documentation and examples
5. Remove deprecated commands in v0.13.0

## Conclusion

This refactoring solves the fundamental context problem while preserving the framework's valuable safety and structure innovations. By embedding intelligence directly into commands and using deterministic scripts for critical operations, we achieve spec-kit's simplicity with Bootstrap's power.

The 4D+1 workflow (Init → Determine → Design → Define → Do) provides a memorable, logical progression that guides users through the entire SDLC while maintaining flexibility for different project styles.

This refactoring represents evolution, not revolution - preserving what works while fixing what doesn't. As a pre-alpha framework, Bootstrap can make these fundamental improvements without disrupting existing users, using itself as the test case for the new architecture.