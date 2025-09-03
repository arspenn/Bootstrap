# PRP: Insight Capture Command Implementation

## Goal
Implement the `/insight-capture` command that intelligently captures framework discoveries, bugs, and insights from conversation context using natural language processing. This command should enable real-time documentation of Bootstrap framework limitations and improvements without breaking development flow.

## Why
- **Knowledge Preservation**: Prevent loss of valuable discoveries when switching projects or Claude sessions
- **Zero-Friction Documentation**: Capture insights within 30 seconds without context switching
- **Framework Evolution**: Build a knowledge base of Bootstrap's actual capabilities vs limitations
- **Learning Acceleration**: Future developers benefit from documented gotchas and patterns

## What
Natural language command that extracts, categorizes, and documents insights from conversation history.

### Success Criteria
- [ ] Accepts natural language references ("what we just discussed", "this bug")
- [ ] Auto-categorizes insights (Bug/Enhancement/Limitation/Discovery)
- [ ] Extracts relevant context from conversation history
- [ ] Generates structured markdown export in < 30 seconds
- [ ] Handles ambiguous references gracefully
- [ ] Creates actionable, shareable documentation

## All Needed Context

### Documentation & References
```yaml
# MUST READ - Include these in your context window
- file: .sdlc/designs/024-insight-capture-command/design.md
  why: Complete architectural design with pipeline stages
  
- file: .claude/commands/gather-feature-requirements.md
  why: Reference for context extraction and natural language patterns
  lines: 30-140  # Context extraction section
  
- file: .claude/commands/reset-framework.md
  why: Command structure pattern and error handling approach
  
- file: .claude/rules/project/sequential-file-naming.md
  why: File naming convention for exports
  
- file: .claude/config.yaml
  why: Configuration access pattern
  
- doc: https://docs.anthropic.com/claude/docs/conversation-history
  section: Accessing conversation context
  critical: Claude has FULL access to entire conversation history
```

### Current Codebase Tree
```bash
Bootstrap/
├── .claude/
│   ├── commands/           # Command implementations
│   ├── config.yaml         # Project configuration
│   ├── rules/              # Project rules
│   └── templates/          # Templates for generation
├── .sdlc/
│   ├── designs/            # Design documents
│   ├── features/           # Feature specifications
│   └── PRPs/              # Project review plans
└── exports/               # Will be created for insights
    └── insights/          # Insight capture storage
```

### Desired Structure with New Files
```bash
Bootstrap/
├── .claude/
│   └── commands/
│       └── insight-capture.md  # Main command implementation
└── exports/
    └── insights/
        └── YYYY-MM-DD-{title}.md  # Generated insight files
```

### Known Gotchas of Framework & Context
```markdown
# CRITICAL: Claude's conversation access capability
# Claude has FULL ACCESS to entire conversation history in this session
# Can reference exact user words, commands, errors from any point

# GOTCHA: Conversation compaction
# Near compaction limit, older context may be lost
# Must handle gracefully with fallback to explicit description

# PATTERN: Command argument extraction
# Commands receive arguments via $ARGUMENTS variable
# Can be empty, single value, or complex natural language

# PATTERN: File operations
# Always use absolute paths with Write tool
# Check parent directory exists before creating files
```

## Implementation Blueprint

### Data Models and Structure

```python
# Insight categorization and structure
INSIGHT_TYPES = ["Bug", "Enhancement", "Limitation", "Discovery"]
SEVERITY_LEVELS = ["High", "Medium", "Low"]

# Context references that trigger analysis
CONTEXT_TRIGGERS = [
    "this", "that", "what we", "earlier", "just now",
    "discussed", "mentioned", "the issue", "the problem"
]

# Classification heuristics
BUG_INDICATORS = ["doesn't work", "error", "failure", "expected X but got Y"]
ENHANCEMENT_INDICATORS = ["would be nice", "should have", "missing", "need"]
LIMITATION_INDICATORS = ["can't", "unable", "not supported", "by design"]
DISCOVERY_INDICATORS = ["found that", "discovered", "turns out", "actually works"]
```

### List of Tasks to Complete (in order)

```yaml
Task 1:
CREATE .claude/commands/insight-capture.md:
  - MIRROR structure from: .claude/commands/gather-feature-requirements.md
  - INCLUDE all processing stages from design document
  - ADD comprehensive error handling sections
  - PRESERVE command documentation pattern

Task 2: 
IMPLEMENT Input Router logic:
  - DETECT context references using CONTEXT_TRIGGERS
  - ROUTE to context analyzer or direct processor
  - HANDLE empty arguments with interactive prompt

Task 3:
IMPLEMENT Context Analyzer:
  - ACCESS full conversation history (Claude capability)
  - SCAN recent 10 exchanges for technical content
  - EXTRACT exact quotes, commands, errors
  - IDENTIFY main topic using keyword frequency

Task 4:
IMPLEMENT Insight Classifier:
  - APPLY classification heuristics
  - ASSIGN category based on indicators
  - DETERMINE severity level
  - GENERATE descriptive title (5-7 words, kebab-case)

Task 5:
IMPLEMENT Document Generator:
  - CREATE structured markdown document
  - INCLUDE all metadata fields
  - FORMAT sections consistently
  - ADD actionable recommendations

Task 6:
IMPLEMENT File Writer:
  - GENERATE filename: YYYY-MM-DD-{kebab-title}.md
  - WRITE document using Write tool (creates directory automatically)
  - REPORT success with file path
  - NOTE: Write tool creates parent directories if they don't exist
```

### Per Task Implementation Details

```markdown
# Task 1: Command File Structure
## Command: /insight-capture

## Arguments
$ARGUMENTS - Natural language reference or direct description

## Process

### Phase 1: Input Analysis
1. Check if $ARGUMENTS provided
2. If empty, prompt: "What insight would you like to capture?"
3. Detect context references vs direct descriptions
4. Route to appropriate processor

### Phase 2: Context Extraction (if context reference)
1. Access conversation history
2. Scan last 10 exchanges
3. Look for:
   - Error messages (exact)
   - Commands executed
   - User frustrations
   - Technical discussions
4. Extract relevant information

### Phase 3: Classification
1. Analyze extracted/provided text
2. Match against classification patterns
3. Auto-assign category
4. Determine severity

### Phase 4: Document Generation
1. Create metadata header
2. Add structured sections
3. Include exact quotes/errors
4. Add recommendations

### Phase 5: Export
1. Generate dated filename (YYYY-MM-DD-{kebab-title}.md)
2. Write document using Write tool (creates exports/insights/ if needed)
3. Report file location to user

# Task 2-3: Context Processing
# Pseudocode for context analysis
def analyze_context(reference):
    # ACCESS Claude's conversation history
    conversation = get_conversation_history()  # Full access
    
    # SCAN recent exchanges
    recent = conversation[-10:]  # Last 10 exchanges
    
    # EXTRACT technical content
    for exchange in recent:
        if has_technical_indicators(exchange):
            extract_commands(exchange)
            extract_errors(exchange)
            extract_discussion_points(exchange)
    
    # IDENTIFY main topic
    topic = extract_topic_keywords(recent)
    
    return structured_information

# Task 4: Classification Logic
def classify_insight(text):
    # Check each pattern type
    if any(indicator in text.lower() for indicator in BUG_INDICATORS):
        return "Bug"
    elif any(indicator in text.lower() for indicator in ENHANCEMENT_INDICATORS):
        return "Enhancement"
    # ... etc
    
def generate_title(insight_text):
    # Extract key nouns and verbs
    # Limit to 5-7 words
    # Convert to kebab-case
    # Examples:
    # "config yaml has django settings" → "config-yaml-django-settings"
    # "reset-framework doesn't handle symlinks" → "reset-framework-symlinks-not-handled"

# Task 5-6: Document Structure
TEMPLATE = """# Insight: {title}

**Date Captured**: {date}
**Category**: {category}
**Severity**: {severity}
**Component**: {component}

## Summary
{summary}

## Context
{context_description}

## Details
### What Was Attempted
{attempted}

### What Happened
{actual_behavior}

### Error/Output
```
{error_output}
```

## Impact
{impact_description}

## Recommendation
{suggested_action}

## Workaround
{workaround_if_any}

---
*Captured via `/insight-capture` from conversation context*
"""
```

### Integration Points
```yaml
DIRECTORIES:
  - create: exports/insights/
  - method: Directory created automatically when first file is written
  - note: Write tool handles parent directory creation implicitly
  
CONFIGURATION:
  - read: .claude/config.yaml
  - use: project.name for metadata
  
ERROR_HANDLING:
  - conversation_too_old: "Context may be compacted. Please describe the insight directly."
  - no_technical_content: "No recent technical discussion found. What would you like to capture?"
  - ambiguous_reference: "Multiple topics found. Please be more specific or describe directly."
  - multi_topic_found: "Found multiple topics: [list]. Which one would you like to capture?"
```

## Validation Loop

### Level 1: Directory Structure
```bash
# Directory creation happens automatically with first file write
# Verify after first insight capture:
ls -la exports/insights/

# Expected: Directory created by Write tool with first insight file present
```

### Level 2: Command File Validation
```bash
# Check command file created
ls -la .claude/commands/insight-capture.md

# Validate markdown structure
head -50 .claude/commands/insight-capture.md

# Expected: Proper command structure with all sections
```

### Level 3: Functional Testing
```markdown
# Test 1: Context reference
User: "The /reset-framework command fails with permission denied on responses/protected.txt"
Assistant: [Acknowledges issue]
User: /insight-capture "what we just discussed"

Expected: Creates insight categorized as "Bug" with details about permission error

# Test 2: Direct description
/insight-capture "The config.yaml file contains Django settings but Bootstrap isn't a Django project"

Expected: Creates insight categorized as "Limitation" or "Bug"

# Test 3: No arguments (interactive)
/insight-capture

Expected: Prompts for insight description

# Test 4: Ambiguous reference
/insight-capture "that thing earlier"

Expected: Handles gracefully, may ask for clarification
```

### Level 4: Output Validation
```bash
# Check generated insight file
ls -la exports/insights/
cat exports/insights/2025-09-02-*.md

# Validate structure
grep "^## " exports/insights/*.md  # Should show all required sections
grep "Category:" exports/insights/*.md  # Should have classification

# Expected: Well-formatted markdown with all sections populated
```

## Final Validation Checklist
- [ ] Command file follows Bootstrap pattern
- [ ] Context extraction works with real conversation
- [ ] Classification correctly categorizes insights
- [ ] Files generated with proper naming (YYYY-MM-DD-title.md)
- [ ] Exports directory created automatically
- [ ] Ambiguous references handled gracefully
- [ ] Interactive mode works when no args provided
- [ ] Title generation creates descriptive kebab-case names
- [ ] Processing completes in < 30 seconds
- [ ] Generated insights are actionable

## Anti-Patterns to Avoid
- ❌ Don't ask for confirmation on classification (preserve flow)
- ❌ Don't create nested directories for categories
- ❌ Don't fail silently - always provide feedback
- ❌ Don't lose context when compaction approaching
- ❌ Don't overthink classification - best guess is fine
- ❌ Don't make the user wait - process quickly

## Testing Scenarios

### Scenario 1: Bug Discovery
```markdown
Setup: User reports command failure
Action: /insight-capture "the reset-framework permission issue"
Verify: 
- Categorized as Bug
- Contains exact error message
- Includes attempted command
- Suggests fix or workaround
```

### Scenario 2: Enhancement Request
```markdown
Setup: User suggests new feature
Action: /insight-capture "what we discussed about adding progress bars"
Verify:
- Categorized as Enhancement
- Captures user need
- Documents use case
- Notes implementation ideas
```

### Scenario 3: Framework Limitation
```markdown
Setup: Discussion about architectural constraint
Action: /insight-capture "this conversation about the command length limit"
Verify:
- Categorized as Limitation
- Documents constraint clearly
- Explains impact
- Suggests alternatives
```

## Implementation Notes

### Critical Implementation Details
1. **Conversation Access**: Claude has FULL access to conversation history - use confidently
2. **Quick Processing**: Minimize prompts, maximize automation
3. **Title Generation**: Extract essence in 5-7 words, kebab-case
4. **File Naming**: YYYY-MM-DD prefix for chronological sorting
5. **Error Recovery**: Always provide fallback to manual description

### Command Implementation Pattern
Follow the established Bootstrap command pattern:
- Clear command header
- Arguments section explaining $ARGUMENTS
- When to Use section with bullet points
- Detailed Process with numbered phases
- Usage examples showing various scenarios
- Output examples with expected results
- Error handling section
- Related commands section

---

## Quality Score: 8.5/10

**Confidence for one-pass implementation**: High

**Strengths**:
- Comprehensive context from design document
- Clear implementation blueprint with pseudocode
- Detailed validation scenarios
- Established patterns from existing commands
- Critical gotchas documented

**Potential Challenges**:
- Natural language processing complexity
- Edge cases in context extraction
- Ambiguity resolution may need refinement

This PRP provides sufficient context for Claude Code to implement the insight-capture command successfully in a single pass, with clear validation gates to ensure correctness.