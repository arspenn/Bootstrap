# ADR-001: Mirror-then-Switch Migration Strategy

## Status
Proposed

## Context
We need to separate framework documentation (Bootstrap framework usage) from project documentation (what we're building with Bootstrap) by moving framework docs to `.claude/docs/`. This migration must:
- Preserve git history for all moved files
- Update all references to new locations
- Ensure no broken links or missing documentation
- Maintain the ability to rollback if issues arise

Three approaches were considered:
1. Complete migration with immediate cleanup
2. Mirror-then-switch approach
3. Symlink bridge approach

## Decision
We will use the mirror-then-switch approach:
1. Copy documentation to new `.claude/docs/` structure using `git mv`
2. Update all references to point to new locations
3. Verify all references and functionality work correctly
4. Remove old documentation locations
5. Commit as a single atomic change

This approach uses git's native move functionality to preserve history while providing a verification step before finalizing the migration.

## Consequences

### Positive
- Git history fully preserved through `git mv` command
- Verification step ensures nothing breaks before cleanup
- Single atomic commit makes rollback simple
- Clear audit trail of what moved where
- No risk of lost documentation

### Negative
- Slightly more complex process than direct migration
- Temporary duplication during migration process (but within same commit)
- Requires careful coordination of moves and reference updates

### Neutral
- Migration happens in one commit but with multiple staged operations
- All team members need to pull the change at once to avoid confusion