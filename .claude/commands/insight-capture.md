# Insight Capture

## Command: /insight-capture

Intelligently capture framework discoveries, bugs, and insights from conversation context using natural language processing. This command enables real-time documentation of Bootstrap framework limitations and improvements without breaking development flow.

## Arguments

$ARGUMENTS - Natural language reference (e.g., "what we just discussed", "this bug") or direct description of the insight to capture.

## When to Use This Command

**Use `/insight-capture` when:**
- You've discovered a bug or limitation in the framework
- You want to document a workaround or solution
- You've found an unexpected capability or pattern
- You need to preserve knowledge before switching projects
- You want to create actionable documentation from a discussion
- You've identified a potential enhancement or improvement

**This command will:**
- Extract relevant context from conversation history
- Auto-categorize the insight (Bug/Enhancement/Limitation/Discovery)
- Generate structured markdown documentation
- Create timestamped, searchable export files
- Preserve exact error messages and commands
- Suggest actionable recommendations

## Process

### Phase 1: Input Analysis
1. **Check Arguments**
   - Extract content from $ARGUMENTS variable
   - If empty, prompt: "What insight would you like to capture? (describe the issue or say 'recent' for last discussion)"
   - Continue with provided input

2. **Detect Reference Type**
   - Context references: "this", "that", "what we", "earlier", "just now", "discussed", "mentioned", "the issue", "the problem"
   - Temporal references: "recently", "last", "previous"
   - Direct descriptions: Detailed explanations without context references
   - Route to appropriate processor

### Phase 2: Context Extraction (if context reference detected)
3. **Access Conversation History**
   - Leverage Claude's full conversation history access
   - Scan last 10 exchanges (or more if needed)
   - Look for technical discussions and issues

4. **Extract Technical Content**
   - Commands executed (exact syntax)
   - Error messages (complete output)
   - File paths mentioned
   - User frustrations or problems stated
   - Solutions attempted
   - Outcomes observed

5. **Identify Main Topic**
   - Analyze keyword frequency
   - Find command/file references
   - Detect error patterns
   - Extract framework components mentioned
   - Generate topic summary

### Phase 3: Information Processing
6. **Parse Information** (from context or direct input)
   - What was being attempted
   - What went wrong or was discovered
   - Exact error messages or unexpected behavior
   - Workarounds tried
   - Potential solutions discussed
   - Impact on development

### Phase 4: Classification
7. **Categorize Insight**
   - **Bug**: "doesn't work", "error", "failure", "expected X but got Y", command failures
   - **Enhancement**: "would be nice", "should have", "missing", "need", feature requests
   - **Limitation**: "can't", "unable", "not supported", "by design", architectural constraints
   - **Discovery**: "found that", "discovered", "turns out", "actually works", unexpected capabilities

8. **Assess Severity**
   - **High**: Blocks work, no workaround available
   - **Medium**: Slows development, workaround exists
   - **Low**: Minor inconvenience, easy to work around

### Phase 5: Document Generation
9. **Generate Title**
   - Extract key nouns and verbs
   - Limit to 5-7 words
   - Convert to kebab-case
   - Remove common words (the, a, an, is, are)
   - Examples:
     - "config yaml has django settings" → "config-yaml-django-settings"
     - "reset-framework doesn't handle symlinks" → "reset-framework-symlinks-not-handled"

10. **Create Structured Document**
    - Add metadata header (date, category, severity)
    - Include summary section
    - Document context and details
    - Add exact errors/outputs
    - Describe impact
    - Suggest recommendations
    - Include workarounds if available

### Phase 6: Export
11. **Generate Filename**
    - Format: `YYYY-MM-DD-{kebab-title}.md`
    - Example: `2025-09-02-config-yaml-django-settings.md`
    - Ensure unique naming

12. **Write to File System**
    - Target directory: `exports/insights/`
    - Use Write tool (creates directory if needed)
    - Preserve all formatting and code blocks

13. **Report Success**
    - Display file path created
    - Show category and severity
    - Confirm successful capture

## Usage Examples

### Context Reference
```bash
# After discussing a bug
/insight-capture "what we just discussed about the permission error"

# Reference recent discovery
/insight-capture "that interesting workaround we found"

# Capture current issue
/insight-capture "this problem with the config file"
```

### Direct Description
```bash
# Document a specific bug
/insight-capture "The /reset-framework command fails with permission denied on protected files"

# Capture a limitation
/insight-capture "Bootstrap commands can't handle file paths with spaces"

# Record an enhancement idea
/insight-capture "Would be useful to have progress indicators for long-running commands"
```

### Interactive Mode
```bash
# No arguments - interactive prompt
/insight-capture

> What insight would you like to capture? (describe the issue or say 'recent' for last discussion)
> recent

# Processes last technical discussion
```

## Output Examples

### Successful Bug Capture
```
📝 Insight Capture Command
========================

Analyzing context: "what we just discussed"...
✓ Found technical discussion about reset-framework command
✓ Extracted error details and attempted solutions

Classification: Bug (High Severity)
Title: reset-framework-permission-denied-error

Generating documentation...
✓ Created structured insight document

File saved to: exports/insights/2025-09-02-reset-framework-permission-denied-error.md

Summary:
- Category: Bug
- Severity: High
- Component: reset-framework command
- Impact: Blocks framework reset on protected files

✅ Insight successfully captured!
```

### Direct Enhancement Capture
```
📝 Insight Capture Command
========================

Processing direct input...
✓ Parsed enhancement request

Classification: Enhancement (Medium Severity)
Title: add-progress-indicators-long-commands

Generating documentation...
✓ Created structured insight document

File saved to: exports/insights/2025-09-02-add-progress-indicators-long-commands.md

Summary:
- Category: Enhancement
- Severity: Medium
- Component: Command framework
- Impact: Improves user experience for long operations

✅ Insight successfully captured!
```

### No Context Found
```
📝 Insight Capture Command
========================

Analyzing context: "that thing earlier"...
⚠️ Could not find clear technical discussion in recent conversation

Please describe the insight more specifically, or provide details directly:
> The config.yaml file has Django-specific settings but we're not using Django

Processing direct input...
✓ Parsed limitation description

Classification: Limitation (Low Severity)
[continues with normal processing...]
```

## Generated File Structure

### Example Output File
```markdown
# Insight: Reset Framework Permission Denied Error

**Date Captured**: 2025-09-02
**Category**: Bug
**Severity**: High
**Component**: reset-framework command

## Summary
The /reset-framework command fails when encountering files with restricted permissions, specifically in the responses/ directory. This prevents complete framework cleanup and blocks the reset process.

## Context
User attempted to reset the Bootstrap framework for a new project but encountered permission denied errors on protected files.

## Details
### What Was Attempted
Running `/reset-framework` to clean the repository for a new project start.

### What Happened
Command failed with permission denied error when trying to remove `responses/protected.txt`.

### Error/Output
```
Removing development artifacts...
✓ Removed .sdlc/ directory
⚠️ Permission denied: responses/protected.txt
✓ Removed .git/ directory
```

## Impact
Prevents complete framework reset, leaving artifacts that could interfere with new project development. Users must manually resolve permission issues before proceeding.

## Recommendation
1. Add permission check before attempting file removal
2. Implement sudo fallback or skip with warning
3. Provide clear instructions for manual resolution

## Workaround
Manually change file permissions before running reset:
```bash
chmod -R u+w responses/
/reset-framework
```

---
*Captured via `/insight-capture` from conversation context*
```

## Error Handling

### Context Extraction Failures
- **No technical content found**: Prompt for explicit description
- **Conversation too old/compacted**: Fall back to manual input with message
- **Multiple topics detected**: List topics and ask for selection
- **Ambiguous reference**: Use most recent or request clarification

### Classification Challenges
- **Unclear category**: Default to "Discovery" with note
- **Mixed indicators**: Use primary characteristic for classification
- **No severity markers**: Default to "Medium" severity

### File System Issues
- **Write permission denied**: Report error with alternative location suggestion
- **Directory creation failed**: Attempt current directory with warning
- **File already exists**: Append timestamp to ensure uniqueness

## Configuration

The command reads project configuration from `.claude/config.yaml`:
- Uses `project.name` for metadata context
- References project type for component detection
- Applies to insight categorization hints

## Notes

- **Conversation Access**: This command leverages Claude's full conversation history access
- **Auto-categorization**: Uses pattern matching for quick classification without user confirmation
- **Speed Priority**: Designed for < 30 second capture to maintain development flow
- **Graceful Degradation**: Falls back to manual input when context is unclear
- **Directory Creation**: The Write tool automatically creates the exports/insights/ directory

## Related Commands

- `/gather-feature-requirements` - For formal feature specification
- `/design-feature` - To design solutions for captured enhancements
- `/task-add` - To add bug fixes or enhancements to task list
- `/quick-feature` - For rapid feature documentation

## Implementation Details

### Context Triggers
The following patterns trigger conversation context analysis:
- "this", "that", "what we", "earlier", "just now"
- "discussed", "mentioned", "the issue", "the problem"
- "recent", "last", "previous", "above"

### Classification Heuristics
- **Bug Indicators**: "doesn't work", "error", "failure", "broken", "crash"
- **Enhancement Indicators**: "would be nice", "should", "missing", "need", "want"
- **Limitation Indicators**: "can't", "unable", "not supported", "impossible"
- **Discovery Indicators**: "found", "discovered", "turns out", "realized", "works"

### Severity Assessment
- **High**: Blocks work, data loss risk, security issue, no workaround
- **Medium**: Slows development, requires workaround, impacts multiple users
- **Low**: Minor inconvenience, cosmetic issue, rare occurrence

---
*Command implementation follows Bootstrap framework patterns for natural language processing and zero-friction documentation capture.*