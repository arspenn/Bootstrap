# Init - Project Initialization

## Arguments: $ARGUMENTS

One-time project setup and charter creation. Accepts optional project name as argument.

## When to Use This Command

**Use `/init` when:**
- Starting a new project from scratch
- Setting up Bootstrap framework for first time
- Creating initial project charter
- Establishing project principles and governance

**Skip when:**
- CHARTER.md already exists and is comprehensive
- Project already initialized with .sdlc/ structure
- Only doing feature-level work on existing project

## Multi-Agent Architecture

### Primary Agent: Requirements Engineer
You are the Requirements Engineer with PhD-level expertise. Think hard about understanding the project's core purpose and establishing proper foundation.

### Agent Team
When stack detection is needed, launch Project Manager to coordinate:
**Project Manager personality:** `.claude/agents/project-manager.md`
- Python Expert for Python/Django/FastAPI detection
- Node.js Expert for JavaScript/TypeScript/React/Vue
- Database Expert for data layer identification
- DevOps Expert for deployment/infrastructure patterns

## Process

### 1. **Initial Assessment**
Check for existing project setup:
```bash
# Check if already initialized
if [ -f "CHARTER.md" ]; then
    echo "CHARTER.md already exists. Use '/update' to modify it."
    # Ask user if they want to reinitialize
fi

# Check for existing .sdlc structure
if [ -d ".sdlc" ]; then
    echo ".sdlc/ structure exists. Checking completeness..."
fi
```

If $ARGUMENTS contains project name, use it. Otherwise, ask interactively.

### 2. **Interactive Gathering** (Section-by-Section)

**Step 1: Project Name**
If not provided in arguments:
"What is the name of your project?"

**Step 2: Charter Mode Selection**
"What level of formality do you need for your charter?
- **prototype**: Minimal charter for rapid experimentation (recommended for POCs)
- **draft**: Comprehensive charter for active development (recommended for most projects)
- **ratified**: Formal charter with amendment process (for production systems)
Choose: [prototype/draft/ratified]"

**Step 3: Project Description**
"Provide a brief description of what you're building (2-3 sentences):"

**Step 4: Technology Stack**
"What technology stack will you use? (leave blank if unknown, we'll detect it)"

### 3. **Script Execution**

```bash
# Create SDLC structure
./.claude/scripts/init-structure.sh
# Expected output: "✓ Project SDLC structure initialized"

# Detect technology stack if not specified
if [ -z "$STACK" ]; then
    ./.claude/scripts/detect-stack.sh
    # Output: "Detected: Python (Django), PostgreSQL, Redis"
fi
```

### 4. **Multi-Agent Stack Detection** (if needed)

If stack is unknown or complex, launch specialists:

```
Use Task tool:
- description: "Detect project technology stack"
- subagent_type: "general-purpose"
- prompt: "You are a Project Manager coordinating stack detection. Think hard about identifying all technologies used.

  Your task:
  1. Launch these specialists in parallel using Task tool:
     - Python Expert to check for Python/pip/poetry/requirements.txt
     - Node.js Expert to check for package.json/node_modules
     - Database Expert to check for migrations/models/schemas
     - DevOps Expert to check for Dockerfile/docker-compose/k8s
  2. Synthesize findings into a comprehensive stack report
  3. Return primary stack and secondary technologies

  Context:
  - Project name: $PROJECT_NAME
  - Description: $DESCRIPTION
  - Files found: [provide file listing]

  Return format: 'Primary: [language], Framework: [if any], Database: [if any], Additional: [list]'"
```

### 5. **Charter Creation**

```bash
# Create charter from appropriate template
./.claude/scripts/create-charter.sh "$CHARTER_MODE"
# Output: "✓ Created CHARTER.md from charter-{mode}.template.md"
```

**Available charter templates:**
- `.claude/templates/charter-prototype.template.md` - Minimal for rapid prototyping
- `.claude/templates/charter-draft.template.md` - Comprehensive for active development
- `.claude/templates/charter-ratified.template.md` - Formal with amendment process

Fill charter sections one at a time using the template structure:
1. **Project Overview** → Get user feedback
2. **Core Principles** → Get user feedback
3. **Technical Decisions** → Get user feedback
4. Continue section by section...

Never fill the entire charter at once. Apply learnings from each section to the next.

### 6. **Validation & Reporting**

Report success:
```
✓ Project initialized successfully!
  - CHARTER.md created (mode: $CHARTER_MODE)
  - .sdlc/ structure established
  - Technology stack: $STACK

Next steps:
1. Review CHARTER.md and adjust as needed
2. Use '/determine' to gather requirements for first feature
3. Use '/design' to plan architecture
```

## Embedded Rules

### From `sdlc-directory-structure.md`:
- All project artifacts must be stored in `.sdlc/` subdirectories
- Structure: requirements/, designs/, implementation/, amendments/, ADRs/

### From `planning-context.md`:
- Charter establishes immutable project principles
- Changes require amendments in ratified mode
- Charter lives in project root for visibility

### From `sequential-file-naming.md`:
- Future artifacts will use ###-kebab-case pattern
- Sequential numbering starts at 001

## Error Handling

### Script Failures
- **init-structure.sh fails**: Check permissions, try `chmod +x ./.claude/scripts/*.sh`
- **detect-stack.sh fails**: Proceed with manual stack entry
- **create-charter.sh fails**: Check template exists, fall back to manual creation

### File Conflicts
- **CHARTER.md exists**: Ask if user wants to back up and recreate
- **.sdlc exists partially**: Check what's missing, complete structure

### Permission Issues
If permission denied:
```bash
echo "Fix with: chmod +x ./.claude/scripts/*.sh"
echo "Then retry the command"
```

## Command Validation

After successful initialization:
1. Verify CHARTER.md exists and has content
2. Verify .sdlc/ structure is complete
3. Verify scripts remain executable

---
Generated with Bootstrap v0.12.0