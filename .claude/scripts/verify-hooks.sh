#!/bin/bash
# Hook verification test script
# Tests whether Claude Code hooks are executing properly

set -e

echo "=== Claude Code Hook Verification Test ==="
echo "Timestamp: $(date)"
echo "Working Directory: $(pwd)"
echo

# Check if hooks.json exists
echo "1. Checking hooks configuration..."
if [ -f ".claude/hooks.json" ]; then
    echo "✅ hooks.json found"
    # Count number of hooks configured
    if command -v jq >/dev/null 2>&1; then
        HOOK_COUNT=$(cat .claude/hooks.json | jq '.hooks | keys | length')
        echo "   Configured hooks: $HOOK_COUNT"
        echo "   Hook types: $(cat .claude/hooks.json | jq -r '.hooks | keys | join(", ")')"
    fi
else
    echo "❌ hooks.json missing"
    exit 1
fi

# Check session directory structure
echo
echo "2. Checking session directory structure..."
mkdir -p .sdlc/logs
echo "   Base log directory: $(ls -la .sdlc/logs/ | wc -l) items"

echo "   Current session tracking files:"
if ls .sdlc/logs/current-session* 2>/dev/null; then
    echo "   ✅ Current session files found"
    for file in .sdlc/logs/current-session*; do
        echo "      $(basename $file): $(cat $file 2>/dev/null || echo 'ERROR READING')"
    done
else
    echo "   ❌ No current session tracking files found"
fi

echo
echo "   Recent session directories:"
SESSION_DIRS=$(ls -1t .sdlc/logs/session-* 2>/dev/null | head -3)
if [ -n "$SESSION_DIRS" ]; then
    echo "$SESSION_DIRS" | while read dir; do
        echo "   - $dir ($(ls -1 $dir 2>/dev/null | wc -l) files)"
    done
else
    echo "   ❌ No session directories found"
fi

# Find most recent session for detailed analysis
LATEST_SESSION=$(ls -1t .sdlc/logs/session-* 2>/dev/null | head -1)

echo
echo "3. Detailed analysis of most recent session..."
if [ -n "$LATEST_SESSION" ] && [ -d "$LATEST_SESSION" ]; then
    echo "   Analyzing: $LATEST_SESSION"
    echo "   Directory contents:"
    ls -la "$LATEST_SESSION/" | sed 's/^/      /'

    # Check for expected files
    echo
    echo "4. Checking for expected log files..."

    # Console log (from UserPromptSubmit, Stop hooks)
    if [ -f "$LATEST_SESSION/console.log" ]; then
        LINE_COUNT=$(wc -l < "$LATEST_SESSION/console.log")
        echo "   ✅ console.log found ($LINE_COUNT lines)"
        if [ $LINE_COUNT -gt 0 ]; then
            echo "      Recent entries:"
            tail -3 "$LATEST_SESSION/console.log" | sed 's/^/         /'
        fi
    else
        echo "   ❌ console.log missing (UserPromptSubmit/Stop hooks not working)"
    fi

    # Tools log (from PreToolUse, PostToolUse hooks)
    if [ -f "$LATEST_SESSION/tools.log" ]; then
        LINE_COUNT=$(wc -l < "$LATEST_SESSION/tools.log")
        echo "   ✅ tools.log found ($LINE_COUNT lines)"
        if [ $LINE_COUNT -gt 0 ]; then
            echo "      Recent entries:"
            tail -3 "$LATEST_SESSION/tools.log" | sed 's/^/         /'
        fi
    else
        echo "   ❌ tools.log missing (PreToolUse/PostToolUse hooks not working)"
    fi

    # Session metadata (from SessionStart hook)
    if [ -f "$LATEST_SESSION/session-metadata.json" ]; then
        echo "   ✅ session-metadata.json found"
        if command -v jq >/dev/null 2>&1; then
            echo "      Content validation:"
            if jq . "$LATEST_SESSION/session-metadata.json" >/dev/null 2>&1; then
                echo "         ✅ Valid JSON"
                echo "         Content preview:"
                jq . "$LATEST_SESSION/session-metadata.json" | head -5 | sed 's/^/            /'
            else
                echo "         ❌ Invalid JSON"
            fi
        else
            echo "      Content (jq not available):"
            cat "$LATEST_SESSION/session-metadata.json" | sed 's/^/         /'
        fi
    else
        echo "   ❌ session-metadata.json missing (SessionStart hook not working)"
    fi

    # Agent tracking (from SessionStart, PreToolUse, SubagentStop hooks)
    if [ -f "$LATEST_SESSION/agent-tracking.log" ]; then
        LINE_COUNT=$(wc -l < "$LATEST_SESSION/agent-tracking.log")
        echo "   ✅ agent-tracking.log found ($LINE_COUNT lines)"
        if [ $LINE_COUNT -gt 0 ]; then
            echo "      Recent entries:"
            tail -3 "$LATEST_SESSION/agent-tracking.log" | sed 's/^/         /'
        fi
    else
        echo "   ❌ agent-tracking.log missing (Agent tracking hooks not working)"
    fi

    # Compaction state (from PreCompact hook)
    if [ -f "$LATEST_SESSION/compaction-state.json" ]; then
        echo "   ✅ compaction-state.json found"
    else
        echo "   ⚠️  compaction-state.json missing (PreCompact hook not triggered yet)"
    fi

else
    echo "   ❌ No valid session directories found"
fi

echo
echo "5. Agent tracking system status..."
if [ -f ".sdlc/logs/active-agents.json" ]; then
    echo "   ✅ active-agents.json found"
    if command -v jq >/dev/null 2>&1; then
        AGENT_COUNT=$(jq '.active | length' .sdlc/logs/active-agents.json 2>/dev/null || echo "ERROR")
        echo "      Active agents: $AGENT_COUNT"
        echo "      Agent list:"
        jq '.active[]' .sdlc/logs/active-agents.json 2>/dev/null | sed 's/^/         /' || echo "         Error reading agent data"
    else
        echo "      Content:"
        cat .sdlc/logs/active-agents.json | sed 's/^/         /'
    fi
else
    echo "   ❌ active-agents.json missing"
fi

if [ -f ".sdlc/logs/agent-tracker.log" ]; then
    LINE_COUNT=$(wc -l < ".sdlc/logs/agent-tracker.log")
    echo "   ✅ agent-tracker.log found ($LINE_COUNT lines)"
    if [ $LINE_COUNT -gt 0 ]; then
        echo "      Recent entries:"
        tail -3 ".sdlc/logs/agent-tracker.log" | sed 's/^/         /'
    fi
else
    echo "   ❌ agent-tracker.log missing"
fi

echo
echo "6. Hook dependency check..."

# Check if agent-tracker script is executable
if [ -x ".claude/scripts/agent-tracker.sh" ]; then
    echo "   ✅ agent-tracker.sh is executable"
    # Test the script
    if .claude/scripts/agent-tracker.sh count >/dev/null 2>&1; then
        CURRENT_COUNT=$(.claude/scripts/agent-tracker.sh count)
        echo "      Agent count function works: $CURRENT_COUNT"
    else
        echo "      ❌ agent-tracker.sh count function failed"
    fi
else
    echo "   ❌ agent-tracker.sh missing or not executable"
fi

# Check for required tools
echo "   Tool availability:"
command -v jq >/dev/null 2>&1 && echo "      ✅ jq available" || echo "      ⚠️  jq not available (will use fallback methods)"
command -v date >/dev/null 2>&1 && echo "      ✅ date available" || echo "      ❌ date not available"

echo
echo "7. Environment variable test preparation..."

# Create environment test hook for debugging
cat > .claude/scripts/test-hook-env.sh << 'EOF'
#!/bin/bash
echo "=== Hook Environment Test ===" >> /tmp/claude-hook-env-test.log
echo "Timestamp: $(date)" >> /tmp/claude-hook-env-test.log
echo "PWD: $(pwd)" >> /tmp/claude-hook-env-test.log
echo "CLAUDE_SESSION_ID: ${CLAUDE_SESSION_ID:-'NOT SET'}" >> /tmp/claude-hook-env-test.log
echo "CLAUDE_MODEL: ${CLAUDE_MODEL:-'NOT SET'}" >> /tmp/claude-hook-env-test.log
echo "CLAUDE_CWD: ${CLAUDE_CWD:-'NOT SET'}" >> /tmp/claude-hook-env-test.log
echo "CLAUDE_USER_PROMPT: ${CLAUDE_USER_PROMPT:-'NOT SET'}" >> /tmp/claude-hook-env-test.log
echo "CLAUDE_TOOL_NAME: ${CLAUDE_TOOL_NAME:-'NOT SET'}" >> /tmp/claude-hook-env-test.log
echo "CLAUDE_TOOL_INPUT: ${CLAUDE_TOOL_INPUT:-'NOT SET'}" >> /tmp/claude-hook-env-test.log
echo "CLAUDE_TOOL_OUTPUT: ${CLAUDE_TOOL_OUTPUT:-'NOT SET'}" >> /tmp/claude-hook-env-test.log
echo "All CLAUDE_* variables:" >> /tmp/claude-hook-env-test.log
env | grep CLAUDE >> /tmp/claude-hook-env-test.log 2>&1 || echo "No CLAUDE_* variables found" >> /tmp/claude-hook-env-test.log
echo "===========================" >> /tmp/claude-hook-env-test.log
echo "" >> /tmp/claude-hook-env-test.log
EOF

chmod +x .claude/scripts/test-hook-env.sh
echo "   ✅ Environment test script created at .claude/scripts/test-hook-env.sh"
echo "      This script will log hook environment variables to /tmp/claude-hook-env-test.log"

# Check if previous environment tests have run
if [ -f "/tmp/claude-hook-env-test.log" ]; then
    echo "   ✅ Previous environment test results found:"
    echo "      $(wc -l < /tmp/claude-hook-env-test.log) lines logged"
    echo "      Recent entries:"
    tail -5 /tmp/claude-hook-env-test.log | sed 's/^/         /'
else
    echo "   ⚠️  No previous environment test results (hooks may not be running)"
fi

echo
echo "=== Test Summary ==="

# Count issues found
ISSUES=0

# Check major indicators
[ ! -f ".claude/hooks.json" ] && ISSUES=$((ISSUES + 1))
[ ! -f ".sdlc/logs/current-session.txt" ] && ISSUES=$((ISSUES + 1))
[ -z "$LATEST_SESSION" ] && ISSUES=$((ISSUES + 1))
[ -n "$LATEST_SESSION" ] && [ ! -f "$LATEST_SESSION/session-metadata.json" ] && ISSUES=$((ISSUES + 1))
[ -n "$LATEST_SESSION" ] && [ ! -f "$LATEST_SESSION/console.log" ] && ISSUES=$((ISSUES + 1))

echo "Issues detected: $ISSUES"

if [ $ISSUES -eq 0 ]; then
    echo "🎉 All basic hook indicators are present!"
    echo "   Hooks appear to be working correctly."
else
    echo "⚠️  $ISSUES issues detected. Hooks may not be working properly."
    echo
    echo "Common causes:"
    echo "1. Claude Code hooks feature is not enabled"
    echo "2. Hook commands are failing silently"
    echo "3. Environment variables are not available to hooks"
    echo "4. File system permissions issues"
    echo
    echo "Next steps:"
    echo "1. Check Claude Code settings for hooks enablement"
    echo "2. Verify environment variables with: cat /tmp/claude-hook-env-test.log"
    echo "3. Test hooks manually by triggering them"
    echo "4. Add error output redirection to hook commands for debugging"
fi

echo
echo "=== Test Complete ==="
echo "For detailed analysis, see: .sdlc/testing/hook-test-strategy.md"