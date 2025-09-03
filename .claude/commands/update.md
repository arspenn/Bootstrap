# Update

## Command: /update

Unified workflow for staging changes, updating changelog, and creating properly formatted commits. This command discovers all repository changes, intelligently suggests version bumps, generates changelog entries, stages files safely, and creates commits with all necessary metadata.

## Arguments

$ARGUMENTS - Brief commit message or version indication (optional)

Examples:
- `/update "feat: add new command"` - Auto-detects minor version bump
- `/update "fix: resolve bug" --version patch` - Explicit patch version
- `/update "breaking: remove old API"` - Auto-detects major version
- `/update` - Interactive mode with prompts

## When to Use This Command

**Use `/update` when:**
- Ready to commit changes with automatic changelog update
- Need intelligent version bump detection
- Want unified staging and commit workflow
- Have multiple files to stage safely
- Want to ensure all project standards are followed

**This command will:**
- Discover all modified and untracked files
- Suggest appropriate version bumps
- Update CHANGELOG.md with entries and commit links
- Stage files in safe, logical batches
- Create conventional commits with metadata
- Update version in config.yaml if needed

## Process

### Phase 1: Discovery
1. **Check Repository Status**
   - Verify git repository exists
   - Check for .git directory
   - Ensure working directory is clean enough

2. **Discover All Changes**
   - Run `git status --porcelain` for complete change list
   - Parse output to categorize: modified, added, deleted, renamed, untracked
   - Respect .gitignore patterns automatically

3. **Check Previous Work**
   - Detect if there are uncommitted changes from earlier
   - If found, ask: "Found uncommitted changes from previous work. Stash or include?"
   - If stash chosen: saves changes temporarily (restore later with `git stash pop`)
   - If include chosen: adds previous changes to current commit

4. **Group Files by Type**
   - Configuration files (.claude/, .sdlc/config)
   - Source code files (.py, .js, .ts, etc.)
   - Test files (containing 'test' in path)
   - Documentation files (.md)
   - Other files

### Phase 2: Analysis
5. **Analyze Changes**
   - Count files by type
   - Detect patterns indicating change type
   - Check for breaking changes (deletions, API changes)
   - Look for new features (new files, new exports)
   - Identify bug fixes (changes to existing logic)

6. **Detect Version Bump**
   - Check for explicit version in arguments (`--version major/minor/patch`)
   - Analyze commit message keywords:
     - "breaking", "major" → major version
     - "feat", "feature", "add" → minor version  
     - "fix", "patch", "bug", "docs" → patch version
   - Analyze file changes if no clear indication
   - Default to patch for small changes

7. **Apply Safety Rules**
   - Check for forbidden patterns: *.env, *.key, *.pem, *_secret*, *password*
   - Verify file sizes (warn if >10MB)
   - Check for binary files (warn if detected)
   - Build list of files safe to stage

8. **Build Change Context**
   - Create summary of changes for commit message
   - Prepare changelog entry categories
   - Extract any task references from message

### Phase 3: Changelog Generation & Version Sync
9. **Read Current State**
   - Load CHANGELOG.md file
   - Parse to find current version in changelog
   - Load .claude/config.yaml to get config version
   - Verify versions are synchronized (warn if mismatch)
   - Locate Unreleased section
   - Check if previous version needs commit link

10. **Generate Changelog Entries**
    - Categorize changes:
      - Added: New features or capabilities
      - Changed: Changes to existing functionality
      - Deprecated: Features marked for removal
      - Removed: Deleted features
      - Fixed: Bug fixes
      - Security: Security fixes
    - Create user-focused descriptions
    - Use commit message as primary source

11. **Prepare Version Update**
    - Use versions already read in step 9
    - Calculate new version based on bump type
    - Format: `## [X.Y.Z] - YYYY-MM-DD [commit]`
    - Prepare to update both changelog and config.yaml
    - Prepare to add commit link after commit created

12. **Update Changelog**
    - Move Unreleased content to new version section
    - Add commit link to new version (placeholder for now)
    - Check and add missing commit link to previous version
    - Show proposed changes for confirmation

### Phase 4: Safe Staging
13. **Prepare Staging Batches**
    - Group files logically to minimize confirmations
    - Create descriptive summary for each batch
    - Order batches by importance

14. **Check Safety for Each File**
    - Verify against forbidden patterns
    - Check file size limits
    - Warn about binary files
    - Skip any unsafe files

15. **Stage Files in Batches**
    - Execute single `git add` command per batch
    - Use explicit file paths (never wildcards)
    - Show clear description: "Staging 5 documentation files"
    - Handle special characters in filenames

16. **Report Staging Progress**
    - Show files staged per batch
    - Report any files skipped
    - Confirm all safe files staged

### Phase 5: Commit Creation
17. **Expand Commit Message**
    - Parse brief input into full conventional format
    - Determine type: feat, fix, docs, style, refactor, test, chore
    - Extract scope if applicable
    - Expand subject line to be descriptive

18. **Add Metadata**
    - Add version bump information if applicable
    - Include task references (Refs: TASK-XXX)
    - Add BREAKING CHANGE note if major version
    - Include changelog summary in body

19. **Create Commit**
    - Execute git commit with formatted message
    - Capture commit hash for changelog
    - Verify commit succeeded

20. **Finalize Updates**
    - Update CHANGELOG.md with actual commit hash
    - Update version in .claude/config.yaml if bumped
    - Ensure config version matches changelog version
    - Report success with summary

## Usage Examples

### Standard Feature Addition
```bash
/update "feat: add update command for unified workflow"

# Output:
🔄 Update Command
================
Discovering changes...
✓ Found 3 new files, 2 modified files

Analyzing changes...
✓ Detected new feature addition
✓ Suggested version: 0.10.0 → 0.11.0 (minor)

Updating changelog...
✓ Added 2 entries to "Added" section
✓ Added 1 entry to "Changed" section

Staging files...
✓ Staging 2 command files
✓ Staging 3 documentation files

Creating commit...
✓ Commit created with message: feat: add update command for unified workflow
✓ Version bumped to 0.11.0 in CHANGELOG.md
✓ Version updated to 0.11.0 in config.yaml

✅ Update complete!
```

### Bug Fix with Patch Version
```bash
/update "fix: resolve issue with file staging"

# Output:
🔄 Update Command
================
Discovering changes...
✓ Found 1 modified file

Analyzing changes...
✓ Detected bug fix
✓ Suggested version: 0.11.0 → 0.11.1 (patch)

Updating changelog...
✓ Added 1 entry to "Fixed" section

Staging files...
✓ Staging 1 source file

Creating commit...
✓ Commit created with message: fix: resolve issue with file staging
✓ Version bumped to 0.11.1 in CHANGELOG.md
✓ Version updated to 0.11.1 in config.yaml

✅ Update complete!
```

### Breaking Change
```bash
/update "breaking: redesign command interface"

# Output:
🔄 Update Command
================
Discovering changes...
✓ Found 5 modified files, 2 deleted files

Analyzing changes...
✓ Detected breaking changes
✓ Suggested version: 0.11.0 → 1.0.0 (major)

Updating changelog...
✓ Added 3 entries to "Changed" section
✓ Added 2 entries to "Removed" section
✓ Added BREAKING CHANGE note

Staging files...
✓ Staging 5 modified files
✓ Staging 2 deletions

Creating commit...
✓ Commit created with breaking change note
✓ Version bumped to 1.0.0 in CHANGELOG.md
✓ Version updated to 1.0.0 in config.yaml

✅ Update complete!
```

### Interactive Mode (No Arguments)
```bash
/update

# Output:
🔄 Update Command
================
Discovering changes...
✓ Found 3 modified files, 1 new file

No commit message provided. Analyzing changes...
✓ Changes appear to be: documentation updates

Suggested commit message: "docs: update command documentation"
Use this message? (y/n/edit): y

Suggested version bump: patch (0.11.0 → 0.11.1)
Accept? (y/n/major/minor/patch): y

[Continues with normal flow...]
```

## Error Handling

### Repository Issues
- **Not a git repository**: "Error: Not in a git repository. Run 'git init' first."
- **No changes found**: "No changes to commit. Make some changes first."
- **Dirty working tree**: "Found uncommitted changes from previous work. Stash or include?"

### Safety Violations
- **Forbidden files detected**: "Cannot stage {file} - matches forbidden pattern {pattern}"
- **Large file warning**: "Warning: {file} is {size}. Stage anyway? (y/n)"
- **Binary file warning**: "Warning: {file} appears to be binary. Stage anyway? (y/n)"

### Changelog Issues
- **CHANGELOG.md not found**: "CHANGELOG.md not found. Create one? (y/n)"
- **Merge conflicts**: "CHANGELOG.md has conflicts. Resolve manually and retry."
- **Parse error**: "Cannot parse CHANGELOG.md. Check format and retry."

### Version Issues
- **Version mismatch**: "Warning: config.yaml version ({config_ver}) doesn't match changelog ({changelog_ver}). Using changelog version."
- **Version already exists**: "Version {version} already exists. Use different version?"
- **Invalid version format**: "Invalid version format. Use semantic versioning (X.Y.Z)"
- **Config not found**: "Cannot find .claude/config.yaml. Check configuration."
- **Config update failed**: "Failed to update version in config.yaml. Update manually."

### Commit Issues
- **Commit failed**: "Commit failed: {error}. Fix issues and retry."
- **No commit message**: "Commit message required. Provide message or use interactive mode."
- **Invalid format**: "Message doesn't follow conventional format. Reformat? (y/n)"

## Configuration

The command uses configuration from:
- `.claude/config.yaml` - Project version and settings
- `.claude/rules/git/*` - Git safety rules
- `.claude/templates/*` - Commit and changelog templates
- `CHANGELOG.md` - Current changelog entries
- `.gitignore` - Files to exclude from staging

## Notes

- **Safety First**: Never uses `git add .` or wildcards
- **Batch Efficiency**: Groups files to minimize confirmations
- **Version Intelligence**: Analyzes both message and changes
- **Changelog Automation**: Updates with every version bump
- **Commit Links**: Adds GitHub-style commit links to versions
- **Error Recovery**: Provides clear next steps for all errors
- **Task Integration**: Detects and includes task references

## Related Commands

- `/task-update` - Update task status when referenced
- `/insight-capture` - Capture discoveries during development
- `/quick-feature` - Create feature specifications
- `/design-feature` - Design features before implementation

## Implementation Details

### Version Synchronization
```
The command ensures version consistency:
1. Read current version from CHANGELOG.md
2. Read version from .claude/config.yaml
3. Warn if they don't match
4. When bumping version:
   - Update CHANGELOG.md with new version
   - Update project.version in config.yaml
   - Both files get same version number
5. Include both files in the commit
```

### Change Type Detection
```
Status Codes:
- M = Modified file
- A = Added file (staged)
- D = Deleted file
- R = Renamed file
- ? = Untracked file
- ! = Ignored file (skip)
```

### Version Bump Rules
```
Major (X.0.0):
- Breaking changes
- Removed features
- Incompatible API changes

Minor (0.X.0):
- New features
- New commands
- Backward-compatible additions

Patch (0.0.X):
- Bug fixes
- Documentation updates
- Internal refactoring
```

### File Batching Strategy
```
Batches created by:
1. Configuration files (.claude/)
2. Source code files
3. Test files
4. Documentation files
5. Other files

Each batch staged with single command for one confirmation.
```

### Forbidden Patterns
```
Never stage:
- *.env (environment files)
- *.key (private keys)
- *.pem (certificates)
- *_secret* (secret files)
- *password* (password files)
```

---
*Command implementation follows Bootstrap framework patterns for safety and consistency*