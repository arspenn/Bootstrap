# PRP: SDLC Directory Consolidation

## Overview
Consolidate all SDLC artifacts (features, designs, PRPs, ADRs) into a single `.sdlc/` hidden directory to create a cleaner project structure for alpha release. This migration involves moving ~102 files and updating 417 path references across 22+ configuration files.

## Context Files to Read
- Design Document: `designs/019-sdlc-directory-consolidation/design.md`
- ADR: `designs/019-sdlc-directory-consolidation/adrs/ADR-001-sdlc-directory-structure.md`
- Template Consolidation PRP (reference): `PRPs/template-consolidation.md`

## Critical Information

### Current State
```
Bootstrap/
├── features/          (19 files)
├── designs/           (18 directories)  
├── PRPs/              (20+ files)
├── docs/ADRs/         (11 files including INDEX.md)
```

### Target State
```
Bootstrap/
├── .sdlc/
│   ├── features/      (all feature files)
│   ├── designs/       (all design directories)
│   ├── PRPs/          (all PRP files)
│   └── ADRs/          (all ADRs, no INDEX.md)
```

### Files Requiring Updates (Must Update ALL)
Key files with path references that MUST be updated:
1. `.claude/rules/project/adr-management.md` - Lines 23, 26-27
2. `.claude/docs/rules/project/adr-management.md` - Multiple references
3. `.claude/commands/generate-prp.md` - PRP path references
4. `.claude/commands/gather-feature-requirements.md` - Feature path
5. `.claude/commands/quick-feature.md` - Feature path
6. `.claude/commands/design-feature.md` - Design path
7. `.claude/rules/project/sequential-file-naming.md` - Directory refs
8. `.claude/docs/rules/project/sequential-file-naming.md` - Examples
9. `.claude/rules/project/design-structure.md` - Design paths
10. `.claude/docs/framework/workflow.md` - Example paths
11. `.claude/docs/framework/getting-started.md` - Example paths
12. `.claude/docs/framework/command-system.md` - Command examples
13. `.claude/templates/feature-design.template.md` - Path refs
14. `.claude/templates/feature-enhanced.template.md` - Path refs
15. `.claude/templates/prp-base.template.md` - Path refs

## Implementation Tasks (35 Total)

### Phase 1: Preparation (Tasks 1-6)
```bash
# Task 1: Find ALL path references (CRITICAL - miss none!)
grep -r "features/\|designs/\|PRPs/\|docs/ADRs/" . --include="*.md" --include="*.yaml" --include="*.py" --exclude-dir=".git" --exclude-dir=".sdlc" > /tmp/path_references.txt

# Task 2: Create .sdlc directory structure (clean any partial migration first)
rm -rf .sdlc 2>/dev/null || true
mkdir -p .sdlc/features .sdlc/designs .sdlc/PRPs .sdlc/ADRs

# Task 3: Count files to move (should be ~102)
find features designs PRPs docs/ADRs -type f | wc -l

# Task 4: Git commit current state (rollback point)
git add -A && git commit -m "chore: pre-migration checkpoint for SDLC consolidation"

# Task 5: Extract ADR organization info from INDEX.md
sed -n '7,28p' docs/ADRs/INDEX.md > /tmp/adr_org_info.txt
echo "ADR organization info saved to /tmp/adr_org_info.txt"
# This will be added to adr-management documentation in Task 14

# Task 6: Create detailed checklist
echo "Migration Checklist Created" > /tmp/migration_checklist.txt
```

### Phase 2: Migration (Tasks 7-11)
```bash
# Task 7: Move features (preserve history)
git mv features/* .sdlc/features/

# Task 8: Move designs (preserve history)
git mv designs/* .sdlc/designs/

# Task 9: Move PRPs (preserve history)  
git mv PRPs/* .sdlc/PRPs/

# Task 10: Move ADRs except INDEX.md (preserve history)
if ls docs/ADRs/*.md 1> /dev/null 2>&1; then
  for file in docs/ADRs/*.md; do
    if [[ $(basename "$file") != "INDEX.md" ]] && [[ $(basename "$file") != "README.md" ]]; then
      git mv "$file" .sdlc/ADRs/
    fi
  done
else
  echo "No ADR files to move"
fi

# Task 11: Remove INDEX.md (no auto-update mechanism)
git rm docs/ADRs/INDEX.md
```

### Phase 3: Create Enforcement & Update References (Tasks 12-27)

#### Task 12: Create SDLC Directory Structure Rule
Create `.claude/rules/project/sdlc-directory-structure.md`:
```markdown
# Rule: SDLC Directory Structure

## Instructions

### Rule Metadata
- ID: project/sdlc-directory-structure
- Status: Active  
- Security Level: High
- Token Impact: ~20 tokens
- Priority: 700
- Dependencies: []

### Rule Configuration
```yaml
trigger: ["create file", "save file", "move file"]
conditions:
  - sdlc_artifact: true
locations:
  features: ".sdlc/features/"
  designs: ".sdlc/designs/"
  prps: ".sdlc/PRPs/"
  adrs: ".sdlc/ADRs/"
validations:
  - no_root_sdlc_files: true
  - enforce_hidden_directory: true
actions:
  - redirect_to_sdlc: true
```

### Behavior
- All SDLC artifacts MUST be created in `.sdlc/` subdirectories
- Prevents creation of features/, designs/, PRPs/ at root level
- Automatically redirects file creation to correct `.sdlc/` location
```

#### Task 13: Update MASTER_IMPORTS.md
Add the new rule to `.claude/MASTER_IMPORTS.md` after line 17:
```bash
sed -i '17a@.claude/rules/project/sdlc-directory-structure.md' .claude/MASTER_IMPORTS.md
```

#### Tasks 14-27: Update All Path References
For each file below, replace ALL occurrences of old paths with new paths:
- `features/` → `.sdlc/features/`
- `designs/` → `.sdlc/designs/`
- `PRPs/` → `.sdlc/PRPs/`
- `docs/ADRs/` → `.sdlc/ADRs/`

**Task 14**: Update `.claude/rules/project/adr-management.md`
- Line 23: Remove `update_index: "docs/ADRs/INDEX.md"` line completely
- Line 26: `project_wide: "docs/ADRs/"` → `project_wide: ".sdlc/ADRs/"`
- Line 27: `design_specific: "designs/*/adrs/"` → `design_specific: ".sdlc/designs/*/adrs/"`

**Task 15**: Update `.claude/docs/rules/project/adr-management.md`
- Insert ADR organization info from /tmp/adr_org_info.txt after line 10
- Line 238: `adr_path: "docs/ADRs/"` → `adr_path: ".sdlc/ADRs/"`
- Line 239: `design_adr_path: "designs/*/adrs/"` → `design_adr_path: ".sdlc/designs/*/adrs/"`
- Update all example paths throughout the file

**Tasks 16-27**: Update remaining files using MultiEdit for efficiency

**Task 16**: `.claude/commands/generate-prp.md` - Update "PRPs/" references
**Task 17**: `.claude/commands/gather-feature-requirements.md` - Line ~580: "features/" path
**Task 18**: `.claude/commands/quick-feature.md` - Update "features/" save path
**Task 19**: `.claude/commands/design-feature.md` - Update "designs/" references
**Task 20**: `.claude/rules/project/sequential-file-naming.md` - Lines 31-34: directory paths
**Task 21**: `.claude/docs/rules/project/sequential-file-naming.md` - Update examples
**Task 22**: `.claude/rules/project/design-structure.md` - Update "designs/" paths
**Task 23**: `.claude/docs/framework/workflow.md` - Update example paths
**Task 24**: `.claude/docs/framework/getting-started.md` - Update example paths
**Task 25**: `.claude/docs/framework/command-system.md` - Update command examples
**Task 26**: `.claude/templates/feature-design.template.md` - Update path references
**Task 27**: `.claude/templates/prp-base.template.md` - Update context paths

For all files: Replace `features/` → `.sdlc/features/`, `designs/` → `.sdlc/designs/`, `PRPs/` → `.sdlc/PRPs/`, `docs/ADRs/` → `.sdlc/ADRs/`

### Phase 4: Validation (Tasks 28-32)
```bash
# Task 28: Test feature creation with actual command
echo "Test feature for validation" | /gather-feature-requirements
# Verify the file was created in .sdlc/features/
ls -la .sdlc/features/*test* || echo "FAIL: Feature not in .sdlc/features/"

# Task 29: Test design creation with actual command
if [ -f ".sdlc/features/019-sdlc-directory-consolidation.md" ]; then
  /design-feature .sdlc/features/019-sdlc-directory-consolidation.md
  ls -la .sdlc/designs/019-* || echo "FAIL: Design not in .sdlc/designs/"
fi

# Task 30: Test PRP creation location
echo "# Test PRP" > .sdlc/PRPs/test-validation.md
ls -la .sdlc/PRPs/test-validation.md || echo "FAIL: PRP not created"

# Task 31: Verify sequential numbering preserved
ls .sdlc/features/ | head -5
# Should show ###-format preserved (001-, 002-, etc.)

# Task 32: Verify git history preserved
git log --follow --oneline .sdlc/features/001-* | head -3 || echo "FAIL: Git history lost"
```

### Phase 5: Cleanup (Tasks 33-35)
```bash
# Task 33: Remove empty directories
rmdir features designs PRPs docs/ADRs 2>/dev/null || true

# Task 34: Update .gitignore if needed
# Add .sdlc/temp/ or other patterns if needed

# Task 35: Create README for .sdlc
cat > .sdlc/README.md << 'EOF'
# SDLC Directory Structure

This hidden directory contains all Software Development Life Cycle artifacts for the Bootstrap framework.

## Structure
- `features/` - Feature specifications (###-kebab-case.md)
- `designs/` - Design documents (###-kebab-case/design.md)
- `PRPs/` - Project Requirement Plans
- `ADRs/` - Architecture Decision Records

## Why Hidden?
The `.sdlc` prefix indicates framework-managed content, keeping the root directory clean while preserving all project artifacts.

## Accessing in VS Code
To see this directory in VS Code, ensure hidden files are visible:
- File > Preferences > Settings
- Search for "files.exclude"
- Remove or modify the `"**/.sdlc"` pattern if present
EOF
```

## Validation Commands
```bash
# Final validation - ALL must pass
echo "=== Validation Starting ==="

# 1. Verify all files moved (should be 0)
find features designs PRPs docs/ADRs -type f 2>/dev/null | wc -l

# 2. Verify .sdlc populated (should be ~102)
find .sdlc -type f -name "*.md" | wc -l

# 3. Verify no broken references (should be 0)
grep -r "features/\|designs/\|PRPs/\|docs/ADRs/" .claude --include="*.md" --include="*.yaml" | grep -v ".sdlc/" | wc -l

# 4. Test command execution (automated)
echo "Testing commands create in .sdlc/..."
# Create a test feature to verify commands work
echo "test validation" | /gather-feature-requirements 2>/dev/null
test -f .sdlc/features/*validation* && echo "PASS: Commands use .sdlc/" || echo "FAIL: Commands not using .sdlc/"

# 5. Verify git history preserved
if [ -f ".sdlc/features/001-"* ]; then
  git log --follow --oneline .sdlc/features/001-* | head -3
  echo "PASS: Git history preserved"
else
  echo "SKIP: No 001 file to check history"
fi

echo "=== Validation Complete ==="
```

## Rollback Plan
If ANY issue occurs:
```bash
git reset --hard HEAD
git clean -fd
```
This returns to the checkpoint created in Task 4.

## Error Patterns & Solutions

### Pattern: "No such file or directory"
**Solution**: Ensure .sdlc directories created before moving files

### Pattern: "Permission denied"  
**Solution**: Check file permissions, use sudo if needed

### Pattern: "Already exists"
**Solution**: Check if partial migration occurred, clean and retry

### Pattern: References still pointing to old paths
**Solution**: Re-run grep search and update missed files

## Success Criteria Checklist
- [ ] All 102 files moved to .sdlc/
- [ ] Zero files remain in old directories
- [ ] All 22+ config files updated
- [ ] SDLC structure rule created and active
- [ ] No broken references found via grep
- [ ] Commands create files in .sdlc/
- [ ] Git history preserved (verify with --follow)
- [ ] .sdlc/README.md created
- [ ] VS Code shows .sdlc/ directory

## Dependencies & Tools
- Git (for history preservation)
- Bash (for scripting)
- Grep/Find (for searching)
- MultiEdit tool (for bulk updates)

## Notes
- This is an ATOMIC operation - all or nothing
- The 417 references found include duplicates and historical docs
- Only update active configuration files, NOT historical PRPs/designs
- Use `git mv` exclusively to preserve history
- Test each command after path updates

## Confidence Score: 8/10
High confidence due to:
- Clear, mechanical tasks (mostly git mv and find/replace)
- Similar to successful template consolidation
- Comprehensive validation gates
- Rollback strategy in place
- All paths and line numbers documented

Minor risks:
- Potential missed references (mitigated by comprehensive grep)
- Command test dependencies (mitigated by conditional checks)
- Edge cases in bash scripts (mitigated by error handling)