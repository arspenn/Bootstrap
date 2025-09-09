# ADR-001: Delete Ineffective Tests

## Status
Accepted

## Context

The current test suite in the `tests/` directory contains 8 test files that were created to test rules and templates, not actual code functionality. These tests:

- Don't effectively test code sections or functionality
- Were created as examples rather than comprehensive tests
- Don't follow proper unit testing patterns for the actual codebase
- Will be replaced with scenario-based testing for Claude commands and rules

The future testing strategy requires:
- Scenario-based tests for Claude commands
- Rule behavior validation tests
- Integration tests for the framework
- Proper test coverage for any actual code modules

## Decision

Delete the entire `tests/` directory and its contents, with the plan to implement proper scenario-based testing in the future when we have:
1. Clear testing requirements for Claude behaviors
2. A testing framework designed for AI command validation
3. Actual code modules that need unit testing

## Consequences

### Positive
- Removes confusion about what the tests actually test
- Eliminates maintenance burden of ineffective tests
- Provides clean slate for implementing proper testing strategy
- Reduces repository clutter during alpha preparation
- Makes it clear that proper testing is a future priority

### Negative
- Repository temporarily has no tests (though current tests aren't effective)
- Might give impression that testing isn't valued (mitigated by this ADR)
- Loss of example test patterns (mitigated by git history)

### Neutral
- Test files remain accessible in git history if needed for reference
- Testing strategy becomes a documented future feature rather than a current liability
- Shifts focus from maintaining bad tests to designing good ones

## Notes

The git history preserves all test files if we need to reference them in the future. The deletion can be reverted if needed, though the preference is to build new, effective tests rather than restore the old ones.