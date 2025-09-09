# Feature Request: Align Git Rules with New Standardization Design

## Problem Statement
The existing Git rules were created before the CLAUDE.md standardization project established patterns for enhanced metadata, configuration separation, and rule structure. These rules now have inconsistencies that need to be fixed to align with the new design patterns we just implemented.

## Current Issues
Based on failing tests and code review, the Git rules have several problems:

### 1. Missing/Incorrect Documentation
- Missing "Git Control Rules" section in documentation
- `git-pull-strategy.md` lacks documentation links
- Documentation files in `.claude/docs/rules/git/` are missing or incomplete

### 2. Inconsistent Metadata Format
- Security levels use incorrect format (e.g., `## Security Level:` instead of `- Security Level:`)
- Missing enhanced metadata fields (Priority, Dependencies)
- Token impact values may be outdated

### 3. Configuration Redundancy
- Git rules likely contain hardcoded values that should be in config.yaml
- No references to centralized configuration
- Duplicate values between rules and potential config settings

### 4. Structure Inconsistencies
- Git rules predate the standardized YAML structure
- Missing proper trigger/condition/action separation
- Inconsistent with patterns established in Phase 2-4 rules

## Proposed Solution

### Phase 1: Metadata Alignment
Update all Git rules to use enhanced metadata format:
```yaml
### Rule Metadata
- ID: git/rule-name
- Status: Active
- Security Level: High/Medium/Low
- Token Impact: ~XX tokens per operation
- Priority: XXX (100-800 scale)
- Dependencies: ["other/rules"]
```

### Phase 2: Configuration Extraction
Move Git-specific settings to config.yaml:
```yaml
# In config.yaml
git:
  default_branch: "main"
  protected_branches: ["main", "master", "develop"]
  commit_format: "conventional"
  force_push_protection: true
  rebase_preference: true
  max_file_size: "10MB"
```

### Phase 3: Rule Refactoring
Restructure each Git rule to follow the new pattern:
- Clear trigger/condition/action sections
- Reference config values instead of hardcoding
- Consistent YAML structure
- Proper documentation links

### Phase 4: Documentation Completion
- Create comprehensive docs in `.claude/docs/rules/git/`
- Add "Git Control Rules" section where needed
- Include examples and troubleshooting
- Add links to Git documentation

## Specific Rules to Fix

1. **git-add-safety.md**
   - Add Priority and Dependencies metadata
   - Extract `max_file_size` to config
   - Fix security level format

2. **git-commit-format.md**
   - Add enhanced metadata
   - Reference config for format type
   - Fix template references

3. **git-push-validation.md**
   - Add enhanced metadata
   - Move protected branches to config
   - Fix security level format

4. **git-pull-strategy.md**
   - Add documentation links
   - Add enhanced metadata
   - Reference config for strategy

5. **git-branch-naming.md**
   - Add enhanced metadata
   - Move patterns to config
   - Fix template references

6. **git-safe-file-operations.md**
   - Add enhanced metadata
   - Align with other safety rules
   - Fix documentation

## Success Criteria
- [ ] All Git rules have enhanced metadata (Priority, Dependencies)
- [ ] Security levels use correct format (`- Security Level:`)
- [ ] Git configuration extracted to config.yaml
- [ ] All rules reference config instead of hardcoding values
- [ ] Documentation exists for all Git rules in `.claude/docs/rules/git/`
- [ ] All Git rule tests pass
- [ ] Consistent structure across all Git rules
- [ ] Token impact reduced through config references

## Implementation Approach

1. **Audit Current State**
   - Review all 6 Git rules for issues
   - Document specific problems per rule
   - Identify values to extract to config

2. **Update Config.yaml**
   - Add `git:` section with extracted values
   - Define Git-specific defaults
   - Set up override capability

3. **Refactor Rules**
   - Update metadata format
   - Replace hardcoded values with config references
   - Ensure consistent YAML structure
   - Add Priority based on security level

4. **Complete Documentation**
   - Create missing docs in `.claude/docs/rules/git/`
   - Add examples and scenarios
   - Include troubleshooting guides
   - Add external documentation links

5. **Update Tests**
   - Fix test expectations to match new format
   - Add tests for config integration
   - Ensure backward compatibility

## Benefits
- **Consistency**: All rules follow the same enhanced pattern
- **Maintainability**: Single source of truth in config.yaml
- **Token Efficiency**: Reduced redundancy, smaller rule files
- **Flexibility**: Easy to customize Git behavior per project
- **Documentation**: Complete guides for all Git operations

## Priority
High - Git rules are fundamental to safe development workflow and should model best practices for the rule system.

## Estimated Effort
- Medium (4-6 hours)
- Systematic refactoring of 6 rules
- Documentation creation
- Test updates

## Dependencies
- Requires: CLAUDE.md Standardization Phase 4 (completed)
- Blocks: Future rule creation (need consistent examples)

## Notes
- This brings Git rules up to the standard established in Phases 1-4
- Will serve as reference implementation for future rule categories
- Consider creating a migration tool for old-format rules
- May discover additional patterns to standardize

## Related Issues
From TASK.md:
- Add "Git Control Rules" section to CLAUDE.md
- Add documentation links to git-pull-strategy.md
- Fix security level format in git rules
- Create missing documentation files in .claude/docs/rules/git/
- Update test expectations to match actual rule format