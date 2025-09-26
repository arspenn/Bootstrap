# Claude Code Hooks Test Procedure

## Test Results Summary

**Date**: 2025-09-25
**Status**: 🔴 HOOKS NOT WORKING
**Issues Found**: 3 critical issues detected

### Current State Analysis

1. **SessionStart Hook**: ❌ NOT WORKING
   - No current session tracking files created
   - Session folders exist but are completely empty
   - Agent tracking is working independently (not through hooks)

2. **UserPromptSubmit Hook**: ❌ NOT WORKING
   - No `console.log` files found in session directories
   - User inputs not being logged

3. **Tool Hooks**: ❌ NOT WORKING
   - No `tools.log` files found
   - Pre/PostToolUse hooks not executing

4. **Configuration**: ✅ CORRECT
   - `hooks.json` is valid JSON with 9 hook types configured
   - All dependencies (jq, agent-tracker.sh) are available

---

## Root Cause Analysis

### Most Likely Cause: Claude Code Hooks Feature Not Enabled

The evidence points to the Claude Code hooks system not being enabled or available:

1. **No environment variables logged**: Our test script found no evidence of hook execution
2. **Empty session folders**: Folders are created by something else, not our hooks
3. **Perfect configuration**: No syntax errors or missing dependencies
4. **All commands would work**: When tested manually, the hook commands execute correctly

### Secondary Possibilities

1. **Silent failures**: Hook commands failing due to environment issues
2. **Permission problems**: Hooks can't write to intended locations
3. **Timing issues**: Hooks triggering before filesystem is ready
4. **Environment variable unavailability**: CLAUDE_* variables not provided

---

## Definitive Test Procedures

### Procedure 1: Basic Hook Execution Test

**Purpose**: Determine if hooks execute at all

**Steps**:
1. **Replace hooks.json temporarily**:
   ```bash
   cp .claude/hooks.json .claude/hooks-backup.json
   cp .claude/hooks-debug.json .claude/hooks.json
   ```

2. **Clear debug log**:
   ```bash
   rm -f /tmp/claude-hook-debug.log
   ```

3. **Trigger hooks** (in Claude Code):
   - Start a new conversation (triggers SessionStart)
   - Submit a user prompt (triggers UserPromptSubmit)
   - Run a tool like `Read` (triggers PreToolUse/PostToolUse)
   - Complete the response (triggers Stop)

4. **Check results**:
   ```bash
   # Check if debug log was created
   ls -la /tmp/claude-hook-debug.log

   # If exists, examine contents
   cat /tmp/claude-hook-debug.log

   # Check for session files
   ls -la .sdlc/logs/current-session*
   ls -la .sdlc/logs/session-$(date +%Y%m%d)*
   ```

**Expected Results**:
- **If hooks work**: Debug log exists with timestamped entries
- **If hooks don't work**: No debug log file created

### Procedure 2: Manual Command Test

**Purpose**: Verify hook commands work when run manually

**Steps**:
1. **Test SessionStart command manually**:
   ```bash
   bash -c "echo '[SessionStart] Starting...' >> /tmp/manual-test.log 2>&1; SESSION_DIR=.sdlc/logs/session-$(date +%Y%m%d-%H%M%S) && echo '[SessionStart] Creating: $SESSION_DIR' >> /tmp/manual-test.log 2>&1; mkdir -p $SESSION_DIR 2>>/tmp/manual-test.log && echo '[SessionStart] Directory created' >> /tmp/manual-test.log 2>&1"
   ```

2. **Check results**:
   ```bash
   cat /tmp/manual-test.log
   ls -la .sdlc/logs/session-$(date +%Y%m%d)*
   ```

**Expected Results**:
- Manual execution should work perfectly
- This confirms the commands themselves are valid

### Procedure 3: Environment Variable Test

**Purpose**: Check if Claude provides hook environment variables

**Steps**:
1. **Create minimal environment test hook**:
   ```json
   {
     "TestEnv": [
       {
         "description": "Log all environment variables",
         "type": "command",
         "command": "env > /tmp/claude-hook-env-dump.txt 2>&1"
       }
     ]
   }
   ```

2. **Add to hooks.json temporarily and test**

3. **Check results**:
   ```bash
   cat /tmp/claude-hook-env-dump.txt | grep CLAUDE
   ```

**Expected Results**:
- **If hooks work**: File contains CLAUDE_* environment variables
- **If hooks don't work**: File not created or no CLAUDE_* variables

### Procedure 4: Permissions and Path Test

**Purpose**: Verify filesystem access from hooks

**Steps**:
1. **Test write permissions**:
   ```bash
   # Create test hook that writes to various locations
   echo 'test' > /tmp/claude-hook-perm-test.txt
   echo 'test' > .sdlc/logs/claude-hook-perm-test.txt
   ```

2. **Check current working directory from hooks**:
   - Add `pwd > /tmp/claude-hook-pwd.txt` to a hook command

**Expected Results**:
- Identify if hooks run from correct directory
- Confirm write permissions to target locations

---

## Quick Diagnostic Commands

Run these immediately to establish current state:

```bash
# 1. Verify hook configuration
.claude/scripts/verify-hooks.sh

# 2. Check for any hook activity
find /tmp -name "*claude-hook*" -ls
find .sdlc/logs -name "*.log" -exec ls -la {} \; 2>/dev/null

# 3. Test manual hook command execution
mkdir -p .sdlc/logs/test-manual
echo "Manual test at $(date)" > .sdlc/logs/test-manual/manual-test.log

# 4. Check Claude Code configuration (if accessible)
# Look for hooks enablement in Claude Code settings
```

---

## Fix Recommendations

### If Hooks Are Disabled in Claude Code:

1. **Check Claude Code Settings**:
   - Look for "Hooks" or "Extensions" settings
   - Enable hook system if available
   - Restart Claude Code if needed

2. **Verify Claude Code Version**:
   - Ensure using a version that supports hooks
   - Check documentation for hook feature availability

### If Hooks Are Enabled But Failing:

1. **Add Comprehensive Error Logging**:
   ```bash
   # Modify all hook commands to include:
   exec 2>> /tmp/claude-hook-errors.log
   ```

2. **Simplify Hook Commands**:
   - Start with minimal commands that just create files
   - Gradually add complexity once basic execution works

3. **Use Absolute Paths**:
   - Replace relative paths with absolute paths
   - Use `$(pwd)` to ensure correct working directory

### Environment Variable Issues:

1. **Document Available Variables**:
   - Use environment dump hook to see what's actually available
   - Create mapping of expected vs actual variables

2. **Use Fallback Values**:
   - Provide default values for missing variables
   - Use alternative identification methods

---

## Success Criteria

**Hooks are working when**:
- ✅ Debug log file shows hook execution timestamps
- ✅ Session folders contain expected log files
- ✅ User prompts appear in `console.log`
- ✅ Tool usage appears in `tools.log`
- ✅ Environment variables are available and logged

**Hooks are not working when**:
- ❌ No debug log files created
- ❌ Session folders remain empty
- ❌ No evidence of hook command execution

---

## Next Steps

1. **Run Procedure 1** with debug hooks configuration
2. **Based on results**, implement appropriate fixes
3. **Iterate testing** until hooks execute properly
4. **Document final working configuration**
5. **Create monitoring** to detect future hook failures

The key insight is that **our hooks configuration is correct** - the issue is likely that Claude Code's hook system is not enabled or not available in the current environment.