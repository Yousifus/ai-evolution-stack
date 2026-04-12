# Ralph Loop

> Iterative agentic loop for Claude Code — feeds the same prompt repeatedly, letting Claude see its own previous edits and git history each cycle, incrementally improving until done.

- **GitHub**: https://github.com/mikeyobrien/ralph-orchestrator
- **Technique origin**: https://ghuntley.com/ralph/
- **Category**: Agent Frameworks / Development Methodology
- **Type**: Claude Code plugin

## What It Does

Ralph Loop implements the "Ralph Wiggum technique" — a methodology pioneered by Geoffrey Huntley for iterative AI development. The core idea:

1. Give Claude a prompt describing what you want built
2. Claude writes code, makes edits, runs tests
3. When Claude finishes, the plugin **re-injects the same prompt**
4. Claude sees its own previous edits + git history → improves on them
5. Repeat until a completion condition is met or max iterations reached

Each iteration, Claude has more context from its own work, leading to progressively better output. It's like pair programming where your partner reviews and improves their own code in a loop.

## Install

Ralph Loop is a Claude Code plugin. Install via the plugin system:

```bash
# In Claude Code
/plugin install ralph-loop
```

Or check: https://github.com/mikeyobrien/ralph-orchestrator

## Usage

```bash
# Start a loop with a prompt
/ralph-loop "Refactor the auth module to use JWT tokens" --max-iterations 5

# With a completion condition
/ralph-loop "Write comprehensive tests for src/api/" \
  --max-iterations 10 \
  --completion-promise "All tests passing with >90% coverage"

# Cancel an active loop
/cancel-ralph
```

### How Completion Works

Claude must output `<promise>TEXT</promise>` matching your `--completion-promise` to break the loop. If it never does, the loop stops at `--max-iterations`.

## Best For

- **Refactoring** — iterative improvement of existing code
- **Test writing** — progressively expanding test coverage
- **Greenfield builds** — building features from scratch over multiple passes
- **Documentation** — iteratively improving docs until comprehensive

## Not Suited For

- Tasks requiring human judgment between iterations
- One-shot operations (just use Claude directly)
- Tasks where iteration doesn't improve output

## Tips

- Start with `--max-iterations 3` to get a feel for it
- Write clear, specific prompts — vague prompts lead to circular iterations
- The completion promise should be objectively verifiable (e.g., "all tests pass")
- Watch git history between iterations to understand what changed
- Combine with DeepEval for automated quality gates between iterations
