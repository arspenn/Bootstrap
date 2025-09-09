# Gather Project Requirements

## Arguments: $ARGUMENTS

Interactive project requirements gathering to create or update PLANNING.md. Accepts optional file for updates or external document context.

## When to Use This Command

**Use `gather-project-requirements` when:**
- Starting a new project
- Updating existing project scope
- Converting external specs to PLANNING.md
- Establishing project vision before features
- Defining success metrics

**Skip when:**
- PLANNING.md is already comprehensive
- Project scope is well-defined
- Only doing feature-level work

## Process

### 1. **Check for File Argument**
   - If $ARGUMENTS contains file path:
     - Check if file is PLANNING.md (update mode)
     - Check if file is external doc (parse mode)
     - Read and extract existing content
   - If no argument: Start fresh

### 2. **Parse Existing Content** (if file provided)
   
   For PLANNING.md:
   - Extract each section content
   - Identify what needs updating
   - Preserve custom sections
   
   For external docs:
   - Extract project description
   - Look for goals/objectives
   - Identify stakeholders
   - Note constraints/scope

### 3. **Core Questions Flow**
   
   Ask based on what's missing:
   
   **Project Overview:**
   "What is this project? Provide a brief description of what you're building."
   
   **Goals & Objectives:**
   "What are the main goals? List 2-3 key objectives (e.g., 'Enable X', 'Reduce Y by 50%')"
   
   **Target Users:**
   "Who will use this? Describe primary users and any secondary audiences."
   
   **Scope & Boundaries:**
   "What's included in this project? What's explicitly out of scope?"
   
   **Success Metrics:**
   "How will you measure success? (e.g., 'User adoption > 100', 'Response time < 2s')"

### 4. **Generate/Update PLANNING.md**
   - Apply planning.template.md from .claude/templates/
   - Preserve any custom sections (if updating)
   - Add generation/update timestamp
   - Format with proper markdown
   - Use Write tool for new files, MultiEdit or sequential Edit tools for updates

### 5. **Report Success**
   - Show file path created/updated
   - Suggest next steps (feature gathering)
   - Highlight any gaps for future refinement

## External Document Keywords

When parsing external documents, look for:
- Project titles, headings → Project name
- Executive summaries → Project overview
- "objective", "goal", "aim" → Goals section
- "stakeholder", "user", "audience" → Target users
- "include", "exclude", "boundary" → Scope
- "success", "KPI", "measure" → Metrics

## Example Usage

### Without File Argument (New Project)
```
/gather-project-requirements

> What is this project? Provide a brief description of what you're building.
A developer productivity toolset that automates common workflows

> What are the main goals? List 2-3 key objectives.
1. Reduce manual repetitive tasks by 80%
2. Enable consistent code quality checks
3. Improve team collaboration

> Who will use this? Describe primary users and any secondary audiences.
Primary: Software developers working in teams
Secondary: Project managers tracking progress

> What's included in this project? What's explicitly out of scope?
Included: CI/CD automation, code review tools, documentation generation
Out of scope: Project management features, time tracking

> How will you measure success?
- Developer time saved > 5 hours/week
- Code review turnaround < 2 hours
- 90% team adoption within 3 months

✓ PLANNING.md created successfully
Suggested next step: /gather-feature-requirements to define specific features
```

### With PLANNING.md Update
```
/gather-project-requirements PLANNING.md

Reading existing PLANNING.md...
Found existing sections: Project Overview, Architecture, Key Components, Design Principles

Missing sections detected:
- Goals & Objectives
- Target Users
- Scope & Boundaries
- Success Metrics

> What are the main goals? List 2-3 key objectives.
[User provides goals...]

[Continues for other missing sections...]

✓ PLANNING.md updated successfully
Preserved custom sections: Architecture, Key Components, Design Principles
Added: Goals & Objectives, Target Users, Scope & Boundaries, Success Metrics
```

### With External Document
```
/gather-project-requirements specs/project-proposal.pdf

Parsing external document...
Extracted information:
- Project name: Customer Portal Redesign
- Overview: [extracted summary]
- Partial goals: improve user experience, reduce support tickets

Need clarification on:
- Specific success metrics
- Detailed scope boundaries
- Target user segments

> The document mentions "improve user experience". Can you provide specific metrics?
Page load time < 2 seconds, task completion rate > 85%

[Continues gathering missing information...]

✓ PLANNING.md created from specs/project-proposal.pdf
Incorporated: Extracted context from proposal
Added through conversation: Specific metrics, scope boundaries, user segments
```

## Output Structure

The generated PLANNING.md follows this structure:

```markdown
# [Project Name] Planning

## Project Overview

[Project description and purpose]

## Goals & Objectives

[Measurable objectives, 2-3 key goals]

## Target Users

### Primary Users
[Primary audience description]

### Secondary Users
[Secondary audience if applicable]

## Scope & Boundaries

### In Scope
- [Items included in project]

### Out of Scope
- [Items explicitly excluded]

## Success Metrics

- [Measurable success criteria]
- [Key performance indicators]

[Any preserved custom sections from original file]

---
*Generated by gather-project-requirements command*
*Last updated: [date]*
```

## Integration with Feature Gathering

After creating or updating PLANNING.md:
1. Project context is available for feature requirements
2. Features can reference project goals
3. Scope boundaries guide feature decisions
4. Success metrics inform acceptance criteria

## Tips for Success

1. **Start with clarity** - Help users articulate their vision clearly
2. **Keep it concise** - Focus on 5 essential sections
3. **Preserve custom work** - Never overwrite user additions
4. **Extract smartly** - Use context from external docs to minimize questions
5. **Guide gently** - Provide examples when users are unsure

## Common Issues

- **Vague goals**: Ask for specific, measurable objectives
- **Unclear scope**: Prompt for explicit in/out lists
- **Missing metrics**: Provide metric examples relevant to project type
- **Existing file conflicts**: Always preserve user's custom sections
- **External doc parsing**: Focus on high-value extraction, ask for rest