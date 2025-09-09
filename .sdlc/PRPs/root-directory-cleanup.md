# Project Requirements Prompt: Root Directory Cleanup

**Date**: 2025-09-02
**Feature**: Root Directory Cleanup
**Priority**: High (Alpha Preparation)
**Confidence Score**: 9/10

## Context and Background

The Bootstrap framework has evolved significantly and many directories in the project root are now obsolete. This cleanup is essential for alpha release preparation. The following directories and files need to be removed:

- **benchmarks/** - Historical benchmark files (obsolete)
- **docs/** - Placeholder documentation (framework docs now in .claude/docs/)
- **PRPs/** - Empty directory (migrated to .sdlc/PRPs/)
- **scripts/** - Unused adr-tools.py script
- **tests/** - Ineffective test suite (will be replaced with scenario-based testing)
- **FEATURE_TEMPLATE.md** - Obsolete template (replaced by framework templates)

Additionally, **responses/** directory should be added to .gitignore as it contains informal historical files.

## Design References

- Feature Spec: `.sdlc/features/021-root-directory-cleanup.md`
- Design Document: `.sdlc/designs/021-root-cleanup/design.md`
- ADR: `.sdlc/designs/021-root-cleanup/adrs/ADR-001-delete-ineffective-tests.md`

## Implementation Tasks

Execute the following tasks in order:

### Phase 1: Pre-Cleanup Validation (Tasks 1-3)

**Task 1: Verify directories exist and understand content**
```bash
# Check what we're about to delete
ls -la benchmarks/ 2>/dev/null || echo "benchmarks/ not found"
ls -la docs/ 2>/dev/null || echo "docs/ not found"
ls -la PRPs/ 2>/dev/null || echo "PRPs/ not found"
ls -la scripts/ 2>/dev/null || echo "scripts/ not found"
ls -la tests/ 2>/dev/null || echo "tests/ not found"
ls -la FEATURE_TEMPLATE.md 2>/dev/null || echo "FEATURE_TEMPLATE.md not found"
```

**Task 2: Check for uncommitted changes**
```bash
git status --porcelain
```
Expected: Clean working tree or only expected changes

**Task 3: Create safety backup list**
```bash
# Document what we're deleting for reference
echo "Files to be deleted:" > /tmp/cleanup-manifest.txt
find benchmarks docs PRPs scripts tests -type f 2>/dev/null >> /tmp/cleanup-manifest.txt || true
echo "FEATURE_TEMPLATE.md" >> /tmp/cleanup-manifest.txt
cat /tmp/cleanup-manifest.txt
```

### Phase 2: Directory Deletion (Tasks 4-9)

**Task 4: Delete benchmarks directory**
```bash
git rm -rf benchmarks/
```
Expected: Directory removed, changes staged

**Task 5: Delete docs directory**
```bash
git rm -rf docs/
```
Expected: Directory removed, changes staged

**Task 6: Delete PRPs directory**
```bash
# This is empty but tracked
git rm -rf PRPs/ 2>/dev/null || rmdir PRPs/ 2>/dev/null || true
```
Expected: Directory removed

**Task 7: Delete scripts directory**
```bash
git rm -rf scripts/
```
Expected: Directory removed, changes staged

**Task 8: Delete tests directory**
```bash
git rm -rf tests/
```
Expected: Directory removed, changes staged

**Task 9: Delete FEATURE_TEMPLATE.md**
```bash
git rm FEATURE_TEMPLATE.md
```
Expected: File removed, changes staged

### Phase 3: Update .gitignore (Tasks 10-12)

**Task 10: Check current .gitignore for responses**
```bash
grep "^responses" .gitignore || echo "responses/ not in .gitignore"
```

**Task 11: Add responses to .gitignore**
```bash
# Add responses/ to .gitignore if not already present
if ! grep -q "^responses/$" .gitignore; then
    echo "" >> .gitignore
    echo "# Historical response files (informal method)" >> .gitignore
    echo "responses/" >> .gitignore
    echo "Added responses/ to .gitignore"
else
    echo "responses/ already in .gitignore"
fi
```

**Task 12: Stage .gitignore changes**
```bash
git add .gitignore
```

### Phase 4: Update Configuration Files (Tasks 13-15)

**Task 13: Update .claude/config.yaml**
Remove references to deleted directories:
```python
# Read the config file
with open('.claude/config.yaml', 'r') as f:
    content = f.read()

# Remove test_directory and tests_root references
import re
content = re.sub(r'\s*test_directory:.*\n', '', content)
content = re.sub(r'\s*tests_root:.*\n', '', content)

# Write back
with open('.claude/config.yaml', 'w') as f:
    f.write(content)

print("Updated .claude/config.yaml")
```

**Task 14: Update test-file-location rule**
Since we're removing tests/, this rule becomes obsolete. Add deprecation notice:
```python
rule_path = '.claude/rules/project/test-file-location.md'
with open(rule_path, 'r') as f:
    content = f.read()

# Add deprecation notice at the top if not already there
if '## Status: Deprecated' not in content:
    lines = content.split('\n')
    # Insert after the title
    lines.insert(1, '')
    lines.insert(2, '## Status: Deprecated')
    lines.insert(3, '**Note**: Tests directory has been removed. This rule will be updated when new testing framework is implemented.')
    lines.insert(4, '')
    content = '\n'.join(lines)
    
    with open(rule_path, 'w') as f:
        f.write(content)
    print("Added deprecation notice to test-file-location rule")
else:
    print("Rule already marked as deprecated")
```

**Task 15: Stage configuration updates**
```bash
git add .claude/config.yaml .claude/rules/project/test-file-location.md
```

### Phase 5: Final Validation (Tasks 16-20)

**Task 16: Verify all directories deleted**
```bash
# Check that directories no longer exist
for dir in benchmarks docs PRPs scripts tests; do
    if [ -d "$dir" ]; then
        echo "ERROR: $dir still exists!"
        exit 1
    else
        echo "✓ $dir deleted"
    fi
done

# Check file is deleted
if [ -f "FEATURE_TEMPLATE.md" ]; then
    echo "ERROR: FEATURE_TEMPLATE.md still exists!"
    exit 1
else
    echo "✓ FEATURE_TEMPLATE.md deleted"
fi
```

**Task 17: Verify .gitignore updated**
```bash
grep "^responses/$" .gitignore && echo "✓ responses/ in .gitignore" || echo "ERROR: responses/ not in .gitignore"
```

**Task 18: Check git status**
```bash
git status
```
Expected: All deletions staged, .gitignore modified

**Task 19: Final file count**
```bash
echo "Root directory contents after cleanup:"
ls -la | grep -v "^\." | tail -n +2 | wc -l
echo "Files/directories remaining:"
ls -1 | grep -v "^\."
```

**Task 20: Create cleanup summary**
```bash
echo "=== Root Directory Cleanup Complete ==="
echo "Deleted directories: benchmarks/, docs/, PRPs/, scripts/, tests/"
echo "Deleted files: FEATURE_TEMPLATE.md"
echo "Updated: .gitignore (added responses/)"
echo "Updated: .claude/config.yaml (removed test references)"
echo "Updated: test-file-location rule (marked deprecated)"
echo ""
echo "Ready for commit with message:"
echo "feat(cleanup): remove obsolete directories and files for alpha [v0.10.0]"
```

## Success Criteria

- [ ] All specified directories deleted (benchmarks/, docs/, PRPs/, scripts/, tests/)
- [ ] FEATURE_TEMPLATE.md deleted
- [ ] responses/ added to .gitignore
- [ ] Configuration files updated to remove references
- [ ] Git history preserved for all deletions
- [ ] Clean git status with all changes staged

## Validation Gates

```bash
# Final validation script
echo "Running final validation..."

# Check directories don't exist
for dir in benchmarks docs PRPs scripts tests; do
    [ ! -d "$dir" ] || (echo "FAIL: $dir still exists" && exit 1)
done

# Check file doesn't exist
[ ! -f "FEATURE_TEMPLATE.md" ] || (echo "FAIL: FEATURE_TEMPLATE.md still exists" && exit 1)

# Check .gitignore
grep -q "^responses/$" .gitignore || (echo "FAIL: responses/ not in .gitignore" && exit 1)

# Check git has staged changes
git status --porcelain | grep -q "^D" || (echo "FAIL: No deletions staged" && exit 1)

echo "✅ All validations passed!"
```

## Error Recovery

If any step fails:

1. **For git rm failures**: File might already be deleted or untracked
   - Use `rm -rf` for untracked files
   - Use `git rm -rf --cached` for tracked but missing files

2. **For .gitignore issues**: 
   - Manually edit .gitignore to add `responses/`
   
3. **For config file updates**:
   - Manually remove test-related lines from .claude/config.yaml

## Commit Message

After successful completion, commit with:
```
feat(cleanup): remove obsolete directories and files for alpha [v0.10.0]

- Remove obsolete directories: benchmarks/, docs/, PRPs/, scripts/, tests/
- Delete FEATURE_TEMPLATE.md (replaced by framework templates)  
- Add responses/ to .gitignore (informal historical files)
- Update config.yaml to remove test directory references
- Mark test-file-location rule as deprecated

Part of alpha release preparation. Tests will be reimplemented with
scenario-based testing for Claude commands and rules.
```

## Important Notes

1. **Tests Removal Rationale**: Current tests don't effectively test code functionality. They were created for rules/templates validation. Future testing will use scenario-based approach for Claude commands and rules.

2. **Docs Removal Rationale**: The docs/ folder contains only placeholders and obsolete documentation. Active framework documentation is in .claude/docs/.

3. **Git History**: All deletions use `git rm` to preserve history. Files can be recovered from git history if needed.

4. **Working Directory**: Must be in project root when executing tasks.

## References

- Git safe file operations rule: `.claude/rules/git/git-safe-file-operations.md`
- Current directory structure: Use `ls -la` to verify
- Git documentation for rm command: https://git-scm.com/docs/git-rm

---
**Confidence Score: 9/10** - This is a straightforward cleanup task with clear steps and validation. The only complexity is ensuring configuration files are properly updated.