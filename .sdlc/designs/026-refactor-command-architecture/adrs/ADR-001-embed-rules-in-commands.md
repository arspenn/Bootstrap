# ADR-001: Embed Rules in Commands

## Status
Accepted

## Context
Rules stored as separate markdown files in the context don't reliably load or persist in AI conversations. The `/load-rules` command frequently fails to maintain rules in active context, leading to inconsistent behavior and safety violations.

## Decision
Embed rule logic directly into command prompts and templates rather than relying on context-loaded markdown files. Each command will contain its own safety checks, validation logic, and behavioral guidelines as part of its execution prompt.

## Consequences

### Positive
- Rules always work without any setup required
- No context window pollution from rule loading
- Commands are self-contained and portable
- Works consistently across all AI platforms

### Negative
- Some duplication of logic across related commands
- Rules harder to update (must modify multiple commands)
- Larger individual command definitions

### Neutral
- Original rule files become reference documentation only
- Commands become more complex but more reliable