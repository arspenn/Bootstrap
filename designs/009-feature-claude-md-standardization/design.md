---
title: CLAUDE.md Standardization and Rule Extraction
status: draft
created: 2025-07-29
updated: 2025-07-29
type: feature
author: user
tags: 
  - rules
  - standardization
  - configuration
  - refactoring
estimated_effort: 1-2 days
---

# CLAUDE.md Standardization and Rule Extraction Design Document

## Executive Summary

This design refactors CLAUDE.md from a monolithic instruction file into a modular rule system, extracting inline rules into standardized format files. This improves consistency, enables individual rule management, and provides clear metadata tracking for token usage and security implications.

## Requirements

### Functional Requirements
- Extract all actionable rules from CLAUDE.md into individual rule files
- Maintain existing rule functionality without breaking changes
- Create standardized metadata for all rules including priority and dependencies
- Transform CLAUDE.md into a minimal configuration loader
- Support sequential implementation for safe rollback
- Enable individual rule testing and validation

### Non-Functional Requirements
- **Performance**: Minimize token usage through efficient rule loading
- **Maintainability**: Each rule independently manageable and testable
- **Clarity**: Clear documentation and override hierarchy
- **Extensibility**: Easy to add new rules without modifying core files
- **Reliability**: Comprehensive testing for each migrated rule

## Current State Analysis

### Existing Infrastructure
- **Rule System**: YAML-based rules in `.claude/rules/` with structured format
- **Import System**: MASTER_IMPORTS.md handles rule loading
- **Documentation**: Each rule has definition and full documentation files
- **Templates**: Support files in `.claude/templates/`

### CLAUDE.md Issues
1. **Mixed Concerns**: Configuration, rules, and behavior guidelines in one file
2. **No Metadata**: Missing security levels, token impact, priorities
3. **Informal Format**: Bullet points instead of structured YAML
4. **Duplication**: Some rules already exist in separate files
5. **No Dependencies**: Rules can't express relationships

## Proposed Design

### Overview
Implement a phased migration extracting CLAUDE.md rules into the standardized format, adding metadata fields for priority and dependencies, and creating a configuration separation strategy.

### Architecture

#### Rule Metadata Enhancement
```yaml
# Enhanced rule metadata
rule_metadata:
  id: "project/planning-context"
  status: "active"
  security_level: "low"
  token_impact: "~30 tokens per operation"
  priority: 100  # Higher number = higher priority
  dependencies:
    - "project/task-management"  # Optional dependencies
  tags:
    - "context"
    - "planning"
```

#### Migration Phases

**Phase 1: Core Project Rules**
1. `project/planning-context.md` - PLANNING.md and TASK.md requirements
2. `project/code-structure.md` - 500 line limit, module organization
3. `project/adr-management.md` - ADR creation and organization

**Phase 2: Python-Specific Rules**
4. `python/code-style.md` - PEP8, black, type hints
5. `python/environment-management.md` - venv_linux usage
6. `documentation/docstring-format.md` - Google-style docstrings

**Phase 3: Testing Rules**
7. `testing/pytest-requirements.md` - Test creation standards

**Phase 4: Configuration Separation**
8. Create `.claude/config.yaml` for project settings
9. Update CLAUDE.md to minimal loader

### Design Decisions

#### Priority System Design
- Add `priority` field to rule metadata (0-1000 scale)
- Default priority: 500
- Override hierarchy:
  1. User instructions (priority: 1000)
  2. TASK.md requirements (priority: 900)
  3. Individual rules (by priority value)
  4. CLAUDE.md defaults (priority: 100)

#### Dependency Management
- Add `dependencies` array to rule metadata
- Dependencies loaded before dependent rules
- Circular dependency detection
- Optional vs required dependencies

#### Configuration Separation
```yaml
# .claude/config.yaml
project:
  name: "Bootstrap"
  language: "python"
  environment: "venv_linux"
  
defaults:
  line_limit: 500
  test_framework: "pytest"
  documentation_style: "google"
  
overrides:
  # Rule-specific overrides
  "project/code-structure":
    line_limit: 600
```

#### AI Behavior Rules Enhancement
The AI Behavior Rules section will remain in CLAUDE.md but be enhanced with specific, actionable guidelines:

**Current Vague Rules → Enhanced Specific Rules:**

1. **"Never assume missing context"** → 
   - When file paths are ambiguous, list possible matches and ask for clarification
   - When requirements are unclear, provide interpretation and confirm before proceeding
   - When multiple valid approaches exist, present options with trade-offs

2. **"Never hallucinate libraries"** →
   - Check imports against requirements.txt/pyproject.toml before using
   - Verify module existence with file system before importing
   - When suggesting new libraries, confirm they exist on PyPI with version

3. **"Always confirm file paths"** →
   - Use Read/LS tools to verify path existence before operations
   - Check parent directory exists before creating new files
   - Resolve relative paths to absolute before use

4. **"Never delete or overwrite"** →
   - Always use Read before Edit/Write on existing files
   - Check git status before file operations
   - Require explicit "overwrite" or "delete" in user instruction
   - Exception: When TASK.md explicitly lists file modification

Additional specific behaviors to add:
- **Token Efficiency**: Batch related tool calls in single message
- **Error Recovery**: When tool fails, explain error and suggest fix
- **Progress Tracking**: Use TodoWrite for multi-step tasks
- **Safety Checks**: Run validation commands after changes

## Alternative Approaches Considered

### Alternative 1: Gradual In-Place Enhancement
Keep rules in CLAUDE.md but add structured sections with metadata.

**Pros:**
- No migration needed
- Backward compatible

**Cons:**
- Still monolithic
- Harder to test individual rules
- Token inefficient

### Alternative 2: Single Migration Script
Create automated tool to extract all rules at once.

**Pros:**
- Fast implementation
- Consistent transformation

**Cons:**
- Higher risk of errors
- Harder to rollback
- Less testing opportunity

### Alternative 3: Rule Packages
Group related rules into package files.

**Pros:**
- Fewer files
- Related rules together

**Cons:**
- Less granular control
- Harder to enable/disable individual rules
- Against current pattern

**Recommendation**: Phased individual migration provides safest path with thorough testing.

## Implementation Plan

### Phase 1: Infrastructure (Day 1 Morning)
1. Enhance rule metadata schema
2. Add priority support to rule loader
3. Implement dependency resolution
4. Create rule validation tool

### Phase 2: Core Rules Migration (Day 1 Afternoon)
1. Create `project/planning-context.md`
2. Create `project/code-structure.md`
3. Create `project/adr-management.md`
4. Test each rule individually
5. Update MASTER_IMPORTS.md

### Phase 3: Language Rules Migration (Day 2 Morning)
1. Create `python/code-style.md`
2. Create `python/environment-management.md`
3. Create `documentation/docstring-format.md`
4. Create `testing/pytest-requirements.md`
5. Comprehensive testing

### Phase 4: Finalization (Day 2 Afternoon)
1. Create `.claude/config.yaml`
2. Enhance AI Behavior Rules section
3. Update CLAUDE.md to minimal loader
4. Update documentation
5. Final integration testing

## Risks and Mitigations

### Technical Risks
1. **Rule Loading Performance**
   - Risk: Increased token usage from multiple files
   - Mitigation: Optimize import system, measure impact

2. **Dependency Conflicts**
   - Risk: Complex dependency chains
   - Mitigation: Keep dependencies minimal, add cycle detection

3. **Priority Conflicts**
   - Risk: Unclear which rule wins
   - Mitigation: Clear priority values, explicit override documentation

### Project Risks
1. **Testing Coverage**
   - Risk: Missing edge cases in migration
   - Mitigation: Comprehensive test suite for each rule

2. **Documentation Lag**
   - Risk: Docs not updated with changes
   - Mitigation: Update docs as part of each phase

## Success Criteria

- [ ] All identified rules extracted into standard format
- [ ] Each rule includes complete metadata
- [ ] Priority system implemented and documented
- [ ] Dependency management functional
- [ ] AI Behavior Rules enhanced with specific actions
- [ ] CLAUDE.md reduced to minimal loader (except AI rules)
- [ ] No functional regression from migration
- [ ] Token usage measured and optimized
- [ ] Comprehensive test coverage
- [ ] Documentation updated

## Example Migrated Rule

```markdown
# Rule: Planning Context Management

## Instructions

### Rule Metadata
- ID: project/planning-context
- Status: Active
- Security Level: Low
- Token Impact: ~30 tokens per operation
- Priority: 800
- Dependencies: []

### Rule Configuration
```yaml
trigger: ["new conversation", "context check"]
conditions:
  - conversation_start: true
  - explicit_request: ["check planning", "review context"]
actions:
  - read_file: "PLANNING.md"
  - read_file: "TASK.md"
  - validate_existence: true
  - create_if_missing: true
validations:
  - planning_md_exists: true
  - task_md_exists: true
  - format_compliance: true
```

### Behavior
- Always read PLANNING.md at conversation start
- Check TASK.md before starting new tasks
- Create files if missing with appropriate templates
- Use information to maintain project consistency

---

📚 **Full Documentation**: [.claude/.claude/docs/rules/project/planning-context.md](../../../.claude/.claude/docs/rules/project/planning-context.md)
```

## Next Steps

1. Review and approve design
2. Create ADRs for key decisions
3. Begin Phase 1 implementation
4. Set up testing framework
5. Start sequential rule migration