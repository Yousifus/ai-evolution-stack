# 🚀 Quick Start Guide

> Get your AI Evolution Stack running in 5 minutes

---

## Prerequisites

- Node.js 18+ (`node --version`)
- Python 3.10+ (`python3 --version`)
- Git (`git --version`)

---

## One-Line Install

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/ai-evolution-stack/main/install.sh | bash
```

### Windows

```powershell
irm https://raw.githubusercontent.com/YOUR_USERNAME/ai-evolution-stack/main/install.ps1 | iex
```

---

## Manual Install (Step by Step)

### 1. Install Core Tools

```bash
# Universal memory (works with all AI tools)
npm install -g @agentmemory/agentmemory

# Human-readable knowledge graph
pip install basic-memory

# Project documentation
npm install -g mex-cli

# Codebase packaging
npm install -g repomix
```

### 2. Configure MCP

Copy this to `~/.claude/mcp.json`:

```json
{
  "mcpServers": {
    "agentmemory": {
      "command": "npx",
      "args": ["-y", "@agentmemory/agentmemory"]
    },
    "basic-memory": {
      "command": "uvx",
      "args": ["basic-memory", "mcp"]
    },
    "repomix": {
      "command": "repomix",
      "args": ["--mcp"]
    }
  }
}
```

### 3. Initialize Your First Project

```bash
cd ~/your-project

# Initialize mex documentation
mex init

# This creates .mex/ folder with:
# - architecture.md
# - conventions.md
# - decisions.md
# - ROUTER.md
```

### 4. Restart Your IDE

- **Cursor:** Fully quit and reopen
- **Claude Code:** Run `claude` again
- **Cline:** Reload window

---

## Verify Installation

```bash
./scripts/verify-install.sh
```

---

## First Use

### In Cursor / Claude Code

```
# Store something important
"Remember that I prefer TypeScript over JavaScript"

# Later, recall it
"What language do I prefer?"

# Get project context
"Load the architecture docs for this project"

# Package the entire codebase
"Use Repomix to give me full context"
```

---

## Common Commands

| Task | Command |
|------|---------|
| Check status | `./scripts/verify-install.sh` |
| Update all | `./scripts/update-all.sh` |
| Init mex in project | `mex init` |
| Check drift | `mex drift check` |
| Search memory | "Search memory for authentication" |
| Package codebase | "Use Repomix to package this repo" |

---

## Next Steps

1. **Read the full docs** in `/docs/`
2. **Set up optional tools** like homunculus or LM Studio
3. **Customize your MCP config** for your workflow
4. **Share with your team** - commit `.mex/` to git

---

## Need Help?

- 📖 Full documentation: See `README.md`
- 🔧 Troubleshooting: See `docs/troubleshooting.md`
- 💬 Discussions: GitHub Discussions
- 🐛 Issues: GitHub Issues
