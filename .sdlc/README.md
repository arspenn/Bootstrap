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