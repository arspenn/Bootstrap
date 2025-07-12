# ADR-001: Git Rules Architecture - One Rule Per File

## Status
Accepted

## Context
The Bootstrap project needs a system for defining Git and GitHub behavior rules that Claude Code will follow. These rules must be:
- Modular and extensible for future growth
- Secure by default with no ability to disable security features
- Clear and unambiguous in scope
- Efficient in terms of token usage
- Easy to reference and maintain

We considered three alternatives:
1. Inline rules in CLAUDE.md (simple but not scalable)
2. Separate GIT_RULES.md file (modular but could clutter root directory)
3. Structured rules directory with categorized behaviors (most flexible)

## Decision
We will implement a structured rules directory under `.claude/rules/` with one rule per file. Each rule will:
- Have a unique ID based on its file path (e.g., `git/git-add-safety`)
- Define clear trigger conditions and actions
- Include security level indicators
- Estimate token impact
- Be immutable (users can only configure allowed behaviors, not modify rules)

User preferences will be stored separately in `.claude/rules/config/user-preferences.yaml`.

## Consequences

### Positive
- **Scalability**: Unlimited rule categories without directory clutter
- **Clarity**: One rule per file prevents confusion about rule boundaries
- **Security**: Rules cannot be weakened, only made more restrictive
- **Maintainability**: Each rule can be updated independently
- **Discoverability**: Clear file structure and naming conventions
- **Performance**: Minimal token overhead (~5-10% increase for Git operations)

### Negative
- **Complexity**: More files to manage than a single rules file
- **Initial Setup**: Requires creating directory structure
- **Learning Curve**: Users need to understand the rule hierarchy

### Neutral
- **Token Usage**: Slight increase (~500-800 tokens initial load, +30-100 per operation)
- **File Count**: More files, but better organized
- **Configuration**: Separate user preferences file adds a layer of indirection