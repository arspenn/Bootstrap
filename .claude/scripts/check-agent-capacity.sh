#!/bin/sh
# Check if we have capacity to launch another agent
# Used by Executor before launching command leads or specialists

TRACKER_SCRIPT=".claude/scripts/agent-tracker.sh"

# Check if tracker exists
if [ ! -f "$TRACKER_SCRIPT" ]; then
    echo "ERROR: Agent tracker not found at $TRACKER_SCRIPT"
    exit 1
fi

# Get current count and check capacity
CURRENT_COUNT=$($TRACKER_SCRIPT count)
CAN_LAUNCH=$($TRACKER_SCRIPT can-launch)

# Report status
echo "Active agents: $CURRENT_COUNT/3"
echo "Can launch: $CAN_LAUNCH"

# Return appropriate exit code
if [ "$CAN_LAUNCH" = "true" ]; then
    exit 0  # Success - can launch
else
    echo "WARNING: At maximum agent capacity (3 agents)"

    # Show current agents for debugging
    echo "Current agents:"
    $TRACKER_SCRIPT list | jq -r '.[] | "  - \(.name) (\(.type))"' 2>/dev/null || $TRACKER_SCRIPT list

    exit 1  # Failure - at capacity
fi