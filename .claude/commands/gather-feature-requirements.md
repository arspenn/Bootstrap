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
   
   **Ambiguity Detection**:
   After extraction, analyze for ambiguous terms using Claude's NLP:
   - Check for vague performance terms (fast, slow, responsive)
   - Identify imprecise quantities (some, many, few)
   - Flag subjective qualities (good, better, user-friendly)
   - Detect unclear timeframes (soon, later, ASAP)
   
   If ambiguity detected, suggest clarifications:
   "I notice 'fast' in your requirements. Could you specify? (e.g., 'responds within 2 seconds')"

### 3. **Identify Missing Components**
   
   Determine what's still needed:
   - Missing user story elements (role, action, benefit)
   - Need acceptance criteria (minimum 2)
   - Priority level
   - Additional context

### 4. **AI-Adaptive Conversation Flow**
   
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
   
   **Dynamic Adaptation**:
   Claude adapts questioning based on:
   - User's technical level (detected from language)
   - Feature complexity (simple vs complex requirements)
   - Domain context (e.g., e-commerce, healthcare)
   - Signs of confusion (provide examples)
   - Previous responses (skip redundant questions)
   
   If missing acceptance criteria:
   "Let's create a specific scenario. Given the user wants to {action}, what's the starting context? Begin with 'Given...'"
   
   "What action triggers this feature? Begin with 'When...'"
   
   "What should happen as a result? Begin with 'Then...'"
   
   "Would you like to add another scenario? (type 'done' if sufficient)"
   
   **Boundary Questions** (after acceptance criteria):
   Generate 3-5 relevant boundary questions based on feature type:
   - "What is explicitly OUT of scope for this feature?"
   - "Are there any system limits or constraints?"
   - "How should edge cases be handled?"
   - Domain-specific boundaries (e.g., compliance, security)
   
   If missing priority:
   "What priority is this feature? (High/Medium/Low)"

### 5. **Validate and Confirm Information**
   
   **Confirm Extraction** (when initial context provided):
   "Based on your input, I understand:
   - User: {extracted role or 'needs clarification'}
   - Feature: {extracted action or 'needs clarification'}  
   - Benefit: {extracted benefit or 'needs clarification'}
   Is this correct? (yes/no/clarify)"
   
   **INVEST Validation**:
   Evaluate the gathered user story against INVEST criteria:
   - **Independent**: Can be developed without waiting for other features
   - **Negotiable**: Problem stated rather than specific solution
   - **Valuable**: Clear business/user value in 'so that' clause
   - **Estimatable**: Enough detail to estimate effort
   - **Small**: Could fit in single sprint/iteration
   - **Testable**: Acceptance criteria are verifiable
   
   Show validation results:
   "INVEST Check: ✓ I, ✓ N, ⚠ V (needs clarification), ✓ E, ✓ S, ✓ T"
   
   **Dependency Detection**:
   Identify dependencies using Claude's analysis:
   - Explicit dependencies mentioned by user
   - Implicit dependencies based on feature type
   - Infrastructure requirements (auth, database, APIs)
   - Downstream features that might depend on this
   
   "I've identified potential dependencies:
   - User authentication (required)
   - Notification system (optional enhancement)
   Are these correct?"

### 6. **Generate Enhanced Feature File**
   
   Create feature file with:
   - Extracted and gathered information
   - Properly formatted user story
   - Acceptance criteria in Given/When/Then format
   - Any technical context preserved from input
   - Metadata (date, status, priority, INVEST score, ambiguity level)
   - Boundaries and constraints
   - Dependencies (upstream/downstream)
   - Open questions for follow-up

### 7. **Save and Report Success**
   - Apply sequential-file-naming rule from .claude/rules/project/
   - Get next sequential number from features/
   - Convert title to kebab-case
   - Generate filename: {number:03d}-{kebab-case-title}.md
   - Save to features/{filename}
   - Display file path
   - Suggest next command: `/design-feature features/{filename}`

## Enhanced Output Structure

Generated feature file format:
```markdown
# Feature: {Feature Title}

**Date**: {YYYY-MM-DD}
**Priority**: {High|Medium|Low}
**Status**: Requirements Gathered
**INVEST Score**: I:✓ N:✓ V:✓ E:✓ S:✓ T:✓
**Ambiguity Level**: Low/Medium/High
**Completeness**: {percentage}%

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

## Boundaries and Constraints

### Out of Scope
- {items explicitly excluded}

### System Limits
- {performance/scale constraints}

### Edge Cases
- {boundary conditions to handle}

## Dependencies

### Requires (Upstream)
- {features/systems this depends on}

### Required By (Downstream)
- {features/systems that depend on this}

### Integration Points
- {APIs/services/databases to integrate}

## Additional Context

{Any additional information from initial input or conversation}

## Technical Considerations

{Any technical constraints or notes provided}

## Open Questions

{Any unresolved items for follow-up}

---
*Generated by gather-feature-requirements command*
```

## Integration with Design-Feature

- **Output to**: features/ directory
- **Used by**: `/design-feature features/{filename}.md`
- **Format**: Compatible with existing feature templates

## Quality Validation

### Requirements Quality Checks
- **Ambiguity Level**: Assess clarity of requirements (Low/Medium/High)
- **INVEST Compliance**: Validate story meets all 6 criteria
- **Completeness Score**: Calculate percentage of captured information
- **Dependency Clarity**: Ensure dependencies are well-defined
- **Testability**: Verify acceptance criteria have clear pass/fail conditions

### File Validation
- Ensure all required fields are captured
- Verify file doesn't already exist (prompt to overwrite)
- Validate file was created successfully
- Check that format is parseable and compatible with design-feature

## Example Usage

### Without Initial Context
```
/gather-feature-requirements

> What feature would you like to define?
I need a way to validate user input before saving to database

> I understand you want input validation. Who is the primary user?
backend developer

> Why is this valuable? So that...
So that we prevent invalid data from corrupting our database

[Continues to gather acceptance criteria...]

Feature requirements saved to: features/input-validation-system.md
Ready for design phase: /design-feature features/input-validation-system.md
```

### With Initial Context
```
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
Ready for design phase: /design-feature features/auto-test-runner.md
```

### With Partial User Story
```
/gather-feature-requirements "I want to add OAuth integration so that users don't need to create new passwords"

> Based on your input, I understand:
> - User: (needs clarification)
> - Feature: add OAuth integration
> - Benefit: users don't need to create new passwords
> Is this correct?

The user is "end user"

> Got it. Let's create acceptance criteria...
[Continues with scenario gathering...]

Feature requirements saved to: features/oauth-integration.md
Ready for design phase: /design-feature features/oauth-integration.md
```

## Implementation Patterns

### Context Parsing Strategy
Extract information from user input by looking for key phrases:
- "as a" → extract role
- "I want" → extract action/feature  
- "so that" → extract benefit
- "for example", "such as" → extract scenarios
- "given", "when", "then" → extract acceptance criteria

### AI-Enhanced Analysis Approach

**Ambiguity Detection**:
Use Claude's natural language understanding to:
- Identify context-specific vague terms beyond simple patterns
- Understand domain implications of ambiguous language
- Suggest clarifications relevant to the feature type
- Provide examples from similar features

**INVEST Validation**:
Leverage Claude's comprehension to:
- Evaluate actual dependencies, not just keyword presence
- Assess if solutions are over-specified for the context
- Determine if value propositions align with user needs
- Estimate complexity based on feature patterns

**Boundary Generation**:
Generate contextual boundary questions by:
- Considering the specific feature domain
- Identifying common edge cases for this feature type
- Recognizing relevant compliance/security needs
- Focusing on critical boundaries that matter

**Dependency Analysis**:
Identify both explicit and implicit dependencies:
- Look beyond what's directly mentioned
- Consider typical infrastructure needs
- Recognize common integration patterns
- Distinguish must-have from nice-to-have

### Adaptive Question Selection
Claude dynamically adjusts the conversation:
1. Assess user's technical level from responses
2. Skip questions already answered implicitly
3. Provide domain-relevant examples
4. Adapt complexity to user understanding
5. Focus on areas needing clarification

### File Naming Convention
- Convert feature description to kebab-case
- Remove special characters
- Limit to reasonable length
- Examples:
  - "User Authentication System" → "user-authentication-system.md"
  - "OAuth 2.0 Integration" → "oauth-2-integration.md"

## Tips for Success

1. **Keep questions relevant** - Focus on what's needed for the feature
2. **Accept user preferences** - Suggestions are optional, not mandatory
3. **Maintain natural flow** - Adapt to user's communication style
4. **Focus on clarity** - Help users articulate clear requirements
5. **Be flexible** - Work with whatever context user provides
6. **Leverage AI capabilities** - Use Claude's understanding for smarter analysis

## Common Issues

- **User unsure of role**: Suggest common roles (developer, end user, admin)
- **Vague feature description**: Ask for a specific example
- **Missing acceptance criteria**: Provide template they can fill
- **Existing file**: Ask if they want to overwrite or choose different name
- **No initial context**: Start with open-ended question to gather description