# PRP: Rule Loading Command Implementation

## Overview
Implement `/load-rules` command to ensure complete loading of all Claude rules from CLAUDE.md and its imports. This addresses the limitation where @import statements are only text references requiring manual file reading.

## Context and Background

### Design Document
Full design available at: `designs/013-feature-rule-loading-command/design.md`

### Current Problem
- CLAUDE.md contains `@.claude/MASTER_IMPORTS.md` which is just text
- MASTER_IMPORTS.md contains `@.claude/rules/...` imports that are also just text
- No automatic loading of actual rule content
- No verification that rules are loaded
- Rules may drift away in context window during long conversations

### Context Window Information
Based on research from https://docs.anthropic.com/en/docs/build-with-claude/context-windows:
- Claude models have 200K token context window standard
- Context includes messages, responses, file contents, tool outputs
- No direct API to clear specific content from context
- Best practice: Reload important content periodically to keep it proximate

## Implementation Blueprint

### File Structure
```
.claude/
├── commands/
│   └── load-rules.md          # Command documentation (NEW)
├── MASTER_IMPORTS.md           # Contains all rule imports (EXISTING)
└── rules/                      # Rule files (EXISTING)
    ├── git/
    ├── project/
    ├── python/
    ├── documentation/
    └── testing/
```

### Command Documentation Template
Based on existing patterns from:
- `.claude/commands/task-add.md`
- `.claude/commands/task-update.md`
- `.claude/commands/task-summary.md`

### Implementation Pseudocode
```python
# /load-rules command execution flow
def load_rules():
    # Step 1: Initial feedback
    print("Loading")
    
    # Step 2: Read CLAUDE.md (contains the rules section)
    claude_content = read_file("CLAUDE.md")
    
    # Step 3: Read MASTER_IMPORTS.md directly (we know it's at .claude/MASTER_IMPORTS.md)
    try:
        imports_content = read_file(".claude/MASTER_IMPORTS.md")
    except FileNotFoundError:
        print("Error: .claude/MASTER_IMPORTS.md not found")
        print("Please ensure CLAUDE.md and MASTER_IMPORTS.md exist in your project.")
        return
    
    # Step 4: Parse all @import statements from MASTER_IMPORTS.md
    import_pattern = r'@(\.claude/rules/[^\s]+\.md)'
    rule_files = find_all_matches(import_pattern, imports_content)
    
    # Step 5: Load each rule file
    loaded = []
    failed = []
    
    for rule_file in rule_files:
        try:
            content = read_file(rule_file)
            loaded.append(rule_file)
        except FileNotFoundError:
            failed.append((rule_file, "File not found"))
        except Exception as e:
            failed.append((rule_file, str(e)))
    
    # Step 6: Report results
    if failed:
        print(f"\nWarning: Failed to load {len(failed)} rules:")
        for file, error in failed:
            print(f"- {file} ({error})")
    
    print(f"\nSuccessfully loaded {len(loaded)} rules")
    print("Complete. Ready for action!")
```

## Implementation Tasks

### Task 1: Create Command Documentation
**File**: `.claude/commands/load-rules.md`

```markdown
# Load Rules

## Command: /load-rules

Load or reload all Claude rules from CLAUDE.md and its imports to ensure they are properly in context.

## When to Use This Command

**Use `/load-rules` when:**
- Starting a new conversation with Claude
- After creating or modifying rule files  
- During long conversations to refresh rule context
- When Claude seems to not be following project rules
- To verify all rules are loading correctly

**This command is crucial for:**
- Ensuring consistent rule application
- Debugging rule loading issues
- Refreshing context window with current rules

## Process

1. **Display Loading Message**
   - Shows "Loading" to indicate process start
   
2. **Read CLAUDE.md**
   - Loads main configuration file
   - Parses for MASTER_IMPORTS reference
   
3. **Read MASTER_IMPORTS.md**
   - Loads master import file from `.claude/MASTER_IMPORTS.md`
   - Extracts all @import statements
   
4. **Load Each Rule File**
   - Reads each rule file referenced in imports
   - Continues on error (graceful degradation)
   - Tracks successes and failures
   
5. **Report Results**
   - Lists any failed rule loads with reasons
   - Shows total count of loaded rules
   - Displays "Complete. Ready for action!"

## Usage

```bash
/load-rules
```

## Output Examples

### Successful Load
```
Loading
Successfully loaded 20 rules
Complete. Ready for action!
```

### Partial Load with Errors
```
Loading

Warning: Failed to load 2 rules:
- .claude/rules/git/missing-rule.md (File not found)
- .claude/rules/custom/broken-rule.md (File not found)

Successfully loaded 18 rules
Complete. Ready for action!
```

### Critical Error
```
Loading
Error: .claude/MASTER_IMPORTS.md not found
Please ensure CLAUDE.md and MASTER_IMPORTS.md exist in your project.
```

## Error Handling

The command uses graceful degradation:
- **Missing individual rules**: Loads remaining rules, reports failures
- **Missing MASTER_IMPORTS.md**: Stops with clear error message
- **Malformed imports**: Skips unparseable lines, continues with valid imports
- **Read errors**: Reports specific file and error, continues

## Integration Notes

- This command should be run at the start of each conversation
- Rules are loaded into Claude's context window
- No way to explicitly clear old rule content (context window limitation)
- Reloading refreshes rule proximity in context

## Tips for Success

1. **Run Early**: Use at conversation start for best results
2. **Run Often**: Refresh during long sessions
3. **Check Output**: Verify all expected rules loaded
4. **Fix Errors**: Address any missing rule files promptly

## Common Issues

- **Rules not applying**: Run `/load-rules` to refresh context
- **File not found errors**: Check rule file paths in MASTER_IMPORTS.md
- **Import not recognized**: Ensure @import syntax is correct

## Related Commands

- Future: `/clear-rules` (if context clearing becomes possible)
- Future: `/check-rules` (validate without loading)
- Future: `/load-rules [category]` (selective loading)
```

### Task 2: Update README.md
Add reference to the load-rules command as crucial for agent performance.

**Location**: Add to "Getting Started" or "Usage" section
```markdown
### Essential Commands

#### `/load-rules` - Load Project Rules
**IMPORTANT**: Run this command at the start of each conversation to ensure Claude properly loads all project rules.

```bash
/load-rules
```

This command:
- Loads all rules from CLAUDE.md and its imports
- Ensures consistent behavior across conversations
- Reports any missing or broken rule files
- Is crucial for proper agent performance
```

### Task 3: Add to TASK.md (Optional - Future Enhancements)
Only if user requests, add future enhancement tasks:

```markdown
### Rule Loading Command Enhancements - 2025-08-30
- [ ] Implement selective rule loading (`/load-rules git`)
- [ ] Add `/check-rules` command for validation without loading
- [ ] Rule dependency resolution
- [ ] Rule conflict detection
```

Note: We decided NOT to implement --metrics flag per design requirements.

## Validation Gates

### 1. File Structure Check
```bash
# Verify command documentation created
ls -la .claude/commands/load-rules.md

# Verify it follows pattern of other commands
head -20 .claude/commands/load-rules.md
```

### 2. Import Pattern Testing
```bash
# Test import pattern matching
grep -E '@\.claude/rules/[^\s]+\.md' .claude/MASTER_IMPORTS.md | head -5

# Count total imports
grep -c '@.claude/rules/' .claude/MASTER_IMPORTS.md
```

### 3. Command Execution Test
```bash
# Simulate command execution
echo "User: /load-rules"
echo "Expected: Loading"
echo "Expected: Successfully loaded X rules"
echo "Expected: Complete. Ready for action!"
```

### 4. Error Handling Test
```bash
# Test with missing file (manually check output)
# Temporarily rename a rule file
mv .claude/rules/git/git-add-safety.md .claude/rules/git/git-add-safety.md.bak
# Run /load-rules
# Should show error for missing file but continue
# Restore file
mv .claude/rules/git/git-add-safety.md.bak .claude/rules/git/git-add-safety.md
```

### 5. README Integration Check
```bash
# Verify README updated
grep -A5 "/load-rules" README.md
```

## Code Patterns to Follow

### From Existing Commands
Reference these files for consistent patterns:
- `.claude/commands/task-add.md` - Command structure template
- `.claude/commands/task-update.md` - Process documentation style
- `.claude/commands/task-summary.md` - Output examples format

### Import Pattern
Current import syntax in codebase:
```
@.claude/MASTER_IMPORTS.md              # In CLAUDE.md
@.claude/rules/git/git-add-safety.md    # In MASTER_IMPORTS.md
```

### Error Message Style
Based on existing patterns:
- Start errors with "Error:" or "Warning:"
- Be specific about what failed
- Provide actionable next steps
- Continue operation when possible

## External References

### Context Window Management
- https://docs.anthropic.com/en/docs/build-with-claude/context-windows
- Context window is 200K tokens standard
- No API to clear specific content
- Reloading refreshes proximity

### Claude Code Best Practices
- https://www.anthropic.com/engineering/claude-code-best-practices
- Load important context early in conversation
- Refresh context periodically in long sessions
- Use clear command feedback

## Success Criteria

1. ✅ Command documentation created following existing patterns
2. ✅ Loads all rules from CLAUDE.md → MASTER_IMPORTS.md → rule files
3. ✅ Shows "Loading" at start and "Complete. Ready for action!" at end
4. ✅ Gracefully handles missing files with clear error reporting
5. ✅ README updated with command reference
6. ✅ Works immediately without additional configuration

## Confidence Score: 9/10

High confidence because:
- Clear existing patterns to follow
- Simple file reading operations
- No complex state management
- Graceful error handling approach
- Well-defined success messages

Minor uncertainty (-1) due to:
- Cannot test actual context window behavior
- Relying on Claude's file reading capabilities

## Implementation Order

1. Create `.claude/commands/load-rules.md` with full documentation
2. Update README.md with command reference and importance note
3. Test command manually:
   - Run `/load-rules` 
   - Verify output format
   - Test with a temporarily renamed rule file for error case
4. Add enhancement tasks to TASK.md for future improvements
5. Verify all validation gates pass

## Anti-Patterns to Avoid

### 1. **DON'T Try to Manipulate Context Window**
- ❌ Don't attempt to clear previous rule content
- ❌ Don't try to calculate context window usage
- ❌ Don't implement complex context management strategies
- ✅ Simply read files and let Claude handle context naturally

### 2. **DON'T Over-Engineer the Solution**
- ❌ Don't parse rule metadata or validate rule structure
- ❌ Don't implement rule dependency checking
- ❌ Don't create rule caching mechanisms
- ❌ Don't build complex error recovery logic
- ✅ Keep it simple: read files, report results

### 3. **DON'T Add Unnecessary Features**
- ❌ Don't add progress bars or percentage complete
- ❌ Don't implement selective loading in initial version
- ❌ Don't add verbose/quiet modes
- ❌ Don't create configuration options
- ✅ Start with basic functionality that works reliably

### 4. **DON'T Change Established Patterns**
- ❌ Don't create new command syntax styles
- ❌ Don't use different error message formats
- ❌ Don't reorganize the file structure
- ❌ Don't modify CLAUDE.md or MASTER_IMPORTS.md format
- ✅ Follow existing patterns exactly

### 5. **DON'T Add Unnecessary Output**
- ❌ Don't list every file as it loads
- ❌ Don't show file sizes or line counts
- ❌ Don't display rule categories or counts by type
- ❌ Don't add timestamps or duration
- ✅ Use minimal output: "Loading" → results → "Complete. Ready for action!"

### 6. **DON'T Create Side Effects**
- ❌ Don't modify any files during loading
- ❌ Don't create log files or cache files
- ❌ Don't update timestamps or metadata
- ❌ Don't trigger other commands automatically
- ✅ Read-only operation with console output only

### 7. **DON'T Handle Edge Cases Initially**
- ❌ Don't worry about circular imports
- ❌ Don't handle symbolic links specially
- ❌ Don't check for duplicate imports
- ❌ Don't validate import syntax extensively
- ✅ Focus on the common case: valid imports that exist

### 8. **DON'T Make Assumptions About Claude's Internals**
- ❌ Don't assume how Claude processes context
- ❌ Don't try to optimize for token usage
- ❌ Don't assume file reading order matters
- ❌ Don't try to detect if rules are "active"
- ✅ Trust Claude to handle loaded content appropriately

## Notes for Implementation

- Keep implementation simple - just read and report
- Don't try to parse rule content or validate structure
- Use exact messages: "Loading" and "Complete. Ready for action!"
- Follow existing command documentation patterns exactly
- Make it clear in README this is crucial for agent performance
- Avoid all anti-patterns listed above