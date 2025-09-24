#!/bin/sh
set -euo pipefail

# Script: check-environment.sh
# Purpose: Validate development environment setup for detected stacks
# Usage: ./.claude/scripts/check-environment.sh [stack]
#   stack: optional specific stack to check, otherwise auto-detect
# Note: Called by AI agent during /do command

STACK="${1:-auto}"
ISSUES=0

echo "Checking development environment..."

# Auto-detect if not specified
if [ "$STACK" = "auto" ]; then
    # Run detect-stack script if it exists
    if [ -f ".claude/scripts/detect-stack.sh" ]; then
        DETECTED=$(.claude/scripts/detect-stack.sh | tail -1)
        STACK="$DETECTED"
        echo "Auto-detected stacks:$STACK"
    else
        # Fallback to simple detection
        if [ -f "package.json" ]; then
            STACK="nodejs"
        elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
            STACK="python"
        elif [ -f "Cargo.toml" ]; then
            STACK="rust"
        fi
    fi
fi

# Check each detected stack (STACK may contain multiple values)
for stack_item in $STACK; do
    case "$stack_item" in
        python)
            echo ""
            echo "Checking Python environment..."

            # Check Python installation
            if ! command -v python3 >/dev/null 2>&1; then
                echo "✗ Python 3 not found"
                ISSUES=$((ISSUES + 1))
            else
                echo "✓ Python 3 found: $(python3 --version)"
            fi

            # Check for virtual environment
            if [ -n "${VIRTUAL_ENV:-}" ]; then
                echo "✓ Virtual environment active: $VIRTUAL_ENV"
            elif [ -d "venv" ] || [ -d ".venv" ] || [ -d "venv_linux" ]; then
                echo "⚠ Virtual environment found but not active"
                if [ -d "venv_linux" ]; then
                    echo "  Run: source venv_linux/bin/activate"
                elif [ -d "venv" ]; then
                    echo "  Run: source venv/bin/activate"
                else
                    echo "  Run: source .venv/bin/activate"
                fi
                ISSUES=$((ISSUES + 1))
            else
                echo "⚠ No virtual environment found"
                echo "  Run: python3 -m venv venv"
                ISSUES=$((ISSUES + 1))
            fi

            # Check for pip
            if ! command -v pip >/dev/null 2>&1; then
                echo "✗ pip not found"
                ISSUES=$((ISSUES + 1))
            else
                echo "✓ pip found"
            fi
            ;;

        nodejs|sveltekit|react|vue|svelte|nextjs)
            echo ""
            echo "Checking Node.js environment..."

            # Check Node installation
            if ! command -v node >/dev/null 2>&1; then
                echo "✗ Node.js not found"
                ISSUES=$((ISSUES + 1))
            else
                echo "✓ Node.js found: $(node --version)"
            fi

            # Check package manager
            if command -v pnpm >/dev/null 2>&1; then
                echo "✓ pnpm found: $(pnpm --version)"
            elif command -v npm >/dev/null 2>&1; then
                echo "✓ npm found: $(npm --version)"
            elif command -v yarn >/dev/null 2>&1; then
                echo "✓ yarn found: $(yarn --version)"
            else
                echo "✗ No package manager found (npm/yarn/pnpm)"
                ISSUES=$((ISSUES + 1))
            fi

            # Check node_modules
            if [ -d "node_modules" ]; then
                echo "✓ node_modules exists"
            else
                echo "⚠ node_modules not found"
                if command -v pnpm >/dev/null 2>&1; then
                    echo "  Run: pnpm install"
                elif command -v npm >/dev/null 2>&1; then
                    echo "  Run: npm install"
                elif command -v yarn >/dev/null 2>&1; then
                    echo "  Run: yarn install"
                fi
                ISSUES=$((ISSUES + 1))
            fi

            # SvelteKit specific checks
            if [ "$stack_item" = "sveltekit" ]; then
                echo ""
                echo "Checking SvelteKit specifics..."
                if [ -f "svelte.config.js" ]; then
                    echo "✓ svelte.config.js found"
                else
                    echo "⚠ svelte.config.js not found"
                fi
                if [ -f "vite.config.js" ] || [ -f "vite.config.ts" ]; then
                    echo "✓ Vite config found"
                else
                    echo "⚠ Vite config not found"
                fi
            fi
            ;;

        rust)
            echo ""
            echo "Checking Rust environment..."

            # Check Rust installation
            if ! command -v cargo >/dev/null 2>&1; then
                echo "✗ Cargo not found"
                echo "  Install from: https://rustup.rs/"
                ISSUES=$((ISSUES + 1))
            else
                echo "✓ Cargo found: $(cargo --version)"
            fi

            # Check rustc
            if ! command -v rustc >/dev/null 2>&1; then
                echo "✗ rustc not found"
                ISSUES=$((ISSUES + 1))
            else
                echo "✓ rustc found: $(rustc --version)"
            fi

            # Check for target directory
            if [ -d "target" ]; then
                echo "✓ target directory exists (project built)"
            else
                echo "• target directory not found (project not built yet)"
            fi
            ;;

        surrealdb)
            echo ""
            echo "Checking SurrealDB environment..."

            # Check if SurrealDB is running (via docker or native)
            if command -v surreal >/dev/null 2>&1; then
                echo "✓ SurrealDB CLI found"
            elif docker ps 2>/dev/null | grep -q surrealdb; then
                echo "✓ SurrealDB running in Docker"
            else
                echo "⚠ SurrealDB not found"
                echo "  Install: curl -sSf https://install.surrealdb.com | sh"
                echo "  Or run: docker run --rm -p 8000:8000 surrealdb/surrealdb:latest start"
            fi
            ;;

        typescript)
            echo ""
            echo "Checking TypeScript..."
            if command -v tsc >/dev/null 2>&1; then
                echo "✓ TypeScript compiler found: $(tsc --version)"
            elif [ -f "node_modules/.bin/tsc" ]; then
                echo "✓ TypeScript compiler found (local)"
            else
                echo "⚠ TypeScript compiler not found"
                echo "  Run: npm install -D typescript"
            fi
            ;;

        docker)
            echo ""
            echo "Checking Docker..."
            if ! command -v docker >/dev/null 2>&1; then
                echo "✗ Docker not found"
                ISSUES=$((ISSUES + 1))
            else
                echo "✓ Docker found: $(docker --version)"
                # Check if Docker daemon is running
                if docker info >/dev/null 2>&1; then
                    echo "✓ Docker daemon is running"
                else
                    echo "✗ Docker daemon is not running"
                    echo "  Start Docker Desktop or run: sudo systemctl start docker"
                    ISSUES=$((ISSUES + 1))
                fi
            fi
            ;;

        go)
            echo ""
            echo "Checking Go environment..."
            if ! command -v go >/dev/null 2>&1; then
                echo "✗ Go not found"
                ISSUES=$((ISSUES + 1))
            else
                echo "✓ Go found: $(go version)"
            fi
            ;;
    esac
done

# Summary
echo ""
if [ $ISSUES -eq 0 ]; then
    echo "✓ Environment check passed"
    exit 0
else
    echo "✗ Environment check found $ISSUES issue(s)"
    echo "  Fix the issues above before proceeding with implementation"
    exit 1
fi