# ADR-001: Natural Language Processing for Context Capture

## Status
Accepted

## Context
The task export command needs to capture insights and discoveries during Bootstrap framework testing. Developers often discover issues, limitations, or improvements while working but lose this context when switching between projects or Claude instances.

Traditional approaches would require:
- Manually creating tasks in TASK.md
- Remembering to document discoveries
- Switching context to write up findings
- Breaking development flow

We need a solution that captures knowledge in real-time without disrupting the development process.

## Decision
Implement natural language processing to understand contextual references like "what we were just talking about", "this issue", "the bug we found", allowing Claude to intelligently extract and export discoveries from the conversation context.

## Consequences

### Positive
- **Seamless Capture**: No interruption to development flow
- **Context Preservation**: Full context of discoveries maintained
- **Natural Interface**: Use conversational language instead of formal syntax
- **Immediate Documentation**: Capture insights as they occur
- **Rich Context**: Include what was being attempted, what went wrong, and potential solutions

### Negative
- **Complexity**: More complex than simple ID matching
- **Ambiguity**: Natural language can be interpreted multiple ways
- **Context Dependency**: Requires access to conversation history

### Neutral
- Leverages Claude's existing NLP capabilities
- Creates a new pattern for Bootstrap commands
- May inspire similar context-aware commands