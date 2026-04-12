# AI Evolution Stack

> **The Ultimate Local-First AI Toolkit for Developers**
>
> 35+ curated tools across 16 categories. At least 2 options per niche.
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
| [Community Finds](#community-finds) | Tools surfaced from r/LocalLLaMA + r/ClaudeAI |

---

## Stack Overview

```
+=====================================================================+
|                     AI EVOLUTION STACK v2                            |
|                  35+ tools across 16 categories                     |
+=====================================================================+
|                                                                     |
|  MEMORY LAYER (Cross-Session, Cross-Project)                        |
|  +-- agentmemory .......... Universal memory, 43 MCP tools          |
|  +-- Basic Memory ......... Human-readable Markdown knowledge graph |
|  +-- MemPalace ............ Conversation history (Claude Code)      |
|  +-- Hindsight ............ Knowledge graph + semantic search       |
|  +-- MemClaw .............. Per-project isolated workspace memory   |
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
|  +-- HF Skills ............ ACP skill definitions for ML tasks      |
|                                                                     |
|  PERSONAL EVOLUTION                                                 |
|  +-- homunculus ........... Pattern learning, instinct evolution     |
|  +-- Hermes Agent ......... Self-improving agent, learns skills     |
|                                                                     |
|  LOCAL INFERENCE                                                    |
|  +-- LM Studio ............ GUI-based local model runner            |
|  +-- Ollama ............... CLI-based, 166k stars, massive ecosystem |
|  +-- LocalAI .............. Multi-modal OpenAI API drop-in          |
|  +-- hf-agents ............ One-command local agent (HuggingFace)   |
|                                                                     |
|  AGENT FRAMEWORKS                                                   |
|  +-- Hermes Agent ......... Self-improving agent (NousResearch)     |
|  +-- crewAI ............... Multi-agent orchestration (45k stars)   |
|  +-- claude-flow .......... Claude-native swarm orchestration       |
|  +-- workflow-orchestration  Lightweight 8-agent task system        |
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

| Feature | agentmemory | Basic Memory | MemPalace | Hindsight | MemClaw |
|---------|-------------|--------------|-----------|-----------|--------|
| **Install** | `npm i -g @agentmemory/agentmemory` | `pip install basic-memory` | `pip install mempalace` | `pip install hindsight-server` | `pip install memclaw` |
| **Works with Cursor** | Yes | Yes | No | Yes | Yes |
| **Works with Claude Code** | Yes | Yes | Yes | Yes | Yes |
| **Works with LM Studio** | Yes | Yes | No | Yes | Yes |
| **Storage** | ChromaDB | Markdown files | ChromaDB | SQLite | SQLite |
| **Search** | Vector + Time | Vector + Time | Vector | Graph + Vector | Vector + Tasks |
| **MCP Tools** | 43 | 12 | 19 | 8 | 6 |
| **Auto-Capture** | Yes | Yes | Manual | Yes | Yes |
| **Scope** | Global | Global | Global | Global | **Per-project isolated** |
| **Best For** | Universal memory across all tools | Human-readable, git-friendly memory | Claude Code conversation recall | Knowledge graphs | Zero cross-project bleed, living project README |

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
| **HF Skills** | `pip install huggingface-skills` | ACP skill definitions: dataset creation, model training, evaluation, paper publishing. Compatible with Claude Code, Codex, Gemini CLI, Cursor. |

### 13. Personal Evolution

| Feature | homunculus | Hermes Agent |
|---------|-----------|--------------|
| **Install** | `git clone` + `pip install -e .` | `curl` install script |
| **What It Does** | Learns YOUR coding patterns over time | Self-improving agent that creates skills from experience |
| **Evolution Path** | Instincts -> Skills -> Agents | Learning loop: observe -> learn -> improve |
| **MCP Support** | No | Yes (both client and server) |
| **Best For** | AI that adapts to your style | Autonomous agent that grows with you |

### 14. Local Inference

| Feature | LM Studio | Ollama | LocalAI | hf-agents |
|---------|-----------|--------|---------|----------|
| **Install** | Download from lmstudio.ai | `curl -fsSL https://ollama.ai/install.sh \| sh` | Docker / binary | `pip install hf-agents` |
| **Interface** | GUI | CLI + REST API | REST API (OpenAI-compatible) | CLI, one command |
| **Model Format** | GGUF | GGUF (auto-pull) | Multi-backend | Auto-detected via llmfit |
| **Multi-Modal** | Text + Vision | Text + Vision | Text + Vision + Audio + Embeddings | Text + Code |
| **GitHub Stars** | -- | 166k | 30k+ | -- |
| **Best For** | Beginners, visual management | Most popular, huge ecosystem | Advanced multi-modal pipelines | Zero-config local agent: detects hardware, picks model, starts server automatically |

### 15. Agent Frameworks

| Feature | Hermes Agent | crewAI | claude-flow | workflow-orchestration |
|---------|-------------|--------|-------------|------------------------|
| **Install** | `curl` install script | `pip install crewai` | `npm i -g claude-flow` | `git clone` |
| **What It Does** | Self-improving agent with persistent memory | Multi-agent orchestration with roles | Claude-native swarm: 87 MCP tools, hive-mind, peer-to-peer agent messaging | 8 specialist agents (code, test, architecture, DevOps) with auto task decomposition |
| **MCP Support** | Native (client + server) | Native | Native (87 tools) | No |
| **Self-Improving** | Yes (learning loop) | No | No | No |
| **Multi-Agent** | Single agent | Yes (crews) | Yes (swarms) | Yes (8 agents) |
| **Claude-Native** | No | No | **Yes** | Yes |
| **GitHub Stars** | 8.7k | 45.9k | -- | -- |
| **Best For** | Personal AI assistant that learns | Orchestrating teams of specialized agents | Maximum Claude Code integration, parallel swarms | Structured multi-step tasks without swarm overhead |

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
| memclaw | Memory | pip |
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
| claude-flow | Agent | npx |

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

### claude-flow

```bash
# Install
npm install -g claude-flow

# Initialize in your project
claude-flow init

# Start the orchestrator
claude-flow start

# Add to Claude Code mcp.json
# {
#   "claude-flow": {
#     "command": "npx",
#     "args": ["-y", "claude-flow", "mcp"]
#   }
# }

# Run a swarm task
claude-flow swarm "Build a REST API with tests"
```

### hf-agents

```bash
# Install
pip install hf-agents

# Run — it detects your hardware, picks the right model, starts everything
hf-agents run

# Specify a task
hf-agents run --task "refactor this module" --path ./src

# Works with Ollama if already running
hf-agents run --backend ollama
```

For all other tools, see the individual docs in the `docs/` folder.

---

## Community Finds

> Tools surfaced from r/LocalLLaMA and r/ClaudeAI that earned their place in the stack.
> Added April 2026. Install scripts coming in next update.

### MemClaw — Per-Project Isolated Memory

**Repo:** [Felo-Inc/memclaw](https://github.com/Felo-Inc/memclaw)

While agentmemory, MemPalace, and Basic Memory are *global* stores, MemClaw creates **isolated workspaces per project** — each with its own tasks, artifacts, decisions, and a living README that auto-updates as the agent works. Context restores in ~8 seconds. Zero cross-project bleed by design. Genuinely fills a different niche from everything else in the memory layer.

```bash
pip install memclaw
memclaw init  # initializes workspace for current project
```

### claude-flow — Claude-Native Swarm Orchestration

**Repo:** [ruvnet/claude-flow](https://github.com/ruvnet/claude-flow)

The community's most-referenced Claude-specific orchestration tool. Hive-mind swarm architecture, 87 MCP tools built-in, parallel agent execution, and peer-to-peer agent messaging via `SendMessage`. More opinionated than crewAI but significantly tighter Claude Code integration. Think crewAI, but built for Claude from the ground up.

```bash
npm install -g claude-flow
claude-flow init && claude-flow start
```

### claude-code-workflow-orchestration — Lightweight 8-Agent System

**Repo:** [barkain/claude-code-workflow-orchestration](https://github.com/barkain/claude-code-workflow-orchestration)

A lighter alternative to claude-flow. 8 specialist agents (code cleanup, testing, architecture, DevOps, etc.) with automatic task decomposition and intelligent switching between sequential and parallel execution. No swarm overhead — good for structured, predictable multi-step tasks.

```bash
git clone https://github.com/barkain/claude-code-workflow-orchestration
cd claude-code-workflow-orchestration
./setup.sh
```

### hf-agents — One-Command Local Agent (HuggingFace)

**Repo:** [huggingface/hf-agents](https://github.com/huggingface/hf-agents)

Hit 624 upvotes on r/LocalLLaMA in March 2026 as "the one-command local agent setup." Uses `llmfit` to detect your hardware specs, recommends a model and quantization that will actually fit in VRAM, starts a local `llama.cpp` server, and launches a Pi coding agent — all in one command. Perfect extension to your local inference layer.

```bash
pip install hf-agents
hf-agents run
```

### HuggingFace Skills — ACP ML Skill Definitions

**Repo:** [huggingface/skills](https://github.com/huggingface/skills)

ACP (Agent Context Protocol) skill definitions for ML tasks: dataset creation, model training, evaluation, paper publishing. Compatible with Claude Code, Codex, Gemini CLI, and Cursor. If you run AI experiments — whether at Colab or personally — having HF skills pre-wired into your agent removes the boilerplate from every ML task.

```bash
pip install huggingface-skills
# Skills auto-register with compatible ACP agents
```

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
npm update -g @agentmemory/agentmemory mex-cli repomix claude-flow
pip install --upgrade mempalace hindsight-server basic-memory crewai mcp-ragex memclaw hf-agents
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
| claude-flow port conflict | Set `CLAUDE_FLOW_PORT` env var to an available port |
| hf-agents VRAM error | Run `hf-agents run --quantize 4bit` to reduce memory usage |

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
