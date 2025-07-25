### 📋 Direct Imports of Rules
- **Always import rules first**
@.claude/MASTER_IMPORTS.md
- **Always report to the user after rules have been loaded**

### 🔄 Project Awareness & Context
- **Always read `PLANNING.md`** at the start of a new conversation to understand the project's architecture, goals, style, and constraints. Add this file if not already present.
- **Check `TASK.md`** before starting a new task. If the task isn’t listed, add it with a brief description and today's date. Add this file if not already present.
- **Use consistent naming conventions, file structure, and architecture patterns** as described in `PLANNING.md`.
- **Use venv_linux** (the virtual environment) whenever executing Python commands, including for unit tests.

### 🧱 Code Structure & Modularity
- **Never create a file longer than 500 lines of code.** If a file approaches this limit, refactor by splitting it into modules or helper files.
- **Organize code into clearly separated modules**, grouped by feature or responsibility.
  For agents this looks like:
    - `agent.py` - Main agent definition and execution logic 
    - `tools.py` - Tool functions used by the agent 
    - `prompts.py` - System prompts
- **Use clear, consistent imports** (prefer relative imports within packages).
- **Use clear, consistent imports** (prefer relative imports within packages).
- **Use python_dotenv and load_env()** for environment variables.

### 🧪 Testing & Reliability
- **Always create Pytest unit tests for new features** (functions, classes, routes, etc).
- **After updating any logic**, check whether existing unit tests need to be updated. If so, do it.
- **Tests should live in a `/tests` folder** mirroring the main app structure.
  - Include at least:
    - 1 test for expected use
    - 1 edge case
    - 1 failure case

### ✅ Task Completion
- **Mark completed tasks in `TASK.md`** immediately after finishing them.
- Add new sub-tasks or TODOs discovered during development to `TASK.md` under a “Discovered During Work” section.

### 📎 Style & Conventions
- **Use Python** as the primary language.
- **Follow PEP8**, use type hints, and format with `black`.
- **Use `pydantic` for data validation**.
- Use `FastAPI` for APIs and `SQLAlchemy` or `SQLModel` for ORM if applicable.
- **Follow design folder structure**: `{sequence}-{type}-{description}/` (e.g., `001-feature-task-management/`)
- **Check for design addendums**: When reading a design, also look for `design-addendum-*.md` files marked with `temporary-addendum` tag and treat them as part of the main design until integrated.
- Write **docstrings for every function** using the Google style:
  ```python
  def example():
      """
      Brief summary.

      Args:
          param1 (type): Description.

      Returns:
          type: Description.
      """
  ```

### 📚 Documentation & Explainability
- **Update `README.md`** when new features are added, dependencies change, or setup steps are modified.
- **Comment non-obvious code** and ensure everything is understandable to a mid-level developer.
- When writing complex logic, **add an inline `# Reason:` comment** explaining the why, not just the what.

### 🏛️ Architecture Decision Records (ADRs)
- **Use ADRs to document significant architectural decisions** that affect the project's structure, technology choices, or development workflow.
- **Project-wide ADRs** go in `docs/ADRs/` when they:
  - Affect multiple features or the entire codebase
  - Establish conventions or standards
  - Define technology choices or architectural patterns
  - Set security, performance, or workflow policies
- **Design-specific ADRs** stay with their feature in `designs/*/adrs/` when they:
  - Only affect that specific feature implementation
  - Document trade-offs unique to that feature
  - Explain implementation choices within established conventions
- **Follow the ADR template** in `templates/design-templates/adr.template.md`
- **Update the ADR Index** at `docs/ADRs/INDEX.md` when creating new ADRs
- **Use the ADR tools** to validate and manage ADRs: `python scripts/adr-tools.py --help`

### 🧠 AI Behavior Rules
- **Never assume missing context. Ask questions if uncertain.**
- **Never hallucinate libraries or functions** – only use known, verified Python packages.
- **Always confirm file paths and module names** exist before referencing them in code or tests.
- **Never delete or overwrite existing code** unless explicitly instructed to or if part of a task from `TASK.md`.