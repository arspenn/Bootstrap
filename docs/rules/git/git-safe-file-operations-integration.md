# Git-Safe File Operations Integration Logic

## Overview

This document describes the conceptual integration logic for the git-safe file operations rule within Claude's command processing system.

## Integration Points

### 1. Command Interception

The rule intercepts bash commands at the execution layer:

```python
def intercept_bash_command(command: str) -> tuple[bool, str]:
    """
    Intercept bash commands before execution.
    
    Returns:
        (should_block, message): Whether to block and why
    """
    # Check if rule is enabled
    if not is_rule_enabled("git-safe-file-operations"):
        return False, ""
    
    # Parse command
    parsed = parse_command(command)
    
    # Check for unsafe operations
    if parsed.command in ["rm", "rmdir", "mv"]:
        # Check for force-unsafe flag
        if "--force-unsafe" in parsed.args:
            return False, ""
        
        # Check git status for affected paths
        for path in parsed.get_paths():
            status = check_git_status(path)
            if status.has_uncommitted_changes:
                return True, f"Path '{path}' has uncommitted changes. Use 'git {parsed.command}' instead."
    
    return False, ""
```

### 2. Git Status Checking

Path-specific git status checks for performance:

```python
def check_git_status(path: str) -> GitStatus:
    """
    Check git status for a specific path.
    
    Uses cached results when available for performance.
    """
    # Check if in git repository
    if not is_git_repository(path):
        return GitStatus(is_tracked=False, has_uncommitted_changes=False)
    
    # Use path-specific git status
    result = run_command(f"git status --porcelain -- {path}")
    
    return GitStatus(
        is_tracked=bool(result),
        has_uncommitted_changes=bool(result.strip())
    )
```

### 3. Alternative Suggestions

When blocking unsafe operations, provide git alternatives:

```python
def suggest_git_alternative(command: str, paths: list[str]) -> str:
    """
    Suggest git-safe alternatives for unsafe commands.
    """
    alternatives = {
        "rm": "git rm",
        "rmdir": "git rm -r",
        "mv": "git mv"
    }
    
    base_cmd = command.split()[0]
    if base_cmd in alternatives:
        return f"Use '{alternatives[base_cmd]}' instead of '{base_cmd}'"
    
    return "Use git commands for tracked files"
```

## Implementation Considerations

### Performance Optimization

1. **Cache git status results** - Avoid repeated git status calls
2. **Path-specific checks** - Only check status for affected paths
3. **Early exit conditions** - Skip checks when rule is disabled

### User Experience

1. **Clear error messages** - Explain why command was blocked
2. **Actionable suggestions** - Provide exact git commands to use
3. **Override mechanism** - Document --force-unsafe flag in messages

### Edge Cases

1. **Mixed operations** - Commands affecting both tracked and untracked files
2. **Symlinks** - Special handling for symbolic links
3. **Submodules** - Respect submodule boundaries

## Integration with Claude

The actual integration depends on Claude's internal command processing:

1. **Hook Registration** - Rule must register command interception hook
2. **Token Efficiency** - Minimize tokens used for checks
3. **Failure Handling** - Gracefully handle git command failures

## Testing Integration

Test scenarios should verify:

1. Rule activation/deactivation
2. Command interception accuracy
3. Git status checking performance
4. Alternative suggestion relevance
5. Override mechanism functionality

## Future Enhancements

1. **Batch operations** - Optimize multiple file operations
2. **Undo support** - Track operations for potential rollback
3. **Custom patterns** - User-defined unsafe command patterns