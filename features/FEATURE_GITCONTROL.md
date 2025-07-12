## FEATURE:

- A rule set for CLAUDE.md describing default behaviors for using Git and Github for version control.
- Should not change any other features or parts of the system.
- Must be fully compatible with existing styles and framework.

## EXAMPLES:

[Provide references to similar features, patterns, or implementations that should be studied]
This may be somewhat new. I cannot find any references.

## DOCUMENTATION:

[List relevant documentation, APIs, or technical resources]

- [Technology/Library Documentation]:GitHub Docs [URL]https://docs.github.com/en
- [API Documentation]: [URL]
- [Best Practices Guide]: [URL]https://about.gitlab.com/topics/version-control/version-control-best-practices/
- Internal docs: none

## OTHER CONSIDERATIONS:

- [Performance requirements or constraints] Make minimal changes but allow for stay ready for future modifications
- [Security considerations] Belived to be minimal, but continue to evaluate to avoid extensive rewrites in the future.
- [Scalability needs] Integral part of the process, needs to add minimal overhead to total processes.
- [User experience requirements] Will need to accomidate users from novice to expert+
- [Timeline or deadline constraints] ASAP
- [Any technical constraints or preferences] Free
- CRITICAL: [Any non-negotiable requirements] Must be completely legal
- May be broken down into sub features and implemented sequentially if it is determined that certian features are critical for the bootstrap method of increacing capability.
- This is an update to the directions of the template that all future development is based on.

## CONTEXT:

This is necessary to ensure swift and consistent use of versioning rather than relying on sporadic human inputs.

## SUCCESS METRICS:

[Optional: How will we measure if this feature is successful?]

- [Metric 1] Given the created rules, and with no other context, can Claude Code corectly implement a full range of git operations
- [Metric 2] Given the created rules, and with no other context, can Claude Code corectly implement a full range of Github operations
- [Metric 3] Descriptive and consice documentation of each capability is documented in the new docs folder.

## OUT OF SCOPE:

[Optional: Explicitly state what is NOT part of this feature request]

- [Thing that might be assumed but isn't needed]
- [Feature for future iteration] Modular rule sets