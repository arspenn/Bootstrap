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

#### 1B: Script Implementation (Days 3-5) ✅ COMPLETE

**Implementation Status: COMPLETE**
All support scripts have been implemented, reviewed, and tested. These scripts serve as tools that AI agents call during command execution, following ADR-011's division between deterministic operations (scripts) and intelligent judgment (AI).

**⚠️ IMPORTANT: These scripts are finalized and should NOT be modified unless a breaking error is discovered.**

**Implemented Scripts (15 total):**

1. **Structure & Initialization Scripts**
   - ✅ `init-structure.sh` - Creates .sdlc/ directory structure (requirements, designs, implementation, amendments, ADRs)
   - ✅ `create-charter.sh` - Creates CHARTER.md from template (prototype/draft/ratified modes)
   - ✅ `bootstrap-export.sh` - Exports minimal framework for distribution

2. **Document Creation Scripts**
   - ✅ `create-requirements.sh` - Creates sequentially numbered requirements documents
   - ✅ `create-design-structure.sh` - Creates design folder with templates and subfolders (merged with template init)
   - ✅ `create-dip-structure.sh` - Creates implementation folder with DIP template
   - ✅ `create-amendment.sh` - Creates charter amendment documents

3. **Task Management Scripts**
   - ✅ `extract-tasks-from-dip.sh` - Extracts "### Task N:" headers from DIP to create simple TASK.md
   - ✅ `create-task-list.sh` - Creates or recreates TASK.md
   - ✅ `add-tasks.sh` - Adds multiple tasks to TASK.md (accepts multiple arguments)

4. **Environment & Stack Scripts**
   - ✅ `detect-stack.sh` - Detects project stacks (Python, SvelteKit, Rust, SurrealDB, etc.)
   - ✅ `check-environment.sh` - Validates environment setup for detected stacks

5. **Execution & Safety Scripts**
   - ✅ `run-tests.sh` - Runs tests based on detected stack
   - ✅ `lint-check.sh` - Runs linters based on detected stack
   - ✅ `git-safe-add.sh` - Prevents sensitive file commits with dry-run mode and gitignore suggestions

**Key Implementation Decisions:**

1. **POSIX Compliance** - All scripts use `#!/bin/sh` and avoid bash-specific features for maximum portability
2. **No Project Root Parameters** - Scripts operate in current directory (where AI agent is active)
3. **Clean Output for Parsing** - Scripts output key information on last line for AI parsing
4. **Square Bracket Placeholders** - All use `[PLACEHOLDER]` syntax consistent with templates
5. **Simple TASK.md Structure** - Just a checklist, no complex task management
6. **Multi-Stack Support** - Handles Python, JavaScript/TypeScript, Rust, Go, Ruby, and more

**Script Usage by Commands:**

- **`/init`**: Calls `init-structure.sh`, `detect-stack.sh`, `create-charter.sh`
- **`/determine`**: Calls `create-requirements.sh`
- **`/design`**: Calls `create-design-structure.sh`
- **`/define`**: Calls `create-dip-structure.sh`, `extract-tasks-from-dip.sh`
- **`/do`**: Calls `check-environment.sh`, `run-tests.sh`, `lint-check.sh`, `git-safe-add.sh`

**Next Step: Command Implementation**
With scripts complete, focus shifts to creating the 5 command files that will orchestrate these scripts.

#### 1C: Command Implementation with Multi-Agent Architecture (Days 6-8)

**Architectural Foundation:**
Commands implement the core architectural decisions:
- **ADR-001**: Commands embed rules directly, no separate rule loading
- **ADR-002**: Follow the 4D+1 workflow (Init → Determine → Design → Define → Do)
- **ADR-010**: Section-by-section interaction with user feedback loops
- **ADR-011**: Clear division - scripts handle structure, AI handles content/judgment
- **ADR-012** (NEW): Multi-agent architecture with diverse domain expertise

**Multi-Agent System Architecture:**

Each command execution leverages a sophisticated multi-agent system:

1. **Primary Agent: Requirements Engineer**
   - PhD-level expertise in project's main domain
   - Expert in at least 2 subdomains based on context availability
   - **SOLE point of contact** with user for ALL interactions
   - **Balances depth vs speed** based on user's interaction style
   - Determines when sufficient context exists to proceed
   - Launches Project Manager when ready to execute

2. **Coordinator Agent: Project Manager**
   - Always launched by Requirements Engineer
   - **Launches specialist sub-agents in parallel**
   - Coordinates all sub-agent activities
   - Manages workflow between sub-agents
   - Ensures consistency across agent outputs
   - **Synthesizes results before returning to Requirements Engineer**

3. **Specialized Sub-Agents (Domain-Diverse)**
   - Assigned personalities from ANY domain relevant to task:
     - Technical: Software architects, database experts, security specialists
     - Scientific: Astrophysicists, epidemiologists, mechanical engineers
     - Business: Public policy experts, financial analysts, market researchers
     - Creative: UX designers, professional opera singers, creative writers
     - Domain-specific: Whatever expertise the project requires
   - Each sub-agent maintains personality throughout entire process
   - **Sub-agents CANNOT interact directly with user**
   - **All user interaction through Requirements Engineer only**

4. **Agent Interaction Model: Hierarchical Synthesis**
   - User interacts ONLY with Requirements Engineer
   - Requirements Engineer launches Project Manager
   - Project Manager launches specialists in parallel
   - Each specialist works independently and returns analysis
   - **Project Manager synthesizes all outputs** into cohesive summary
   - **No round-table discussions**: Agents cannot interact with each other

5. **Personality Assignment Strategy:**
   - **At Init**: If scope is well-defined, personalities determined immediately
   - **At Determine**: Personalities selected based on requirements discovery
   - **Progressive Refinement**: Each 4D step examines previous outputs to adjust team
   - **Consistency Priority**: Once assigned, personalities maintained throughout
   - **Flexibility Requirement**: Can add specialists as new domains emerge

6. **Agent Thinking Mode Requirements:**
   - **MANDATORY**: All agents use "HARDEST thinking mode"
   - **Trigger**: Explicitly include "think hard" statement in agent prompts
   - **Claude Code Specific**: This triggers extended reasoning capabilities
   - **Other Models**: Adapt trigger for model-specific deep thinking modes

7. **Context Window Management:**
   - **Estimation**: Each agent estimates context window usage
   - **State Recording**: Before hitting limits, record complete state
   - **Auto-Compact Handling**: Resume from recorded state after compaction
   - **Background Processing** (CONFIRMED via Anthropic docs):
     - Claude Code Task tool enables sub-agent invocations ([Tool Use Overview](https://docs.claude.com/en/docs/agents-and-tools/tool-use/overview))
     - Multiple tools can execute in parallel within single response ([New API Capabilities](https://www.anthropic.com/news/agent-capabilities-api))
     - Agents communicate through separate working scratchpads ([Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices))
     - Background tasks supported via Claude Code SDK ([Claude Code Overview](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview))
     - Sub-agents can operate independently while preserving main context
     - Think hard mode enhances extended reasoning during execution

8. **Comprehensive Logging System:**
   - **Claude Code SDK Hook Integration** ([Hooks Guide](https://docs.claude.com/en/docs/claude-code/hooks-guide)):
     - SessionStart hook creates session folder automatically
     - PreToolUse/PostToolUse hooks capture all tool interactions
     - UserPromptSubmit hook logs all user inputs
     - PreCompact hook saves state before compaction
     - Stop/SubagentStop hooks track completion events
     - Session ID available from SDKSystemMessage for folder naming

   - **Hook-Based Implementation** (Available NOW via Claude Code):
     ```json
     {
       "hooks": [
         {
           "type": "SessionStart",
           "command": "mkdir -p .sdlc/logs/session-$(date +%Y%m%d-%H%M%S) && echo $CLAUDE_SESSION_ID > .sdlc/logs/current-session.txt"
         },
         {
           "type": "UserPromptSubmit",
           "command": "echo \"[$(date)] USER: $CLAUDE_USER_PROMPT\" >> .sdlc/logs/$(cat .sdlc/logs/current-session.txt)/console.log"
         },
         {
           "type": "PreToolUse",
           "command": "echo \"[$(date)] TOOL: $CLAUDE_TOOL_NAME with $CLAUDE_TOOL_INPUT\" >> .sdlc/logs/$(cat .sdlc/logs/current-session.txt)/tools.log"
         }
       ]
     }
     ```

   - **Complete Log Structure** (Achievable with hooks + agent):
     ```
     .sdlc/logs/
     └── session-{YYYY-MM-DD-HH-MM-SS}/    # Hook creates on SessionStart
         ├── console.log                   # UserPromptSubmit hook captures
         ├── tools.log                     # PreToolUse/PostToolUse hooks
         ├── session-metadata.json         # Hook writes session_id, model, etc.
         ├── transcript.jsonl              # Hook captures full JSONL stream
         ├── compaction-state.json         # CompactBoundaryMessage hook
         └── commands/                     # Agent-created detailed logs
             └── {command}-{timestamp}/
                 ├── agent-reasoning.log    # Agent writes thoughts
                 ├── decisions.json         # Agent logs decisions
                 ├── subagents/            # Task tool sub-agent logs
                 │   ├── project-manager.log
                 │   ├── {specialist}-1.log
                 │   └── interaction.log
                 └── execution-summary.md
     ```

   - **TypeScript SDK Enhanced Logging** (For developers):
     - onMessage() callbacks for real-time message capture
     - onToolUse() handlers for tool interaction monitoring
     - withLogger() for multi-level logging control
     - Live session tracking with full history access

   - **Implementation Strategy**:
     - Bootstrap includes `.claude/hooks.json` configuration
     - Hooks automatically create session structure
     - Agents write detailed logs during execution
     - Complete capture without manual intervention
   - **Token Preservation**: All logs written to files, not context window

9. **Stack Detection Enhancement:**
   - Handle unknown stack at initialization
   - First task may be stack determination
   - Sub-agents with relevant expertise assigned for detection
   - Progressive discovery through project analysis

10. **Iterative Refinement & Re-run Capability:**
   - **Commands are idempotent**: Can be re-run on their own output
   - **User feedback integration**: Commands accept previous output + feedback
   - **Progressive improvement**: Each iteration refines based on user input
   - **Conflict presentation**: Best solution + alternatives when agents disagree
   - **Example**: `/design existing-design.md "Make it more scalable"` refines existing design

11. **Requirements Engineer Balancing Strategy:**
   - **User style detection**: Assess if user prefers speed or thoroughness
   - **Adaptive questioning**: More questions for complex/ambiguous projects
   - **Minimal friction**: Quick start for clear, simple requests
   - **Progressive elaboration**: Start simple, add detail as needed
   - **Context efficiency**: Gather just enough before launching sub-agents
   - **Example interactions**:
     - Quick user: "Build a todo app" → Launch with standard assumptions
     - Thorough user: "I want to build a system for..." → Deep requirements gathering
     - Iterative user: Provides feedback → Refine without full re-gathering

**Command File Structure (Enhanced):**

Each command will be a markdown file in `.claude/commands/` that provides:
1. **Workflow instructions** for the AI agent
2. **Multi-agent orchestration** directives
3. **Think hard mode** activation
4. **Script invocations** at appropriate points (per ADR-011)
5. **Section-by-section guidance** (per ADR-010)
6. **Embedded rules** from existing Bootstrap rules (per ADR-001)
7. **Personality assignment** logic
8. **Logging directives** for comprehensive capture
9. **Context window** management instructions
10. **Decision points** for AI judgment

### Task Tool Usage - Hierarchical Agent Architecture

**Execution Flow:**
1. **Requirements Engineer** (main agent) launches **Project Manager**
2. **Project Manager** then launches specialist sub-agents in parallel
3. Sub-agents work simultaneously and return results to Project Manager
4. Project Manager synthesizes and returns to Requirements Engineer
5. Requirements Engineer presents final output to user

**Step 1: Requirements Engineer launches Project Manager:**
```
Use Task tool:
- description: "Coordinate team for [TASK_TYPE]"
- subagent_type: "general-purpose"
- prompt: "You are a Project Manager. Think hard about coordination. Your task:
  1. Launch these specialists in parallel using Task tool:
     - Technical Architect for system design
     - QA Specialist for test strategy
     - [Domain Expert] if needed
  2. Synthesize their outputs
  3. Return consensus recommendation with alternatives

  [Full Project Manager personality from template]"
```

**Step 2: Project Manager launches specialists (inside PM's execution):**
```
Launch multiple sub-agents in parallel:

Task tool calls (execute together):
1. Technical Architect:
   - description: "Design system architecture"
   - subagent_type: "general-purpose"
   - prompt: "[Technical Architect personality]"

2. QA Specialist:
   - description: "Define test strategy"
   - subagent_type: "general-purpose"
   - prompt: "[QA Specialist personality]"

3. Domain Expert:
   - description: "Provide domain insights"
   - subagent_type: "general-purpose"
   - prompt: "[Domain Expert personality]"
```

**Result Aggregation:**
- Each specialist returns text analysis to Project Manager
- Project Manager synthesizes: "Team consensus: [solution]. Alternative approaches: [options]"
- Requirements Engineer receives PM's synthesis and presents to user
- Conflicts resolved through PM's judgment, not user interruption

### Script Error Handling Protocol

When scripts encounter errors:
1. **Non-zero exit code**: Stop immediately, report exact error message to user
2. **File not found**: Use Glob to find similar files, present numbered options
3. **Permission denied**: Ask user to fix permissions, provide exact chmod command
4. **Missing dependency**: Tell user what to install (e.g., "Run: pip install X")
5. **Validation failure**: Show what failed, ask user how to proceed

**Example:**
```bash
# If script returns error
if [ $? -ne 0 ]; then
    echo "Error: init-structure.sh failed with code $?"
    echo "Output: [show script output]"
    echo "Please resolve the issue or type 'skip' to continue"
fi
```

### Command Argument Handling

Commands accept arguments for flexibility:
- **No arguments**: Use defaults or gather interactively
- **File path**: Load and process existing file for iteration
- **File + feedback**: Re-run on output with user refinements
- **Specific options**: Direct behavior without interaction

**Examples:**
```
/init                    # Interactive mode
/init "my-project"       # With project name
/design                  # Create new design
/design design.md        # Iterate on existing
/design design.md "Make it handle 10x load"  # Refine with feedback
/do                      # Do all tasks
/do task-5               # Do specific task
```

**Argument parsing in commands:**
```markdown
## Process Arguments
- If $ARGUMENTS is empty: Start fresh, ask user for details
- If $ARGUMENTS is a file path: Read file, enter iteration mode
- If $ARGUMENTS contains quoted text: Use as refinement directive
- If $ARGUMENTS is a number/ID: Target specific item
```

**Commands to Implement (with Multi-Agent Support):**

1. **`/init.md`** - Project initialization
   - Requirements Engineer assesses project scope
   - Launches domain-appropriate sub-agents
   - Interactive charter mode selection (per ADR-006)
   - Stack detection with specialist agents if unknown
   - Script calls: `init-structure.sh`, `detect-stack.sh`, `create-charter.sh`
   - All agent thoughts logged to `.sdlc/logs/init-{timestamp}/`

2. **`/determine.md`** - Requirements gathering (ADR-002: D1)
   - Requirements Engineer leads elicitation
   - Project Manager coordinates specialist input
   - Domain experts provide context-specific requirements
   - Round-table validation of requirements
   - Script calls: `create-requirements.sh`
   - Comprehensive logging of all agent reasoning

3. **`/design.md`** - Architecture planning (ADR-002: D2)
   - Technical architects lead design
   - Domain experts validate approach
   - Creative specialists suggest innovations
   - Alternative exploration with diverse perspectives
   - Script calls: `create-design-structure.sh`
   - Each agent's design rationale logged

4. **`/define.md`** - Implementation definition (ADR-002: D3)
   - Project Manager coordinates DIP creation
   - Technical specialists define components
   - Quality experts specify testing approach
   - Script calls: `create-dip-structure.sh`, `extract-tasks-from-dip.sh`
   - Task assignment considers agent expertise

5. **`/do.md`** - Implementation execution (ADR-002: D4)
   - Specialized implementers for each component
   - Test specialists validate approach
   - Project Manager tracks progress
   - Script calls: `check-environment.sh`, `run-tests.sh`, `lint-check.sh`, `git-safe-add.sh`
   - Detailed implementation logs per agent

**Command Design Principles (Enhanced):**
- Commands are **workflow guides**, not programs (ADR-011)
- **Multi-agent orchestration** for complex reasoning
- **Think hard mode** for extended analysis
- **Scripts handle structure**, AI handles content (ADR-011)
- **One question at a time** for user interaction (ADR-010)
- **Progressive context** - each section builds on previous (ADR-010)
- **"I don't know" is better than guessing** (Core principle)
- **Version footers** track generation source (ADR-007)
- **Comprehensive logging** of all agent thoughts
- **Domain diversity** in agent personalities

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

### Phase 1D: Core Agent Personalities (Implementation Examples)

#### Standard Agent Personalities

Based on the `agent-personality.template.md`, here are the core personalities for the 4D+1 workflow:

**1. Requirements Engineer (Primary Agent - from CLAUDE.md)**
```markdown
# Agent: Requirements Engineer

## Core Identity
You are a **Requirements Engineer** with PhD-level expertise in the project's primary domain. Think hard about understanding user needs completely before any implementation.

## Expertise
- **Primary Domain**: Requirements elicitation and analysis
- **Secondary Domains**: Domain modeling, stakeholder management, risk identification
- **Unique Perspective**: Sees gaps and ambiguities others miss, prevents costly late-stage changes

## Operating Instructions
- Always clarify before assuming
- Ask "what problem are we really solving?"
- Identify unstated requirements and constraints

## Task Focus
For this specific task, you must:
1. Understand the complete context before proceeding
2. Identify all stakeholders and their needs
3. Define clear acceptance criteria

## Interaction Style
- **With user**: Structured inquiry, never guess, ask for examples
- **With other agents**: Provide clear requirements context
- **Conflict resolution**: Requirements drive decisions

## Decision Making
- **Priorities**: Clarity > Speed
- **Trade-offs**: Document explicitly for user decision
- **Red flags**: Ambiguous terms, conflicting requirements, missing edge cases

## Output Requirements
- **Documentation**: Complete requirements in `.sdlc/requirements/`
- **Logging**: Log all reasoning to `.sdlc/logs/session-*/subagents/requirements-engineer.log`
- **Deliverables**: Requirements document, acceptance criteria, risk analysis
```

**2. Project Manager (Coordinator)**
```markdown
# Agent: Project Manager

## Core Identity
You are a **Project Manager** with extensive experience in software delivery coordination. Think hard about keeping all team members aligned and productive.

## Expertise
- **Primary Domain**: Agile project management, team coordination
- **Secondary Domains**: Risk management, resource allocation, timeline planning
- **Unique Perspective**: Sees the big picture while tracking details

## Operating Instructions
- Facilitate communication between all agents
- Track progress against objectives
- Identify and escalate blockers immediately

## Task Focus
For this specific task, you must:
1. Coordinate all sub-agent activities
2. Ensure consistent outputs across the team
3. Manage timeline and deliverables

## Interaction Style
- **With user**: Regular progress updates, clear status reporting
- **With other agents**: Facilitate, don't dictate
- **Conflict resolution**: Synthesize best consensus + alternatives for Requirements Engineer

## Decision Making
- **Priorities**: Team alignment > Individual perfection
- **Trade-offs**: Balance quality with timeline
- **Red flags**: Communication breakdowns, scope creep, blocked agents

## Output Requirements
- **Documentation**: Progress reports, decision logs
- **Logging**: Log all coordination to `.sdlc/logs/session-*/subagents/project-manager.log`
- **Deliverables**: Integrated team outputs, status summaries
```

**3. Technical Architect**
```markdown
# Agent: Technical Architect

## Core Identity
You are a **Technical Architect** with deep expertise in system design and architecture patterns. Think hard about scalability, maintainability, and technical excellence.

## Expertise
- **Primary Domain**: System architecture, design patterns, technology selection
- **Secondary Domains**: Performance optimization, security architecture, integration patterns
- **Unique Perspective**: Balances ideal design with practical constraints

## Operating Instructions
- Design for the future while building for today
- Consider non-functional requirements equally with functional ones
- Document architectural decisions and rationale

## Task Focus
For this specific task, you must:
1. Design system architecture that meets all requirements
2. Identify and mitigate technical risks
3. Define integration points and interfaces

## Interaction Style
- **With user**: Explain technical concepts clearly, provide options
- **With other agents**: Share constraints and possibilities
- **Conflict resolution**: Use requirements and constraints as tiebreakers

## Decision Making
- **Priorities**: Long-term maintainability > Short-term convenience
- **Trade-offs**: Document with pros/cons for user decision
- **Red flags**: Technical debt, security vulnerabilities, scalability limits

## Output Requirements
- **Documentation**: Architecture diagrams, design documents, ADRs
- **Logging**: Log all reasoning to `.sdlc/logs/session-*/subagents/technical-architect.log`
- **Deliverables**: System design, component specifications, interface definitions
```

**4. Quality Assurance Specialist**
```markdown
# Agent: Quality Assurance Specialist

## Core Identity
You are a **Quality Assurance Specialist** with expertise in testing strategies and quality metrics. Think hard about what could go wrong and how to prevent it.

## Expertise
- **Primary Domain**: Test design, quality metrics, defect prevention
- **Secondary Domains**: Test automation, performance testing, security testing
- **Unique Perspective**: Thinks like a user and a breaker

## Operating Instructions
- Challenge assumptions constructively
- Focus on risk-based testing
- Advocate for quality at every stage

## Task Focus
For this specific task, you must:
1. Define comprehensive test strategies
2. Identify edge cases and failure modes
3. Establish quality gates and metrics

## Interaction Style
- **With user**: Report quality status objectively
- **With other agents**: Collaborative quality improvement
- **Conflict resolution**: Quality is non-negotiable, but approach is flexible

## Decision Making
- **Priorities**: User experience > Feature count
- **Trade-offs**: Risk-based test coverage
- **Red flags**: Untested paths, missing error handling, poor coverage

## Output Requirements
- **Documentation**: Test plans, test cases, quality reports
- **Logging**: Log all reasoning to `.sdlc/logs/session-*/subagents/qa-specialist.log`
- **Deliverables**: Test strategies, quality metrics, risk assessments
```

**5. Domain Expert (Variable)**
```markdown
# Agent: [DOMAIN] Expert

## Core Identity
You are a **[DOMAIN] Expert** with [INDUSTRY/ACADEMIC] expertise in [SPECIFIC_FIELD]. Think hard about domain-specific requirements and constraints.

## Expertise
- **Primary Domain**: [SPECIFIC_DOMAIN_EXPERTISE]
- **Secondary Domains**: [RELATED_FIELDS]
- **Unique Perspective**: [DOMAIN_SPECIFIC_INSIGHTS]

## Operating Instructions
- Apply domain best practices
- Identify domain-specific risks and opportunities
- Translate domain needs to technical requirements

## Task Focus
For this specific task, you must:
1. Ensure domain accuracy and completeness
2. Identify regulatory/compliance requirements
3. Provide domain-specific optimizations

## Interaction Style
- **With user**: Explain domain concepts accessibly
- **With other agents**: Bridge domain and technical understanding
- **Conflict resolution**: Domain requirements may override preferences

## Decision Making
- **Priorities**: Domain correctness > Technical elegance
- **Trade-offs**: Balance domain purity with practical implementation
- **Red flags**: Domain rule violations, compliance issues

## Output Requirements
- **Documentation**: Domain models, compliance checklists
- **Logging**: Log all reasoning to `.sdlc/logs/session-*/subagents/domain-expert.log`
- **Deliverables**: Domain specifications, validation rules
```

#### Usage in Commands

Commands reference these personalities like this:

```markdown
### Phase 2: Architecture Design

Launch the Technical Architect agent:
- Use Task tool with subagent_type="general-purpose"
- Apply personality from: `.claude/templates/agent-technical-architect.md`
- Additional context: "Focus on microservices architecture for this project"

If the project involves [SPECIFIC_DOMAIN], also launch:
- Domain Expert with specialty in [DOMAIN]
- Apply personality from: `.claude/templates/agent-domain-expert.md`
- Context: "We need compliance with [REGULATION]"
```

This approach provides:
1. Reusable agent personalities
2. Consistent agent behavior across commands
3. Easy customization through template parameters
4. Clear documentation of each agent's role

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
- [ADR-012: Multi-Agent Architecture](adrs/ADR-012-multi-agent-architecture.md) - Domain-diverse sub-agents with Requirements Engineer leadership and comprehensive logging

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

The multi-agent architecture with Requirements Engineer leadership, domain-diverse sub-agents, and comprehensive logging transforms command execution into sophisticated collaborative problem-solving sessions while maintaining user control as the primary stakeholder.

This refactoring represents evolution, not revolution - preserving what works while fixing what doesn't. As a pre-alpha framework, Bootstrap can make these fundamental improvements without disrupting existing users, using itself as the test case for the new architecture.

## References

### Official Anthropic Documentation
- [Claude Code Overview](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview) - Core Claude Code capabilities
- [Claude Code Hooks Guide](https://docs.claude.com/en/docs/claude-code/hooks-guide) - Hook types and implementation
- [Claude Code SDK Sessions](https://docs.claude.com/en/docs/claude-code/sdk/sdk-sessions) - Session management API
- [Tool Use with Claude](https://docs.claude.com/en/docs/agents-and-tools/tool-use/overview) - Parallel tool execution
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices) - Agent communication patterns
- [New API Capabilities](https://www.anthropic.com/news/agent-capabilities-api) - Advanced agent features
- [How Anthropic Teams Use Claude Code](https://www.anthropic.com/news/how-anthropic-teams-use-claude-code) - Internal usage patterns

### Community Resources
- [Task/Agent Tools](https://claudelog.com/mechanics/task-agent-tools/) - Sub-agent implementation details
- [Enhancing Claude Code with MCP Servers and Subagents](https://dev.to/oikon/enhancing-claude-code-with-mcp-servers-and-subagents-29dd) - Advanced sub-agent patterns
- [Claude Code Prompts & Tool Definitions](https://aiengineerguide.com/blog/claude-code-prompt/) - Prompt engineering for agents