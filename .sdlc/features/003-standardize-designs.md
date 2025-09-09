## FEATURE:

- Standardize the designs folder structure and naming conventions
- Create consistent templates for design documents, ADRs, and PRPs
- Establish clear lifecycle for design artifacts (draft → approved → implemented → archived)
- Define naming patterns that make it easy to find and reference designs
- Integrate design tracking with task management system

## EXAMPLES:

- `designs/README.md` - Index of all designs with status tracking
- `designs/templates/` - Standard templates for different design types
- `designs/active/` - Currently approved designs being implemented
- `designs/archive/` - Completed or deprecated designs
- Naming pattern: `YYYY-MM-DD-feature-name/` for design folders

## DOCUMENTATION:

- [ADR Template](https://adr.github.io/) - Standard ADR format reference
- [Design Doc Best Practices](https://www.industrialempathy.com/posts/design-docs-at-google/) - Google's approach
- [C4 Model](https://c4model.com/) - Architecture diagram standards
- Bootstrap conventions: `PLANNING.md`, existing design docs

## OTHER CONSIDERATIONS:

- Must support both simple (single file) and complex (multi-file with ADRs) designs
- Should integrate with Git workflow (branches, PRs)
- Need clear status indicators (draft, review, approved, implementing, completed)
- Consider auto-generating index/table of contents
- Support for design templates that match Bootstrap patterns
- Version control friendly (avoid conflicts in shared index files)
- CRITICAL: Must not break existing design references

## CONTEXT:

Currently, the designs folder has inconsistent structure:
- Some designs are single files (analyze-command-design.md)
- Some have sub-folders with ADRs
- No clear naming convention
- No status tracking
- Hard to find related designs

This standardization will make it easier to:
- Find and reference designs
- Track implementation progress
- Maintain design history
- Onboard new contributors

## SUCCESS METRICS:

- All designs follow consistent structure
- Easy to find designs by feature, date, or status
- Clear lifecycle from proposal to implementation
- Reduced time to locate relevant design docs
- Automated index generation working

## OUT OF SCOPE:

- Migrating to external design tools
- Changing the markdown-based approach
- Automated design review workflows
- Integration with external project management tools