# Claude Configuration

## Rule Loading
@.claude/MASTER_IMPORTS.md

## Project Context
Loaded from: .claude/config.yaml

## AI Behavior Rules

### Context Verification
- **When file paths are ambiguous**: 
  - Use `Glob` to list possible matches with pattern
  - Present numbered options to user with full paths
  - Example: "Did you mean: 1) /src/main.py 2) /tests/test_main.py?"
  
- **When requirements are unclear**: 
  - State your interpretation explicitly
  - Ask: "I understand you want to [interpretation]. Is this correct?"
  - Wait for confirmation before proceeding
  
- **When multiple approaches exist**: 
  - Present 2-3 options with trade-offs
  - Format: "Option A: [approach] - Pros: [list] Cons: [list]"
  - Include factors: performance, complexity, maintainability, time

### Library and Import Safety
- **Before using any library**: 
  - Check requirements.txt or pyproject.toml with `Read` tool
  - If not found, ask: "This requires {library}. Should I add it to requirements.txt?"
  - Show install command: `pip install {library}=={version}`
  
- **Before importing modules**: 
  - Verify file exists with `LS` or `Glob` tool
  - For ambiguous imports, show file structure: "Found modules: ..."
  
- **When suggesting new libraries**: 
  - Include exact command: `pip install pandas==2.1.0`
  - Mention why this library vs alternatives
  - Check PyPI for latest stable version

### File System Operations
- **Before any file operation**: 
  - Use `Read` to check current content
  - Handle "file not found" gracefully
  - Show relevant portion of current content before changes
  
- **Before creating files**: 
  - Use `LS` on parent directory
  - Confirm: "Creating {file} in {directory}. Proceed?"
  - Show what will be created
  
- **For all paths**: 
  - Convert to absolute: `Path(path).resolve()`
  - Show resolved path in operations
  - Handle path errors with suggestions
  
- **After file changes**: 
  - Show diff-style output: "Changed lines X-Y:"
  - Include 2 lines of context above/below
  - Confirm: "{X} lines modified in {file}"

### Code Modification Safety
- **Requirement for deletion**: 
  - User must use: "delete", "remove", "clean up", or "get rid of"
  - Confirm: "This will delete {target}. Continue?"
  - Show what will be deleted
  
- **Requirement for overwrite**: 
  - User must use: "overwrite", "replace entirely", "start fresh"
  - Show current content first
  - Confirm: "This will replace all content. Continue?"
  
- **Exception**: 
  - When TASK.md lists: "Delete {file}" or "Replace {file}"
  - Still show what will be affected
  
- **Git awareness**: 
  - Run `git status {file}` before operations
  - Warn if file has uncommitted changes
  - Suggest: "Commit changes first?"

### Task Completion
- **Mark completed tasks in `TASK.md`** immediately after finishing them.
- Add new sub-tasks or TODOs discovered during development to `TASK.md` under a "Discovered During Work" section.

### Efficiency and Progress
- **Tool batching**: 
  - Group related operations: `Read` multiple files in one call
  - Example: Read all test files together
  - Combine file operations when logical
  
- **Task tracking**: 
  - Use `TodoWrite` for tasks with 3+ steps
  - Update status as you progress
  - Mark complete immediately when done
  
- **Error handling**: 
  - Show exact error message
  - Explain what it means
  - Provide specific fix: "Try: {command}"
  
- **Validation**: 
  - After code changes: `ruff check && mypy {file}`
  - After tests: `pytest {test_file} -v`
  - Show validation output

### Communication Standards
- **Ambiguity resolution**: 
  - Never guess - always clarify
  - Use: "Do you mean X or Y?"
  - Provide examples of each option
  
- **Progress updates**: 
  - For multi-step tasks: "Step 2/5: Creating test file..."
  - Report completion: "✓ Tests created and passing"
  
- **Error transparency**: 
  - Show full error with context
  - Include relevant log lines
  - Explain technical terms
  
- **Change confirmation**: 
  - Use unified diff format when appropriate
  - Summarize: "Added: X lines, Removed: Y lines, Modified: Z lines"

### Testing and Validation
- **After creating functions**: 
  - Create test file immediately
  - Include 3 test cases minimum
  - Run tests before claiming complete
  
- **After modifying logic**: 
  - Check: "Do existing tests cover this change?"
  - Update tests if needed
  - Show test output
  
- **Before claiming completion**: 
  - Run: `pytest`, `ruff check`, `mypy`
  - Only claim success if all pass
  
- **Test failure handling**: 
  - Show exact failure
  - Fix the code, not the test
  - Explain what was wrong

### Documentation Practices
- **Function creation**: 
  - Write docstring first
  - Include parameter types
  - Add usage example if complex
  
- **Complex logic**: 
  - Add comment: "# This works because..."
  - Explain non-obvious decisions
  
- **API changes**: 
  - Update relevant .md files
  - Include migration notes
  
- **Examples**: 
  - Show both input and output
  - Include edge cases
  - Make them copy-pasteable

## Override Hierarchy
1. User instructions (highest priority)
2. TASK.md requirements
3. Individual rule files (by priority)
4. Config file defaults
5. AI Behavior Rules (baseline)