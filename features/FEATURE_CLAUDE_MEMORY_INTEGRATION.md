## FEATURE: Claude Memory Integration for Rule System

- Integrate Claude Code's memory import feature (@file syntax) with our rule system
- Restructure rules to be direct behavioral instructions (not documentation)
- Move all non-instructional content (examples, rationale, scenarios) to documentation
- Ensure rules are automatically loaded and followed by Claude Code
- Maintain clear separation between instructions and reference material

## EXAMPLES:

[Provide references to similar features, patterns, or implementations that should be studied]
- Claude Code Memory Documentation: https://docs.anthropic.com/en/docs/claude-code/memory
- The @import syntax for CLAUDE.md files
- Our existing rule system at `.claude/rules/`

## DOCUMENTATION:

[List relevant documentation, APIs, or technical resources]

- [Claude Memory System]: https://docs.anthropic.com/en/docs/claude-code/memory
- [Import Syntax]: Uses @path/to/file for importing additional instructions
- [Memory Hierarchy]: Project memory (./CLAUDE.md) vs User memory (~/.claude/CLAUDE.md)
- Internal docs: `.claude/rules/README.md`, `docs/rules/git/README.md`

## OTHER CONSIDERATIONS:

- [Performance requirements] Imports limited to 5 recursive hops, need efficient structure
- [Security considerations] Rules must remain immutable, only behavioral changes allowed
- [Scalability needs] System must support future rule categories beyond Git
- [User experience] Clear distinction between what Claude follows vs what users read
- [Timeline] Should be implemented before adding more rule categories
- CRITICAL: Rules are direct instructions, not documentation
- CRITICAL: All examples, rationale, and explanations move to docs/rules/
- This affects all existing Git rules and future rule categories
- Must maintain backward compatibility with user preferences system

## CONTEXT:

During Git control rules implementation, we discovered that our rules mixed documentation with instructions. Claude's memory import feature expects direct behavioral instructions, not reference documentation. Current rules contain examples, rationale, and scenarios that belong in documentation, not in Claude's instruction set.

## SUCCESS METRICS:

[Optional: How will we measure if this feature is successful?]

- [Metric 1] Claude Code successfully imports and follows all rules via @import syntax
- [Metric 2] Rules contain only direct instructions (no examples or explanations)
- [Metric 3] Documentation remains comprehensive but separate from rules
- [Metric 4] Token overhead remains within 10% target
- [Metric 5] User can easily understand what Claude will do by reading rules

## OUT OF SCOPE:

[Optional: Explicitly state what is NOT part of this feature request]

- Changing the fundamental rule structure (ID, Status, Security Level, etc.)
- Modifying user preference system
- Creating new rule categories (just restructuring existing ones)
- Changing the one-rule-per-file architecture