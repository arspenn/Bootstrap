# Test Scenarios: Git-Safe File Operations

## Overview

Test scenarios to validate the git-safe file operations rule functionality.

## Test Categories

### 1. Basic Operation Interception

#### Test 1.1: Block rm on tracked file
```bash
# Setup: Create and commit a file
echo "test" > tracked-file.txt
git add tracked-file.txt
git commit -m "Add test file"

# Test: Attempt to remove
rm tracked-file.txt

# Expected: Command blocked with suggestion to use 'git rm'
```

#### Test 1.2: Block mv on tracked file
```bash
# Setup: Use existing tracked file
# Test: Attempt to move
mv tracked-file.txt renamed-file.txt

# Expected: Command blocked with suggestion to use 'git mv'
```

#### Test 1.3: Block rmdir on tracked directory
```bash
# Setup: Create and track directory
mkdir tracked-dir
touch tracked-dir/file.txt
git add tracked-dir/
git commit -m "Add directory"

# Test: Attempt to remove directory
rmdir tracked-dir

# Expected: Command blocked with suggestion to use 'git rm -r'
```

### 2. Uncommitted Changes Detection

#### Test 2.1: Block rm on modified file
```bash
# Setup: Modify tracked file
echo "modified" >> tracked-file.txt

# Test: Attempt to remove
rm tracked-file.txt

# Expected: Command blocked - uncommitted changes detected
```

#### Test 2.2: Block mv on modified file
```bash
# Setup: Modify tracked file
echo "modified" >> tracked-file.txt

# Test: Attempt to move
mv tracked-file.txt moved-file.txt

# Expected: Command blocked - uncommitted changes detected
```

### 3. Untracked File Handling

#### Test 3.1: Allow rm on untracked file
```bash
# Setup: Create untracked file
echo "untracked" > untracked-file.txt

# Test: Remove untracked file
rm untracked-file.txt

# Expected: Command succeeds - file is not tracked
```

#### Test 3.2: Allow mv on untracked file
```bash
# Setup: Create untracked file
echo "untracked" > untracked-file.txt

# Test: Move untracked file
mv untracked-file.txt new-name.txt

# Expected: Command succeeds - file is not tracked
```

### 4. Override Mechanism

#### Test 4.1: Force-unsafe flag bypasses checks
```bash
# Setup: Create tracked file with changes
echo "test" > force-test.txt
git add force-test.txt
git commit -m "Add file"
echo "modified" >> force-test.txt

# Test: Remove with force-unsafe
rm --force-unsafe force-test.txt

# Expected: Command succeeds despite uncommitted changes
```

#### Test 4.2: Rule disabled in preferences
```bash
# Setup: Disable rule in user-preferences.yaml
# git-safe-file-operations: disabled

# Test: Remove tracked file
rm tracked-file.txt

# Expected: Command succeeds - rule is disabled
```

### 5. Git Command Alternatives

#### Test 5.1: Git rm works correctly
```bash
# Setup: Use tracked file
# Test: Use git rm
git rm tracked-file.txt

# Expected: File removed and staged for commit
```

#### Test 5.2: Git mv works correctly
```bash
# Setup: Use tracked file
# Test: Use git mv
git mv tracked-file.txt renamed-file.txt

# Expected: File moved and staged for commit
```

### 6. Edge Cases

#### Test 6.1: Non-git repository
```bash
# Setup: Work outside git repo
cd /tmp
echo "test" > non-git-file.txt

# Test: Remove file
rm non-git-file.txt

# Expected: Command succeeds - not in git repo
```

#### Test 6.2: Symlinks
```bash
# Setup: Create tracked symlink
ln -s target.txt link.txt
git add link.txt
git commit -m "Add symlink"

# Test: Remove symlink
rm link.txt

# Expected: Command blocked with git rm suggestion
```

#### Test 6.3: Mixed operations
```bash
# Setup: Multiple files (tracked and untracked)
echo "tracked" > tracked.txt
echo "untracked" > untracked.txt
git add tracked.txt
git commit -m "Add tracked"

# Test: Remove with wildcard
rm *.txt

# Expected: Command blocked if any tracked files match
```

### 7. Performance Tests

#### Test 7.1: Large directory operations
```bash
# Setup: Create directory with many files
mkdir large-dir
for i in {1..1000}; do echo "test" > large-dir/file$i.txt; done
git add large-dir/
git commit -m "Add large directory"

# Test: Remove directory
rm -rf large-dir/

# Expected: Command blocked efficiently without checking each file
```

### 8. Integration Tests

#### Test 8.1: Rule loading on startup
```bash
# Test: Start new Claude session
# Verify: Rule is automatically loaded from MASTER_IMPORTS.md
# Expected: Git-safe operations are enforced by default
```

#### Test 8.2: User preference changes
```bash
# Test: Modify user-preferences.yaml during session
# Toggle git-safe-file-operations between enabled/disabled
# Expected: Behavior changes immediately
```

## Validation Commands

Run these commands to verify rule functionality:

```bash
# Check if rule is loaded
grep "git-safe-file-operations" .claude/MASTER_IMPORTS.md

# Check user preferences
grep -A 5 "git-safe-file-operations" .claude/rules/config/user-preferences.yaml

# Verify rule file exists
ls -la .claude/rules/git/git-safe-file-operations.md

# Check documentation
ls -la .claude/docs/rules/git/git-safe-file-operations*.md
```

## Expected Behaviors Summary

1. **Default**: All rm/mv/rmdir operations on tracked files are blocked
2. **Suggestions**: Clear git command alternatives provided
3. **Overrides**: --force-unsafe flag and rule disabling work
4. **Performance**: Minimal impact on command execution
5. **Safety**: Uncommitted changes are always protected

## Test Execution Notes

- Run tests in a clean git repository
- Reset between tests to ensure isolation
- Verify both positive and negative cases
- Check error messages for clarity
- Validate performance on large operations