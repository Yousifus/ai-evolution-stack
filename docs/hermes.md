# Hermes Agent

> Self-improving autonomous agent by NousResearch. Learns skills from experience, has persistent cross-session memory, and works as both an MCP client and server.

- **GitHub**: https://github.com/NousResearch/hermes-agent
- **Stars**: ~8,700
- **Category**: Personal Evolution + Agent Framework

## What It Does

Hermes Agent is an autonomous AI agent that:
- **Self-improves** through a learning loop: observe -> learn -> create skills -> improve
- **Persists memory** across sessions using FTS5 search + LLM summarization
- **Consumes MCP servers** (uses your other tools)
- **Runs as an MCP server** (exposes its own tools to Claude Code / Cursor)
- Works with **any LLM backend**: OpenAI, Anthropic, Ollama, LM Studio, OpenRouter

## Install

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
source ~/.bashrc  # or ~/.zshrc
```

### Windows (via pip)

```powershell
pip install hermes-agent
```

### With extras

```bash
pip install "hermes-agent[voice]"    # Voice support
pip install "hermes-agent[mcp]"      # MCP support
```

## Configure Provider

```bash
# Use local Ollama
hermes config set provider ollama
hermes config set provider.ollama.base_url http://localhost:11434

# Use local LM Studio
hermes config set provider.custom.base_url http://localhost:1234/v1

# Use Claude
hermes config set provider anthropic
hermes config set provider.anthropic.api_key sk-ant-...

# Use OpenAI
hermes config set provider openai
hermes config set provider.openai.api_key sk-...
```

## Run as MCP Server

This exposes Hermes tools to Claude Code, Cursor, etc.

```bash
hermes mcp serve
```

### Add to Claude Code

Add to `~/.claude/mcp.json`:

```json
{
  "hermes": {
    "command": "hermes",
    "args": ["mcp", "serve"]
  }
}
```

### Tools Exposed via MCP

When running as an MCP server, Hermes exposes ~10 tools covering:
- Messaging across Telegram, Discord, Slack, WhatsApp, Signal, Email
- Conversation and history access
- Skill creation and management

## Key Concepts

### Learning Loop

Hermes observes your interactions and creates reusable "skills" — small programs it can run autonomously next time. Over time, it builds a library of capabilities specific to your workflow.

### Persistent Memory

Uses FTS5 (full-text search) + LLM summarization to remember context across sessions. No cloud storage — everything stays local.

### Skills vs Tools

- **Tools**: Static capabilities defined by MCP servers
- **Skills**: Dynamic capabilities Hermes creates from experience — they evolve

## Tips

- Start with Ollama for a fully local setup (no API keys needed)
- Let Hermes observe for a few sessions before expecting useful skills
- Export skills with `hermes skills export` to share between machines
