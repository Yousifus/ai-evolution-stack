# Quick Start Guide

> Get your AI Evolution Stack running in 5 minutes

## Prerequisites

- Node.js 18+ (`node --version`)
- Python 3.10+ (`python3 --version` or `python --version` on Windows)
- Git (`git --version`)

## One-Line Install

### macOS / Linux

```bash
git clone https://github.com/Yousifus/ai-evolution-stack.git
cd ai-evolution-stack && chmod +x install.sh && ./install.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/Yousifus/ai-evolution-stack.git
cd ai-evolution-stack; .\install.ps1
```

## What Gets Installed

The interactive installer lets you choose:

- **Everything** — all 30+ tools across 15 categories
- **Core** — memory + project context + code search + MCP config
- **Individual categories** — pick exactly what you need

## After Install

1. **Restart** Cursor / Claude Code
2. **Verify** MCP servers loaded: `claude mcp list`
3. **Try it**:
   - "Search memory for authentication" (memory)
   - "Use Repomix to package this repo" (context)
   - "Fetch https://example.com" (web)
   - "Search Brave for React 19 changes" (search)

## Key Commands

| Task | Command |
|------|---------|
| Install everything | `./install.sh --everything` |
| Install core only | `./install.sh --core` |
| Update all tools | `./scripts/update-all.sh` |
| Check status | `./install.sh --verify` |
| Setup MCP only | `./install.sh --mcp` |

## Need Help?

- Full docs: See `README.md`
- Per-tool guides: See `docs/` folder
- Issues: https://github.com/Yousifus/ai-evolution-stack/issues
