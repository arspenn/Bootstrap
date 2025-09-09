# ADR-001: Config Reference Mechanism with Inline Defaults

## Status
Accepted

## Context
The Git rules refactoring requires a mechanism to reference values from `.claude/config.yaml` while allowing rules to function independently. Rules need to be customizable through configuration but must work without external dependencies to ensure reliability and reduce file loading overhead.

## Decision
Implement a reference mechanism using the pattern `{{config.path.to.value:default_value}}` where:
- Double curly braces denote a config reference
- Dot notation specifies the path in config.yaml
- Colon separates the path from the default value
- Default value is used if config.yaml is missing or path not found

Example:
```yaml
validations:
  - max_file_size: "{{config.git.max_file_size:10MB}}"
  - forbidden_patterns: "{{config.git.forbidden_patterns:[*.env,*.key,*.pem]}}"
```

## Consequences

### Positive
- Rules remain functional without config.yaml
- Reduced file loading overhead
- Clear documentation of default values within rules
- Config becomes purely optional for customization
- Better error resilience
- Familiar syntax similar to other config systems

### Negative
- Slightly larger rule files due to inline defaults
- Requires implementing a custom reference parser
- Potential for default drift if not carefully managed

### Neutral
- Defaults are visible in rules rather than centralized
- Config.yaml becomes a customization layer rather than requirement
- Parser complexity is moderate but manageable