# Bootstrap - AI-Native SDLC Framework

Bootstrap is a comprehensive Software Development Lifecycle framework designed for AI-assisted development. It provides structured workflows, safety controls, and intelligent automation from requirements gathering through deployment.

## Key Concept

Bootstrap uses its own functionality to build itself - every feature is developed using Bootstrap's own rules, templates, and workflows. This self-bootstrapping approach ensures the framework is battle-tested and practical.

## 🎯 Core Features

### Requirements & Design
- **Structured Requirements Gathering** - Commands for project and feature requirements
- **Design Documentation** - Organized design system with ADR support
- **Project Planning** - Templates and workflows for SDLC planning

### Development Safety
- **Git Control Rules** - Prevent accidental commits, force pushes, and sensitive file exposure
- **Commit Standards** - Enforced Conventional Commits format
- **Branch Management** - Automated naming and tracking
- **File Operation Safety** - Protection against destructive operations

### Task Management
- **Integrated Tracking** - Tasks linked with git commits
- **Sequential Numbering** - Organized task and document numbering
- **Discovery System** - Track new tasks found during development

### Framework Architecture
- **Modular Rules** - One rule per file for maximum flexibility
- **Token Optimization** - Achieved 83.6% reduction in context usage
- **Command System** - High-level commands combining multiple operations
- **Template Library** - Reusable templates for common patterns

## 🚀 Quick Start

### 1. Load Rules and Reset Framework (Required First Step)
```bash
/load-rules
/reset-framework
```

### 2. Initialize Your Project
```bash
# For new projects
/gather-project-requirements

# For feature development
/gather-feature-requirements

# For quick ideas
/quick-feature "feature description"
```

### 3. Work Safely
Bootstrap's rules automatically:
- Block `git add .` and `git add -A`
- Prevent commits of sensitive files
- Enforce commit message standards
- Validate before push operations

## 📁 Structure

```
.claude/
├── rules/              # Behavioral rules
│   ├── git/           # Git safety and automation
│   ├── project/       # Project management
│   ├── python/        # Language-specific
│   └── testing/       # Test requirements
├── commands/          # Claude commands
├── templates/         # Reusable templates
└── MASTER_IMPORTS.md  # Central import file

.sdlc/
├── features/          # Feature specifications
├── designs/           # Design documents
├── PRPs/             # Project Requirement Plans
└── ADRs/             # Architecture Decision Records
```

## 🛠️ Current Capabilities

### Available Commands
- `/load-rules` - Load framework configuration
- `/gather-project-requirements` - Project planning
- `/gather-feature-requirements` - Feature discovery
- `/quick-feature` - Rapid feature capture
- `/design-feature` - Design documentation
- `/generate-prp` - Implementation planning
- `/task-add`, `/task-update` - Task management

### Active Rules (24+)
- Git operations safety
- Commit format enforcement
- Task-commit integration
- File operation protection
- Python environment management
- Documentation standards
- Testing requirements

### Templates
- Project planning
- Feature requirements
- Design documents
- Task management
- Commit messages
- ADR format

## 📊 Metrics

- **Token Usage**: <1000 tokens for full rule load
- **Development Time**: Using Bootstrap for 6+ months
- **Rules Coverage**: Git, project management, Python, testing
- **Active Development**: Regular updates and improvements

## 🗺️ Roadmap

### Phase 1: Foundation ✅
- Core rule system
- Git safety controls
- Basic documentation

### Phase 2: Current Focus
- Enhanced task management
- Requirements commands
- Template standardization
- Documentation improvements

### Phase 3: Planned
- Testing framework
- Deployment automation
- Performance monitoring
- Multi-AI support

See [ROADMAP.md](ROADMAP.md) for detailed plans.

## 💡 Philosophy

1. **Self-Bootstrapping** - Use the framework to build the framework
2. **Safety First** - Protective defaults with override options
3. **Token Efficiency** - Minimize context usage
4. **Progressive Enhancement** - Start simple, add as needed
5. **Developer Control** - Automation without sacrificing flexibility

## 📚 Documentation

- **Project Vision**: [PLANNING.md](PLANNING.md)
- **Development Timeline**: [ROADMAP.md](ROADMAP.md)
- **Version History**: [CHANGELOG.md](CHANGELOG.md)
- **Rule Documentation**: `.claude/docs/rules/`
- **Command Reference**: `.claude/commands/`

## 🤝 Contributing

Priority areas for contribution:
- Additional safety rules
- Command improvements
- Template additions
- Documentation updates
- Test coverage

## 📄 License

MIT License - See [LICENSE](LICENSE)

---

*Bootstrap: Building better AI-assisted development workflows through recursive self-improvement.*