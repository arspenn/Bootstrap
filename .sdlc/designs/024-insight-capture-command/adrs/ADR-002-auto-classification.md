# ADR-002: Auto-Classification Without Confirmation

## Status
Accepted

## Context
When capturing insights, we need to classify them as Bug, Enhancement, Limitation, or Discovery. We could either:
1. Auto-classify and export immediately
2. Show classification and ask for confirmation
3. Let user manually specify type

The key tension is between accuracy and flow preservation. Confirmations improve accuracy but break development flow - the primary problem we're solving.

## Decision
Automatically classify insights without asking for confirmation, prioritizing speed and flow preservation over perfect accuracy.

## Consequences

### Positive
- **Zero-friction capture**: No interruption to development flow
- **Fast documentation**: < 30 seconds from discovery to file
- **Natural interaction**: Feels like taking quick notes
- **Immediate results**: User sees file created instantly

### Negative
- **Potential misclassification**: ~20% may be wrongly categorized
- **No correction opportunity**: Must edit file manually if wrong
- **Less user control**: Can't override classification in-flow

### Neutral
- Classification accuracy will improve with usage patterns
- Users can edit exported files if needed
- Most important thing is capturing the information, not perfect classification
- Could add optional `--type` flag in future for explicit control