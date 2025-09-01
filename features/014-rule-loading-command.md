# Feature: Rule Loading Command

## Overview
Implement a manual trigger command to ensure complete and proper loading of all Claude rules at the beginning of conversations or when rules are updated.

## Problem Statement
Currently, CLAUDE.md contains @import statements that reference rule files, but these are just text references. Claude must manually read each imported file to fully load the rules. This creates several issues:
- No guarantee all rules are loaded at conversation start
- No way to verify new rules are loaded after creation
- Rules may become distant in context window over long conversations
- No explicit confirmation that rule loading is complete

## Proposed Solution
Create a `/load-rules` or `/reload` command that:
1. Reads CLAUDE.md
2. Parses all @import statements
3. Reads each imported file in order
4. Provides confirmation of successful loading
5. Reports any missing or invalid rule files

## Benefits
- **Reliability**: Ensures all rules are properly loaded every time
- **Verification**: Confirms new rules work after creation
- **Context Management**: Refreshes rules in context window during long sessions
- **Transparency**: User knows exactly when rules are loaded
- **Debugging**: Helps identify missing or broken rule imports

## Implementation Approach

### Command Structure
```yaml
command: /load-rules
aliases: [/reload, /refresh-rules, /lr]
description: "Load or reload all Claude rules from CLAUDE.md imports"
actions:
  - read_claude_md: true
  - parse_imports: true
  - read_all_imports: true
  - validate_rules: true
  - report_status: true
```

### Example Usage
```
User: /load-rules

Claude: Loading rules from CLAUDE.md...
[Reads CLAUDE.md]
[Reads .claude/MASTER_IMPORTS.md]
[Reads 20 rule files]
Complete. Ready for action!
Successfully loaded 20 rules from 4 categories:
- Git Rules: 7 rules
- Project Rules: 6 rules  
- Python Rules: 2 rules
- Documentation Rules: 1 rule
- Testing Rules: 1 rule
```

### Error Handling
```
User: /load-rules

Claude: Loading rules from CLAUDE.md...
[Reads files...]
Warning: Failed to load 2 rules:
- .claude/rules/git/missing-rule.md (File not found)
- .claude/rules/python/invalid-rule.md (Invalid format)

Successfully loaded 18 of 20 rules.
Complete. Ready for action with partial rule set.
```

## Alternative Approaches Considered

### 1. Automatic Loading
- Pros: No manual intervention needed
- Cons: Can't control when it happens, no visibility into process

### 2. Rule Compilation
- Compress all rules into single CLAUDE.md file
- Pros: Single file to read
- Cons: Loses modularity, harder to maintain, very large file

### 3. Rule Caching
- Cache parsed rules between conversations
- Pros: Faster loading
- Cons: Cache invalidation issues, not possible with current architecture

## Future Enhancements
- Add `/check-rules` to verify rules without reloading
- Support selective rule loading (`/load-rules git`)
- Rule dependency resolution
- Rule conflict detection
- Performance metrics for rule loading

## Success Criteria
- Command successfully loads all valid rule files
- Clear feedback on loading progress and results
- Graceful handling of missing or invalid rules
- Measurable improvement in rule consistency across conversations

## Priority
HIGH - This directly impacts Claude's ability to follow project-specific rules consistently

## Estimated Effort
Small - Primarily involves creating command documentation and usage pattern

## Dependencies
- CLAUDE.md must maintain @import syntax
- Rule files must follow consistent structure
- .claude/commands/ directory for command documentation

## Status
PROPOSED

## References
- Current CLAUDE.md implementation
- .claude/MASTER_IMPORTS.md structure
- Existing rule file patterns