#!/bin/sh
# Agent Tracker - Manages active agent count for 3-agent limit enforcement
# Used by hooks.json to track Task tool invocations

TRACKER_FILE=".sdlc/logs/active-agents.json"
TRACKER_DIR=".sdlc/logs"

# Ensure tracker directory exists
mkdir -p "$TRACKER_DIR"

# Initialize tracker file if it doesn't exist
init_tracker() {
    if [ ! -f "$TRACKER_FILE" ]; then
        echo '{"max_agents": 3, "active": []}' > "$TRACKER_FILE"
    fi
}

# Add an agent to tracking
register_agent() {
    agent_name="$1"
    agent_type="$2"
    timestamp=$(date -Iseconds)

    init_tracker

    # Read current state
    current=$(cat "$TRACKER_FILE")

    # Add new agent (using jq if available, fallback to simple append)
    if command -v jq >/dev/null 2>&1; then
        echo "$current" | jq \
            --arg name "$agent_name" \
            --arg type "$agent_type" \
            --arg time "$timestamp" \
            '.active += [{"name": $name, "type": $type, "started": $time}]' > "$TRACKER_FILE"
    else
        # Fallback without jq - basic append
        echo "[AGENT_TRACKER] Registered: $agent_name ($agent_type) at $timestamp" >> "$TRACKER_DIR/agent-tracker.log"
    fi
}

# Remove an agent from tracking
deregister_agent() {
    agent_name="$1"

    init_tracker

    # Read current state
    current=$(cat "$TRACKER_FILE")

    # Remove agent (using jq if available)
    if command -v jq >/dev/null 2>&1; then
        echo "$current" | jq \
            --arg name "$agent_name" \
            '.active = [.active[] | select(.name != $name)]' > "$TRACKER_FILE"
    else
        # Fallback without jq - log removal
        echo "[AGENT_TRACKER] Deregistered: $agent_name at $(date -Iseconds)" >> "$TRACKER_DIR/agent-tracker.log"
    fi
}

# Get current agent count
count_agents() {
    init_tracker

    if command -v jq >/dev/null 2>&1; then
        count=$(cat "$TRACKER_FILE" | jq '.active | length')
        echo "$count"
    else
        # Fallback: always return 1 (conservative)
        echo "1"
    fi
}

# Check if we can launch another agent
can_launch() {
    current_count=$(count_agents)
    max_agents=3

    if [ "$current_count" -lt "$max_agents" ]; then
        echo "true"
    else
        echo "false"
    fi
}

# Clear all agents (for recovery/reset)
clear_all() {
    echo '{"max_agents": 3, "active": []}' > "$TRACKER_FILE"
    echo "[AGENT_TRACKER] Cleared all agents at $(date -Iseconds)" >> "$TRACKER_DIR/agent-tracker.log"
}

# List active agents
list_agents() {
    init_tracker

    if command -v jq >/dev/null 2>&1; then
        cat "$TRACKER_FILE" | jq '.active'
    else
        cat "$TRACKER_FILE"
    fi
}

# Main command handler
case "$1" in
    register)
        register_agent "$2" "$3"
        ;;
    deregister)
        deregister_agent "$2"
        ;;
    count)
        count_agents
        ;;
    can-launch)
        can_launch
        ;;
    clear)
        clear_all
        ;;
    list)
        list_agents
        ;;
    *)
        echo "Usage: $0 {register|deregister|count|can-launch|clear|list} [agent_name] [agent_type]"
        echo ""
        echo "Commands:"
        echo "  register <name> <type>  - Register a new active agent"
        echo "  deregister <name>       - Remove an agent from tracking"
        echo "  count                   - Get current active agent count"
        echo "  can-launch              - Check if another agent can be launched"
        echo "  clear                   - Clear all agents (recovery)"
        echo "  list                    - List all active agents"
        exit 1
        ;;
esac