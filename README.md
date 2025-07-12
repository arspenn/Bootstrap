# Claude Design Bootstrap

A quick-start repository for software design and development with Claude AI. This bootstrap template provides a structured workflow for designing features before implementation.

## 🚀 Quick Start

1. Clone this repository:
```bash
git clone [your-repo-url] my-project
cd my-project
```

2. Start designing your feature:
```bash
# Copy the feature template
cp FEATURE_TEMPLATE.md features/my-feature.md
# Edit with your requirements
```

3. Use Claude to design your feature:
```
/design-feature features/my-feature.md
```

4. Generate a PRP from your design:
```
/generate-prp designs/my-feature-design.md
```

5. Execute the implementation:
```
/execute-prp PRPs/my-feature.md
```

## 📁 Project Structure

```
.
├── .claude/
│   └── commands/          # Claude AI commands
│       ├── design-feature.md    # Interactive design exploration
│       ├── generate-prp.md      # PRP generation from designs
│       └── execute-prp.md       # Implementation execution
├── PRPs/
│   └── templates/         # PRP templates
│       └── prp_base.md         # Base PRP template
├── designs/               # Design documents output directory
├── features/              # Feature request files
├── tests/                 # Test files
├── CLAUDE.md             # Project conventions and rules
├── FEATURE_TEMPLATE.md   # Template for new features
└── README.md             # This file
```

## 🔄 Workflow

### 1. Define Your Feature
Create a new feature file using `FEATURE_TEMPLATE.md` as a guide:
- Clear description of what needs to be built
- Examples and references
- Technical requirements
- Success criteria

### 2. Design Phase
Use the `/design-feature` command to:
- Interactively explore requirements
- Analyze existing codebase patterns
- Document design alternatives
- Create Architecture Decision Records (ADRs)
- Generate architecture diagrams

### 3. PRP Generation
Use `/generate-prp` with your design document to create:
- Detailed implementation plan
- Task breakdown
- Validation criteria
- All necessary context for implementation

### 4. Implementation
Use `/execute-prp` to implement the feature with:
- Comprehensive context from design phase
- Clear implementation steps
- Built-in validation

## 📝 Project Documentation

### PLANNING.md (Optional)
Create this file to document:
- Overall system architecture
- Technology decisions
- Design principles
- System constraints

### TASK.md (Optional)
Track implementation tasks:
- Current work in progress
- Completed tasks with dates
- Discovered tasks during implementation

### CLAUDE.md
Customize project-specific rules:
- Coding conventions
- File structure patterns
- Testing requirements
- Documentation standards

## 🛠️ Customization

### Adding Project-Specific Commands
Create new commands in `.claude/commands/`:
```markdown
# Command Name

## Input: $ARGUMENTS

[Command description and process...]
```

### Modifying Templates
- Edit `PRPs/templates/prp_base.md` for your project needs
- Update `FEATURE_TEMPLATE.md` with project-specific sections

## 📚 Best Practices

1. **Start with Design**: Use `/design-feature` for complex features
2. **Document Decisions**: Create ADRs for important choices
3. **Include Context**: Add all necessary documentation to PRPs
4. **Validate Early**: Use the validation sections in designs and PRPs
5. **Iterate**: Designs can be refined before implementation

## 🎯 When to Use Each Command

### /design-feature
- Requirements are unclear or complex
- Multiple implementation approaches exist
- Feature impacts multiple components
- Stakeholder review needed

### /generate-prp
- After design is complete
- For simple features (can skip design)
- When you have clear requirements

### /execute-prp
- When PRP is ready
- For actual implementation
- Includes built-in validation

## 🔧 Requirements

- Claude AI access (via API or Claude.ai)
- Python environment (for generated code)
- Git for version control

## 📄 License

This bootstrap template is provided as-is for use with Claude AI development workflows.

---

Ready to start designing? Create your first feature file and let Claude guide you through the design process!