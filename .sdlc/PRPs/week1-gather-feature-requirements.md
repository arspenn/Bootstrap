name: "Week 1: Basic Feature Requirements Gathering Command"
description: |

## Purpose
Create a minimal viable `/gather-feature-requirements` command that uses interactive conversation to gather basic user stories and generate feature files compatible with the Bootstrap design-feature workflow. Accepts optional initial input to streamline the process.

## Core Principles
1. **Simplicity First**: Basic conversation flow without complex branching
2. **User Story Focus**: Gather role, feature, benefit, and acceptance criteria
3. **Template Compliance**: Follow Bootstrap command and feature file patterns
4. **Immediate Value**: Must generate usable feature file in first attempt
5. **Flexible Entry**: Accept initial context via argument or start fresh

---

## Goal
Create a functional `/gather-feature-requirements [initial-context]` command that can either start from provided context or conduct a simple linear conversation to gather feature requirements and output a properly formatted feature file ready for `/design-feature` command.

## Why
- Bootstrap needs requirements gathering to complete its SDLC workflow
- Users often have partial requirements already thought through
- Interactive guidance helps refine and complete requirements
- Sets foundation for more sophisticated gathering in later weeks

## What
A command that:
- Accepts optional argument with initial requirements/context
- Extracts what it can from provided context
- Asks targeted questions to fill gaps
- Generates a feature file in the features/ directory
- Follows the "As a... I want... So that..." pattern
- Includes at least 2 acceptance criteria in Given/When/Then format
- Outputs file path for immediate use with design-feature

### Success Criteria
- [ ] Command handles both with-argument and no-argument cases
- [ ] Extracts useful information from provided context
- [ ] Generated feature file works with `/design-feature` command
- [ ] Conversation completes in under 10 interactions
- [ ] Output follows Bootstrap feature file conventions

## All Needed Context

### Documentation & References
```yaml
# Command patterns to follow
- file: .claude/commands/task-add.md
  why: Reference for command structure and argument handling
  
- file: .claude/commands/design-feature.md
  why: Shows conversation flow pattern and context loading (lines 24-29)
  
- file: .claude/templates/command.template.md
  why: Template structure for new command
  
# Feature file formats to generate
- file: features/FEATURE_GIT_MERGE_CONTROL.md
  why: Good example of feature file structure
  
- file: features/phase-one-incremental-plan.md
  why: Example of detailed feature specification

# Design specifications
- file: designs/014-feature-requirements-gathering/design.md
  why: Week 1 requirements at lines 139-143, tasks at lines 222-227
  
- file: designs/014-feature-requirements-gathering/adrs/ADR-001-conversation-architecture.md
  why: Conversation approach decision
  
# User story references
- url: https://www.atlassian.com/agile/project-management/user-stories
  why: User story format and examples
  
- url: https://www.agilealliance.org/glossary/gwt/
  why: Given/When/Then format for acceptance criteria
```

### Current Codebase Structure
```bash
.claude/
├── commands/           # Where new command will go
│   ├── design-feature.md
│   ├── task-add.md
│   └── ... (other commands)
├── templates/
│   └── command.template.md
features/              # Where output files will go
├── FEATURE_GIT_MERGE_CONTROL.md
└── ... (other feature files)
```

### Desired Structure After Implementation
```bash
.claude/
├── commands/
│   ├── gather-feature-requirements.md  # NEW: Command definition
│   └── ... (existing commands)
features/
├── [generated-feature-name].md         # Output from command
└── ... (existing features)
```

### Known Patterns and Conventions
```markdown
# Argument Handling Pattern (from existing commands)
## Arguments: $ARGUMENTS
- If argument provided: Parse and use as initial context
- If no argument: Start with open prompt
- Example from design-feature.md: Loads feature file from $ARGUMENTS

# Feature File Naming Convention
- Use descriptive kebab-case: feature-name.md
- Sanitize special characters from user input
- Include date in metadata

# Information Extraction Pattern
1. Try to identify user story components in provided text
2. Look for keywords: "as a", "I want", "so that", "given", "when", "then"
3. Extract what's available, ask for what's missing
4. Don't assume - confirm interpretations with user
```

## Implementation Blueprint

### Task 1: Create Command File with Argument Handling

CREATE .claude/commands/gather-feature-requirements.md:
```markdown
# Gather Feature Requirements

## Arguments: $ARGUMENTS

Interactive requirements gathering to create feature specifications ready for design-feature command. Accepts optional initial context to streamline the process.

## When to Use This Command

**Use `gather-feature-requirements` when:**
- Starting a new feature from scratch
- Have partial requirements that need structure
- Need to convert informal notes into formal requirements
- Want guided help creating user stories
- Preparing input for design-feature command

**Skip and use manual creation when:**
- Requirements are already fully documented
- Copying an existing feature pattern
- Have a complete specification ready

## Process

### 1. **Load Initial Context**
   - Check if $ARGUMENTS contains initial context
   - If provided, extract available information:
     - Look for user story components
     - Identify any examples or scenarios
     - Extract feature name/description
     - Note any technical details
   - If not provided, start with open prompt
```

### Task 2: Implement Context Extraction and Gap Analysis

ADD to Process section:
```markdown
### 2. **Extract Information from Context** (if provided)
   
   Parse provided text for:
   - **Feature description**: General idea or problem statement
   - **User role**: Who will use this (developer, end user, admin, etc.)
   - **Desired action**: What they want to do
   - **Benefit/value**: Why it matters
   - **Examples**: Any scenarios or use cases mentioned
   - **Technical notes**: Constraints, integrations, or requirements
   
   Example extraction:
   "I need a way for developers to validate their code before committing"
   → Role: developer
   → Action: validate code before committing
   → Benefit: (need to ask)
   → Scenario: (need to ask for specifics)

### 3. **Identify Missing Components**
   
   Determine what's still needed:
   - Missing user story elements (role, action, benefit)
   - Need acceptance criteria (minimum 2)
   - Priority level
   - Additional context
```

### Task 3: Implement Adaptive Conversation Flow

ADD conversation section:
```markdown
### 4. **Adaptive Conversation Flow**
   
   **If no argument provided:**
   "What feature would you like to define? You can provide a brief description, a user story, or even paste in any notes or examples you have."
   
   [Then extract what's provided and continue below]
   
   **Based on what's missing, ask targeted questions:**
   
   If missing role:
   "Who is the primary user of this feature? (e.g., 'developer', 'end user', 'administrator')"
   
   If missing action (but have role):
   "What does {role} want to do? Complete: 'I want to...'"
   
   If missing benefit:
   "Why is this valuable? What problem does it solve? Complete: 'So that...'"
   
   If missing acceptance criteria:
   "Let's create a specific scenario. Given the user wants to {action}, what's the starting context? Begin with 'Given...'"
   
   "What action triggers this feature? Begin with 'When...'"
   
   "What should happen as a result? Begin with 'Then...'"
   
   "Would you like to add another scenario? (type 'done' if sufficient)"
   
   If missing priority:
   "What priority is this feature? (High/Medium/Low)"

### 5. **Confirm Extracted Information**
   
   When initial context provided:
   "Based on your input, I understand:
   - User: {extracted role or 'needs clarification'}
   - Feature: {extracted action or 'needs clarification'}  
   - Benefit: {extracted benefit or 'needs clarification'}
   Is this correct? (yes/no/clarify)"
```

### Task 4: Implement Output Generation

ADD output section:
```markdown
### 6. **Generate Feature File**
   
   Create feature file with:
   - Extracted and gathered information
   - Properly formatted user story
   - Acceptance criteria in Given/When/Then format
   - Any technical context preserved from input
   - Metadata (date, status, priority)

### 7. **Save and Report Success**
   - Generate filename from feature description
   - Save to features/{filename}.md
   - Display file path
   - Suggest next command: `/design-feature features/{filename}.md`

## Output Structure

Generated feature file format:
\```markdown
# Feature: {Feature Title}

**Date**: {YYYY-MM-DD}
**Priority**: {High|Medium|Low}
**Status**: Requirements Gathered

## User Story

As a {role}
I want to {feature}
So that {benefit}

## Acceptance Criteria

### Scenario 1
- **Given** {context}
- **When** {action}
- **Then** {expected result}

### Scenario 2
- **Given** {context}
- **When** {action}
- **Then** {expected result}

## Additional Context

{Any additional information from initial input or conversation}

## Technical Considerations

{Any technical constraints or notes provided}

---
*Generated by gather-feature-requirements command*
\```
```

### Task 5: Add Usage Examples

ADD examples section:
```markdown
## Example Usage

### Without Initial Context
\```
/gather-feature-requirements

> What feature would you like to define?
I need a way to validate user input before saving to database

> I understand you want input validation. Who is the primary user?
backend developer

> Why is this valuable? So that...
So that we prevent invalid data from corrupting our database

[Continues to gather acceptance criteria...]

Feature requirements saved to: features/input-validation-system.md
\```

### With Initial Context
\```
/gather-feature-requirements "As a developer, I want to be able to run tests automatically when I save files. For example, when I save a Python file, the relevant unit tests should run and show results in the terminal."

> Based on your input, I understand:
> - User: developer
> - Feature: run tests automatically on file save  
> - Benefit: (needs clarification)
> Is this correct?

yes

> Why is this valuable? So that...
So that I can catch errors immediately without manual test runs

> You mentioned an example. Let's formalize it:
> Given: I am editing a Python file with associated tests
> When: I save the file
> Then: The relevant unit tests run automatically and display results
> Is this accurate?

yes

[Continues if more scenarios needed...]

Feature requirements saved to: features/auto-test-runner.md
\```

### With Partial User Story
\```
/gather-feature-requirements "I want to add OAuth integration so that users don't need to create new passwords"

> Based on your input, I understand:
> - User: (needs clarification)
> - Feature: add OAuth integration
> - Benefit: users don't need to create new passwords
> Is this correct?

The user is "end user"

> Got it. Let's create acceptance criteria...
[Continues with scenario gathering...]
\```
```

### Task 6: Implementation Patterns

ADD implementation guidance:
```markdown
## Implementation Patterns

### Context Parsing Strategy
\```python
# Pseudocode for context extraction
def extract_from_context(user_input):
    extracted = {}
    
    # Check for explicit user story format
    if "as a" in user_input.lower():
        # Extract role after "as a"
        extracted['role'] = extract_after("as a", user_input)
    
    if "i want" in user_input.lower():
        # Extract action after "i want"
        extracted['action'] = extract_after("i want", user_input)
    
    if "so that" in user_input.lower():
        # Extract benefit after "so that"
        extracted['benefit'] = extract_after("so that", user_input)
    
    # Check for example scenarios
    if any(word in user_input.lower() for word in ["example", "for instance", "such as"]):
        extracted['examples'] = extract_examples(user_input)
    
    # If no explicit format, treat as description
    if not extracted:
        extracted['description'] = user_input
    
    return extracted
\```

### Adaptive Question Selection
\```python
# Determine what questions to ask based on extracted info
def get_next_question(extracted, answered):
    if 'role' not in extracted and 'role' not in answered:
        return "Who is the primary user of this feature?"
    
    if 'action' not in extracted and 'action' not in answered:
        return "What does the user want to do?"
    
    if 'benefit' not in extracted and 'benefit' not in answered:
        return "Why is this valuable? So that..."
    
    if not has_acceptance_criteria(extracted, answered):
        return "Let's create a scenario. Given..."
    
    # Continue with remaining questions
\```
```

## Validation Loop

### Validation Steps for Implementation
```bash
# 1. Test without argument
/gather-feature-requirements
# Should start with open prompt
# Complete full conversation flow

# 2. Test with basic description
/gather-feature-requirements "need a login system"
# Should extract description, ask for details

# 3. Test with partial user story  
/gather-feature-requirements "As a developer, I want to automate deployments"
# Should recognize role and action, ask for benefit

# 4. Test with full context
/gather-feature-requirements "As an admin, I want to see usage metrics so that I can optimize resource allocation. For example, seeing daily active users."
# Should extract most info, just need to formalize scenarios

# 5. Verify output
cat features/[generated-file].md
# Check format is correct

# 6. Test integration
/design-feature features/[generated-file].md
# Verify design-feature accepts the file
```

## Final Validation Checklist
- [ ] Command handles both argument and no-argument cases
- [ ] Context extraction identifies available information
- [ ] Adaptive questions fill in missing pieces
- [ ] Doesn't re-ask for information already provided
- [ ] Feature file generates with correct format
- [ ] Generated file works with design-feature
- [ ] Examples cover main usage patterns
- [ ] Process remains simple (Week 1 scope)

---

## Anti-Patterns to Avoid (Week 1 Specific)
- ❌ Don't add ambiguity detection yet (Week 2)
- ❌ Don't implement INVEST validation (Week 2)
- ❌ Don't parse complex document formats (Week 3)
- ❌ Don't create complex branching logic
- ❌ Don't over-parse - simple keyword matching is fine
- ❌ Don't integrate with project requirements (Week 3)

## Success Metrics
- Command works with and without initial context
- Reduces questions asked when context provided
- Still completes in under 10 interactions
- Generated file immediately usable with design-feature
- Sets foundation for Week 2 enhancements

---

**Confidence Score: 9/10**

This PRP provides comprehensive context for implementing Week 1's basic feature requirements gathering with the added flexibility of accepting initial context. The argument handling allows users to provide whatever information they have, reducing the conversation length while still ensuring complete requirements are gathered. The implementation remains simple enough for Week 1 while providing significant value.