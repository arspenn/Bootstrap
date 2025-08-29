# Bootstrap Framework Documentation

Welcome to the Bootstrap framework documentation. This is the complete guide for understanding and using the Bootstrap software engineering framework with Claude.

## 📚 Documentation Structure

### Framework Guides
Core documentation for understanding Bootstrap:

- **[Getting Started](framework/getting-started.md)** - Quick introduction and setup
- **[Configuration](framework/configuration.md)** - How to configure the framework
- **[Rule System](framework/rule-system.md)** - Understanding and creating rules
- **[Command System](framework/command-system.md)** - Available commands and usage
- **[Workflow](framework/workflow.md)** - Development workflow and best practices

### How-To Guides
Step-by-step guides for common tasks:

- **[Guides Overview](guides/README.md)** - Planned guides (coming soon)
  - Creating Features
  - Writing Rules
  - Design Process
  - PRP Workflow
  - Testing Strategy

### Rule Documentation
Detailed documentation for each rule category:

- **[Git Rules](rules/git/)** - Git operation safety and standards
- **[Project Rules](rules/project/)** - Project management and organization
- **[Testing Rules](rules/testing/)** - Test requirements and standards
- **[Documentation Rules](rules/documentation/)** - Documentation standards
- **[Python Rules](rules/python/)** - Python-specific conventions

### Technical Reference
Detailed technical specifications:

- **[Reference Overview](reference/README.md)** - Technical references (coming soon)
  - Rule Metadata Specification
  - Configuration Schema
  - Command API
  - Template Variables

## 🚀 Quick Links

### For New Users
1. Start with [Getting Started](framework/getting-started.md)
2. Review the [Workflow Guide](framework/workflow.md)
3. Understand the [Rule System](framework/rule-system.md)

### For Configuration
1. See [Configuration Guide](framework/configuration.md)
2. Check rule documentation in [rules/](rules/)
3. Review templates in [templates/](../templates/)

### For Development
1. Understand [Commands](framework/command-system.md)
2. Follow the [Workflow](framework/workflow.md)
3. Reference specific [Rule Documentation](rules/)

## 📂 Related Documentation

### Project Documentation
Project-specific documentation (not framework docs) can be found in:
- `/docs/` - Project documentation
- `/designs/` - Feature designs
- `/PRPs/` - Project Requirements Prompts
- `/docs/ADRs/` - Architectural Decision Records

### Framework Configuration
- `/CLAUDE.md` - Main configuration file
- `/.claude/MASTER_IMPORTS.md` - Rule import manifest
- `/.claude/config.yaml` - Framework configuration

## 🔧 Framework Components

### Rules
Automated enforcement of best practices:
- Located in `.claude/rules/`
- Documentation in `.claude/docs/rules/`
- Imported via `MASTER_IMPORTS.md`

### Commands
Structured workflows for development:
- Located in `.claude/commands/`
- Executed via `/command-name`
- Guide complex processes

### Templates
Standardized structures for consistency:
- Located in `.claude/templates/`
- Used by rules and commands
- Ensure uniformity

## 📖 Documentation Philosophy

Bootstrap follows a dual-structure approach:

1. **Concise Instructions** - Rules and commands are brief and actionable
2. **Comprehensive Documentation** - Full explanations available when needed

This ensures efficient token usage while maintaining complete documentation.

## 🆘 Getting Help

- **Framework Issues**: Check this documentation
- **Project Issues**: Check project-specific docs in `/docs/`
- **Rule Questions**: See detailed docs in `rules/`
- **Command Help**: Review `framework/command-system.md`

---

*Bootstrap: A comprehensive software engineering framework for Claude AI*