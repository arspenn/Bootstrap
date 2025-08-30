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