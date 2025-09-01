# Sequential File Naming Rule

## Overview
This rule standardizes file naming across features and designs with sequential numbering for better organization and tracking.

## Purpose
- Maintain chronological order of features and designs
- Enable easy tracking of feature/design count
- Provide consistent naming across all commands
- Improve file system organization

## Pattern
`###-kebab-case-title.{extension}`

Where:
- `###` - Three-digit sequential number (001, 002, etc.)
- `kebab-case-title` - Lowercase title with hyphens
- `extension` - File extension (.md for features)

## Implementation

### For Commands
When implementing in a command:

```markdown
# In command process section:
1. Apply sequential-file-naming rule
2. Get next number from features/
3. Convert title to kebab-case
4. Create file: {number}-{title}.md
```

### Algorithm
```python
def get_next_sequential_number(directory):
    """Get next sequential number for files in directory"""
    files = list_files(directory)
    numbers = []
    for file in files:
        match = regex_match(r'^(\d{3})-', file)
        if match:
            numbers.append(int(match.group(1)))
    
    if numbers:
        return f"{max(numbers) + 1:03d}"
    return "001"

def to_kebab_case(title):
    """Convert title to kebab-case format"""
    # Convert to lowercase
    title = title.lower()
    # Replace spaces with hyphens
    title = title.replace(' ', '-')
    # Remove special characters
    title = regex_sub(r'[^a-z0-9-]', '', title)
    # Remove consecutive hyphens
    title = regex_sub(r'-+', '-', title)
    # Trim length
    title = title[:50]
    # Remove trailing hyphens
    title = title.strip('-')
    return title
```

## Examples

### Feature Files
```
features/
├── 001-user-authentication.md
├── 002-password-reset.md
├── 003-two-factor-auth.md
└── 004-oauth-integration.md
```

### Design Folders
```
designs/
├── 001-feature-authentication/
├── 002-feature-payment-system/
├── 003-refactor-database/
└── 004-system-monitoring/
```

## Migration Strategy
All existing feature files will be renamed to follow the sequential pattern based on their creation order (oldest to newest).

## Edge Cases

### Gaps in Numbering
If files are deleted, gaps are acceptable. Always use highest + 1, not fill gaps.

### Duplicate Numbers
Should never occur if rule is followed. If detected, increment to next available.

### Very Long Titles
Truncated at 50 characters to maintain readability.

### Special Characters
All special characters except hyphens and alphanumerics are removed.

## Related Rules
- project/design-structure - Uses same pattern for design folders
- project/task-management - Similar ID pattern (TASK-###)

## Commands Using This Rule
- `/quick-feature` - Feature file creation
- `/gather-feature-requirements` - Feature file creation
- `/design-feature` - Reference for consistency