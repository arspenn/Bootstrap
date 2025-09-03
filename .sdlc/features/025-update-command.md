# Feature: Update Command

**Date**: 2025-09-02
**Priority**: High
**Status**: Requirements Defined

## User Story

As a developer
I want to stage changes, update the changelog, and commit with a single command
So that I can maintain consistent project updates without missing steps

## Acceptance Criteria

### Scenario 1: Standard Update Flow
- **Given** I have made changes to tracked and/or untracked files
- **When** I run `/update` with a commit message
- **Then** The command should:
  - Discover all modified and untracked files
  - Show a summary of changes to be staged
  - Update the CHANGELOG.md with appropriate entries
  - Stage all approved changes
  - Create a commit with proper formatting
  - Follow all git safety rules

### Scenario 2: Version Bump Detection
- **Given** The changes warrant a version bump
- **When** The command analyzes the changes
- **Then** It should:
  - Detect the type of version bump needed (major/minor/patch)
  - Update version in config.yaml
  - Add version entry to CHANGELOG.md
  - Include version tag in commit message

### Scenario 3: Safety Checks
- **Given** There are potential issues with the changes
- **When** Safety checks are performed
- **Then** The command should:
  - Block if sensitive files detected (*.env, *.key, etc.)
  - Warn about large files (>10MB)
  - Prevent staging of binary files without confirmation
  - Check for uncommitted changes from previous work
  - Verify branch is appropriate for commits

### Scenario 4: Interactive Mode
- **Given** No commit message is provided
- **When** I run `/update` without arguments
- **Then** The command should:
  - Analyze changes and suggest a commit message
  - Prompt for changelog entries if needed
  - Ask for version bump confirmation if applicable

## Additional Context

### Command Process Flow

1. **Discovery Phase**
   - Run `git status` to find all changes
   - Identify untracked files
   - Check for changes outside current context
   - Detect file patterns and types

2. **Analysis Phase**
   - Categorize changes (features, fixes, etc.)
   - Determine changelog requirements
   - Check version bump necessity
   - Apply git safety rules

3. **Changelog Update**
   - Use changelog-entry.template
   - Auto-categorize changes
   - Generate user-focused descriptions
   - Maintain proper formatting

4. **Staging Phase**
   - Stage files individually (no wildcards)
   - Verify each file against safety rules
   - Show progress for multiple files
   - Handle errors gracefully

5. **Commit Phase**
   - Format message per git-commit-format rule
   - Include task references if applicable
   - Add version tags when needed
   - Execute commit with proper validation

### Integration Requirements

- Must use existing templates:
  - `.claude/templates/changelog-entry.template`
  - `.claude/templates/commit-message.template` (if exists)
  
- Must follow all git rules:
  - `git-add-safety.md` - No wildcards, check patterns
  - `git-commit-format.md` - Proper message formatting
  - `git-safe-file-operations.md` - File safety checks
  - `task-commit-integration.md` - Link to tasks if applicable

- Must respect version management:
  - Follow semantic versioning
  - Update config.yaml version field
  - Create appropriate tags

### Error Handling

- **Merge conflicts**: Abort and inform user
- **Unstaged changes from before**: Ask to stash or include
- **Large files**: Require explicit confirmation
- **Binary files**: Warn and require confirmation
- **Sensitive files**: Block completely with clear message
- **Failed changelog update**: Offer manual edit option

### Success Indicators

- All changes properly staged
- Changelog accurately updated
- Commit message follows standards
- Version bumped if needed
- No sensitive files included
- All safety checks passed

## Technical Considerations

- Command should work even if changes were made outside Claude's context
- Must handle both tracked and untracked files
- Should preserve file permissions and attributes
- Needs to handle special characters in filenames
- Must work across different git configurations

## Example Usage

```bash
# With commit message
/update "feat: add insight capture command"

# Interactive mode
/update
> Analyzing changes...
> Found: 3 new files, 2 modified files
> Suggested message: "feat: add update command with changelog integration"
> Update CHANGELOG.md? (y/n)
> Version bump needed? (patch/minor/major/none)

# With version bump
/update "feat: major refactor of command system" --version major
```

## Dependencies

### Required Rules
- All git safety rules must be loaded
- Changelog update rule must be active
- Version management rule must be configured

### Required Templates
- Changelog entry template must exist
- Commit message template (optional but recommended)

### Required Commands
- Git must be installed and configured
- File system access for reading/writing

## Priority Rationale

High priority because this command:
- Streamlines the development workflow
- Ensures consistency across updates
- Reduces manual steps and potential errors
- Enforces project standards automatically

---
*Generated by quick-feature command*