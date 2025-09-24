#!/bin/sh
set -euo pipefail

# Script: lint-check.sh
# Purpose: Run linters based on detected stack
# Usage: ./.claude/scripts/lint-check.sh [stack]
# Note: Called by AI agent during /do command

STACK="${1:-auto}"
EXIT_CODE=0

echo "Running linters..."

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

# Track if any linters were run
LINTERS_RUN=0

# Run linters for each detected stack
for stack_item in $STACK; do
    case "$stack_item" in
        python)
            echo ""
            echo "Running Python linters..."

            # Try ruff (fastest, most comprehensive)
            if command -v ruff >/dev/null 2>&1; then
                echo "Running ruff..."
                ruff check . || EXIT_CODE=$?
                LINTERS_RUN=1
            fi

            # Try black for formatting
            if command -v black >/dev/null 2>&1; then
                echo "Running black..."
                black --check . || EXIT_CODE=$?
                LINTERS_RUN=1
            fi

            # Try flake8 if no ruff
            if [ $LINTERS_RUN -eq 0 ] && command -v flake8 >/dev/null 2>&1; then
                echo "Running flake8..."
                flake8 . || EXIT_CODE=$?
                LINTERS_RUN=1
            fi

            # Try pylint
            if command -v pylint >/dev/null 2>&1 && [ -f ".pylintrc" ]; then
                echo "Running pylint..."
                pylint **/*.py || EXIT_CODE=$?
                LINTERS_RUN=1
            fi

            # Try mypy for type checking
            if command -v mypy >/dev/null 2>&1; then
                echo "Running mypy..."
                mypy . || EXIT_CODE=$?
                LINTERS_RUN=1
            fi

            if [ $LINTERS_RUN -eq 0 ]; then
                echo "⚠ No Python linters found"
                echo "  Install: pip install ruff black mypy"
            fi
            ;;

        nodejs|sveltekit|react|vue|svelte|nextjs|typescript)
            echo ""
            echo "Running JavaScript/TypeScript linters..."

            # Check for lint script in package.json
            if [ -f "package.json" ] && grep -q '"lint"' package.json; then
                # Use the appropriate package manager
                if command -v pnpm >/dev/null 2>&1 && [ -f "pnpm-lock.yaml" ]; then
                    pnpm run lint || EXIT_CODE=$?
                elif command -v yarn >/dev/null 2>&1 && [ -f "yarn.lock" ]; then
                    yarn lint || EXIT_CODE=$?
                else
                    npm run lint || EXIT_CODE=$?
                fi
                LINTERS_RUN=1
            fi

            # Try eslint directly if no lint script
            if [ $LINTERS_RUN -eq 0 ] && command -v eslint >/dev/null 2>&1; then
                echo "Running eslint..."
                eslint . || EXIT_CODE=$?
                LINTERS_RUN=1
            fi

            # Try prettier for formatting check
            if command -v prettier >/dev/null 2>&1; then
                echo "Checking prettier formatting..."
                prettier --check . || EXIT_CODE=$?
                LINTERS_RUN=1
            fi

            # TypeScript type checking
            if [ -f "tsconfig.json" ] && command -v tsc >/dev/null 2>&1; then
                echo "Running TypeScript type check..."
                tsc --noEmit || EXIT_CODE=$?
                LINTERS_RUN=1
            fi

            # SvelteKit specific check
            if [ "$stack_item" = "sveltekit" ] && [ -f "package.json" ] && grep -q '"check"' package.json; then
                echo "Running SvelteKit check..."
                if command -v pnpm >/dev/null 2>&1; then
                    pnpm run check || EXIT_CODE=$?
                else
                    npm run check || EXIT_CODE=$?
                fi
                LINTERS_RUN=1
            fi

            if [ $LINTERS_RUN -eq 0 ]; then
                echo "⚠ No JavaScript/TypeScript linters configured"
                echo "  Install: npm install -D eslint prettier"
            fi
            ;;

        rust)
            echo ""
            echo "Running Rust linters..."

            # Run clippy (Rust's linter)
            if command -v cargo >/dev/null 2>&1; then
                echo "Running clippy..."
                cargo clippy -- -D warnings || EXIT_CODE=$?
                LINTERS_RUN=1

                # Check formatting
                echo "Running rustfmt check..."
                cargo fmt -- --check || EXIT_CODE=$?
                LINTERS_RUN=1
            else
                echo "✗ Cargo not found"
                EXIT_CODE=1
            fi
            ;;

        go)
            echo ""
            echo "Running Go linters..."

            # Run go fmt
            echo "Checking go fmt..."
            test -z "$(gofmt -l .)" || EXIT_CODE=1
            LINTERS_RUN=1

            # Run go vet
            echo "Running go vet..."
            go vet ./... || EXIT_CODE=$?
            LINTERS_RUN=1

            # Try golangci-lint if available
            if command -v golangci-lint >/dev/null 2>&1; then
                echo "Running golangci-lint..."
                golangci-lint run || EXIT_CODE=$?
                LINTERS_RUN=1
            fi
            ;;

        ruby|rails)
            echo ""
            echo "Running Ruby linters..."

            # Try rubocop
            if command -v rubocop >/dev/null 2>&1; then
                echo "Running rubocop..."
                rubocop || EXIT_CODE=$?
                LINTERS_RUN=1
            else
                echo "⚠ Rubocop not found"
                echo "  Install: gem install rubocop"
            fi
            ;;
    esac
done

# Summary
echo ""
if [ $LINTERS_RUN -eq 0 ]; then
    echo "⚠ No linters configured for stack: $STACK"
    echo "  Set up linting for your project"
    exit 1
elif [ $EXIT_CODE -eq 0 ]; then
    echo "✓ All linting checks passed"
else
    echo "✗ Linting failed with exit code $EXIT_CODE"
fi

exit $EXIT_CODE