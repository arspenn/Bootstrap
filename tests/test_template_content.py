#!/usr/bin/env python3
# test_template_content.py

def test_template_completeness():
    """Ensure template has all required sections"""
    with open('.claude/templates/changelog-entry.template', 'r') as f:
        content = f.read()
    
    required_sections = [
        '## Instructions',
        '## Template', 
        '## Writing Guidelines',
        '## Examples of Good vs Bad',
        '## Quick Checklist'
    ]
    
    for section in required_sections:
        assert section in content, f"Missing section: {section}"
    print("✓ All required sections present")

def test_category_examples():
    """Ensure each category has examples"""
    categories = ['Added', 'Changed', 'Deprecated', 'Removed', 'Fixed', 'Security']
    
    with open('.claude/templates/changelog-entry.template', 'r') as f:
        content = f.read()
    
    for category in categories:
        assert f'### {category}' in content, f"Missing category: {category}"
        # Check that examples follow each category
        category_index = content.find(f'### {category}')
        examples_index = content.find('Examples:', category_index)
        next_category_index = content.find('###', category_index + 1)
        assert examples_index > category_index and examples_index < next_category_index, f"Missing examples for {category}"
    
    print("✓ All categories have examples")

if __name__ == "__main__":
    test_template_completeness()
    test_category_examples()
    print("\n✅ All content quality tests passed!")