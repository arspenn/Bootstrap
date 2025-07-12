# Architecture Decision Records

This directory contains Architecture Decision Records (ADRs) for the Bootstrap project. ADRs document significant architectural decisions made during the project's development.

## What is an ADR?

An Architecture Decision Record captures:
- The context and problem being addressed
- The decision made
- The consequences of that decision

## ADR Format

Each ADR follows this template:
- **Status**: Proposed, Accepted, Deprecated, or Superseded
- **Context**: What prompted this decision?
- **Decision**: What did we decide?
- **Consequences**: What are the positive, negative, and neutral outcomes?

## Current ADRs

| ADR | Title | Status | Date |
|-----|-------|--------|------|
| [ADR-001](ADR-001-git-rules-architecture.md) | Git Rules Architecture - One Rule Per File | Accepted | 2025-07-12 |
| [ADR-002](ADR-002-git-commit-standards.md) | Git Commit Message Standards | Accepted | 2025-07-12 |
| [ADR-003](ADR-003-branching-strategy.md) | Git Branching Strategy | Accepted | 2025-07-12 |

## Creating New ADRs

1. Copy an existing ADR as a template
2. Use the next sequential number
3. Follow the established format
4. Update this README with the new entry
5. Link related ADRs where appropriate

## ADR Lifecycle

1. **Proposed**: Under discussion
2. **Accepted**: Decision is final and being implemented
3. **Deprecated**: No longer relevant but kept for history
4. **Superseded**: Replaced by a newer ADR (link to the new one)