#!/bin/sh
set -euo pipefail

# Script: run-tests.sh
# Purpose: Run tests based on detected stack
# Usage: ./.claude/scripts/run-tests.sh [stack]
# Note: Called by AI agent during /do command

STACK="${1:-auto}"
EXIT_CODE=0

echo "Running tests..."

# Auto-detect if not specified
if [ "$STACK" = "auto" ]; then
    if [ -f ".claude/scripts/detect-stack.sh" ]; then
        DETECTED=$(.claude/scripts/detect-stack.sh | tail -1)
        STACK="$DETECTED"
    elif [ -f "package.json" ]; then
        STACK="nodejs"
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
        STACK="python"
    elif [ -f "Cargo.toml" ]; then
        STACK="rust"
    fi
fi

# Track if any tests were run
TESTS_RUN=0

# Run tests for each detected stack
for stack_item in $STACK; do
    case "$stack_item" in
        python)
            echo ""
            echo "Running Python tests..."

            # Try pytest first (most common)
            if command -v pytest >/dev/null 2>&1; then
                pytest || EXIT_CODE=$?
                TESTS_RUN=1
            # Try unittest
            elif [ -d "tests" ] || [ -d "test" ]; then
                python3 -m unittest discover || EXIT_CODE=$?
                TESTS_RUN=1
            # Try tox if available
            elif command -v tox >/dev/null 2>&1 && [ -f "tox.ini" ]; then
                tox || EXIT_CODE=$?
                TESTS_RUN=1
            else
                echo "⚠ No Python test runner found"
                echo "  Install: pip install pytest"
            fi
            ;;

        nodejs|sveltekit|react|vue|svelte|nextjs)
            echo ""
            echo "Running JavaScript/TypeScript tests..."

            # Check package.json for test script
            if [ -f "package.json" ] && grep -q '"test"' package.json; then
                # Use the appropriate package manager
                if command -v pnpm >/dev/null 2>&1 && [ -f "pnpm-lock.yaml" ]; then
                    pnpm test || EXIT_CODE=$?
                elif command -v yarn >/dev/null 2>&1 && [ -f "yarn.lock" ]; then
                    yarn test || EXIT_CODE=$?
                else
                    npm test || EXIT_CODE=$?
                fi
                TESTS_RUN=1
            else
                echo "⚠ No test script defined in package.json"
                echo "  Add a 'test' script to package.json"
            fi

            # SvelteKit specific test (using Vitest)
            if [ "$stack_item" = "sveltekit" ] && [ -f "vite.config.js" ] || [ -f "vite.config.ts" ]; then
                if command -v vitest >/dev/null 2>&1; then
                    echo "Running Vitest..."
                    vitest run || EXIT_CODE=$?
                    TESTS_RUN=1
                fi
            fi
            ;;

        rust)
            echo ""
            echo "Running Rust tests..."
            cargo test || EXIT_CODE=$?
            TESTS_RUN=1

            # Also run doc tests
            echo "Running Rust doc tests..."
            cargo test --doc || EXIT_CODE=$?
            ;;

        go)
            echo ""
            echo "Running Go tests..."
            go test ./... || EXIT_CODE=$?
            TESTS_RUN=1
            ;;

        ruby|rails)
            echo ""
            echo "Running Ruby tests..."

            if [ -f "Rakefile" ] && grep -q "test" Rakefile; then
                rake test || EXIT_CODE=$?
                TESTS_RUN=1
            elif command -v rspec >/dev/null 2>&1 && [ -d "spec" ]; then
                rspec || EXIT_CODE=$?
                TESTS_RUN=1
            elif [ -d "test" ]; then
                ruby -I test test/**/*_test.rb || EXIT_CODE=$?
                TESTS_RUN=1
            else
                echo "⚠ No Ruby test framework found"
            fi
            ;;
    esac
done

# Summary
echo ""
if [ $TESTS_RUN -eq 0 ]; then
    echo "⚠ No tests found for stack: $STACK"
    echo "  Set up tests for your project"
    exit 1
elif [ $EXIT_CODE -eq 0 ]; then
    echo "✓ All tests passed"
else
    echo "✗ Tests failed with exit code $EXIT_CODE"
fi

exit $EXIT_CODE