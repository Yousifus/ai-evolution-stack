# AI Evolution Stack

> **The Ultimate Local-First AI Toolkit for Developers**
>
> 30+ curated tools across 15 categories. At least 2 options per niche.
> One script installs everything. No cloud required.

---

## Quick Navigation

| Section | Description |
|---------|-------------|
| [Stack Overview](#stack-overview) | Full architecture — what's included |
| [Quick Install](#quick-install) | One command to get everything |
| [Tool Catalog](#tool-catalog) | Every tool by category with comparisons |
| [MCP Integration](#mcp-integration) | Unified config for Claude Code, Cursor, LM Studio |
| [Setup Guides](#setup-guides) | Step-by-step per tool |
| [Troubleshooting](#troubleshooting) | Common issues and fixes |

---

## Stack Overview

```
+=====================================================================+
|                     AI EVOLUTION STACK v2                            |
|                  30+ tools across 15 categories                     |
+=====================================================================+
|                                                                     |
|  MEMORY LAYER (Cross-Session, Cross-Project)                        |
|  +-- agentmemory .......... Universal memory, 43 MCP tools          |
|  +-- Basic Memory ......... Human-readable Markdown knowledge graph |
|  +-- MemPalace ............ Conversation history (Claude Code)      |
|  +-- Hindsight ............ Knowledge graph + semantic search       |
|                                                                     |
|  PROJECT CONTEXT (Per-Project)                                      |
|  +-- Repomix .............. Full codebase packaging for AI          |
|  +-- mex .................. Living documentation scaffold           |
|  +-- Claude Context ....... Hybrid code search                      |
|                                                                     |
|  CODE SEARCH & NAVIGATION                                           |
|  +-- mcp-ragex ............ Hybrid: RAG + AST + regex search        |
|  +-- Repomix .............. Codebase packaging (dual-use)           |
|                                                                     |
|  WEB & BROWSER                                                      |
|  +-- Fetch MCP ............ URL fetching, HTML-to-Markdown          |
|  +-- Playwright MCP ....... Full browser automation (Microsoft)     |
|  +-- Brave Search MCP ..... Web, image, news, local search          |
|                                                                     |
|  FILE SYSTEM                                                        |
|  +-- Filesystem MCP ....... Official sandboxed file access          |
|  +-- Desktop Commander .... File ops + terminal + diff editing      |
|                                                                     |
|  DATABASE                                                           |
|  +-- SQLite MCP ........... Local SQLite database access            |
|  +-- Postgres MCP ......... PostgreSQL read access + introspection  |
|                                                                     |
|  GIT & GITHUB                                                       |
|  +-- Git MCP .............. Local repo: history, diffs, branches    |
|  +-- GitHub MCP ........... Official: PRs, issues, code search      |
|                                                                     |
|  TERMINAL & SHELL                                                   |
|  +-- Desktop Commander .... Terminal control (dual-use with FS)     |
|  +-- mcp-shell-server ..... Secure whitelisted command execution    |
|                                                                     |
|  IMAGE & VISION                                                     |
|  +-- screenshot MCP ....... Screen capture + content processing     |
|  +-- mcp-vision ........... Camera/screenshot + Ollama vision       |
|                                                                     |
|  TASK & PROJECT MANAGEMENT                                          |
|  +-- Notion MCP ........... Official Notion: pages, databases       |
|  +-- Jira MCP ............. Jira Cloud: tickets, projects, JQL      |
|                                                                     |
|  SECURITY & SECRETS                                                 |
|  +-- Vault MCP ............ HashiCorp Vault integration             |
|  +-- mcp-secrets-vault .... Local mini-vault, AI never sees keys    |
|                                                                     |
|  KNOWLEDGE & DOCS                                                   |
|  +-- Context7 ............. Up-to-date library documentation        |
|                                                                     |
|  PERSONAL EVOLUTION                                                 |
|  +-- homunculus ........... Pattern learning, instinct evolution     |
|  +-- Hermes Agent ......... Self-improving agent, learns skills     |
|                                                                     |
|  LOCAL INFERENCE                                                    |
|  +-- LM Studio ............ GUI-based local model runner            |
|  +-- Ollama ............... CLI-based, 166k stars, massive ecosystem |
|  +-- LocalAI .............. Multi-modal OpenAI API drop-in          |
|                                                                     |
|  AGENT FRAMEWORKS                                                   |
|  +-- Hermes Agent ......... Self-improving agent (NousResearch)     |
|  +-- crewAI ............... Multi-agent orchestration (45k stars)   |
|                                                                     |
+=====================================================================+
```

---

## Quick Install

### macOS / Linux

```bash
git clone https://github.com/Yousifus/ai-evolution-stack.git
cd ai-evolution-stack
chmod +x install.sh
./install.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/Yousifus/ai-evolution-stack.git
cd ai-evolution-stack
.\install.ps1
```

The installer is interactive — choose "Everything" or pick categories individually.

### Install Flags

```bash
# macOS/Linux
./install.sh --everything       # Install all tools
./install.sh --core             # Memory + Context + MCP config
./install.sh --memory           # Memory layer only
./install.sh --web              # Web/Browser tools only
./install.sh --database         # Database tools only
./install.sh --agents           # Agent frameworks only
./install.sh --inference        # Local inference (Ollama + LocalAI)
./install.sh --verify           # Check what's installed

# Windows
.\install.ps1 -Everything
.\install.ps1 -Core
.\install.ps1 -Verify
```

---

## Tool Catalog

### 1. Memory Layer

Cross-session, cross-project memory systems that remember your work.

| Feature | agentmemory | Basic Memory | MemPalace | Hindsight |
|---------|-------------|--------------|-----------|-----------|
| **Install** | `npm i -g @agentmemory/agentmemory` | `pip install basic-memory` | `pip install mempalace` | `pip install hindsight-server` |
| **Works with Cursor** | Yes | Yes | No | Yes |
| **Works with Claude Code** | Yes | Yes | Yes | Yes |
| **Works with LM Studio** | Yes | Yes | No | Yes |
| **Storage** | ChromaDB | Markdown files | ChromaDB | SQLite |
| **Search** | Vector + Time | Vector + Time | Vector | Graph + Vector |
| **MCP Tools** | 43 | 12 | 19 | 8 |
| **Auto-Capture** | Yes | Yes | Manual | Yes |
| **Best For** | Universal memory across all tools | Human-readable, git-friendly memory | Claude Code conversation recall | Knowledge graphs |

### 2. Project Context

Per-project tools that give AI deep understanding of your codebase.

| Feature | Repomix | mex | Claude Context |
|---------|---------|-----|----------------|
| **Install** | `npm i -g repomix` | `npm i -g mex-cli` | Via plugins |
| **What It Does** | Packages entire codebase for AI consumption | Living docs that stay in sync with code | Hybrid code search |
| **Token Reduction** | ~80% | ~60% | ~40% |
| **Drift Detection** | No | Yes | No |
| **MCP Server** | Yes | No | Yes |

### 3. Code Search & Navigation

| Feature | mcp-ragex | Repomix (dual-use) |
|---------|-----------|-------------------|
| **Install** | `pip install mcp-ragex` | `npm i -g repomix` |
| **Search Modes** | RAG (vector) + AST (tree-sitter) + regex (ripgrep) | Full codebase packaging |
| **Local Embeddings** | Yes | N/A |
| **Multi-Language** | Yes | Yes |

### 4. Web & Browser

| Feature | Fetch MCP | Playwright MCP | Brave Search MCP |
|---------|-----------|----------------|-------------------|
| **Install** | `npx @modelcontextprotocol/server-fetch` | `npx @playwright/mcp@latest` | `npx @brave/mcp-server` |
| **What It Does** | Fetches URLs, converts HTML to Markdown | Full browser automation: click, fill, screenshot | Web, image, news, local search |
| **API Key Required** | No | No | Yes (free tier) |
| **Best For** | Reading web pages/APIs | E2E testing, form filling | Searching the internet |

### 5. File System

| Feature | Filesystem MCP | Desktop Commander |
|---------|---------------|-------------------|
| **Install** | `npx @modelcontextprotocol/server-filesystem /path` | `npx @wonderwhy-er/desktop-commander` |
| **What It Does** | Sandboxed read/write to allowed directories | File ops + diff editing + terminal + process mgmt |
| **Scope** | File operations only | File + Terminal + Process (all-in-one) |
| **Best For** | Safe, minimal file access | Power users who want everything |

### 6. Database

| Feature | SQLite MCP | Postgres MCP |
|---------|-----------|--------------|
| **Install** | `uvx mcp-server-sqlite --db-path ./db.sqlite` | `npx @modelcontextprotocol/server-postgres $CONN` |
| **What It Does** | Full CRUD on SQLite databases | Read-only Postgres with schema introspection |
| **Access Level** | Read + Write | Read-only (safe) |
| **Best For** | Local databases, prototyping | Production DB exploration |

### 7. Git & GitHub

| Feature | Git MCP | GitHub MCP |
|---------|---------|------------|
| **Install** | `uvx mcp-server-git` | See [setup guide](#github-mcp) |
| **What It Does** | Local repo: log, diff, blame, branches | PRs, issues, code search, actions |
| **Scope** | Local git operations | GitHub API (cloud) |
| **API Key Required** | No | Yes (PAT) |

### 8. Terminal & Shell

| Feature | Desktop Commander | mcp-shell-server |
|---------|-------------------|-----------------|
| **Install** | `npx @wonderwhy-er/desktop-commander` | `pip install mcp-shell-server` |
| **What It Does** | Full terminal control + file system | Whitelisted command execution |
| **Security** | Broad access | Restricted to allowed commands |
| **Best For** | Power users | Security-conscious setups |

### 9. Image & Vision

| Feature | Screenshot MCP | mcp-vision |
|---------|---------------|------------|
| **Install** | `pip install screenshot-mcp-server` | See [repo](https://github.com/MikeyBeez/mcp-vision) |
| **What It Does** | Screen capture + content processing | Camera/screenshot + Ollama vision analysis |
| **Cloud Required** | No | No (uses Ollama locally) |
| **Best For** | Quick screenshots for AI | Full local vision pipeline |

### 10. Task & Project Management

| Feature | Notion MCP | Jira MCP |
|---------|-----------|----------|
| **Install** | Official Notion integration | `pip install jira-mcp-server` |
| **What It Does** | Pages, databases, search, content management | Tickets, projects, JQL search |
| **Best For** | Teams using Notion | Teams using Jira/Atlassian |

### 11. Security & Secrets

| Feature | Vault MCP | mcp-secrets-vault |
|---------|----------|-------------------|
| **Install** | Via HashiCorp | `pip install mcp-secrets-vault` |
| **What It Does** | HashiCorp Vault: enterprise secret management | Local mini-vault, AI calls APIs without seeing keys |
| **Scope** | Enterprise | Individual / small team |
| **Best For** | Production environments | Dev workflows, personal API keys |

### 12. Knowledge & Docs

| Tool | Install | What It Does |
|------|---------|-------------|
| **Context7** | Via Cursor/Claude plugins | Always up-to-date library documentation |

### 13. Personal Evolution

| Feature | homunculus | Hermes Agent |
|---------|-----------|--------------|
| **Install** | `git clone` + `pip install -e .` | `curl` install script |
| **What It Does** | Learns YOUR coding patterns over time | Self-improving agent that creates skills from experience |
| **Evolution Path** | Instincts -> Skills -> Agents | Learning loop: observe -> learn -> improve |
| **MCP Support** | No | Yes (both client and server) |
| **Best For** | AI that adapts to your style | Autonomous agent that grows with you |

### 14. Local Inference

| Feature | LM Studio | Ollama | LocalAI |
|---------|-----------|--------|---------|
| **Install** | Download from lmstudio.ai | `curl -fsSL https://ollama.ai/install.sh \| sh` | Docker / binary |
| **Interface** | GUI | CLI + REST API | REST API (OpenAI-compatible) |
| **Model Format** | GGUF | GGUF (auto-pull) | Multi-backend |
| **Multi-Modal** | Text + Vision | Text + Vision | Text + Vision + Audio + Embeddings |
| **GitHub Stars** | -- | 166k | 30k+ |
| **Best For** | Beginners, visual management | Most popular, huge ecosystem | Advanced multi-modal pipelines |

### 15. Agent Frameworks

| Feature | Hermes Agent | crewAI |
|---------|-------------|--------|
| **Install** | `curl` install script | `pip install crewai` |
| **What It Does** | Self-improving agent with persistent memory | Multi-agent orchestration with roles |
| **MCP Support** | Native (client + server) | Native |
| **Self-Improving** | Yes (learning loop) | No |
| **Multi-Agent** | Single agent | Yes (crews of agents) |
| **GitHub Stars** | 8.7k | 45.9k |
| **Best For** | Personal AI assistant that learns | Orchestrating teams of specialized agents |

---

## MCP Integration

### Complete Claude Code Config

Copy `mcp.json` from this repo to `~/.claude/mcp.json`, or run:

```bash
# macOS/Linux
./install.sh --mcp

# Windows
.\install.ps1 -MCP
```

This configures all MCP servers for Claude Code, Cursor, and LM Studio.

### What Gets Configured

| MCP Server | Category | Install Method |
|---|---|---|
| agentmemory | Memory | npx |
| basic-memory | Memory | uvx/pip |
| hindsight | Memory | pip |
| mempalace | Memory | pip |
| repomix | Context | npx |
| mcp-ragex | Code Search | pip |
| fetch | Web | npx |
| playwright | Web/Browser | npx |
| brave-search | Web/Search | npx |
| filesystem | File System | npx |
| desktop-commander | File + Terminal | npx |
| sqlite | Database | uvx |
| postgres | Database | npx |
| git | Git | uvx |
| github | GitHub | HTTP |
| mcp-shell-server | Terminal | pip |
| screenshot | Vision | pip |
| notion | Task Mgmt | HTTP |
| secrets-vault | Security | pip |
| hermes | Agent | pip |

---

## Setup Guides

### Hermes Agent

```bash
# Install (macOS/Linux)
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
source ~/.bashrc

# Configure provider (use local Ollama or LM Studio)
hermes config set provider.custom.base_url http://localhost:11434/v1

# Or use Claude/OpenAI
hermes config set provider anthropic
hermes config set provider.anthropic.api_key YOUR_KEY

# Run as MCP server (exposes tools to Claude Code)
hermes mcp serve

# Add to Claude Code mcp.json
# {
#   "hermes": {
#     "command": "hermes",
#     "args": ["mcp", "serve"]
#   }
# }
```

### Ollama

```bash
# Install
curl -fsSL https://ollama.ai/install.sh | sh

# Windows: download from https://ollama.com/download

# Pull recommended models
ollama pull qwen2.5-coder:32b    # Best for coding
ollama pull llama3.3:70b          # General purpose
ollama pull nomic-embed-text      # Embeddings

# Ollama runs as a REST API on http://localhost:11434
# Compatible with any OpenAI-client tool
```

### Brave Search MCP

```bash
# Get free API key: https://brave.com/search/api/
# Then configure:
# In mcp.json:
# {
#   "brave-search": {
#     "command": "npx",
#     "args": ["-y", "@brave/mcp-server"],
#     "env": {
#       "BRAVE_API_KEY": "your-key-here"
#     }
#   }
# }
```

### GitHub MCP

```bash
# Generate a Personal Access Token at https://github.com/settings/tokens
# Then add to Claude Code:
claude mcp add github \
  --transport http \
  --url https://api.githubcopilot.com/mcp/ \
  --header "Authorization: Bearer YOUR_GITHUB_PAT"
```

### Desktop Commander

```bash
# Install and auto-configure
npx @wonderwhy-er/desktop-commander setup

# Or add manually to mcp.json:
# {
#   "desktop-commander": {
#     "command": "npx",
#     "args": ["-y", "@wonderwhy-er/desktop-commander"]
#   }
# }
```

### crewAI

```bash
# Install
pip install crewai

# Create a crew
crewai create crew my-research-crew
cd my-research-crew

# crewAI has native MCP support — it auto-discovers
# MCP servers and converts tools to LangChain format
```

For all other tools, see the individual docs in the `docs/` folder.

---

## Repository Structure

```
ai-evolution-stack/
+-- README.md                  # This file
+-- install.sh                 # macOS/Linux installer (all tools)
+-- install.ps1                # Windows installer (all tools)
+-- mcp.json                   # Complete MCP configuration
+-- docs/
|   +-- agentmemory.md         # agentmemory deep dive
|   +-- basic-memory.md        # Basic Memory deep dive
|   +-- homunculus.md          # homunculus deep dive
|   +-- lm-studio.md          # LM Studio deep dive
|   +-- mex.md                 # mex deep dive
|   +-- hermes.md              # Hermes Agent guide
|   +-- ollama.md              # Ollama guide
|   +-- web-browser.md         # Fetch + Playwright + Brave guide
|   +-- database.md            # SQLite + Postgres MCP guide
|   +-- git-github.md          # Git + GitHub MCP guide
|   +-- security.md            # Vault + secrets-vault guide
+-- examples/
|   +-- claude-mcp.json        # Claude Code MCP config
|   +-- cursor-mcp.json        # Cursor MCP config
|   +-- lmstudio-mcp.json     # LM Studio MCP config
+-- scripts/
|   +-- update-all.sh          # Update all installed tools
|   +-- verify-install.sh      # Verify installation status
+-- .gitignore
+-- LICENSE
+-- QUICKSTART.md
```

---

## Update All Tools

```bash
# Run the update script
./scripts/update-all.sh

# Or update manually
npm update -g @agentmemory/agentmemory mex-cli repomix
pip install --upgrade mempalace hindsight-server basic-memory crewai mcp-ragex
ollama pull qwen2.5-coder:32b   # Updates models too
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| MCP server not found | Check PATH: `echo $PATH` or restart terminal |
| Permission denied | `chmod +x install.sh` |
| Port conflicts | Change ports in mcp.json or stop conflicting services |
| Ollama model not loading | Check `ollama serve` is running |
| Brave Search 401 | Verify `BRAVE_API_KEY` in env |
| GitHub MCP auth failed | Regenerate PAT with correct scopes |
| Memory not persisting | Check ChromaDB/SQLite file permissions |
| Windows: python3 not found | Use `python` instead of `python3` on Windows |
| Desktop Commander hangs | Kill with `npx @wonderwhy-er/desktop-commander stop` |

---

## Contributing

Found a new tool? Open a PR! The goal is **2+ options per category**.

When adding a tool, include:
1. Add to the relevant category table in README
2. Add install function to `install.sh` and `install.ps1`
3. Add MCP config to `mcp.json` if applicable
4. Add a doc file in `docs/` for detailed setup

---

## License

MIT - Use however you want. Keep it local. Stay private.

---

**Made for the local-first AI community.**
