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