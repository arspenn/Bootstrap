# ADR-006: Pivot to Comprehensive AI Development Framework

## Status
Accepted

## Context

Bootstrap was initially understood (by the AI assistant) to be a Git control rules framework with a focused scope. However, the human's vision has always been for Bootstrap to become a comprehensive AI development framework, using Git control rules as merely the first feature to establish patterns and architecture.

The discovery of SuperClaude, a complete AI development framework with 19 commands and multiple personas, prompted a strategic discussion about Bootstrap's direction. This revealed the misunderstanding about scope and led to clarifying the true vision.

Key observations:
- Bootstrap's architecture (one rule per file, clean imports) is superior to SuperClaude's complex YAML structure
- Bootstrap has already achieved 83.6% token reduction with the memory integration
- The modular rule system scales better than monolithic command files
- Git rules successfully established the patterns for expansion

## Decision

Bootstrap will proceed as a comprehensive AI development framework, not just a Git control system. We will:

1. **Maintain Bootstrap's architectural advantages**:
   - One rule/command per file
   - Simple @import system without YAML anchors
   - Clear separation of instructions and documentation
   - Immutable rules with user preferences

2. **Adopt a hybrid development approach**:
   - Use SuperClaude's feature set as a roadmap
   - Adapt their command concepts to Bootstrap's patterns
   - Learn from their successes while avoiding their complexity

3. **Build progressively**:
   - Complete Git control as the foundation
   - Add command abstraction layer
   - Implement commands following established patterns
   - Expand to full development lifecycle coverage

## Consequences

### Positive
- **Clear vision**: Eliminates confusion about project scope
- **Accelerated development**: Can use SuperClaude as a feature roadmap
- **Architectural superiority**: Our patterns have proven more efficient
- **Market positioning**: Competing in comprehensive AI development space
- **Learning opportunity**: Can study and improve upon existing solutions

### Negative
- **Increased scope**: Much larger development effort required
- **Longer timeline**: Full feature parity will take months
- **Resource requirements**: Need sustained development effort
- **Competition**: Entering space with established players

### Neutral
- **Project identity**: Bootstrap becomes a framework, not just a tool
- **User expectations**: Will be compared to comprehensive solutions
- **Documentation needs**: Requires extensive guides and examples
- **Community building**: Need to attract contributors for larger scope

## Implementation Notes

1. The Git control rules remain valuable as the foundation
2. Each new feature should follow established patterns
3. Token efficiency must be maintained as we scale
4. The roadmap provides a clear path forward
5. Credits.md acknowledges inspirations appropriately

## References

- [ROADMAP.md](../../ROADMAP.md) - Comprehensive development plan
- [CREDITS.md](../../CREDITS.md) - Acknowledgments including SuperClaude
- [SuperClaude Repository](https://github.com/NomenAK/SuperClaude) - Inspiration and feature reference