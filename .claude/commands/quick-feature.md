# Quick Feature

## Arguments: $ARGUMENTS

Streamlined feature definition for small changes, bug fixes, and documentation updates. Completes in 2-3 questions maximum.

## When to Use This Command

**Use `quick-feature` when:**
- Creating bug fixes or small enhancements
- Documentation updates
- Simple prototypes
- Single-file changes
- Features you can describe in one sentence

**Skip and use `gather-feature-requirements` when:**
- Complex multi-component features
- Need extensive design documentation
- Breaking changes or major refactors
- Unsure about requirements

## Process

### 1. **Parse Initial Input**
   - Check if $ARGUMENTS provided
   - Extract any user story components
   - Identify feature description
   - Note technical context

### 2. **Analyze Complexity**
   Use Claude's understanding to assess:
   - Number of files likely affected
   - Need for test changes
   - Integration complexity
   - Technical depth required
   
   If complex (2+ files or significant tests):
   - Generate context summary
   - Suggest escalation

### 3. **Extract Information**
   From input, identify:
   - User role (developer if not specified)
   - Feature/action desired
   - Benefit (can infer for bug fixes)
   - Technical constraints

### 4. **Minimal Questions**
   Ask only what's essential (max 2):
   
   If missing critical info:
   "What specifically needs to be fixed/added?"
   
   If missing context:
   "What's the main goal? (e.g., 'fix login timeout', 'add debug logging')"
   
   If need priority:
   "Priority? (High/Medium/Low)"

### 5. **Generate Feature File**
   - Apply sequential-file-naming rule from .claude/rules/project/
   - Get next sequential number from features/
   - Convert title to kebab-case
   - Create filename: ###-feature-title.md
   - Apply feature-quick.template.md
   - Save to features/

### 6. **Handle Escalation**
   If too complex:
   "This feature appears to involve [complexity detected]. 
   I recommend using the full requirements gathering process.
   
   Context summary for /gather-feature-requirements:
   [Generated summary with all extracted information]"

## Usage Examples

### Simple Bug Fix
/quick-feature "Fix login button not responding on mobile"
> Priority? (High/Medium/Low)
High
> Created: features/017-fix-login-button.md

### With Sufficient Context  
/quick-feature "As a developer, I want to add debug logging to the API endpoints so that I can troubleshoot issues faster"
> Created: features/018-add-debug-logging.md

### Escalation Case
/quick-feature "Redesign the entire authentication system"
> This feature appears to involve multiple components and significant architectural changes.
> I recommend using the full requirements gathering process.
> 
> Context: User wants to redesign authentication system...
> Use: /gather-feature-requirements "redesign authentication system"

## Complexity Detection Patterns

### Patterns Indicating Complexity
(This section grows from experience)

### Keywords/Phrases
- (To be added as patterns are discovered)

### Structural Indicators  
- (To be added based on usage)

### Domain Patterns
- (To be added from real examples)

## Implementation Helpers

### Sequential Number Generation
(Delegates to sequential-file-naming rule)
1. Apply rule from .claude/rules/project/sequential-file-naming.md
2. Rule handles finding next number automatically

### Title to Kebab Case
(Delegates to sequential-file-naming rule)
1. Apply rule from .claude/rules/project/sequential-file-naming.md
2. Rule handles kebab-case conversion

### Complexity Signals
Initial heuristics (will evolve):
- Multiple components mentioned
- Words: "refactor", "redesign", "system", "architecture"
- Multiple user types mentioned
- Performance or scale requirements
- Security implications