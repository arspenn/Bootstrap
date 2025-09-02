name: "Quick-Feature Command Implementation PRP"
description: |

## Purpose
Implement a streamlined /quick-feature command as a parallel implementation to gather-feature-requirements, optimized for small features, bug fixes, and documentation updates. This command will complete in 2-3 questions maximum and intelligently escalate complex features to the full requirements gathering process.

## Core Principles
1. **Parallel Implementation**: Independent command with own logic (per ADR-001)
2. **Minimal Interaction**: Maximum 2-3 questions for simple features
3. **Intelligent Complexity Detection**: Use Claude's analysis, not pattern matching
4. **Context Preservation**: Full context summary when escalating
5. **Template Compatibility**: Share templates with gather-feature-requirements

---

## Goal
Create a /quick-feature command that enables developers to rapidly define small features with minimal overhead while maintaining compatibility with the existing design-feature workflow. The command should complete in under 30 seconds for simple features and intelligently detect when to escalate to the full requirements gathering process.

## Why
- **Speed**: Reduces friction for small changes and bug fixes
- **Efficiency**: Eliminates unnecessary questions for simple features
- **Intelligence**: Leverages Claude's understanding to assess complexity
- **Compatibility**: Maintains full integration with existing workflow
- **User Experience**: Improves developer productivity for common tasks

## What
A new command that:
- Accepts minimal input to generate feature specifications
- Asks 1-2 targeted questions maximum
- Uses Claude's intelligence to detect complexity
- Escalates to gather-feature-requirements when appropriate
- Generates sequentially numbered feature files (###-feature-title.md)
- Uses minimal template (feature-quick.template.md)

### Success Criteria
- [ ] Command completes in <30 seconds for simple features
- [ ] Maximum 2-3 questions asked for any feature
- [ ] Correctly detects complexity 80% of the time
- [ ] Generated files work with design-feature command
- [ ] Context fully preserved when escalating
- [ ] Sequential numbering implemented correctly

## All Needed Context

### Documentation & References
```yaml
# MUST READ - Include these in your context window
- file: .claude/commands/gather-feature-requirements.md
  why: Reference implementation to understand patterns and conversation flow
  
- file: .claude/commands/task-add.md
  why: Simpler command example showing argument parsing and file updates
  
- file: .claude/templates/feature-quick.template.md
  why: Template to use for generated feature files
  
- file: .claude/templates/feature-enhanced.template.md
  why: Template used by gather-feature-requirements for comparison
  
- file: designs/015-quick-feature-command/design.md
  why: Complete design specification with all requirements
  
- file: designs/015-quick-feature-command/adrs/ADR-001-parallel-implementation.md
  why: Architecture decision for parallel implementation approach

- doc: https://docs.anthropic.com/en/docs/claude-code
  section: Claude Code command documentation
  critical: Commands are markdown files in .claude/commands/ that Claude interprets
```

### Current Codebase Structure
```bash
Bootstrap/
├── .claude/
│   ├── commands/              # All commands live here
│   │   ├── gather-feature-requirements.md
│   │   ├── design-feature.md
│   │   ├── task-add.md
│   │   └── ... (other commands)
│   └── templates/              # Shared templates
│       ├── feature-quick.template.md     # Already created
│       └── feature-enhanced.template.md  # Already created
├── features/                   # Feature files output here
│   ├── quick-feature-command.md
│   └── ... (various feature files, no sequential numbering yet)
└── designs/
    └── 015-quick-feature-command/  # Design for this feature
```

### Desired Structure After Implementation
```bash
Bootstrap/
├── .claude/
│   ├── commands/
│   │   ├── quick-feature.md           # NEW: Our command
│   │   └── gather-feature-requirements.md  # UPDATE: Add sequential naming
├── features/
│   ├── 001-quick-feature-command.md   # Renamed with sequential number
│   ├── 002-[next-feature].md          # Future features use sequential
│   └── ... (existing files remain)
```

### Known Gotchas & Patterns
```markdown
# CRITICAL: Command Structure Pattern
# All commands follow this structure:
# 1. Title and description
# 2. ## Arguments: $ARGUMENTS (for receiving input)
# 3. ## When to Use This Command
# 4. ## Process (detailed steps)
# 5. ## Usage/Examples
# 6. ## Output/Integration

# CRITICAL: Claude interprets markdown literally
# The command must be self-contained with all logic described
# Claude reads and executes based on the markdown instructions

# PATTERN: File operations
# Always check if file exists before reading
# Use Write tool for new files, Edit for existing
# Show clear success/error messages

# PATTERN: User interaction
# Use > prefix for questions to user
# Keep questions concise and specific
# Provide examples in parentheses

# GOTCHA: Sequential numbering
# Must handle existing non-numbered files gracefully
# Start from 001 if no numbered files exist
# Find highest number and increment by 1
```

## Implementation Blueprint

### Task 1: Create Sequential File Naming Rule

CREATE .claude/rules/project/sequential-file-naming.md:
```markdown
# Rule: Sequential File Naming

## Instructions

### Rule Metadata
- ID: project/sequential-file-naming
- Status: Active
- Security Level: Low
- Token Impact: ~15 tokens per operation
- Priority: 300
- Dependencies: []

### Rule Configuration
```yaml
trigger: "file creation in features/ or designs/"
conditions:
  - creating_feature_file: true
  - creating_design_folder: true
actions:
  - enforce_sequential_naming: true
  - pattern: "###-{kebab-case-title}"
  - find_next_number: true
validations:
  - number_format: "^\\d{3}$"
  - kebab_case_title: true
  - max_title_length: 50
```

### Behavior
- Enforces sequential numbering for feature files and design folders
- Pattern: `###-kebab-case-title` (e.g., 001-fix-login-button.md)
- Automatically finds next available number
- Converts titles to kebab-case (lowercase, hyphens for spaces)
- Applies to both features/ and designs/ directories

### Implementation Details

#### Getting Next Sequential Number
1. List all files/folders in target directory
2. Filter for pattern: `^\\d{3}-.*`
3. Extract numbers, find highest
4. Return highest + 1, formatted as 3 digits
5. If no numbered items exist, return "001"

#### Title to Kebab Case Conversion
1. Convert to lowercase
2. Replace spaces with hyphens
3. Remove special characters except hyphens
4. Remove consecutive hyphens
5. Trim to max 50 characters
6. Remove trailing hyphens

#### Examples
- "Fix Login Button" → `001-fix-login-button.md`
- "Add OAuth 2.0 Support" → `002-add-oauth-2-0-support.md`
- "URGENT: Security patch!!!" → `003-urgent-security-patch.md`

### Usage in Commands
Commands should reference this rule when creating files:
- `/quick-feature` - Creates feature files
- `/gather-feature-requirements` - Creates feature files
- `/design-feature` - References for consistency

---

📚 **Full Documentation**: [.claude/docs/rules/project/sequential-file-naming.md](../../docs/rules/project/sequential-file-naming.md)
```

CREATE .claude/docs/rules/project/sequential-file-naming.md:
```markdown
# Sequential File Naming Rule

## Overview
This rule standardizes file naming across features and designs with sequential numbering for better organization and tracking.

## Purpose
- Maintain chronological order of features and designs
- Enable easy tracking of feature/design count
- Provide consistent naming across all commands
- Improve file system organization

## Pattern
`###-kebab-case-title.{extension}`

Where:
- `###` - Three-digit sequential number (001, 002, etc.)
- `kebab-case-title` - Lowercase title with hyphens
- `extension` - File extension (.md for features)

## Implementation

### For Commands
When implementing in a command:

```markdown
# In command process section:
1. Apply sequential-file-naming rule
2. Get next number from features/
3. Convert title to kebab-case
4. Create file: {number}-{title}.md
```

### Algorithm
```python
def get_next_sequential_number(directory):
    """Get next sequential number for files in directory"""
    files = list_files(directory)
    numbers = []
    for file in files:
        match = regex_match(r'^(\d{3})-', file)
        if match:
            numbers.append(int(match.group(1)))
    
    if numbers:
        return f"{max(numbers) + 1:03d}"
    return "001"

def to_kebab_case(title):
    """Convert title to kebab-case format"""
    # Convert to lowercase
    title = title.lower()
    # Replace spaces with hyphens
    title = title.replace(' ', '-')
    # Remove special characters
    title = regex_sub(r'[^a-z0-9-]', '', title)
    # Remove consecutive hyphens
    title = regex_sub(r'-+', '-', title)
    # Trim length
    title = title[:50]
    # Remove trailing hyphens
    title = title.strip('-')
    return title
```

## Examples

### Feature Files
```
features/
├── 001-user-authentication.md
├── 002-password-reset.md
├── 003-two-factor-auth.md
└── 004-oauth-integration.md
```

### Design Folders
```
designs/
├── 001-feature-authentication/
├── 002-feature-payment-system/
├── 003-refactor-database/
└── 004-system-monitoring/
```

## Migration Strategy
All existing feature files will be renamed to follow the sequential pattern based on their creation order (oldest to newest).

## Edge Cases

### Gaps in Numbering
If files are deleted, gaps are acceptable. Always use highest + 1, not fill gaps.

### Duplicate Numbers
Should never occur if rule is followed. If detected, increment to next available.

### Very Long Titles
Truncated at 50 characters to maintain readability.

### Special Characters
All special characters except hyphens and alphanumerics are removed.

## Related Rules
- project/design-structure - Uses same pattern for design folders
- project/task-management - Similar ID pattern (TASK-###)

## Commands Using This Rule
- `/quick-feature` - Feature file creation
- `/gather-feature-requirements` - Feature file creation
- `/design-feature` - Reference for consistency
```

### Task 2: Migrate Existing Feature Files to Sequential Naming

RENAME existing feature files in chronological order (oldest first):
```bash
# First check git status to ensure files are tracked and no uncommitted changes
git status features/

# Use git mv for safe renaming that preserves history
# Based on file modification times (oldest to newest):
git mv features/fix-git-rules-alignment.md features/001-fix-git-rules-alignment.md
git mv features/FEATURE_TASK_MANAGEMENT.md features/002-task-management.md
git mv features/FEATURE_STANDARDIZE_DESIGNS.md features/003-standardize-designs.md
git mv features/FEATURE_GIT_SAFE_FILE_OPERATIONS.md features/004-git-safe-file-operations.md
git mv features/FEATURE_GIT_MERGE_CONTROL.md features/005-git-merge-control.md
git mv features/FEATURE_GITCONTROL.md features/006-git-control.md
git mv features/FEATURE_FRAMEWORK_DOCS_SEPARATION.md features/007-framework-docs-separation.md
git mv features/FEATURE_DESIGN_ADDENDUM_SYSTEM.md features/008-design-addendum-system.md
git mv features/FEATURE_CLAUDE_MEMORY_INTEGRATION.md features/009-claude-memory-integration.md
git mv features/FEATURE_CLAUDE_MD_STANDARDIZATION.md features/010-claude-md-standardization.md
git mv features/FEATURE_SDLC_CONSOLIDATION.md features/011-sdlc-consolidation.md
git mv features/enhanced-task-management-feature.md features/012-enhanced-task-management.md
git mv features/FEATURE_ENHANCED_TASK_STRUCTURE.md features/013-enhanced-task-structure.md
git mv features/FEATURE_RULE_LOADING_COMMAND.md features/014-rule-loading-command.md
git mv features/phase-one-incremental-plan.md features/015-phase-one-incremental-plan.md
git mv features/quick-feature-command.md features/016-quick-feature-command.md

# Keep README.md as is (not a feature file)
# Keep .gitkeep as is (not a feature file)

# After all renames, stage the changes
git status features/
```

This migration:
- Orders files by their modification time (proxy for creation order)
- Converts FEATURE_ prefix and uppercase to kebab-case
- Assigns sequential numbers starting from 001
- Preserves the semantic meaning of filenames
- Makes all feature files consistent with new naming convention

### Task 3: Create the Quick-Feature Command File

CREATE .claude/commands/quick-feature.md:
```markdown
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
> Created: features/001-fix-login-button.md

### With Sufficient Context  
/quick-feature "As a developer, I want to add debug logging to the API endpoints so that I can troubleshoot issues faster"
> Created: features/002-add-debug-logging.md

### Escalation Case
/quick-feature "Redesign the entire authentication system"
> This feature appears to involve multiple components and significant architectural changes.
> I recommend using the full requirements gathering process.
> 
> Context: User wants to redesign authentication system...
> Use: /gather-feature-requirements "redesign authentication system"
```

### Task 4: Update gather-feature-requirements to Use Sequential Naming Rule

MODIFY .claude/commands/gather-feature-requirements.md:
- FIND section: "### 7. **Save and Report Success**"
- REPLACE filename generation logic with:
```markdown
   - Apply sequential-file-naming rule from .claude/rules/project/
   - Get next sequential number from features/
   - Convert title to kebab-case
   - Generate filename: {number:03d}-{kebab-case-title}.md
   - Save to features/{filename}
   - Display file path
   - Suggest next command: `/design-feature features/{filename}`
```

### Task 5: Update MASTER_IMPORTS to Include New Rule

MODIFY .claude/MASTER_IMPORTS.md:
- FIND section: "## Project Management Rules"
- ADD after test-file-location.md:
```markdown
@.claude/rules/project/sequential-file-naming.md
```

### Task 6: Add Complexity Pattern Learning Section

APPEND to .claude/commands/quick-feature.md after main process:
```markdown
## Complexity Detection Patterns

### Patterns Indicating Complexity
(This section grows from experience)

### Keywords/Phrases
- (To be added as patterns are discovered)

### Structural Indicators  
- (To be added based on usage)

### Domain Patterns
- (To be added from real examples)
```

### Task 7: Create Helper Functions Documentation

APPEND to .claude/commands/quick-feature.md:
```markdown
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
```

## Validation Loop

### Level 1: Rule and Command File Validation
```bash
# Check rule file exists
ls -la .claude/rules/project/sequential-file-naming.md
ls -la .claude/docs/rules/project/sequential-file-naming.md

# Check command file exists and is readable
ls -la .claude/commands/quick-feature.md

# Verify markdown structure is valid
# Expected: All files exist with proper markdown formatting
```

### Level 2: Template Validation
```bash
# Verify templates exist
ls -la .claude/templates/feature-*.template.md

# Expected: Both feature-quick.template.md and feature-enhanced.template.md exist
```

### Level 3: Migration Validation
```bash
# Check that existing files are renamed correctly
ls -la features/0*.md

# Expected: 16 feature files with sequential numbering 001-016
# No more FEATURE_ prefixed files
# All names in kebab-case format
```

### Level 4: Functional Tests

Test Case 1: Simple feature with minimal input
```bash
# Simulate: /quick-feature "fix login button"
# Expected: 
# - Asks for priority
# - Creates features/017-fix-login-button.md (next after migration)
# - Uses feature-quick.template.md format
```

Test Case 2: Complete input requiring no questions
```bash
# Simulate: /quick-feature "As a developer, I want to add logging so that debugging is easier"
# Expected:
# - No questions asked
# - Creates features/018-add-logging.md (sequential after migration)
# - Properly formatted user story
```

Test Case 3: Complex feature triggering escalation
```bash
# Simulate: /quick-feature "Redesign entire authentication system with OAuth, SAML, and biometrics"
# Expected:
# - Detects complexity
# - Suggests gather-feature-requirements
# - Provides context summary
```

Test Case 4: Sequential numbering
```bash
# After migration, check existing files in features/
# Run quick-feature multiple times
# Verify sequential numbers continue from 017, 018, 019...
```

### Level 5: Integration Test
```bash
# Create feature with quick-feature
/quick-feature "Add user avatar upload"

# Use with design-feature (assuming this creates file 019)
/design-feature features/019-add-user-avatar-upload.md

# Expected: design-feature accepts and processes the file correctly
```

## Final Validation Checklist
- [ ] Sequential naming rule created at .claude/rules/project/sequential-file-naming.md
- [ ] Rule documentation created at .claude/docs/rules/project/sequential-file-naming.md
- [ ] Existing feature files migrated to sequential naming (001-016)
- [ ] Rule added to .claude/MASTER_IMPORTS.md
- [ ] Command file created at .claude/commands/quick-feature.md
- [ ] gather-feature-requirements updated to use rule
- [ ] Sequential numbering continues correctly from 017+
- [ ] Maximum 2-3 questions asked
- [ ] Complexity detection triggers appropriately
- [ ] Context preserved during escalation
- [ ] Generated files compatible with design-feature
- [ ] Both templates used appropriately
- [ ] Clear user messages and feedback

---

## Anti-Patterns to Avoid
- ❌ Don't ask more than 2-3 questions total
- ❌ Don't use regex patterns for complexity - use Claude's understanding
- ❌ Don't create new template formats - use existing ones
- ❌ Don't break compatibility with design-feature
- ❌ Don't lose context during escalation
- ❌ Don't skip sequential numbering

## Implementation Notes

1. **Start Simple**: Begin with basic flow, add complexity detection after
2. **Test Incrementally**: Test each component before integration
3. **Preserve Compatibility**: Always ensure design-feature can read output
4. **Document Patterns**: Add discovered complexity patterns to the command
5. **User-Centric**: Optimize for developer experience and speed

## Confidence Score: 9/10

High confidence due to:
- Clear design specification
- Existing patterns to follow
- Templates already created
- Simple parallel implementation approach
- Well-defined validation criteria

Minor uncertainty only around Claude's exact interpretation of complexity, which will improve with usage patterns.