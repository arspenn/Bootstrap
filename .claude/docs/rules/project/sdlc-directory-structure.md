# SDLC Directory Structure Rule

## Overview

This rule enforces the centralized Software Development Life Cycle (SDLC) directory structure for the Bootstrap framework. All SDLC artifacts must be stored in the `.sdlc/` hidden directory to maintain a clean project root.

## Purpose

- **Reduce root clutter**: Keeps the project root clean and focused on active code
- **Centralize SDLC artifacts**: All feature requests, designs, PRPs, and ADRs in one location
- **Maintain consistency**: Enforces standardized paths across the project
- **Improve discoverability**: Developers know exactly where to find SDLC documents

## Behavior

### Directory Structure

```
.sdlc/                    # Hidden directory for all SDLC artifacts
├── features/            # Feature requests and specifications
│   └── ###-*.md        # Sequential numbered features
├── designs/            # Design documents
│   └── ###-*/          # Sequential numbered design folders
│       ├── design.md   # Main design document
│       └── adrs/       # Design-specific ADRs (optional)
├── PRPs/               # Project Requirement Plans
│   └── *.md           # PRP documents
└── ADRs/               # Project-wide Architecture Decision Records
    └── ADR-###-*.md   # Sequential numbered ADRs
```

### Enforcement Rules

1. **File Creation Prevention**
   - Blocks creation of SDLC files in old locations:
     - `features/` at root
     - `designs/` at root
     - `PRPs/` at root
     - `docs/ADRs/` (project ADRs)
   
2. **Automatic Redirection**
   - When attempting to create SDLC files in wrong location
   - Suggests correct path in `.sdlc/` directory
   - Shows example of correct usage

3. **Path Validation**
   - Validates file paths during:
     - File creation
     - File moves
     - File saves
   - Ensures proper structure is maintained

## Trigger Conditions

- **File operations**: create, save, move
- **Locations monitored**:
  - Root directory for `features/`, `designs/`, `PRPs/`
  - `docs/` directory for ADRs
- **File patterns**:
  - `*.md` files in SDLC directories
  - Design folders with `/design.md`
  - ADR files matching `ADR-*.md`

## Examples

### Correct Usage

```bash
# Creating a new feature
.sdlc/features/020-new-feature.md ✓

# Creating a design
.sdlc/designs/020-new-feature/design.md ✓

# Creating a PRP
.sdlc/PRPs/new-feature.md ✓

# Creating a project-wide ADR
.sdlc/ADRs/ADR-002-api-design.md ✓
```

### Blocked Operations

```bash
# These will be blocked with error messages:
features/020-new-feature.md ✗
designs/020-new-feature/design.md ✗
PRPs/new-feature.md ✗
docs/ADRs/ADR-002-api-design.md ✗
```

## Integration with Other Rules

### Works with:
- **sequential-file-naming**: Ensures proper numbering in `.sdlc/features/` and `.sdlc/designs/`
- **adr-management**: Manages ADRs in `.sdlc/ADRs/` and `.sdlc/designs/*/adrs/`
- **design-structure**: Maintains design folder structure within `.sdlc/designs/`

### Priority: 700
- Runs after basic file operations
- Runs before documentation generation
- Higher priority than naming conventions

## Configuration

No configuration needed. The rule automatically:
- Detects SDLC file patterns
- Enforces `.sdlc/` directory usage
- Provides helpful error messages

## Migration

For existing projects:
1. Use migration script to move existing files
2. Update all references in documentation and configuration
3. Enable rule in MASTER_IMPORTS.md
4. Validate no files remain in old locations

## Exceptions

The following are NOT affected by this rule:
- `docs/` directory (project documentation remains at root)
- Test files in `tests/`
- Source code in `src/` or other code directories
- Configuration files at root (CLAUDE.md, README.md, etc.)
- Hidden directories other than `.sdlc/`

## Error Messages

### File Creation in Wrong Location
```
ERROR: SDLC files must be created in .sdlc/ directory
Attempted: features/new-feature.md
Correct: .sdlc/features/###-new-feature.md
```

### Invalid Structure
```
ERROR: Invalid SDLC directory structure
Expected: .sdlc/{features|designs|PRPs|ADRs}/
Found: {incorrect-path}
```

## Best Practices

1. **Use commands for creation**: Let framework commands handle path generation
   - `/gather-feature-requirements` for features
   - `/design-feature` for designs
   - `/generate-prp` for PRPs

2. **Maintain sequential numbering**: Follow the sequential-file-naming rule

3. **Keep ADRs organized**:
   - Project-wide ADRs in `.sdlc/ADRs/`
   - Design-specific ADRs in `.sdlc/designs/###-*/adrs/`

4. **VS Code visibility**: Add to settings.json if you want to see hidden directories:
   ```json
   {
     "files.exclude": {
       ".sdlc": false
     }
   }
   ```

## Troubleshooting

### Can't see .sdlc/ directory
- It's hidden by default (starts with dot)
- Use `ls -la` to see hidden directories
- Configure VS Code as shown above

### File creation fails
- Check you're using correct path under `.sdlc/`
- Verify sequential numbering is correct
- Use framework commands instead of manual creation

### References not working
- Update paths in documentation to use `.sdlc/`
- Check configuration files are updated
- Run validation to find broken references

## Related Documentation

- [Sequential File Naming](sequential-file-naming.md)
- [ADR Management](adr-management.md)
- [Design Structure](design-structure.md)
- [Template Management](template-management.md)