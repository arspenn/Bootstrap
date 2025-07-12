#!/usr/bin/env python3
import os
import yaml
import re
import sys

def validate_yaml_in_rules():
    """Validate YAML syntax in all rule files"""
    rules_dir = '.claude/rules/git/'
    errors = []
    
    for filename in os.listdir(rules_dir):
        if filename.endswith('.md') and not filename == 'index.md':
            filepath = os.path.join(rules_dir, filename)
            print(f"Checking {filepath}")
            
            try:
                with open(filepath) as file:
                    content = file.read()
                    # Find YAML block
                    yaml_match = re.search(r'```yaml\n(.*?)\n```', content, re.DOTALL)
                    
                    if yaml_match:
                        yaml_content = yaml_match.group(1)
                        yaml.safe_load(yaml_content)
                        print(f"  ✓ Valid YAML")
                    else:
                        errors.append(f"{filepath}: No YAML block found")
            except yaml.YAMLError as e:
                errors.append(f"{filepath}: YAML error - {e}")
            except Exception as e:
                errors.append(f"{filepath}: Error - {e}")
    
    if errors:
        print("\nErrors found:")
        for error in errors:
            print(f"  ❌ {error}")
        return 1
    else:
        print("\n✅ All YAML blocks are valid!")
        return 0

if __name__ == "__main__":
    sys.exit(validate_yaml_in_rules())