# Example: Enhanced CLAUDE.md After Migration

```markdown
# Claude Configuration

## Rule Loading
@.claude/MASTER_IMPORTS.md

## Project Context
Loaded from: .claude/config.yaml

## AI Behavior Rules

### Context Verification
- **When file paths are ambiguous**: Use Glob to list possible matches, present options to user
- **When requirements are unclear**: State your interpretation and ask "Is this understanding correct?"
- **When multiple approaches exist**: Present 2-3 options with explicit trade-offs

### Library and Import Safety
- **Before using any library**: Check requirements.txt or pyproject.toml with Read tool
- **Before importing modules**: Verify file exists with LS or Glob tool
- **When suggesting new libraries**: Include `pip install <library>==<version>` command

### File System Operations
- **Before any file operation**: Use Read to check current content
- **Before creating files**: Use LS to verify parent directory exists
- **For all paths**: Convert to absolute paths before use
- **After file changes**: Display the change with snippet of modified content

### Code Modification Safety
- **Requirement for deletion**: User must explicitly say "delete" or "remove"
- **Requirement for overwrite**: User must explicitly say "overwrite" or "replace"
- **Exception**: When TASK.md lists the file operation as a task
- **Git awareness**: Check git status before operations on tracked files

### Efficiency and Progress
- **Tool batching**: Call multiple tools in single message when possible
- **Task tracking**: Use TodoWrite for any task with 3+ steps
- **Error handling**: When tool fails, explain error and suggest resolution
- **Validation**: Run appropriate validation commands after changes

### Communication Standards
- **Ambiguity resolution**: Never proceed with assumptions - always clarify
- **Progress updates**: Report completion of major steps in multi-step tasks
- **Error transparency**: Show actual error messages, not summaries
- **Change confirmation**: Show what was changed, not just that it was changed
```

## Notes
This example shows how the AI Behavior Rules would be transformed from vague statements to specific, actionable guidelines while keeping them in CLAUDE.md rather than forcing them into the YAML rule format.