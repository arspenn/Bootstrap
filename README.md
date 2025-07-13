# Bootstrap - AI Development Framework

A comprehensive AI development framework that combines clean architecture with powerful automation. Bootstrap provides modular rules, intelligent commands, and AI-assisted workflows to accelerate software development while maintaining code quality and safety.

## 🎯 Vision

Bootstrap aims to be the most developer-friendly AI framework by:
- Starting with essential Git safety rules
- Building toward comprehensive development automation
- Maintaining clean, token-efficient architecture
- Providing granular control over AI behaviors

## ✨ Current Features

### Git Control Rules
- **Safe Operations**: Prevent accidental commits of sensitive files
- **Commit Standards**: Enforce Conventional Commits format
- **Smart Branching**: Automated branch naming with base tracking
- **Pull Safety**: Intelligent rebase/merge strategies
- **Push Validation**: Pre-push checks and validations

### Memory Integration
- **Efficient Imports**: 83.6% token reduction through smart loading
- **Modular Rules**: One rule per file for maximum flexibility
- **User Preferences**: Enable/disable rules without modifying core

## 🚀 Quick Start

1. Clone and setup:
```bash
git clone [your-repo-url] my-project
cd my-project
```

2. Review the Git control rules:
```bash
cat .claude/rules/git/*.md
```

3. Configure your preferences:
```bash
cp .claude/rules/config/user-preferences.template.yaml .claude/rules/config/user-preferences.yaml
# Edit to enable/disable specific rules
```

4. Start developing with AI safety rails in place!

## 📁 Project Structure

```
.
├── .claude/
│   ├── MASTER_IMPORTS.md      # Single import point for all rules
│   ├── rules/
│   │   ├── git/              # Git control rules
│   │   │   ├── git-add-safety.md
│   │   │   ├── git-commit-format.md
│   │   │   ├── git-push-validation.md
│   │   │   ├── git-pull-strategy.md
│   │   │   └── git-branch-naming.md
│   │   └── config/           # User preferences
│   └── templates/            # Message templates
├── docs/
│   ├── ADRs/                 # Architecture Decision Records
│   └── rules/                # Comprehensive rule documentation
├── features/                 # Feature planning documents
├── designs/                  # Design documents
├── PRPs/                     # Project Requirement Plans
├── tests/                    # Test suites
├── benchmarks/              # Performance benchmarks
├── CLAUDE.md                # AI behavior configuration
├── ROADMAP.md              # Development roadmap
├── CREDITS.md              # Attributions
└── README.md               # This file
```

## 🔄 How It Works

### 1. Rule-Based Architecture
Each rule is a small, focused file that defines specific behaviors:
```yaml
trigger: "git add"
conditions:
  - command_contains: ["add", "stage"]
actions:
  - forbid_commands: ["git add .", "git add -A"]
  - require_explicit_paths: true
```

### 2. Smart Imports
CLAUDE.md imports all rules through a single master file:
```
@.claude/MASTER_IMPORTS.md
```

### 3. User Control
Enable/disable rules without touching core files:
```yaml
git:
  rules:
    git-add-safety: enabled
    git-commit-format: disabled  # Turn off if needed
```

## 🗺️ Roadmap Highlights

### Phase 2: Git Completion (Current)
- [ ] Merge control rules
- [ ] Tag management
- [ ] Checkpoint system

### Phase 3: Command Layer
- [ ] High-level command abstractions
- [ ] Flag inheritance system
- [ ] Interactive workflows

### Phase 4: Core Commands
- [ ] `/build` - Build automation
- [ ] `/test` - Testing orchestration  
- [ ] `/review` - AI code review
- [ ] `/analyze` - Code metrics

See [ROADMAP.md](ROADMAP.md) for complete development plan.

## 🛠️ Design Philosophy

1. **One Rule Per File**: Maximum modularity and clarity
2. **Token Efficiency**: Minimize context usage (current: <1000 tokens)
3. **User Empowerment**: Immutable rules with preference overrides
4. **Progressive Enhancement**: Start simple, add power gradually
5. **Clean Imports**: No complex YAML anchors or references

## 📚 Documentation

- **For Users**: See `docs/rules/git/` for comprehensive guides
- **For Contributors**: Check `docs/ADRs/` for design decisions
- **For Developers**: Read `CLAUDE.md` for AI conventions

## 🤝 Contributing

We welcome contributions! Priority areas:
1. Git merge control rules (active development)
2. Command abstraction design
3. Documentation improvements
4. Test coverage expansion

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 🙏 Credits

Bootstrap builds on great ideas from:
- [SuperClaude](https://github.com/NomenAK/SuperClaude) - Command concepts
- [Conventional Commits](https://www.conventionalcommits.org/) - Commit standards
- [bolt.new](https://github.com/coleam00) - AI development patterns

See [CREDITS.md](CREDITS.md) for full attributions.

## 📊 Performance

- **Token Usage**: ~1000 tokens for all Git rules (83.6% reduction)
- **Import Depth**: 2 levels (well under Claude's 5-hop limit)
- **Rule Activation**: <10ms per rule check

## 🎯 Why Bootstrap?

Unlike monolithic AI frameworks, Bootstrap provides:
- **Granular Control**: Enable exactly what you need
- **Clean Architecture**: Simple patterns that scale
- **Token Efficiency**: Do more with less context
- **Future Proof**: Built for expansion without complexity

## 📄 License

MIT License - See [LICENSE](LICENSE) for details