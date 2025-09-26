# Claude Code Hooks Test Strategy

## Executive Summary

Our hooks in `.claude/hooks.json` appear to not be executing properly. Session folders are being created but remain empty, indicating either:
1. Hooks aren't triggering at all
2. Hook commands are failing silently
3. Environment variables (`$CLAUDE_SESSION_ID`, etc.) are unavailable
4. Claude Code hooks system is not active

## Test Plan Overview

This strategy provides systematic verification of each hook type with observable outputs, specific triggers, and clear success/failure criteria.

---

## Hook-by-Hook Test Plan

### 1. SessionStart Hook

**Purpose**: Creates session folder and metadata on conversation start

**Expected Behavior**:
- Creates session folder: `.sdlc/logs/session-YYYYMMDD-HHMMSS/`
- Creates `current-session.txt` with session ID
- Creates `current-session-dir.txt` with session path
- Creates `session-metadata.json` with session details
- Registers executor agent and clears stale tracking
- Creates `agent-tracking.log`

**Test Trigger**: Start a new conversation in Claude Code

**Verification Steps**:
```bash
# Check for session folder creation
ls -la .sdlc/logs/session-$(date +%Y%m%d)*

# Check for tracking files
ls -la .sdlc/logs/current-session*

# Check metadata file exists and has content
find .sdlc/logs -name "session-metadata.json" -exec cat {} \;

# Check agent tracking
ls -la .sdlc/logs/active-agents.json
cat .sdlc/logs/agent-tracker.log
```

**Success Indicators**:
- ✅ New timestamped session folder exists
- ✅ `current-session.txt` contains session ID
- ✅ `current-session-dir.txt` contains session path
- ✅ `session-metadata.json` contains valid JSON with session_id, started timestamp, model, cwd
- ✅ `agent-tracking.log` shows executor registration

**Failure Indicators**:
- ❌ No session folder created
- ❌ Session folder exists but is empty
- ❌ Tracking files missing
- ❌ JSON files malformed or empty

---

### 2. UserPromptSubmit Hook

**Purpose**: Logs all user inputs to console.log

**Expected Behavior**:
- Appends timestamp and user prompt to `{session-dir}/console.log`
- User input is indented with 2 spaces

**Test Trigger**: Submit any user prompt

**Verification Steps**:
```bash
# Find current session directory
SESSION_DIR=$(cat .sdlc/logs/current-session-dir.txt 2>/dev/null)
echo "Session dir: $SESSION_DIR"

# Check console.log for user prompts
ls -la "$SESSION_DIR/console.log"
cat "$SESSION_DIR/console.log" | grep "USER:"
```

**Success Indicators**:
- ✅ `console.log` exists in session directory
- ✅ Contains `[timestamp] USER:` entries
- ✅ User prompts are logged with proper indentation

**Failure Indicators**:
- ❌ `console.log` missing
- ❌ No USER entries in log
- ❌ Malformed entries or missing timestamps

---

### 3. PreToolUse Hook

**Purpose**: Logs tool invocations with parameters and tracks agent usage

**Expected Behavior**:
- Logs tool name and input to `{session-dir}/tools.log`
- For Task tools: registers agent and checks 3-agent limit
- Updates agent tracking logs

**Test Trigger**: Use any Claude Code tool (Read, Write, Bash, etc.)

**Verification Steps**:
```bash
# Check tools.log for tool usage
SESSION_DIR=$(cat .sdlc/logs/current-session-dir.txt 2>/dev/null)
ls -la "$SESSION_DIR/tools.log"
cat "$SESSION_DIR/tools.log" | grep "TOOL:"

# For Task tool specifically, check agent tracking
cat "$SESSION_DIR/agent-tracking.log" | grep "AGENT_TRACKING:"
```

**Success Indicators**:
- ✅ `tools.log` exists and contains TOOL entries
- ✅ Tool parameters are logged (JSON formatted)
- ✅ Task tools trigger agent registration
- ✅ Agent count tracking works

**Failure Indicators**:
- ❌ `tools.log` missing or empty
- ❌ No TOOL entries
- ❌ Task tools don't trigger agent tracking

---

### 4. PostToolUse Hook

**Purpose**: Logs tool execution results

**Expected Behavior**:
- Logs completion message for each tool
- Includes first 100 lines of output if available

**Test Trigger**: Complete any tool execution

**Verification Steps**:
```bash
# Check for completion messages
SESSION_DIR=$(cat .sdlc/logs/current-session-dir.txt 2>/dev/null)
cat "$SESSION_DIR/tools.log" | grep "RESULT:"
```

**Success Indicators**:
- ✅ RESULT entries for each tool execution
- ✅ Tool output included (truncated to 100 lines)

**Failure Indicators**:
- ❌ No RESULT entries
- ❌ Missing tool output

---

### 5. Stop Hook

**Purpose**: Logs when Claude finishes responding

**Expected Behavior**:
- Adds completion timestamp to console.log

**Test Trigger**: Complete any Claude response

**Verification Steps**:
```bash
SESSION_DIR=$(cat .sdlc/logs/current-session-dir.txt 2>/dev/null)
cat "$SESSION_DIR/console.log" | grep "CLAUDE: Response completed"
```

**Success Indicators**:
- ✅ Response completion logged with timestamp

**Failure Indicators**:
- ❌ No completion messages in console.log

---

## Comprehensive Test Script

Create a test script that systematically verifies all hooks:

```bash
#!/bin/bash
# Hook verification test script

echo "=== Claude Code Hook Verification Test ==="
echo "Timestamp: $(date)"
echo

# Check if hooks.json exists
echo "1. Checking hooks configuration..."
if [ -f ".claude/hooks.json" ]; then
    echo "✅ hooks.json found"
else
    echo "❌ hooks.json missing"
    exit 1
fi

# Check session directory structure
echo "2. Checking session structure..."
echo "Current session files:"
ls -la .sdlc/logs/current-session* 2>/dev/null || echo "❌ No current session files"

echo "Recent session directories:"
ls -la .sdlc/logs/session-* 2>/dev/null | tail -5

# Find most recent session
LATEST_SESSION=$(ls -1t .sdlc/logs/session-* 2>/dev/null | head -1)
echo "Latest session: $LATEST_SESSION"

if [ -n "$LATEST_SESSION" ]; then
    echo "3. Examining session contents..."
    ls -la "$LATEST_SESSION/"

    # Check for expected files
    echo "4. Checking for expected log files..."

    # Console log
    if [ -f "$LATEST_SESSION/console.log" ]; then
        echo "✅ console.log found"
        echo "  Entries: $(wc -l < "$LATEST_SESSION/console.log")"
        echo "  Sample:"
        head -3 "$LATEST_SESSION/console.log" | sed 's/^/    /'
    else
        echo "❌ console.log missing"
    fi

    # Tools log
    if [ -f "$LATEST_SESSION/tools.log" ]; then
        echo "✅ tools.log found"
        echo "  Entries: $(wc -l < "$LATEST_SESSION/tools.log")"
    else
        echo "❌ tools.log missing"
    fi

    # Session metadata
    if [ -f "$LATEST_SESSION/session-metadata.json" ]; then
        echo "✅ session-metadata.json found"
        if command -v jq >/dev/null 2>&1; then
            echo "  Content:"
            cat "$LATEST_SESSION/session-metadata.json" | jq . | sed 's/^/    /'
        else
            cat "$LATEST_SESSION/session-metadata.json" | sed 's/^/    /'
        fi
    else
        echo "❌ session-metadata.json missing"
    fi

    # Agent tracking
    if [ -f "$LATEST_SESSION/agent-tracking.log" ]; then
        echo "✅ agent-tracking.log found"
        echo "  Entries: $(wc -l < "$LATEST_SESSION/agent-tracking.log")"
    else
        echo "❌ agent-tracking.log missing"
    fi
else
    echo "❌ No session directories found"
fi

echo
echo "5. Testing hook environment variables..."

# Create a simple test script to check environment
cat > .claude/scripts/test-hook-env.sh << 'EOF'
#!/bin/bash
echo "=== Hook Environment Test ==="
echo "CLAUDE_SESSION_ID: ${CLAUDE_SESSION_ID:-'NOT SET'}"
echo "CLAUDE_MODEL: ${CLAUDE_MODEL:-'NOT SET'}"
echo "CLAUDE_CWD: ${CLAUDE_CWD:-'NOT SET'}"
echo "CLAUDE_USER_PROMPT: ${CLAUDE_USER_PROMPT:-'NOT SET'}"
echo "CLAUDE_TOOL_NAME: ${CLAUDE_TOOL_NAME:-'NOT SET'}"
echo "CLAUDE_TOOL_INPUT: ${CLAUDE_TOOL_INPUT:-'NOT SET'}"
echo "CLAUDE_TOOL_OUTPUT: ${CLAUDE_TOOL_OUTPUT:-'NOT SET'}"
echo "=========================="
EOF

chmod +x .claude/scripts/test-hook-env.sh

echo "Environment test script created at .claude/scripts/test-hook-env.sh"
echo

echo "=== Test Complete ==="
echo "Next steps:"
echo "1. Review the output above for missing files/logs"
echo "2. If hooks aren't working, check Claude Code configuration"
echo "3. Verify hooks are enabled in Claude Code settings"
echo "4. Check if environment variables are available during hook execution"
```

---

## Environment Variable Testing

Since the hooks depend heavily on Claude-provided environment variables, we need to test their availability:

**Critical Environment Variables**:
- `$CLAUDE_SESSION_ID` - Unique session identifier
- `$CLAUDE_MODEL` - Model being used
- `$CLAUDE_CWD` - Current working directory
- `$CLAUDE_USER_PROMPT` - User's input text
- `$CLAUDE_TOOL_NAME` - Name of tool being executed
- `$CLAUDE_TOOL_INPUT` - Tool parameters as JSON
- `$CLAUDE_TOOL_OUTPUT` - Tool execution results

**Test Method**: Create a simple hook that dumps all environment variables to a file:

```json
{
  "TestEnv": [
    {
      "description": "Test environment variable availability",
      "type": "command",
      "command": "env | grep CLAUDE > /tmp/claude-env-test.txt"
    }
  ]
}
```

---

## Failure Mode Analysis

**Scenario 1: No session folders created**
- **Cause**: SessionStart hook not triggering
- **Solution**: Check Claude Code hooks are enabled
- **Verification**: Add debug logging to hook commands

**Scenario 2: Session folders exist but are empty**
- **Cause**: Hook commands failing silently
- **Solution**: Add error output redirection to hook commands
- **Verification**: Check for error logs

**Scenario 3: Environment variables unavailable**
- **Cause**: Claude Code not providing expected variables
- **Solution**: Document actual available variables
- **Verification**: Create environment dump hook

**Scenario 4: Commands executing but files not created**
- **Cause**: Permission issues or path problems
- **Solution**: Use absolute paths and check permissions
- **Verification**: Add file creation verification

---

## Immediate Action Items

1. **Run the verification script** to establish current state
2. **Check Claude Code settings** for hooks enablement
3. **Test environment variables** availability
4. **Add error handling** to hook commands
5. **Create minimal test hooks** for debugging

This test strategy will definitively answer whether hooks are working and identify the specific failure points if they're not.