# PRP: Update Command Implementation

## Goal
Implement the `/update` command that provides a unified workflow for discovering changes, analyzing for version bumps, updating changelog, staging files safely, and creating properly formatted commits. This command should streamline the development process by combining multiple manual steps into a single intelligent operation while maintaining all safety checks and project standards.

## Why
- **Workflow Automation**: Replace 5+ manual steps with single command
- **Consistency Enforcement**: Ensure changelog updates and proper commit formatting
- **Safety Preservation**: Apply all git safety rules automatically
- **Version Intelligence**: Auto-detect appropriate version bumps from changes
- **Developer Experience**: Reduce cognitive load and prevent missed steps

## What
A comprehensive update command that discovers all repository changes, intelligently suggests version bumps, generates changelog entries, stages files safely in batches, and creates properly formatted commits with all necessary metadata.

### Success Criteria
- [ ] Discovers all changes repository-wide respecting .gitignore
- [ ] Correctly suggests version bumps based on changes
- [ ] Updates CHANGELOG.md with appropriate entries and commit links
- [ ] Stages files in logical batches with single confirmations
- [ ] Creates conventional commits with task references
- [ ] Handles errors gracefully with clear recovery paths
- [ ] Completes typical update in < 30 seconds

## All Needed Context

### Documentation & References
```yaml
# MUST READ - Include these in your context window
- file: .sdlc/designs/025-update-command/design.md
  why: Complete architectural design with all components
  
- file: .sdlc/designs/025-update-command/adrs/ADR-001-batch-processing-strategy.md
  why: Batching strategy for minimal confirmations
  
- file: .sdlc/designs/025-update-command/adrs/ADR-002-version-detection-approach.md
  why: Version bump detection logic
  
- file: .sdlc/designs/025-update-command/adrs/ADR-003-changelog-integration.md
  why: Changelog update strategy with commit links

- file: .claude/commands/task-update.md
  why: Command structure pattern to follow
  lines: 1-140
  
- file: .claude/commands/insight-capture.md
  why: Phase structure and error handling patterns
  lines: 1-150

- file: .claude/rules/git/git-add-safety.md
  why: Git safety rules to enforce
  
- file: .claude/rules/git/git-commit-format.md
  why: Commit format requirements
  
- file: .claude/rules/git/task-commit-integration.md
  why: Task reference handling in commits

- file: .claude/templates/changelog-entry.template
  why: Changelog entry format and categories
  
- file: .claude/templates/commit-message.template
  why: Commit message structure

- file: .claude/config.yaml
  why: Version field location and format
  lines: 1-10

- file: CHANGELOG.md
  why: Current changelog format and structure
  lines: 1-50

- doc: https://keepachangelog.com/en/1.1.0/
  section: Format specification
  critical: Categories and version format

- doc: https://www.conventionalcommits.org/en/v1.0.0/
  section: Specification
  critical: Type, scope, and breaking change format
```

### Current Codebase Tree
```bash
Bootstrap/
├── .claude/
│   ├── commands/         # Command implementations (task-*.md, insight-capture.md)
│   ├── config.yaml       # Version field: project.version
│   ├── rules/            # Git safety and format rules
│   └── templates/        # Commit and changelog templates
├── .sdlc/
│   ├── designs/025-update-command/  # Design and ADRs
│   └── features/025-update-command.md
├── CHANGELOG.md          # Keep a Changelog format
└── TASK.md              # Task tracking for references
```

### Known Gotchas & Critical Patterns
```markdown
# CRITICAL: Git safety rules
# Never use: git add ., git add -A, git add --all
# Must use: git add file1 file2 file3 (explicit paths)

# PATTERN: Single confirmation per batch
# Claude Code shows ONE confirmation dialog per command
# Batch multiple files: git add file1.md file2.md file3.md

# GOTCHA: Changelog version format
# Format: ## [0.11.0] - 2025-09-02 [abc123f](url)
# Previous version may need commit link added

# PATTERN: Command argument extraction
# Commands receive arguments via $ARGUMENTS variable
# Can be empty, single value, or complex string

# GOTCHA: Version in config.yaml
# Located at: project.version
# Format: "0.10.0" (string with quotes)

# PATTERN: File operations
# Always use absolute paths
# Check file exists before operations
# Use Edit for modifications, Write for new files
```

## Implementation Blueprint

### Data Models and Structure

```python
# Change categorization
CHANGE_TYPES = {
    'M': 'modified',
    'A': 'added', 
    'D': 'deleted',
    'R': 'renamed',
    '?': 'untracked'
}

# Version bump detection
VERSION_KEYWORDS = {
    'major': ['breaking', 'major', 'incompatible'],
    'minor': ['feat', 'feature', 'add', 'new'],
    'patch': ['fix', 'patch', 'bug', 'docs', 'chore']
}

# Changelog categories
CHANGELOG_CATEGORIES = ["Added", "Changed", "Deprecated", "Removed", "Fixed", "Security"]

# Forbidden file patterns (from git-add-safety)
FORBIDDEN_PATTERNS = ["*.env", "*.key", "*.pem", "*_secret*", "*password*"]
MAX_FILE_SIZE = "10MB"
```

### List of Tasks to Complete (in order)

```yaml
Task 1:
CREATE .claude/commands/update.md:
  - MIRROR structure from: .claude/commands/task-update.md
  - INCLUDE all 5 phases from design document
  - ADD comprehensive error handling sections
  - PRESERVE Bootstrap command pattern

Task 2:
IMPLEMENT Phase 1 - Discovery:
  - EXECUTE git status --porcelain
  - PARSE output into change categories
  - GROUP files by type (config/source/tests/docs/other)
  - CHECK for uncommitted previous work
  - RESPECT .gitignore patterns

Task 3:
IMPLEMENT Phase 2 - Analysis:
  - ANALYZE file types and change patterns
  - DETECT version bump from input + changes
  - BUILD change context for commit/changelog
  - APPLY safety rules (file size, forbidden patterns)
  - PREPARE batches for staging

Task 4:
IMPLEMENT Phase 3 - Changelog Generation:
  - READ current CHANGELOG.md
  - FIND last version and Unreleased section
  - GENERATE entries based on changes and message
  - ADD commit hash links to versions
  - UPDATE previous version if missing link
  - USE Edit tool to modify CHANGELOG.md

Task 5:
IMPLEMENT Phase 4 - Safe Staging:
  - BATCH files logically (single git add per batch)
  - CHECK each file against forbidden patterns
  - VERIFY file sizes < 10MB
  - EXECUTE git add with explicit file paths
  - SHOW clear batch descriptions

Task 6:
IMPLEMENT Phase 5 - Commit Creation:
  - EXPAND brief input to full message
  - APPLY conventional commit format
  - ADD task references if found (Refs: TASK-XXX)
  - INCLUDE version in message if bumped
  - EXECUTE git commit with formatted message

Task 7:
IMPLEMENT Version Management:
  - READ .claude/config.yaml
  - UPDATE project.version field if bumped
  - MAINTAIN yaml format and structure
  - VERIFY version update succeeded
```

### Per Task Implementation Details

```markdown
# Task 1: Command File Structure
## Command: /update

## Arguments
$ARGUMENTS - Brief commit message or version indication (optional)

## When to Use This Command
**Use `/update` when:**
- Ready to commit changes with changelog update
- Need intelligent version bump detection
- Want unified staging and commit workflow
- Have multiple files to stage safely

## Process

### Phase 1: Discovery
1. Check git repository status
2. Run `git status --porcelain` for all changes
3. Parse and categorize changes
4. Check for previous uncommitted work
5. Group files by type for batching

### Phase 2: Analysis  
1. Analyze file types and changes
2. Detect version bump need from input + changes
3. Build change context
4. Apply safety rules
5. Prepare staging batches

### Phase 3: Changelog
1. Read current CHANGELOG.md
2. Generate new entries
3. Add commit links to versions
4. Update with user confirmation

### Phase 4: Staging
1. Apply safety checks
2. Stage files in logical batches
3. Show progress
4. Handle special characters

### Phase 5: Commit
1. Expand commit message
2. Apply format rules
3. Add task references
4. Execute commit

# Task 2-3: Discovery and Analysis
def discover_changes():
    # Get all changes
    result = bash("git status --porcelain")
    changes = parse_git_status(result)
    
    # Group by type
    batches = {
        'config': [],
        'source': [],
        'tests': [],
        'docs': [],
        'other': []
    }
    
    for file in changes:
        if file.startswith('.claude/'):
            batches['config'].append(file)
        elif file.endswith(('.py', '.js', '.ts')):
            batches['source'].append(file)
        elif 'test' in file.lower():
            batches['tests'].append(file)
        elif file.endswith('.md'):
            batches['docs'].append(file)
        else:
            batches['other'].append(file)
    
    return batches

def detect_version_bump(input_arg, file_changes):
    # Check for explicit version
    if '--version' in input_arg:
        return extract_version_type(input_arg)
    
    # Check for version keywords
    for level, keywords in VERSION_KEYWORDS.items():
        if any(kw in input_arg.lower() for kw in keywords):
            return level
    
    # Analyze file changes
    if has_breaking_changes(file_changes):
        return 'major'
    elif has_new_features(file_changes):
        return 'minor'
    else:
        return 'patch'

# Task 4: Changelog Update
def update_changelog(version, changes, commit_message):
    # Read current changelog
    changelog = read_file("CHANGELOG.md")
    
    # Generate entries
    entries = generate_changelog_entries(changes, commit_message)
    
    # Add commit link to new version
    new_version_line = f"## [{version}] - {today} [{commit_hash[:7]}]"
    
    # Check previous version for missing link
    if previous_version_needs_link(changelog):
        add_previous_version_link(changelog)
    
    # Update changelog
    update_file("CHANGELOG.md", updated_content)

# Task 5: Safe Staging
def stage_files_safely(batches):
    for category, files in batches.items():
        if not files:
            continue
        
        # Check safety rules
        for file in files:
            check_forbidden_patterns(file)
            check_file_size(file)
        
        # Stage batch with single command
        file_list = ' '.join(files)
        description = f"Staging {len(files)} {category} files"
        bash(f"git add {file_list}", description=description)

# Task 6: Commit Creation
def create_commit(message, version=None, tasks=None):
    # Expand message
    full_message = expand_commit_message(message)
    
    # Add version if bumped
    if version:
        full_message += f"\n\nVersion: {version}"
    
    # Add task references
    if tasks:
        full_message += f"\n\nRefs: {', '.join(tasks)}"
    
    # Create commit
    bash(f'git commit -m "{full_message}"')
```

### Integration Points
```yaml
FILES_TO_MODIFY:
  - CHANGELOG.md: Add new entries and version links
  - .claude/config.yaml: Update project.version field

RULES_TO_FOLLOW:
  - git-add-safety: No wildcards, check patterns
  - git-commit-format: Conventional format
  - task-commit-integration: Add task references
  - changelog-update: Ensure changelog updated
  - version-management: Semantic versioning

ERROR_HANDLING:
  - uncommitted_changes: "Found uncommitted changes from previous work. Stash or include?"
  - forbidden_file: "Cannot stage {file} - matches forbidden pattern"
  - large_file: "File {file} is >10MB. Stage anyway? (y/n)"
  - changelog_conflict: "CHANGELOG.md has conflicts. Resolve manually"
  - version_exists: "Version {version} already exists. Use different version?"
```

## Validation Loop

### Level 1: Command Structure
```bash
# Check command file created
ls -la .claude/commands/update.md

# Validate markdown structure
head -100 .claude/commands/update.md

# Expected: Proper command structure with all phases
```

### Level 2: Change Discovery
```bash
# Test discovery with sample changes
touch test1.md test2.py
echo "test" > test1.md

# Run discovery phase
# Should categorize: test1.md → docs, test2.py → source
```

### Level 3: Version Detection
```markdown
# Test 1: Explicit version
/update "breaking: remove old API" --version major
Expected: Detects major version bump

# Test 2: Keywords
/update "feat: add new command"
Expected: Detects minor version bump

# Test 3: File analysis
/update "update docs"
Expected: Detects patch version bump
```

### Level 4: Changelog Update
```bash
# Check changelog updated
grep "## \[0.11.0\]" CHANGELOG.md

# Verify commit link added
grep "\[.*\](https://github.com/" CHANGELOG.md

# Expected: New version with commit link
```

### Level 5: Safe Staging
```bash
# Create forbidden file
echo "secret" > test.env

# Attempt staging
# Expected: Blocks test.env, stages others

# Check staged files
git status --short
```

### Level 6: Commit Format
```bash
# Check commit message
git log -1 --pretty=format:"%s%n%n%b"

# Expected: Conventional format with metadata
```

## Final Validation Checklist
- [ ] Command file follows Bootstrap pattern
- [ ] Discovers all changes correctly
- [ ] Version detection works with various inputs
- [ ] Changelog updated with proper format
- [ ] Commit links added to versions
- [ ] Files staged in efficient batches
- [ ] Safety rules enforced (no forbidden files)
- [ ] Commit message properly formatted
- [ ] Task references included when applicable
- [ ] Processing completes in < 30 seconds

## Anti-Patterns to Avoid
- ❌ Don't use `git add .` or wildcards
- ❌ Don't stage forbidden patterns (*.env, *.key)
- ❌ Don't skip changelog update
- ❌ Don't force version bumps without user confirmation
- ❌ Don't create multiple confirmations for logical batches
- ❌ Don't lose context when processing many files

## Testing Scenarios

### Scenario 1: Standard Update
```bash
# Make changes
echo "update" > README.md
touch new-feature.md

# Run update
/update "docs: update README and add feature doc"

# Verify:
- Version bumped to patch
- Changelog updated with docs changes
- Files staged and committed
```

### Scenario 2: Major Version with Tasks
```bash
# Make breaking changes
rm old-api.py
touch new-api.py

# Run update
/update "breaking: replace old API with v2"

# Verify:
- Version bumped to major
- Changelog shows breaking change
- Commit includes BREAKING CHANGE note
```

### Scenario 3: Large Changeset
```bash
# Create many files
for i in {1..20}; do touch "file$i.md"; done

# Run update
/update "feat: add documentation suite"

# Verify:
- Files batched logically
- Single confirmation per batch
- Progress shown during staging
```

## Implementation Notes

### Critical Implementation Details
1. **Batch Staging**: Use single `git add` with multiple files for one confirmation
2. **Version Detection**: Analyze both input and actual changes
3. **Changelog Links**: Add commit hash to current and previous versions
4. **Safety First**: Check every file against forbidden patterns
5. **Error Recovery**: Always provide clear next steps

### Command Implementation Pattern
Follow the established Bootstrap command pattern:
- Clear command header with description
- Arguments section explaining $ARGUMENTS
- When to Use section with bullet points
- Detailed Process with numbered phases
- Usage examples showing various scenarios
- Output examples with expected results
- Error handling section
- Related commands section

### Example Output
```
🔄 Update Command
================

Discovering changes...
✓ Found 5 modified files, 3 new files

Analyzing changes...
✓ Changes suggest: minor version bump (0.10.0 → 0.11.0)
✓ Detected new feature additions

Preparing changelog...
✓ Generated 3 Added entries, 2 Changed entries

Staging files...
✓ Staging 3 configuration files
✓ Staging 2 source files  
✓ Staging 3 documentation files

Creating commit...
✓ Commit message: feat: add update command with changelog integration
✓ Version bumped to 0.11.0
✓ Changelog updated

✅ Update complete!
```

---

## Quality Score: 9/10

**Confidence for one-pass implementation**: Very High

**Strengths**:
- Comprehensive context with all needed files
- Clear task breakdown with implementation details
- Extensive validation scenarios
- All gotchas and patterns documented
- Error handling strategies included

**Minor Considerations**:
- Complex multi-phase implementation may need debugging
- Changelog parsing might need refinement for edge cases

This PRP provides all necessary context for Claude Code to implement the update command successfully in a single pass, with clear validation gates and comprehensive error handling.