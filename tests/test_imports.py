#!/usr/bin/env python3
# test_imports.py
import os
import re

def test_master_import_exists():
    assert os.path.exists('.claude/MASTER_IMPORTS.md'), "MASTER_IMPORTS.md does not exist"
    print("✓ MASTER_IMPORTS.md exists")

def test_claude_md_imports_master():
    with open('CLAUDE.md') as f:
        content = f.read()
    assert '@.claude/MASTER_IMPORTS.md' in content, "CLAUDE.md does not import MASTER_IMPORTS.md"
    print("✓ CLAUDE.md imports MASTER_IMPORTS.md")

def test_all_rules_imported():
    with open('.claude/MASTER_IMPORTS.md') as f:
        content = f.read()
    rules = ['git-add-safety', 'git-commit-format', 'git-push-validation', 
             'git-pull-strategy', 'git-branch-naming']
    for rule in rules:
        assert f'@.claude/rules/git/{rule}.md' in content, f"Rule {rule} not imported"
    print("✓ All rules imported in MASTER_IMPORTS.md")

def test_bidirectional_references():
    rules = ['git-add-safety', 'git-commit-format', 'git-push-validation', 
             'git-pull-strategy', 'git-branch-naming']
    
    for rule_name in rules:
        # Check rule references doc
        with open(f'.claude/rules/git/{rule_name}.md') as f:
            rule_content = f.read()
        assert f'docs/rules/git/{rule_name}.md' in rule_content, f"Rule {rule_name} missing doc reference"
        
        # Check doc references rule
        with open(f'docs/rules/git/{rule_name}.md') as f:
            doc_content = f.read()
        assert f'.claude/rules/git/{rule_name}.md' in doc_content, f"Doc {rule_name} missing rule reference"
    
    print("✓ Bidirectional references work correctly")

def test_rule_size_reduction():
    print("\nFile size comparison:")
    total_old = 0
    total_new = 0
    
    # Original sizes (from validation earlier)
    original_sizes = {
        'git-add-safety': 2908,
        'git-commit-format': 5403,
        'git-push-validation': 4648,
        'git-pull-strategy': 4889,
        'git-branch-naming': 6289
    }
    
    for rule_name in original_sizes:
        rule_size = os.path.getsize(f'.claude/rules/git/{rule_name}.md')
        doc_size = os.path.getsize(f'docs/rules/git/{rule_name}.md')
        
        total_old += original_sizes[rule_name]
        total_new += rule_size
        
        reduction = (1 - rule_size/original_sizes[rule_name]) * 100
        print(f"  {rule_name}: {original_sizes[rule_name]} → {rule_size} bytes ({reduction:.1f}% reduction)")
        
        assert rule_size < 1000, f"Rule {rule_name} too large: {rule_size} bytes"
        assert doc_size > 2000, f"Documentation {rule_name} too small: {doc_size} bytes"
    
    total_reduction = (1 - total_new/total_old) * 100
    print(f"\nTotal: {total_old} → {total_new} bytes ({total_reduction:.1f}% reduction)")
    assert total_reduction > 80, f"Total reduction {total_reduction:.1f}% is less than 80% target"
    print("✓ Size reduction target achieved")

if __name__ == "__main__":
    print("Running import tests...\n")
    
    try:
        test_master_import_exists()
        test_claude_md_imports_master()
        test_all_rules_imported()
        test_bidirectional_references()
        test_rule_size_reduction()
        
        print("\n✅ All tests passed!")
    except AssertionError as e:
        print(f"\n❌ Test failed: {e}")
        exit(1)
    except Exception as e:
        print(f"\n❌ Error: {e}")
        exit(1)