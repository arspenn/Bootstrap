# ADR-007: Changelog Automation Level

## Status
Accepted

## Context

Bootstrap needs a changelog management system to track project evolution. We must decide the appropriate level of automation for changelog updates. Options range from fully manual to fully automated.

Key considerations:
- We already use Conventional Commits format
- Developers need to understand project history
- Quality and context matter more than completeness
- Integration with existing Git rules is desired
- Future CI/CD integration is planned

## Decision

We will implement a **semi-automated changelog system** with the following characteristics:

1. **Rule-Based Reminders**: Git rules will remind developers to update changelog for significant changes
2. **Template-Driven**: Standardized templates ensure consistent entries
3. **Human Judgment**: Developers decide what's changelog-worthy
4. **Automated Assistance**: Tools help format and organize entries
5. **Real-Time Updates**: Changes logged under "Unreleased" until version bump

## Consequences

### Positive
- **Quality Control**: Human review ensures meaningful entries
- **Flexibility**: Can capture context beyond commit messages
- **Progressive Enhancement**: Can add more automation later
- **Low Friction**: Templates and rules reduce manual effort
- **Integration Ready**: Works with existing Git workflow

### Negative
- **Manual Effort**: Still requires human action
- **Possible Gaps**: Changes might be missed
- **Training Need**: Team must learn the process

### Neutral
- **Hybrid Approach**: Balances automation with control
- **Rule Complexity**: Adds new rules to the system
- **Process Change**: Modifies development workflow

## Implementation Notes

The semi-automated approach will be implemented through:
- Git rules that detect changelog-worthy changes
- Templates that standardize entry format
- Integration points with task completion
- Clear documentation of the process

This decision can be revisited if the manual effort becomes burdensome or if better automation tools become available.