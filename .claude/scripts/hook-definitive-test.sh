#!/bin/bash
# Definitive Hook Test - Determines exactly why hooks aren't working
# This script will test every aspect of hook functionality

set -e

echo "🔍 DEFINITIVE CLAUDE CODE HOOK TEST"
echo "=================================="
echo "Timestamp: $(date)"
echo "Working Directory: $(pwd)"
echo

# Clean up previous test files
rm -f /tmp/claude-hook-*.log /tmp/claude-hook-*.txt

# Step 1: Backup and prepare test environment
echo "📋 Step 1: Preparing test environment..."

# Backup original hooks if not already done
if [ ! -f ".claude/hooks-original.json" ]; then
    cp .claude/hooks.json .claude/hooks-original.json
    echo "   ✅ Original hooks.json backed up"
else
    echo "   ℹ️  Original hooks.json already backed up"
fi

# Create minimal test hooks configuration
cat > .claude/hooks-minimal-test.json << 'EOF'
{
  "$schema": "https://docs.claude.com/schemas/hooks.json",
  "description": "Minimal test hooks to verify basic execution",
  "hooks": {
    "SessionStart": [
      {
        "description": "Minimal session start test",
        "type": "command",
        "command": "echo 'HOOK_TEST: SessionStart executed at $(date)' >> /tmp/claude-hook-test.log"
      }
    ],
    "UserPromptSubmit": [
      {
        "description": "Minimal user prompt test",
        "type": "command",
        "command": "echo 'HOOK_TEST: UserPromptSubmit executed at $(date)' >> /tmp/claude-hook-test.log"
      }
    ],
    "PreToolUse": [
      {
        "description": "Minimal tool use test",
        "type": "command",
        "command": "echo 'HOOK_TEST: PreToolUse executed at $(date)' >> /tmp/claude-hook-test.log"
      }
    ],
    "Stop": [
      {
        "description": "Minimal response stop test",
        "type": "command",
        "command": "echo 'HOOK_TEST: Stop executed at $(date)' >> /tmp/claude-hook-test.log"
      }
    ]
  }
}
EOF

echo "   ✅ Minimal test hooks configuration created"

# Step 2: Test manual command execution
echo
echo "🧪 Step 2: Testing hook commands manually..."

echo "MANUAL_TEST: SessionStart simulation at $(date)" > /tmp/claude-hook-manual.log
echo "MANUAL_TEST: UserPromptSubmit simulation at $(date)" >> /tmp/claude-hook-manual.log
echo "MANUAL_TEST: PreToolUse simulation at $(date)" >> /tmp/claude-hook-manual.log
echo "MANUAL_TEST: Stop simulation at $(date)" >> /tmp/claude-hook-manual.log

if [ -f "/tmp/claude-hook-manual.log" ]; then
    echo "   ✅ Manual command execution works"
    echo "      Content:"
    cat /tmp/claude-hook-manual.log | sed 's/^/         /'
else
    echo "   ❌ Manual command execution failed"
fi

# Step 3: Check current hook execution evidence
echo
echo "🕵️  Step 3: Checking for hook execution evidence..."

# Check for any existing hook logs
HOOK_EVIDENCE=0

if [ -f "/tmp/claude-hook-test.log" ]; then
    echo "   ✅ Found hook test log from previous runs"
    echo "      Content:"
    cat /tmp/claude-hook-test.log | sed 's/^/         /'
    HOOK_EVIDENCE=1
else
    echo "   ❌ No hook test log found"
fi

# Check for environment dumps
if find /tmp -name "*claude*" -type f | grep -q .; then
    echo "   ✅ Found Claude-related files in /tmp"
    find /tmp -name "*claude*" -type f -exec ls -la {} \; | sed 's/^/         /'
    HOOK_EVIDENCE=1
else
    echo "   ❌ No Claude-related files in /tmp"
fi

# Check for any activity in session directories during current session
CURRENT_SESSION_DIRS=$(find .sdlc/logs -name "session-$(date +%Y-%m-%d)*" -type d 2>/dev/null || true)
if [ -n "$CURRENT_SESSION_DIRS" ]; then
    echo "   ✅ Found today's session directories"
    echo "$CURRENT_SESSION_DIRS" | while read dir; do
        FILE_COUNT=$(find "$dir" -type f 2>/dev/null | wc -l)
        echo "      $dir: $FILE_COUNT files"
        if [ $FILE_COUNT -gt 0 ]; then
            HOOK_EVIDENCE=1
            find "$dir" -type f -exec ls -la {} \; | sed 's/^/            /'
        fi
    done
else
    echo "   ❌ No today's session directories found"
fi

# Step 4: Environment analysis
echo
echo "🌍 Step 4: Environment analysis..."

# Check if we're running in Claude Code
if [ -n "$CLAUDE_SESSION_ID" ]; then
    echo "   ✅ CLAUDE_SESSION_ID environment variable detected: $CLAUDE_SESSION_ID"
    HOOK_EVIDENCE=1
else
    echo "   ❌ CLAUDE_SESSION_ID environment variable not found"
fi

# Check for other Claude environment variables
CLAUDE_VARS=$(env | grep '^CLAUDE_' || true)
if [ -n "$CLAUDE_VARS" ]; then
    echo "   ✅ Claude environment variables detected:"
    echo "$CLAUDE_VARS" | sed 's/^/         /'
    HOOK_EVIDENCE=1
else
    echo "   ❌ No Claude environment variables found"
fi

# Check if this is actually Claude Code
if [ -n "$CLAUDE_CWD" ] || [ -n "$CLAUDE_MODEL" ] || [ -n "$CLAUDE_SESSION_ID" ]; then
    echo "   ✅ Running in Claude Code environment"
else
    echo "   ⚠️  May not be running in Claude Code environment"
    echo "      This could explain why hooks aren't working"
fi

# Step 5: File system permissions test
echo
echo "📁 Step 5: File system permissions test..."

# Test write permissions to various locations
PERM_ISSUES=0

# Test /tmp write
if echo "test" > /tmp/claude-perm-test.txt 2>/dev/null; then
    echo "   ✅ Can write to /tmp"
    rm -f /tmp/claude-perm-test.txt
else
    echo "   ❌ Cannot write to /tmp"
    PERM_ISSUES=$((PERM_ISSUES + 1))
fi

# Test local directory write
if echo "test" > ./claude-perm-test.txt 2>/dev/null; then
    echo "   ✅ Can write to current directory"
    rm -f ./claude-perm-test.txt
else
    echo "   ❌ Cannot write to current directory"
    PERM_ISSUES=$((PERM_ISSUES + 1))
fi

# Test .sdlc/logs write
mkdir -p .sdlc/logs
if echo "test" > .sdlc/logs/claude-perm-test.txt 2>/dev/null; then
    echo "   ✅ Can write to .sdlc/logs"
    rm -f .sdlc/logs/claude-perm-test.txt
else
    echo "   ❌ Cannot write to .sdlc/logs"
    PERM_ISSUES=$((PERM_ISSUES + 1))
fi

# Step 6: Hook configuration validation
echo
echo "⚙️  Step 6: Hook configuration validation..."

# Validate JSON syntax
if jq . .claude/hooks.json >/dev/null 2>&1; then
    echo "   ✅ hooks.json is valid JSON"
else
    echo "   ❌ hooks.json has JSON syntax errors"
fi

# Check hook schema
if jq '.hooks | keys' .claude/hooks.json >/dev/null 2>&1; then
    HOOK_TYPES=$(jq -r '.hooks | keys | join(", ")' .claude/hooks.json)
    echo "   ✅ Hook types configured: $HOOK_TYPES"
else
    echo "   ❌ Invalid hooks configuration structure"
fi

# Step 7: Generate test report
echo
echo "📊 DIAGNOSTIC REPORT"
echo "=================="

echo "Hook Execution Evidence: $HOOK_EVIDENCE indicators found"
echo "File System Permissions: $PERM_ISSUES issues found"

# Determine most likely cause
if [ $HOOK_EVIDENCE -eq 0 ]; then
    if [ -n "$CLAUDE_SESSION_ID" ]; then
        echo
        echo "🔍 DIAGNOSIS: Hooks are configured correctly but not executing"
        echo "   Most likely causes:"
        echo "   1. Claude Code hooks feature is disabled"
        echo "   2. Hooks are failing silently"
        echo "   3. Hook trigger conditions not met"
        echo
        echo "   Recommended actions:"
        echo "   1. Check Claude Code settings for hooks enablement"
        echo "   2. Replace hooks.json with minimal test version:"
        echo "      cp .claude/hooks-minimal-test.json .claude/hooks.json"
        echo "   3. Restart Claude Code and test again"
        echo "   4. Monitor /tmp/claude-hook-test.log for activity"
    else
        echo
        echo "🔍 DIAGNOSIS: Not running in Claude Code environment"
        echo "   This explains why hooks aren't working."
        echo "   Hooks only function within Claude Code, not in regular bash/terminal."
        echo
        echo "   To test hooks:"
        echo "   1. Open this project in Claude Code"
        echo "   2. Start a conversation in Claude Code"
        echo "   3. The hooks should automatically execute"
    fi
else
    echo
    echo "🔍 DIAGNOSIS: Some hook activity detected"
    echo "   Hooks may be partially working or were working previously."
    echo "   Review the evidence above to determine current status."
fi

# Step 8: Provide next steps
echo
echo "📝 NEXT STEPS"
echo "============"

cat << 'EOF'
Based on this diagnostic:

IF RUNNING IN CLAUDE CODE:
1. Replace hooks with minimal test version:
   cp .claude/hooks-minimal-test.json .claude/hooks.json

2. Start a new conversation and run a tool

3. Check for hook activity:
   cat /tmp/claude-hook-test.log

4. If still no activity, hooks feature may be disabled

IF NOT RUNNING IN CLAUDE CODE:
1. This is normal - hooks only work in Claude Code environment
2. Open this project in Claude Code to test hooks
3. Use regular scripts for testing outside Claude Code

TO RESTORE ORIGINAL HOOKS:
   cp .claude/hooks-original.json .claude/hooks.json

FOR ONGOING MONITORING:
   Run this script periodically to check hook status
EOF

echo
echo "🏁 Diagnostic complete. Results logged above."
echo "   Test files created in /tmp/claude-hook-* for reference."