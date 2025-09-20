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
- **Workflow Clarity**: Clear 4D workflow (Determine → Design → Define → Do)
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

The refactored Bootstrap uses the **4D Workflow** with embedded intelligence:

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

The architecture consists of four main layers:
1. **User Interface** - Command line interface for user interaction
2. **4D Command Layer** - The four primary workflow commands
3. **Embedded Intelligence** - Rules and templates embedded into prompts
4. **Deterministic Layer** - Scripts and validators for guaranteed safety

### Command Structure

#### /init (Project Initialization)
New command - not a direct merge but inspired by:
- Bootstrap: `/reset-framework` (cleanup logic) , `/gather-project-requirements` (create charter)
- Spec-kit: `/constitution` (principles establishment)

```yaml
Core Function: One-time project setup and charter creation
Embedded Logic:
  - Create .sdlc/ directory structure
  - Initialize CHARTER.md with appropriate mode
  - Detect project stack (Python/Node/etc)
  - Setup initial TASK.md if needed
  - Migrate existing PLANNING.md if present
Charter Creation:
  - Prototype mode: Minimal, allows empty sections
  - Draft mode: All sections, but changeable
  - Ratified mode: Only via explicit upgrade
Outputs:
  - CHARTER.md (with selected mode)
  - .sdlc/ directory structure
  - Initial configuration files
Templates:
  - charter-{mode}.template.md (prototype/draft/ratified)
Scripts:
  - detect-stack.sh (identifies languages/tools)
  - init-structure.sh (creates directories)
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
Embedded Rules:
  - Read CHARTER.md for context and constraints
  - Sequential numbering (###-kebab-case pattern)
  - Stakeholder identification
  - Success criteria definition
  - Risk assessment
  - Create/update TASK.md entries
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
Embedded Rules:
  - Sequential numbering (###-{type}-{name}/)
  - Always create subfolder structure:
    - design.md (main design document)
    - phase-{n}-{name}.md (for large designs)
    - adrs/ (design-specific ADRs)
    - diagrams/ (visual documentation)
  - Alternative evaluation (min 2 options)
  - Integration point identification
  - Performance/security considerations
  - Automatic phase separation (>5 days or >5 components)
Output: .sdlc/designs/{number}-{type}-{name}/design.md
Templates:
  - design.template.md
  - design-phase.template.md (for phased work)
  - adr.template.md (for ADRs)
Integration: Validates against CHARTER.md principles
Note: Large designs automatically split into phases
```

#### /define (Implementation Definition)
Merges:
- Bootstrap: `/generate-prp` (primary function)
- Bootstrap: `/task-add`, `/task-update` (lightweight tracking)
- Spec-kit: `/tasks` (breakdown concept)

```yaml
Core Function: Generate implementation prompts (DIPs)
Embedded Rules:
  - Creates DIP(s) from design (single or multiple)
  - Always create subfolder structure
  - Automatic separation when >500 LOC or >3 components
  - Preserves atomicity for transactional operations
  - Lightweight task checklist for progress tracking
  - Git commit integration requirements
  - Test specifications embedded in prompts
  - Self-contained implementation instructions
Outputs:
  - Always: .sdlc/implementation/{number}-{name}/
  - Single DIP: dip.md
  - Multiple DIPs: {letter}-{component}-dip.md
  - TASK.md updates (lightweight checklist per DIP)
Templates:
  - dip.template.md (for implementation prompts)
Trade-off: Dual tracking for resumability vs token efficiency
Strategy: Split at natural boundaries, maintain atomic operations
```

#### /do (Implementation)
Merges:
- Bootstrap: `/execute-prp` (core implementation)
- Spec-kit: `/implement` (task execution)

```yaml
Core Function: Execute the DIP to build the solution
Embedded Rules:
  - Test-first development (write tests, then code)
  - Code style enforcement (stack-specific linters)
  - Stack environment checks (detected at init)
  - File safety (no overwriting without reading first)
  - Progress tracking in TASK.md
Scripts:
  - check-environment.sh (validates stack setup)
  - run-tests.sh (executes stack test runner)
  - lint-check.sh (runs stack linters)
Integration:
  - Updates TASK.md checkboxes as tasks complete
  - Adds discovered tasks to separate section
  - NO commits, NO pushes, NO changelog updates
Note: Review and commit are separate commands for user control
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

#### 1A: Template Refresh (Days 1-2)
1. **Audit existing templates**
   - Review all in `.claude/templates/`
   - Identify gaps for new commands
   - Note spec-kit features to incorporate

2. **Create new templates**
   - `charter.template.md` (3 modes: prototype/draft/ratified)
   - `requirements.template.md` (merge Bootstrap + spec-kit formats)
   - `dip.template.md` (Design Implementation Prompt)
   - `amendment.template.md` (for charter changes)

3. **Update existing templates**
   - Add version footers to all
   - Incorporate spec-kit's clarity
   - Ensure consistent structure

4. **Template naming convention**
   - `{artifact-type}.template.md` for primary templates
   - `{artifact-type}-{variant}.template.md` for variants

#### 1B: Command Implementation (Days 3-5)
1. Create `/init` command referencing `charter.template.md`
2. Create `/determine` command referencing `requirements.template.md`
3. Create `/design` command referencing existing design templates
4. Create `/define` command referencing `dip.template.md`
5. Create `/do` command with embedded safety logic
6. Build deterministic safety scripts

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

The 4D workflow (Determine → Design → Define → Do) provides a memorable, logical progression that guides users through the entire SDLC while maintaining flexibility for different project styles.

This refactoring represents evolution, not revolution - preserving what works while fixing what doesn't. As a pre-alpha framework, Bootstrap can make these fundamental improvements without disrupting existing users, using itself as the test case for the new architecture.