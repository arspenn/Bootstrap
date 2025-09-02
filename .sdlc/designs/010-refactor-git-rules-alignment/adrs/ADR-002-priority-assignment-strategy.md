# ADR-002: Priority Assignment Strategy for Git Rules

## Status
Accepted

## Context
The enhanced metadata format requires a Priority field (100-800 scale) for all rules. Git rules need consistent priority assignments that reflect both their security importance and operational impact on the development workflow.

## Decision
Assign priorities based on a two-tier system:
1. **Primary factor**: Security level (High/Medium/Low)
2. **Secondary factor**: Operational impact within security tier

Priority ranges:
- **High Security (700-800)**: Rules preventing security issues
  - git-add-safety: 750 (prevents secrets in commits)
  - git-push-validation: 700 (protects branch integrity)
- **Medium Security (400-600)**: Rules ensuring workflow safety
  - git-safe-file-operations: 650 (prevents data loss)
  - git-pull-strategy: 500 (maintains clean merges)
  - git-commit-format: 400 (ensures consistency)
- **Low Security (100-300)**: Convention and formatting rules
  - git-branch-naming: 300 (naming standards)

## Consequences

### Positive
- Predictable priority assignment based on risk
- Clear hierarchy for rule precedence
- Aligns with security-first approach
- Easy to understand and document

### Negative
- May need adjustment based on actual usage patterns
- Some rules might need priority tweaks for specific workflows

### Neutral
- Priorities can be overridden in config.yaml if needed
- Provides baseline that projects can customize