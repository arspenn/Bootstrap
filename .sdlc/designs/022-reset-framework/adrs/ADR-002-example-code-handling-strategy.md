# ADR-002: Example Code Handling Strategy

## Status
Accepted

## Context

When resetting the framework, we may encounter files that aren't part of the Bootstrap framework but aren't in the explicit removal list either. These could be:

- Example code added by the user before cloning
- Test files created during framework evaluation
- Custom scripts or configurations
- Documentation specific to the new project

We need a strategy to handle these files safely:

1. **Whitelist Approach**: Only remove files explicitly listed, keep everything else
2. **Blacklist Approach**: Remove everything except framework files
3. **Interactive Approach**: Ask the user about unknown files
4. **Pattern Matching**: Use heuristics to identify likely user files

## Decision

Use an interactive approach where Claude identifies potential example code files outside the framework directories and asks the user whether each should be kept or removed.

The command will:
- Identify files not in `.claude/` or other preserved directories
- Detect common code file extensions (.py, .js, .java, etc.)
- Present each file to the user with the prompt: "Found {file} - is this an example for your current project? (keep/remove)"
- Apply the user's decision for each file

## Consequences

### Positive
- **Safety**: No accidental deletion of user's work
- **Flexibility**: Handles unexpected scenarios gracefully
- **User Control**: User makes informed decisions about their files
- **Learning**: Command adapts to user's specific situation

### Negative
- **User Interaction Required**: Not fully automated
- **Potential for Many Prompts**: Could be tedious with many files
- **Consistency**: Different outcomes based on user choices

### Neutral
- **Execution Time**: Slightly longer due to prompts
- **Complexity**: Moderate implementation complexity
- **Documentation**: Need clear examples of the interaction

## Notes

This approach prioritizes safety and user control over automation. For future versions, we could add:
- Pattern learning to reduce prompts over time
- Batch confirmation options ("Keep all .py files?")
- Configuration file to predefine decisions