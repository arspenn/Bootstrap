#!/bin/sh
set -euo pipefail

# Script: detect-stack.sh
# Purpose: Detect project technology stack
# Usage: ./.claude/scripts/detect-stack.sh
# Note: Called by AI agent during /init command

STACKS=""

echo "Detecting project stack..."

# Python detection
if [ -f "requirements.txt" ] || \
   [ -f "setup.py" ] || \
   [ -f "pyproject.toml" ] || \
   [ -f "Pipfile" ] || \
   [ -f "poetry.lock" ]; then
    STACKS="${STACKS}python "
    echo "✓ Python detected"

    # Check for specific Python frameworks
    if [ -f "pyproject.toml" ] && grep -q "django" "pyproject.toml" 2>/dev/null; then
        STACKS="${STACKS}django "
        echo "  └── Django framework"
    fi
    if [ -f "requirements.txt" ] && grep -q "fastapi" "requirements.txt" 2>/dev/null; then
        STACKS="${STACKS}fastapi "
        echo "  └── FastAPI framework"
    fi
fi

# Node.js/JavaScript detection
if [ -f "package.json" ]; then
    STACKS="${STACKS}nodejs "
    echo "✓ Node.js detected"

    # Check for specific frameworks
    if grep -q '"react"' "package.json" 2>/dev/null; then
        STACKS="${STACKS}react "
        echo "  └── React framework"
    fi
    if grep -q '"vue"' "package.json" 2>/dev/null; then
        STACKS="${STACKS}vue "
        echo "  └── Vue framework"
    fi
    if grep -q '"svelte"' "package.json" 2>/dev/null; then
        STACKS="${STACKS}svelte "
        echo "  └── Svelte framework"
    fi
    if grep -q '"@sveltejs/kit"' "package.json" 2>/dev/null; then
        STACKS="${STACKS}sveltekit "
        echo "  └── SvelteKit framework"
    fi
    if grep -q '"next"' "package.json" 2>/dev/null; then
        STACKS="${STACKS}nextjs "
        echo "  └── Next.js framework"
    fi
fi

# Rust detection
if [ -f "Cargo.toml" ]; then
    STACKS="${STACKS}rust "
    echo "✓ Rust detected"

    # Check for specific Rust frameworks
    if grep -q "actix-web" "Cargo.toml" 2>/dev/null; then
        STACKS="${STACKS}actix "
        echo "  └── Actix Web framework"
    fi
    if grep -q "rocket" "Cargo.toml" 2>/dev/null; then
        STACKS="${STACKS}rocket "
        echo "  └── Rocket framework"
    fi
    if grep -q "axum" "Cargo.toml" 2>/dev/null; then
        STACKS="${STACKS}axum "
        echo "  └── Axum framework"
    fi
fi

# Database detection
if [ -f "docker-compose.yml" ] || [ -f "docker-compose.yaml" ]; then
    # Check for SurrealDB
    if grep -q "surrealdb" "docker-compose.yml" "docker-compose.yaml" 2>/dev/null; then
        STACKS="${STACKS}surrealdb "
        echo "✓ SurrealDB detected"
    fi
    # Check for PostgreSQL
    if grep -q "postgres" "docker-compose.yml" "docker-compose.yaml" 2>/dev/null; then
        STACKS="${STACKS}postgresql "
        echo "✓ PostgreSQL detected"
    fi
fi

# Go detection
if [ -f "go.mod" ] || [ -f "go.sum" ]; then
    STACKS="${STACKS}go "
    echo "✓ Go detected"
fi

# Ruby detection
if [ -f "Gemfile" ] || [ -f "Rakefile" ]; then
    STACKS="${STACKS}ruby "
    echo "✓ Ruby detected"

    if [ -f "Gemfile" ] && grep -q "rails" "Gemfile" 2>/dev/null; then
        STACKS="${STACKS}rails "
        echo "  └── Rails framework"
    fi
fi

# Java/Maven detection
if [ -f "pom.xml" ]; then
    STACKS="${STACKS}java maven "
    echo "✓ Java/Maven detected"
fi

# Gradle detection (Java/Kotlin)
if [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then
    STACKS="${STACKS}gradle "
    echo "✓ Gradle detected"

    if [ -f "build.gradle.kts" ]; then
        STACKS="${STACKS}kotlin "
        echo "  └── Kotlin detected"
    fi
fi

# Docker detection
if [ -f "Dockerfile" ] || [ -f "docker-compose.yml" ] || [ -f "docker-compose.yaml" ]; then
    STACKS="${STACKS}docker "
    echo "✓ Docker detected"
fi

# TypeScript detection
if [ -f "tsconfig.json" ]; then
    STACKS="${STACKS}typescript "
    echo "✓ TypeScript detected"
fi

# Output results
echo ""
if [ -z "$STACKS" ]; then
    echo "⚠ No recognized stack detected"
    echo "  Project may be new or use an unsupported stack"
else
    echo "Detected stacks:$STACKS"
fi

# Output as simple list for parsing (last line)
echo "$STACKS"