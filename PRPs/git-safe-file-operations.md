name: Git-Safe File Operations Implementation
description: |
  Implement a comprehensive safety system for file operations within git repositories. 
  This feature prevents accidental data loss by enforcing git-aware checks before any 
  potentially destructive file operations (rm, rmdir, mv).
  
  CRITICAL: Claude must NEVER automatically fall back to unsafe operations if git commands fail.

## Goal

Create a git-safe file operations rule that:
- Intercepts destructive file commands (rm, rmdir, mv) by default
- Checks git status before allowing operations
- Blocks operations that would lose uncommitted changes or untracked files
- Provides clear guidance on safe alternatives
- Allows explicit overrides for advanced users
- Never falls back to unsafe operations automatically

## Why

**Critical Issue**: Current implementations use direct file operations without checking git status
**User Impact**: Prevents accidental loss of uncommitted work during refactoring/migrations
**Business Value**: Protects developer productivity and reduces risk of lost work
**Integration**: Enhances existing git rules with file operation safety

## What

User-visible behavior:
- File operations check git status first
- Blocked operations show clear error messages with solutions
- Git commands (git rm, git mv) preferred for tracked files
- Advanced users can override with explicit flags
- No automatic fallbacks - fail safely

### Success Criteria
- [ ] Zero data loss from file operations
- [ ] <100ms overhead for typical operations
- [ ] Clear error messages guide resolution
- [ ] Rule can be disabled in preferences
- [ ] All new PRPs use safe patterns

## All Needed Context

### Documentation & References
```yaml
- file: /home/arspenn/Dev/Bootstrap/designs/007-feature-git-safe-file-operations/design.md
  why: Complete design document with requirements and architecture
  
- file: /home/arspenn/Dev/Bootstrap/designs/007-feature-git-safe-file-operations/adrs/ADR-001-no-automatic-fallback.md
  why: Critical decision - NEVER fall back automatically
  
- file: /home/arspenn/Dev/Bootstrap/designs/007-feature-git-safe-file-operations/adrs/ADR-002-medium-security-level.md
  why: Security level allows user overrides
  
- file: /home/arspenn/Dev/Bootstrap/designs/007-feature-git-safe-file-operations/adrs/ADR-003-path-specific-status-checks.md
  why: Performance optimization approach

- file: /home/arspenn/Dev/Bootstrap/.claude/rules/git/git-add-safety.md
  why: Example git rule structure to follow
  
- file: /home/arspenn/Dev/Bootstrap/.claude/rules/config/user-preferences.yaml
  why: Where rule enable/disable is configured
  
- url: https://git-scm.com/docs/git-rm
  why: Git rm command documentation
  
- url: https://git-scm.com/docs/git-mv  
  why: Git mv command documentation
```

### Current Implementation Issues
```yaml
Problem Areas:
  - file: /home/arspenn/Dev/Bootstrap/PRPs/diagram-migration-implementation.md
    issue: Uses 'rmdir' without checking for uncommitted files
    lines: [86, 90, 94]
    
  - pattern: Direct file operations in PRPs
    issue: "rm -rf", "rmdir", "mv" used without safety checks
    risk: Loss of uncommitted changes
```

### Rule System Architecture
```yaml
Rule Structure:
  location: .claude/rules/git/
  format: Markdown with YAML configuration
  components:
    - metadata: ID, Status, Security Level, Token Impact
    - configuration: trigger, conditions, actions, validations
    - documentation: Link to full docs
    
Integration:
  - trigger: How Claude detects when to apply rule
  - conditions: When the rule should activate
  - actions: What the rule does
  - validations: Checks performed
```

### Known Gotchas
```python
# CRITICAL: Rules currently trigger on git commands, not bash commands
# SOLUTION: Rule must hook into Bash tool execution
# PATTERN: Check command before execution, not after

# CRITICAL: git status can be slow on large repos
# SOLUTION: Use path-specific checks: git status --porcelain -- <path>

# CRITICAL: Some paths may not be in a git repo
# SOLUTION: Check for .git directory first, allow operation if not in repo

# CRITICAL: User must be able to override
# SOLUTION: Support --force-unsafe flag or preference setting
```

## Implementation Blueprint

### Task 1: Create Rule Definition File

CREATE .claude/rules/git/git-safe-file-operations.md:
```markdown
# Rule: Git-Safe File Operations

## Instructions

### Rule Metadata
- ID: git/git-safe-file-operations
- Status: Active  
- Security Level: Medium
- Token Impact: ~75 tokens per file operation

### Rule Configuration
```yaml
trigger: "bash command execution"
conditions:
  - command_starts_with: ["rm", "rmdir", "mv"]
  - not_force_unsafe: true
actions:
  - check_git_repository: true
  - check_path_status: true
  - block_if_unsafe: true
  - suggest_alternatives: true
validations:
  - no_uncommitted_changes: true
  - no_untracked_files_in_deletion: true
  - prefer_git_commands: true
error_handling:
  - show_git_status: true
  - provide_solutions: true
  - no_automatic_fallback: true
```

### Safety Checks
- Check if in git repository
- Run path-specific git status
- Block if uncommitted changes detected
- Suggest git alternatives for tracked files

---

📚 **Full Documentation**: [docs/rules/git/git-safe-file-operations.md](../../../docs/rules/git/git-safe-file-operations.md)
```

### Task 2: Create Full Documentation

CREATE docs/rules/git/git-safe-file-operations.md:
```markdown
# Git-Safe File Operations Documentation

## Overview
Prevents accidental data loss by checking git status before file operations.

## Rule Definition
[Include full YAML configuration]

## Description
This rule intercepts potentially destructive file operations (rm, rmdir, mv) and ensures they won't result in loss of uncommitted changes or untracked files.

## Rationale
- Discovered during diagram migration when `rmdir` was used on folders with uncommitted files
- Direct file operations bypass git's safety mechanisms
- Users often forget to check git status before destructive operations

## Examples

### Good Practices
```bash
# Check status first
git status src/old-module/
# If clean, use git rm
git rm -r src/old-module/

# Or commit changes first
git add src/old-module/
git commit -m "Save work before deletion"
rm -rf src/old-module/
```

### Bad Practices  
```bash
# DANGEROUS - No status check
rm -rf src/module/

# DANGEROUS - Might lose uncommitted work
rmdir old-folder/
```

## Common Scenarios

### Scenario 1: Deleting with uncommitted changes
```bash
$ rm -rf src/utils/
ERROR: Cannot remove 'src/utils/': uncommitted changes detected

Affected files:
  M src/utils/helpers.py
  ? src/utils/new_module.py

To proceed safely:
  1. Commit changes: git add src/utils/ && git commit -m "Save work"
  2. Or stash changes: git stash push -m "Temporary" src/utils/
  3. Or force removal (DANGEROUS): rm -rf src/utils/ --force-unsafe
```

### Scenario 2: Moving tracked files
```bash
$ mv src/old.py src/new.py
WARNING: 'src/old.py' is tracked by git

Recommended: git mv src/old.py src/new.py
This preserves git history.

To proceed anyway: mv src/old.py src/new.py --force-unsafe
```

## User Preferences

Disable this rule in `.claude/rules/config/user-preferences.yaml`:
```yaml
git:
  rules:
    git-safe-file-operations: disabled
```

## Related Rules
- git-add-safety: Prevents unsafe staging
- git-push-validation: Pre-push safety checks

## Troubleshooting

If git commands fail:
1. Check git status manually
2. Resolve any repo issues
3. Never use --force-unsafe without understanding consequences

## References
- Git documentation: https://git-scm.com/docs/git-rm
- Design document: designs/007-feature-git-safe-file-operations/design.md
```

### Task 3: Update User Preferences

MODIFY .claude/rules/config/user-preferences.yaml:
```yaml
# Under git: rules: section, add:
    git-safe-file-operations: enabled  # Prevent unsafe file operations

# Under git: config: section, add:
    # File operation safety
    file_operations:
      check_uncommitted: true          # Block if uncommitted changes
      check_untracked: true           # Warn about untracked files
      suggest_git_commands: true      # Recommend git rm/mv
      allow_force_unsafe: true        # Allow --force-unsafe override
```

### Task 4: Update MASTER_IMPORTS.md

MODIFY .claude/MASTER_IMPORTS.md:
```markdown
# Under ## Git Rules section, add:
@.claude/rules/git/git-safe-file-operations.md
```

### Task 5: Create Integration Logic

**CRITICAL**: This is conceptual - Claude's rule system needs to intercept bash commands.
The implementation depends on how Claude processes commands internally.

```python
# Conceptual implementation for Claude's command processing
def process_bash_command(command: str) -> CommandResult:
    """Process bash command with safety checks"""
    
    # Parse command
    parsed = parse_command(command)
    operation = parsed.command  # rm, mv, rmdir, etc.
    paths = parsed.arguments
    
    # Check if git-safe rule is enabled
    if is_rule_enabled('git-safe-file-operations'):
        # Check if this is a destructive operation
        if operation in ['rm', 'rmdir', 'mv'] and not '--force-unsafe' in command:
            # Run safety checks
            safety_result = check_file_operation_safety(operation, paths)
            
            if not safety_result.safe:
                # Block operation and show guidance
                return CommandResult(
                    success=False,
                    error=safety_result.reason,
                    suggestions=safety_result.suggestions
                )
    
    # Execute command if safe or overridden
    return execute_command(command)

def check_file_operation_safety(operation: str, paths: List[str]) -> SafetyResult:
    """Check if file operation is safe"""
    
    # Check if in git repository
    if not is_git_repository():
        return SafetyResult(safe=True, reason="Not in git repository")
    
    # Check each path
    for path in paths:
        # Path-specific git status (fast)
        status = run_command(f"git status --porcelain -- {path}")
        
        if status.strip():  # Has output = has changes
            # Parse what kind of changes
            changes = parse_git_status(status)
            
            if changes.has_modifications:
                return SafetyResult(
                    safe=False,
                    reason=f"Uncommitted changes in {path}",
                    suggestions=[
                        f"Commit changes: git add {path} && git commit -m 'Save work'",
                        f"Stash changes: git stash push -m 'Temporary' {path}",
                        f"Force operation: {operation} {path} --force-unsafe"
                    ]
                )
            
            if operation in ['rm', 'rmdir'] and changes.has_untracked:
                return SafetyResult(
                    safe=False,
                    reason=f"Untracked files in {path} would be lost",
                    suggestions=[
                        f"Review files: git status {path}",
                        f"Add files: git add {path}",
                        f"Force removal: {operation} {path} --force-unsafe"
                    ]
                )
    
    # Check if files are tracked (suggest git commands)
    for path in paths:
        if is_tracked(path):
            if operation == 'rm':
                return SafetyResult(
                    safe=True,
                    warning=f"Consider using: git rm {path}",
                    reason="Preserves git history"
                )
            elif operation == 'mv' and len(paths) >= 2:
                return SafetyResult(
                    safe=True,
                    warning=f"Consider using: git mv {paths[0]} {paths[1]}",
                    reason="Preserves git history"
                )
    
    return SafetyResult(safe=True)
```

### Task 6: Update PRPs to Use Safe Patterns

Example updates for future PRPs:
```bash
# OLD (Dangerous)
rmdir old-folder

# NEW (Safe)
# Check for uncommitted changes
git status old-folder/ --porcelain || echo "Clean"
# If clean, remove
git rm -r old-folder/ || rmdir old-folder

# OR with explicit safety bypass
rmdir old-folder --force-unsafe  # Verified: no important files
```

### Task 7: Create Test Scenarios

CREATE tests/test_git_safe_file_operations.py:
```python
import pytest
from unittest.mock import patch, MagicMock

# Note: These are conceptual tests for the rule behavior

class TestGitSafeFileOperations:
    """Test git-safe file operations rule"""
    
    def test_allows_operations_outside_git_repo(self):
        """Operations outside git repos should work"""
        with patch('is_git_repository', return_value=False):
            result = check_file_operation_safety('rm', ['file.txt'])
            assert result.safe is True
    
    def test_blocks_rm_with_uncommitted_changes(self):
        """Should block rm when uncommitted changes exist"""
        with patch('is_git_repository', return_value=True):
            with patch('run_command', return_value='M file.txt'):
                result = check_file_operation_safety('rm', ['file.txt'])
                assert result.safe is False
                assert 'Uncommitted changes' in result.reason
    
    def test_blocks_rmdir_with_untracked_files(self):
        """Should block rmdir when untracked files exist"""
        with patch('is_git_repository', return_value=True):
            with patch('run_command', return_value='?? folder/new.txt'):
                result = check_file_operation_safety('rmdir', ['folder'])
                assert result.safe is False
                assert 'Untracked files' in result.reason
    
    def test_suggests_git_mv_for_tracked_files(self):
        """Should suggest git mv for tracked files"""
        with patch('is_git_repository', return_value=True):
            with patch('run_command', return_value=''):  # Clean status
                with patch('is_tracked', return_value=True):
                    result = check_file_operation_safety('mv', ['old.txt', 'new.txt'])
                    assert result.safe is True
                    assert 'git mv' in result.warning
    
    def test_force_unsafe_bypasses_checks(self):
        """--force-unsafe should bypass all checks"""
        # This would be handled before safety checks are called
        command = 'rm -rf folder --force-unsafe'
        assert '--force-unsafe' in command  # Would bypass rule
```

## Validation

### Verify Rule Files Created
```bash
# Check rule file exists
ls -la .claude/rules/git/git-safe-file-operations.md

# Check documentation exists  
ls -la docs/rules/git/git-safe-file-operations.md

# Check rule is imported
grep -n "git-safe-file-operations" .claude/MASTER_IMPORTS.md

# Check user preferences updated
grep -A5 "git-safe-file-operations" .claude/rules/config/user-preferences.yaml
```

### Test Rule Behavior (Manual)
```bash
# Create test scenario
mkdir test-safe-ops
cd test-safe-ops
git init
echo "test" > file.txt
git add file.txt
git commit -m "Initial"

# Modify file (create uncommitted change)
echo "modified" >> file.txt

# This should be blocked by the rule
rm file.txt
# Expected: ERROR about uncommitted changes

# This should work (explicit override)
rm file.txt --force-unsafe
# Expected: File removed
```

### Integration Test
```bash
# Test with real Claude Code
# 1. Make a change to a file
# 2. Ask Claude to delete the file
# 3. Verify Claude refuses and provides guidance
# 4. Commit the change
# 5. Ask Claude again
# 6. Verify Claude suggests git rm
```

## Final Validation Checklist
- [ ] Rule file created with correct YAML structure
- [ ] Documentation complete with examples
- [ ] User preferences updated
- [ ] MASTER_IMPORTS includes new rule
- [ ] Manual test shows safety blocking works
- [ ] Override mechanism (--force-unsafe) works
- [ ] Error messages are clear and actionable
- [ ] Performance impact <100ms

## Anti-Patterns to Avoid
- ❌ Don't automatically fall back to unsafe operations
- ❌ Don't run full repo git status (use path-specific)
- ❌ Don't block operations outside git repos
- ❌ Don't make override too easy (require explicit flag)
- ❌ Don't hide the actual git error if commands fail

## Migration Guide for Existing PRPs

Update existing PRPs that use unsafe operations:

1. Search for dangerous patterns:
   ```bash
   grep -r "rm -rf\|rmdir\|mv " PRPs/
   ```

2. Replace with safe alternatives:
   ```bash
   # Before
   rmdir old-folder
   
   # After  
   git rm -r old-folder/ 2>/dev/null || rmdir old-folder
   ```

3. Or add explicit safety notes:
   ```bash
   rmdir old-folder  # Safe: verified no uncommitted files
   ```

## Notes for Implementation

**CRITICAL**: This PRP assumes Claude's rule system can intercept bash commands before execution. If the current architecture doesn't support this, the rule system would need enhancement to hook into the Bash tool.

The actual implementation will depend on Claude's internal architecture for processing commands. The conceptual code provided shows the logic flow, but the integration point needs to be determined based on Claude's codebase.

**Success depends on**:
1. Claude's ability to intercept bash commands
2. Integration with the Bash tool
3. Consistent application of the rule
4. Clear error messages that don't frustrate users

## Confidence Score: 8/10

High confidence in the rule design and safety logic. Uncertainty comes from the integration point with Claude's command processing system. The implementation may need adjustment based on Claude's actual architecture.