# PRP: Phase 1C - Command Implementation with Multi-Agent Architecture

**Generated:** 2025-09-24
**Feature:** Command Implementation (Phase 1C from design.md)
**Confidence Level:** 9/10 (Scripts exist, patterns clear, comprehensive research completed)

## Executive Summary

Implement the five core commands (/init, /determine, /design, /define, /do) that orchestrate Bootstrap's 4D+1 workflow using multi-agent architecture. Commands are markdown files that guide AI agents through SDLC phases, invoking scripts for structure and leveraging hierarchical agent teams for intelligent content creation.

## Context and Constraints

### Design Foundation
- **Source Design:** `.sdlc/designs/026-refactor-command-architecture/design.md` (Phase 1C, lines 465-741)
- **Architecture:** Hierarchical multi-agent system (Requirements Engineer → Project Manager → Specialists)
- **Key ADRs:**
  - ADR-001: Embed rules directly in commands
  - ADR-002: Follow 4D+1 workflow (Init → Determine → Design → Define → Do)
  - ADR-010: Section-by-section user interaction
  - ADR-011: Scripts handle structure, AI handles content

### Existing Infrastructure
- **Scripts Ready:** All 15 scripts exist in `.claude/scripts/` (POSIX-compliant)
- **Templates Ready:** All templates in `.claude/templates/` with placeholders
- **Agent Personalities:** Project Manager exists at `.claude/agents/project-manager.md`
- **Command Pattern:** Reference `.claude/commands/gather-project-requirements.md` for structure

### Technical Requirements
- Commands must be workflow guides, not programs
- Use Task tool with `subagent_type: "general-purpose"`
- Include "Think hard" directive for all agents
- Maintain hierarchical synthesis (no peer-to-peer agent communication)
- Rely on automatic JSONL logging (no custom logging implementation)

## Implementation Blueprint

### Command Structure Pattern
```markdown
# [Command Name]

## Arguments: $ARGUMENTS

[Brief description of command purpose and argument handling]

## When to Use This Command

**Use `/[command]` when:**
- [Specific use case 1]
- [Specific use case 2]

**Skip when:**
- [Exception case 1]
- [Exception case 2]

## Multi-Agent Architecture

### Primary Agent: Requirements Engineer
You are the Requirements Engineer with PhD-level expertise. Think hard about [phase goal].

### Agent Team
When sufficient context gathered, launch Project Manager to coordinate:
- Technical Architect for system design
- QA Specialist for test strategy
- [Domain-specific experts as needed]

## Process

### 1. **Initial Assessment**
[Check for arguments, existing files, context]

### 2. **Interactive Gathering** (Section-by-Section)
[User interaction flow with one question at a time]

### 3. **Script Execution**
```bash
# Call appropriate script
./.claude/scripts/[script-name].sh [args]
```

### 4. **Multi-Agent Synthesis**
[Launch Project Manager with Task tool]

### 5. **Content Creation**
[Fill templates with AI-generated content]

### 6. **Validation & Reporting**
[Success criteria and next steps]

## Embedded Rules
[Extract relevant rules from .claude/rules/]

## Error Handling
[Script error protocols]

---
Generated with Bootstrap v0.12.0
```

## Detailed Task List

### Task 1: Create /init.md Command
**File:** `.claude/commands/init.md`
**Purpose:** One-time project setup and charter creation

**Key Components:**
- Check for existing CHARTER.md
- Interactive charter mode selection (prototype/draft/ratified)
- Stack detection with specialist agents
- Script calls: `init-structure.sh`, `detect-stack.sh`, `create-charter.sh`

**Multi-Agent Flow:**
```
1. Requirements Engineer assesses project type
2. If stack unknown, launch specialists:
   - Python Expert for Python detection
   - Node.js Expert for JavaScript/TypeScript
   - Database Expert for data layer
3. Project Manager synthesizes recommendations
4. Create charter with appropriate template
```

**Embedded Rules:**
- From `sequential-file-naming.md`: Use ###-kebab-case pattern
- From `sdlc-directory-structure.md`: All artifacts in .sdlc/
- From `planning-context.md`: Charter establishes project principles

### Task 2: Create /determine.md Command
**File:** `.claude/commands/determine.md`
**Purpose:** Requirements gathering and documentation

**Key Components:**
- Prerequisites: CHARTER.md must exist
- Section-by-section requirements building
- Script call: `create-requirements.sh`
- Sequential numbering (###-{name}.md)

**Multi-Agent Flow:**
```
Requirements Engineer launches Project Manager:
Use Task tool:
- description: "Coordinate requirements analysis"
- subagent_type: "general-purpose"
- prompt: "You are a Project Manager. Think hard about requirements. Launch specialists:
  - Business Analyst for user stories
  - Technical Architect for constraints
  - QA Specialist for acceptance criteria
  Synthesize comprehensive requirements document."
```

**Interactive Questions:**
1. "What feature/capability are we gathering requirements for?"
2. "Who are the stakeholders?"
3. "What problem does this solve?"
4. Build requirements through conversation

### Task 3: Create /design.md Command
**File:** `.claude/commands/design.md`
**Purpose:** Architecture planning with alternatives

**Key Components:**
- Complexity assessment (>5 days or >5 components = phasing)
- Minimum 2 alternatives evaluation
- Script call: `create-design-structure.sh`
- ADR creation for key decisions

**Multi-Agent Architecture:**
```python
# Pseudocode for agent orchestration
if complexity > threshold:
    agents = [
        "Technical Architect",
        "Performance Engineer",
        "Security Specialist",
        "Domain Expert"
    ]
else:
    agents = ["Technical Architect", "QA Specialist"]

for agent in agents:
    launch_parallel(agent, context)
synthesize_results()
```

**Embedded Rules:**
- From `design-structure.md`: design.md in subfolder with diagrams
- From `adr-management.md`: Document architectural decisions

### Task 4: Create /define.md Command
**File:** `.claude/commands/define.md`
**Purpose:** Generate implementation prompts (DIPs)

**Key Components:**
- Analyze design complexity
- Split if >500 LOC or >3 components
- Script calls: `create-dip-structure.sh`, `extract-tasks-from-dip.sh`
- Generate TASK.md checklist

**DIP Structure:**
```markdown
## Context & Constraints
[From design document]

## Implementation Tasks
### Task 1: [Component]
- Files to create/modify
- Test specifications
- Validation requirements

## Git Guidelines
- Commit after each task
- Conventional format required
```

**Multi-Agent Approach:**
- Project Manager coordinates DIP creation
- Technical specialists define components
- QA defines test approach

### Task 5: Create /do.md Command
**File:** `.claude/commands/do.md`
**Purpose:** Execute DIP implementation

**Key Components:**
- Read DIP sequentially
- Test-first development
- Script calls: `check-environment.sh`, `run-tests.sh`, `lint-check.sh`, `git-safe-add.sh`
- Update TASK.md checkboxes

**Implementation Flow:**
```bash
# 1. Check environment
./.claude/scripts/check-environment.sh

# 2. For each task in DIP:
#    - Write tests first
#    - Implement to pass tests
#    - Run validation

# 3. Stage safe files only
./.claude/scripts/git-safe-add.sh [files]

# 4. Update TASK.md progress
```

**Error Handling Protocol:**
- Non-zero exit: Report exact error
- File not found: Use Glob, present options
- Permission denied: Provide chmod command
- Test failure: Ask for guidance

## Validation Gates

```bash
# After creating all commands
# 1. Verify command files exist
ls -la .claude/commands/{init,determine,design,define,do}.md

# 2. Check markdown syntax
for cmd in .claude/commands/{init,determine,design,define,do}.md; do
    echo "Checking $cmd"
    # Verify has required sections
    grep -q "## Arguments:" "$cmd" || echo "Missing Arguments section"
    grep -q "## Process" "$cmd" || echo "Missing Process section"
    grep -q "## Multi-Agent" "$cmd" || echo "Missing Multi-Agent section"
done

# 3. Verify script references are valid
for script in init-structure detect-stack create-charter create-requirements create-design-structure create-dip-structure extract-tasks-from-dip check-environment run-tests lint-check git-safe-add; do
    test -f ".claude/scripts/${script}.sh" || echo "Missing script: ${script}.sh"
done

# 4. Test with a simple project (manual validation)
echo "Test commands with: /init test-project"
```

## External Resources

### Claude Code Documentation
- [Subagents Guide](https://docs.claude.com/en/docs/claude-code/sub-agents)
- [Task Tool Overview](https://docs.claude.com/en/docs/agents-and-tools/tool-use/overview)
- [Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [Multi-Agent Patterns](https://claudelog.com/mechanics/task-agent-tools/)

### Key Patterns from Existing Commands
- Reference: `.claude/commands/gather-project-requirements.md`
  - Argument parsing pattern (lines 23-28)
  - Interactive question flow (lines 45-60)
  - File generation approach (lines 62-67)

### Script Integration Examples
- All scripts in `.claude/scripts/` return meaningful exit codes
- Scripts output status messages for AI parsing
- Example from `init-structure.sh`:
  ```sh
  echo "✓ Project SDLC structure initialized"
  ```

## Critical Implementation Notes

### Multi-Agent Invocation Pattern
```javascript
// Correct pattern for launching Project Manager
Use Task tool:
- description: "Coordinate [phase] execution"
- subagent_type: "general-purpose"  // MUST be exactly this
- prompt: "You are a Project Manager. Think hard about [task].

  Your responsibilities:
  1. Launch these specialists in parallel:
     - [Agent 1] for [purpose]
     - [Agent 2] for [purpose]
  2. Synthesize outputs
  3. Return consensus with alternatives

  [Full personality from .claude/agents/project-manager.md]"
```

### Section-by-Section Pattern
```markdown
### Content Creation Flow
1. Script creates empty structure
2. AI fills section 1 → user feedback
3. Apply learnings to section 2
4. Continue until complete
5. Never fill entire document at once
```

### Argument Handling
```markdown
## Process Arguments
- Empty: Interactive mode, gather requirements
- File path: Read file, enter iteration mode
- File + "quoted text": Refine with feedback
- Number/ID: Target specific item
```

## Common Pitfalls to Avoid

1. **DON'T** create custom logging - JSONL is automatic
2. **DON'T** allow sub-agents to interact with user directly
3. **DON'T** skip "Think hard" directive - critical for reasoning
4. **DON'T** fill entire templates at once - use section-by-section
5. **DON'T** embed scripts - call them via Bash tool
6. **DON'T** allow round-table discussions - use hierarchical synthesis
7. **DON'T** forget to check script exit codes

## Quality Checklist
- [x] All scripts verified to exist
- [x] Command structure pattern documented
- [x] Multi-agent patterns researched and documented
- [x] Task tool usage with general-purpose subagent confirmed
- [x] Section-by-section interaction pattern included
- [x] Error handling protocols specified
- [x] Validation gates are executable
- [x] External documentation URLs provided
- [x] Existing patterns referenced with line numbers

## Success Metrics
- All 5 commands created and syntactically valid
- Each command properly invokes required scripts
- Multi-agent orchestration follows hierarchical pattern
- Commands accept and parse arguments correctly
- Section-by-section interaction implemented
- Error handling responds appropriately to script failures

---
**Implementation Confidence:** 9/10
**Reasoning:** Scripts already exist, patterns are clear from existing commands, multi-agent architecture is well-documented, and comprehensive research has been completed. The only unknown is the exact agent personality variations needed, which can be adapted during implementation.