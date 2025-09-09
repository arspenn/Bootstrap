# Rule: Sequential File Naming

## Instructions

### Rule Metadata
- ID: project/sequential-file-naming
- Status: Active
- Security Level: Low
- Token Impact: ~15 tokens per operation
- Priority: 300
- Dependencies: []

### Rule Configuration
```yaml
trigger: "file creation in .sdlc/features/ or .sdlc/designs/"
conditions:
  - creating_feature_file: true
  - creating_design_folder: true
actions:
  - enforce_sequential_naming: true
  - pattern: "###-{kebab-case-title}"
  - find_next_number: true
validations:
  - number_format: "^\\d{3}$"
  - kebab_case_title: true
  - max_title_length: 50
```

### Behavior
- Enforces sequential numbering for feature files and design folders
- Pattern: `###-kebab-case-title` (e.g., 001-fix-login-button.md)
- Automatically finds next available number
- Converts titles to kebab-case (lowercase, hyphens for spaces)
- Applies to both .sdlc/features/ and .sdlc/designs/ directories

### Implementation Details

#### Getting Next Sequential Number
1. List all files/folders in target directory
2. Filter for pattern: `^\\d{3}-.*`
3. Extract numbers, find highest
4. Return highest + 1, formatted as 3 digits
5. If no numbered items exist, return "001"

#### Title to Kebab Case Conversion
1. Convert to lowercase
2. Replace spaces with hyphens
3. Remove special characters except hyphens
4. Remove consecutive hyphens
5. Trim to max 50 characters
6. Remove trailing hyphens

#### Examples
- "Fix Login Button" → `001-fix-login-button.md`
- "Add OAuth 2.0 Support" → `002-add-oauth-2-0-support.md`
- "URGENT: Security patch!!!" → `003-urgent-security-patch.md`

### Usage in Commands
Commands should reference this rule when creating files:
- `/quick-feature` - Creates feature files
- `/gather-feature-requirements` - Creates feature files
- `/design-feature` - References for consistency

---

📚 **Full Documentation**: [.claude/docs/rules/project/sequential-file-naming.md](../../docs/rules/project/sequential-file-naming.md)