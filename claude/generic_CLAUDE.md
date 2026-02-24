# CLAUDE.md

## Workflow

- Restate the goal in your own words before starting.
- If the request is ambiguous, ask clarifying questions before writing code.
- List every file you expect to touch. If adding or deleting files, explain why.

## Writing Code

- Before modifying a function, search for all callers to understand impact.
- Match existing patterns in the codebase: error handling, logging, naming, structure.
- Prefer reusing existing utilities and abstractions over creating new ones.
- If adding a dependency, mention it and justify why existing deps can't do the job.
- State assumptions explicitly before acting on them.
- Keep diffs small and focused on a single concern.
- For complex changes, consider edge cases and failure modes before coding.

## Quality Bar

- Before presenting work, ask: "Would a staff engineer approve this in code review?"
- Diff your changes against the base branch mentally - do they make sense as a coherent unit?

## Boundaries

- NEVER run the build, deploy, linters, or formatters unless explicitly asked.
- NEVER write tests unless explicitly asked.
