# Reset Framework

## Command: /reset-framework

Remove all Bootstrap development history and artifacts, preparing the framework for use in a new project. This command cleans the repository to a pristine state while preserving framework functionality.

## Arguments

None - this command takes no arguments.

## When to Use This Command

**Use `/reset-framework` when:**
- Starting a new project with the Bootstrap framework
- Testing the framework from a clean state
- Preparing the framework for distribution
- Before alpha testing or release

**This command will:**
- Remove all SDLC artifacts and development history
- Delete Bootstrap-specific documentation
- Clear git repository completely
- Reset configuration to generic defaults
- Preserve framework functionality

## Process

### Phase 1: Discovery & Analysis
1. **Scan Repository**
   - Check current directory structure
   - Identify Bootstrap development artifacts
   - Detect potential user code files
   - Build list of items to process

2. **Identify Targets**
   - Directories: `.sdlc/`, `responses/`, `.git/`
   - Files: `TASK.md`, `CHANGELOG.md`, `ROADMAP.md`, `CREDITS.md`, `PLANNING.md`, `README.md`
   - Preserve: `.claude/`, `CLAUDE.md`, `AI_TRANSPARENCY.md`, `LICENSE`, `requirements.txt`, `.gitignore`

### Phase 2: Interactive Resolution
3. **Handle Example Code**
   - For files outside framework directories
   - If code files detected (.py, .js, .java, etc.)
   - Ask user: "Found {file} - is this an example for your current project? (keep/remove)"
   - Record decisions for execution

### Phase 3: Execution
4. **Remove SDLC Artifacts**
   ```bash
   rm -rf .sdlc/
   ```

5. **Delete Development Files**
   ```bash
   rm -f TASK.md CHANGELOG.md ROADMAP.md CREDITS.md PLANNING.md README.md
   ```

6. **Remove Directories**
   ```bash
   rm -rf responses/
   rm -rf .git/
   ```

7. **Reset Configuration**
   - Copy `.claude/templates/config-default.template.yaml` to `.claude/config.yaml`
   - Configuration will have generic project settings

### Phase 4: Verification & Reporting
8. **Verify Framework Integrity**
   - Check `.claude/` directory exists
   - Confirm `CLAUDE.md` present
   - Validate core files preserved

9. **Generate Summary**
   - List all removed items
   - Report any errors encountered
   - Show final state assessment

## Usage

```bash
/reset-framework
```

## Output Examples

### Successful Reset
```
🔄 Reset Framework Command
========================

Scanning repository...
✓ Found Bootstrap development artifacts

Found potential example code:
- examples/demo.py - is this an example for your current project? (keep/remove)
> keep
✓ Preserving examples/demo.py

Removing development artifacts...
✓ Removed .sdlc/ directory (131 files)
✓ Removed TASK.md
✓ Removed CHANGELOG.md
✓ Removed ROADMAP.md
✓ Removed CREDITS.md
✓ Removed PLANNING.md
✓ Removed README.md
✓ Removed responses/ directory
✓ Removed .git/ directory

Resetting configuration...
✓ Configuration reset to defaults

Verification:
✓ Framework integrity maintained
✓ Core functionality preserved

Summary:
- Removed: 140 files, 9 directories
- Preserved: examples/demo.py (user choice)
- Status: Ready for new project development

✅ Framework successfully reset!
```

### Already Clean
```
🔄 Reset Framework Command
========================

Scanning repository...
✓ No Bootstrap artifacts found
✓ No development files present
✓ Configuration already at defaults

Status: Project verified as ready to develop

✅ Framework is already in clean state!
```

### With Errors
```
🔄 Reset Framework Command
========================

Scanning repository...
✓ Found Bootstrap development artifacts

Removing development artifacts...
✓ Removed .sdlc/ directory
⚠️ TASK.md not found (already removed)
✓ Removed CHANGELOG.md
⚠️ Permission denied: responses/protected.txt
✓ Removed .git/ directory

Summary:
- Removed: 95% of targeted files
- Warnings: 2 (see above)
- Status: Mostly clean, manual review recommended

⚠️ Framework reset completed with warnings
```

## Error Handling

### File Not Found
- Skip and continue
- Report in summary as already removed

### Permission Denied
- Skip file/directory
- Report in warnings
- Continue with other operations

### Already Clean
- Report clean state
- Provide verification summary
- Exit successfully

## Safety Features

1. **No Backup Required**: GitHub repository serves as backup
2. **Interactive Prompts**: For unknown files only
3. **Framework Protection**: Never removes `.claude/` or core files
4. **Graceful Degradation**: Continues despite individual errors
5. **Clear Reporting**: All actions logged and summarized

## Notes

- Command is idempotent (safe to run multiple times)
- Works on Linux, Mac, and Windows
- Preserves `.gitignore` as-is
- LICENSE file kept but user should update copyright name
- After reset, user should:
  1. Initialize new git repository
  2. Update project name in config.yaml
  3. Create project-specific README
  4. Begin development

## Related Commands

- `/load-rules` - Reload framework rules after reset
- `/gather-project-requirements` - Start defining new project