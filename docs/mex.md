# mex

> **Living documentation scaffold that evolves with your code**

---

## What It Does

mex creates a structured documentation system inside your project (`.mex/` folder) that stays in sync with your actual code. It detects when docs go stale and helps you keep them current.

**Key Features:**
- Auto-generated project scaffold
- Drift detection (8 checkers)
- ~60% token reduction per session
- Works with Cursor, Claude Code, Windsurf
- ROUTER.md for smart context loading

---

## Installation

```bash
npm install -g mex-cli
```

---

## Quick Start

```bash
# Navigate to your project
cd ~/my-awesome-project

# Initialize mex
mex init

# This creates:
# .mex/
# ├── architecture.md      # System overview
# ├── conventions.md       # Coding standards
# ├── decisions.md         # ADRs (Architecture Decision Records)
# ├── patterns/            # Reusable patterns
# ├── ROUTER.md            # Context routing table
# └── .cursorrules         # Cursor-specific rules
```

---

## File Structure

```
.mex/
├── architecture.md          # System architecture
├── conventions.md           # Coding conventions
├── decisions.md             # Decision log (ADRs)
├── patterns/
│   ├── authentication.md
│   ├── error-handling.md
│   └── state-management.md
├── ROUTER.md                # Smart context router
├── .cursorrules             # Cursor AI rules
└── CLAUDE.md                # Claude Code context
```

---

## ROUTER.md Explained

The ROUTER.md acts as a smart table of contents. AI agents read it first to know what context to load.

```markdown
# ROUTER

## When working on...

### Authentication
- Load: patterns/authentication.md
- Load: decisions.md#auth-decisions

### API Design
- Load: patterns/api-design.md
- Load: conventions.md#api-conventions

### Database
- Load: architecture.md#data-layer
- Load: decisions.md#database-choice
```

---

## Drift Detection

mex automatically detects when your docs don't match your code:

```bash
# Enable drift detection
mex drift --enable

# Run drift check
mex drift check

# Output:
# ⚠️  Stale file: patterns/authentication.md
#    Last updated: 2024-01-15
#    Related files changed: src/auth/*.ts
#
# ⚠️  Missing documentation: src/api/new-endpoint.ts
#    No pattern doc found for this endpoint style
```

### Drift Checkers

| Checker | Detects |
|---------|---------|
| `stale-files` | Docs not updated when code changes |
| `missing-docs` | New code without documentation |
| `broken-links` | Links to non-existent files |
| `orphaned-patterns` | Patterns not used anywhere |
| `decision-gaps` | Decisions without rationale |
| `convention-violations` | Code not following conventions |
| `architecture-drift` | Code diverging from architecture |
| `api-mismatch` | API docs don't match implementation |

---

## IDE Integration

### Cursor

```bash
# Generate .cursorrules
mex cursor-rules

# This creates .cursorrules in your project root
# Cursor automatically reads it for context
```

### Claude Code

```bash
# Generate CLAUDE.md
mex claude-md

# This creates CLAUDE.md in your project root
# Claude Code reads it on startup
```

### Windsurf

```bash
# Generate .windsurfrules
mex windsurf-rules
```

---

## Commands

| Command | Description |
|---------|-------------|
| `mex init` | Initialize mex in current project |
| `mex status` | Check documentation health |
| `mex drift` | Run drift detection |
| `mex update` | Update all generated files |
| `mex add-pattern <name>` | Add a new pattern doc |
| `mex add-decision` | Add a new ADR |
| `mex cursor-rules` | Generate .cursorrules |
| `mex claude-md` | Generate CLAUDE.md |
| `mex export` | Export docs to markdown |
| `mex import` | Import from existing docs |

---

## Best Practices

1. **Run `mex init` in every project**
2. **Enable drift detection** - `mex drift --enable`
3. **Update docs when code changes** - Don't let drift accumulate
4. **Use ROUTER.md** - Helps AI load only relevant context
5. **Commit .mex/ to git** - Share docs with your team

---

## Workflow Example

```bash
# 1. Start new project
mkdir my-project && cd my-project
npm init -y

# 2. Initialize mex
mex init

# 3. Work on feature
# ... write code ...

# 4. Check for drift
mex drift check

# 5. Update docs
# Edit .mex/decisions.md to document your choices

# 6. Commit everything
git add .
git commit -m "Add feature X with documentation"
```

---

## Comparison with Other Tools

| Feature | mex | Repomix | Claude Context |
|---------|-----|---------|----------------|
| Drift detection | ✅ Yes | ❌ No | ❌ No |
| Token reduction | ~60% | ~80% | ~40% |
| IDE rules | ✅ Yes | ❌ No | ❌ No |
| Auto-update | ✅ Yes | ❌ No | ❌ No |
| Code search | ❌ No | ❌ No | ✅ Yes |

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Drift false positives | Adjust checker sensitivity in config |
| ROUTER.md not loading | Check file is in project root |
| Cursor not reading rules | Ensure .cursorrules is committed |
| Slow drift checks | Exclude large directories in config |

---

## Resources

- GitHub: https://github.com/thedakshjaitly/mex
- NPM: https://www.npmjs.com/package/mex-cli
- Docs: https://docs.mex.dev
