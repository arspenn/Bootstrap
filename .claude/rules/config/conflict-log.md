# Rule Conflict Log

This file tracks conflicts between rules when they provide contradictory guidance. Each entry helps improve rule definitions and user preferences.

## Log Format

```
### Date: YYYY-MM-DD HH:MM:SS
**Conflicting Rules**: rule1-id vs rule2-id
**Context**: What operation triggered the conflict
**Conflict**: Description of the contradiction
**Resolution**: How the conflict was resolved
**User Choice**: Which rule took precedence
**Task Created**: Issue or task number if applicable
---
```

## Active Conflicts

*No conflicts logged yet*

## Example Entry

```
### Date: 2025-01-15 14:32:10
**Conflicting Rules**: git/git-add-safety vs git/quick-commit
**Context**: User attempted to stage all changes for hotfix
**Conflict**: git-add-safety prevents "git add ." but quick-commit suggests it for hotfixes
**Resolution**: User chose git-add-safety (security priority)
**User Choice**: Staged files individually despite hotfix urgency
**Task Created**: #45 - Review bulk operation safety rules for emergency fixes
---
```

## Conflict Categories

### Severity Levels
- **High**: Security rule conflicts (always log)
- **Medium**: Workflow conflicts (log if repeated)
- **Low**: Style preferences (log patterns only)

### Common Conflict Types
1. **Security vs Convenience**: Safety rules conflict with quick operations
2. **Performance vs Safety**: Validation overhead vs speed
3. **Standardization vs Flexibility**: Strict formats vs team preferences
4. **Automation vs Control**: Auto-actions vs manual review

## Resolution Guidelines

When conflicts occur:
1. Security rules take precedence by default
2. User can override via explicit preference
3. Document the decision in this log
4. Consider creating ADR for significant conflicts
5. Update rule definitions if conflicts are frequent

## Statistics

- Total Conflicts Logged: 0
- High Severity: 0
- Medium Severity: 0
- Low Severity: 0
- Rules Most Often in Conflict: N/A

## Review Schedule

This log should be reviewed:
- Weekly during active development
- Monthly during maintenance phase
- Immediately for high-severity conflicts

Last Review: Not yet reviewed
Next Review: TBD