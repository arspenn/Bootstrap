#!/bin/sh
set -euo pipefail

# Script: init-structure.sh
# Purpose: Create the .sdlc/ directory structure for a Bootstrap project
# Usage: ./.claude/scripts/init-structure.sh
# Note: Called by AI agent during /init command

SDLC_DIR=".sdlc"

# Function to create directory with message
create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "✓ Created: $1"
    else
        echo "• Exists: $1"
    fi
}

echo "Initializing project SDLC structure..."

# Create project .sdlc structure
create_dir "${SDLC_DIR}"
create_dir "${SDLC_DIR}/requirements"     # For requirements documents
create_dir "${SDLC_DIR}/designs"          # For design documents
create_dir "${SDLC_DIR}/implementation"   # For DIPs (replaces PRPs)
create_dir "${SDLC_DIR}/amendments"       # For charter amendments
create_dir "${SDLC_DIR}/ADRs"            # Project-wide ADRs

echo "✓ Project SDLC structure initialized"