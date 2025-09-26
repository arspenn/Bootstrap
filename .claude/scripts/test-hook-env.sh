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
