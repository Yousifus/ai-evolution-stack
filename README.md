# 🧠 AI Evolution Stack

> **Your Complete Local-First AI Memory & Context Architecture**
> 
> Everything runs on your device. No cloud. No API keys required (mostly). Full privacy.

---

## 📋 Quick Navigation

| Section | Description |
|---------|-------------|
| [🎯 Your Stack Overview](#-your-stack-overview) | What you have vs what to add |
| [🔧 Core Tools](#-core-tools) | Essential memory & context systems |
| [⚡ Quick Install](#-quick-install) | One-liners to get everything |
| [📊 Comparison Matrix](#-comparison-matrix) | Side-by-side feature comparison |
| [🛠️ Setup Guides](#️-setup-guides) | Step-by-step for each tool |
| [🔌 MCP Integration](#-mcp-integration) | Making everything work together |

---

## 🎯 Your Stack Overview

### ✅ What You Already Have
- **Cursor AI** - Primary IDE with AI
- **Claude Code** - Secondary AI assistant  
- **Cline** - Alternative AI agent
- **Augment** - AI coding assistant
- **Warp** - AI-powered terminal

### 🚀 What This Repo Adds

```
┌─────────────────────────────────────────────────────────────┐
│                    LOCAL AI EVOLUTION STACK                  │
├─────────────────────────────────────────────────────────────┤
│  MEMORY LAYER (Cross-Project)                                │
│  ├── MemPalace      → Conversation history (Claude Code)    │
│  ├── agentmemory    → Universal memory for ALL agents       │
│  ├── Basic Memory   → Human-readable knowledge graph        │
│  └── Hindsight      → Knowledge graph + semantic search     │
├─────────────────────────────────────────────────────────────┤
│  PROJECT CONTEXT (Per-Project)                               │
│  ├── mex            → Living documentation scaffold         │
│  ├── Repomix        → Full codebase packaging               │
│  └── Claude Context → Hybrid code search                    │
├─────────────────────────────────────────────────────────────┤
│  PERSONAL EVOLUTION (Learns You)                             │
│  └── homunculus     → Pattern learning & instinct evolution │
├─────────────────────────────────────────────────────────────┤
│  KNOWLEDGE LAYER (Current Docs)                              │
│  └── Context7       → Up-to-date library documentation      │
├─────────────────────────────────────────────────────────────┤
│  LOCAL INFERENCE (Optional)                                  │
│  └── LM Studio      → Run models locally (Hermes agent)     │
└─────────────────────────────────────────────────────────────┘
```

---

## ⚡ Quick Install

### 🖥️ macOS / Linux

```bash
# Clone this repo
git clone https://github.com/YOUR_USERNAME/ai-evolution-stack.git
cd ai-evolution-stack

# Run the all-in-one installer
chmod +x install.sh
./install.sh
```

### 🪟 Windows (PowerShell)

```powershell
# Clone this repo
git clone https://github.com/YOUR_USERNAME/ai-evolution-stack.git
cd ai-evolution-stack

# Run the installer
.\install.ps1
```

### 📦 Individual Install Commands

| Tool | Install Command | Time |
|------|-----------------|------|
| **MemPalace** | `pip install mempalace` | 30s |
| **agentmemory** | `npx -y @agentmemory/agentmemory` | 1m |
| **Basic Memory** | `uvx basic-memory mcp` | 30s |
| **Hindsight** | `pip install hindsight-server` | 1m |
| **mex** | `npx -g mex-cli` | 30s |
| **Repomix** | `npx -g repomix` | 30s |
| **homunculus** | See [setup guide](#homunculus) | 5m |
| **Context7** | Via Cursor/Claude plugins | 1m |
| **LM Studio** | Download from lmstudio.ai | 5m |

---

## 📊 Comparison Matrix

### Memory Systems

| Feature | MemPalace | agentmemory | Basic Memory | Hindsight |
|---------|-----------|-------------|--------------|-----------|
| **Local-First** | ✅ | ✅ | ✅ | ✅ |
| **Works with Cursor** | ❌ | ✅ | ✅ | ✅ |
| **Works with Claude Code** | ✅ | ✅ | ✅ | ✅ |
| **Works with Cline** | ❌ | ✅ | ✅ | ✅ |
| **Works with LM Studio** | ❌ | ✅ | ✅ | ✅ |
| **Storage** | ChromaDB | ChromaDB | Markdown files | SQLite |
| **Search** | Vector | Vector + Time | Vector + Time | Graph + Vector |
| **Token Reduction** | 92% | 92% | ~60% | ~70% |
| **Recall Accuracy** | 96.6% | 95.2% | ~85% | ~90% |
| **MCP Tools** | 19 | 43 | 12 | 8 |
| **Auto-Capture** | Manual | ✅ | ✅ | ✅ |
| **Export/Import** | ✅ | ✅ | ✅ | ✅ |
| **Setup Complexity** | Medium | Low | Low | Low |

### Project Context Tools

| Feature | mex | Repomix | Claude Context |
|---------|-----|---------|----------------|
| **Local-First** | ✅ | ✅ | ✅ |
| **Works with Cursor** | ✅ | ✅ | ✅ |
| **Works with Claude Code** | ✅ | ✅ | ✅ |
| **Drift Detection** | ✅ | ❌ | ❌ |
| **Code Search** | ❌ | ❌ | ✅ |
| **Token Reduction** | ~60% | ~80% | ~40% |
| **MCP Integration** | ❌ | ✅ | ✅ |
| **Setup Complexity** | Low | Low | Medium |

### Personal Evolution

| Feature | homunculus | Context7 |
|---------|------------|----------|
| **Local-First** | ✅ | ✅ |
| **Works with Cursor** | ❌ | ✅ |
| **Works with Claude Code** | ✅ | ✅ |
| **Pattern Learning** | ✅ | ❌ |
| **Library Docs** | ❌ | ✅ |
| **Evolution Path** | Instincts→Skills→Agents | Static |
| **Setup Complexity** | Medium | Low |

---

## 🛠️ Setup Guides

### 1. MemPalace (Claude Code Only)

```bash
# Install
pip install mempalace

# Initialize
mempalace init

# Add to Claude Code MCP
# Edit: ~/.claude/mcp.json
{
  "mcpServers": {
    "mempalace": {
      "command": "mempalace",
      "args": ["mcp"]
    }
  }
}

# Import existing conversations
mempalace import --source claude --file ~/Downloads/conversations.json
```

**Verdict:** Best for Claude Code users who want to remember everything.

---

### 2. agentmemory (Universal - Recommended)

```bash
# Install globally
npm install -g @agentmemory/agentmemory

# Or run without installing
npx -y @agentmemory/agentmemory

# Add to Claude Code
# Edit: ~/.claude/mcp.json
{
  "mcpServers": {
    "agentmemory": {
      "command": "npx",
      "args": ["-y", "@agentmemory/agentmemory"]
    }
  }
}

# Add to Cursor
# Settings → MCP → Add Server → Command: npx -y @agentmemory/agentmemory

# Test
agentmemory status
```

**Verdict:** Best universal memory that works across ALL your AI tools.

---

### 3. Basic Memory (Human-Readable)

```bash
# Install via uv (recommended)
uvx basic-memory mcp

# Or via pip
pip install basic-memory

# Add to Claude Code
# Edit: ~/.claude/mcp.json
{
  "mcpServers": {
    "basic-memory": {
      "command": "uvx",
      "args": ["basic-memory", "mcp"]
    }
  }
}

# Initialize
basic-memory init

# Import from Claude/ChatGPT
basic-memory import claude ~/Downloads/conversations.json
```

**Verdict:** Best if you want to read/edit your memory as Markdown files.

---

### 4. Hindsight (Knowledge Graph)

```bash
# Install
pip install hindsight-server

# Configure for local-only (no OpenAI)
export HINDSIGHT_API_LLM_PROVIDER=ollama
export HINDSIGHT_API_LLM_BASE_URL=http://localhost:11434

# Or use LM Studio
export HINDSIGHT_API_LLM_PROVIDER=custom
export HINDSIGHT_API_LLM_BASE_URL=http://localhost:1234/v1

# Start server
hindsight-server

# Add to Claude Code
# Edit: ~/.claude/mcp.json
{
  "mcpServers": {
    "hindsight": {
      "command": "hindsight-server",
      "env": {
        "HINDSIGHT_API_LLM_PROVIDER": "ollama"
      }
    }
  }
}
```

**Verdict:** Best for building a knowledge graph of your work.

---

### 5. mex (Project Documentation)

```bash
# Install
npm install -g mex-cli

# Initialize in your project
cd ~/your-project
mex init

# This creates .mex/ folder with:
# - architecture.md
# - conventions.md  
# - decisions.md
# - patterns/
# - ROUTER.md

# Enable drift detection
mex drift --enable

# Add to Cursor (creates .cursorrules)
mex cursor-rules

# Add to Claude Code (creates CLAUDE.md)
mex claude-md
```

**Verdict:** Best for keeping project docs in sync with code.

---

### 6. Repomix (Codebase Packaging)

```bash
# Install
npm install -g repomix

# Run as MCP server
repomix --mcp

# Or package a repo
repomix --remote https://github.com/user/repo

# Add to Claude Code
# Edit: ~/.claude/mcp.json
{
  "mcpServers": {
    "repomix": {
      "command": "repomix",
      "args": ["--mcp"]
    }
  }
}
```

**Verdict:** Best for giving AI complete codebase context instantly.

---

### 7. homunculus (Pattern Learning)

```bash
# Install (Claude Code plugin)
# Currently requires manual setup

git clone https://github.com/humanplane/homunculus.git
cd homunculus
pip install -e .

# Initialize in your project
cd ~/your-project
homunculus init

# Commands available in Claude Code:
# /homunculus:init    - Initialize observer
# /homunculus:status  - Check evolution progress
# /homunculus:evolve  - Trigger evolution
# /homunculus:export  - Export your instincts
# /homunculus:import  - Import someone else's instincts
```

**Verdict:** Best for AI that learns YOUR coding style over time.

---

### 8. Context7 (Library Docs)

```bash
# Via Claude Code plugin
# In Claude Code: /plugin install context7

# Or via Cursor
# Settings → Extensions → Search "Context7"

# Usage
# In any conversation: "Use Context7 to check React 19 docs"
```

**Verdict:** Best for staying current with library APIs.

---

### 9. LM Studio (Local Inference)

```bash
# Download from https://lmstudio.ai

# Recommended models for coding:
# - Qwen 2.5 Coder 32B (best for coding)
# - Llama 3.3 70B (general purpose)
# - gpt-oss 20B (good balance)

# Start server
# In LM Studio: Server → Start Server

# Connect Hermes (optional)
hermes config set provider.custom.base_url http://localhost:1234/v1

# Add MCP servers
# Edit: ~/.lmstudio/mcp.json
{
  "mcpServers": {
    "agentmemory": {
      "command": "npx",
      "args": ["-y", "@agentmemory/agentmemory"]
    },
    "basic-memory": {
      "command": "uvx",
      "args": ["basic-memory", "mcp"]
    }
  }
}
```

**Verdict:** Best for 100% local, private AI inference.

---

## 🔌 MCP Integration

### Complete MCP Configuration

Create `~/.claude/mcp.json`:

```json
{
  "mcpServers": {
    "agentmemory": {
      "command": "npx",
      "args": ["-y", "@agentmemory/agentmemory"],
      "description": "Universal memory for all AI tools"
    },
    "basic-memory": {
      "command": "uvx",
      "args": ["basic-memory", "mcp"],
      "description": "Human-readable knowledge graph"
    },
    "hindsight": {
      "command": "hindsight-server",
      "env": {
        "HINDSIGHT_API_LLM_PROVIDER": "ollama"
      },
      "description": "Knowledge graph with semantic search"
    },
    "repomix": {
      "command": "repomix",
      "args": ["--mcp"],
      "description": "Full codebase context"
    },
    "mempalace": {
      "command": "mempalace",
      "args": ["mcp"],
      "description": "Conversation history (Claude Code only)"
    }
  }
}
```

### Cursor MCP Configuration

In Cursor: `Settings → MCP → Add Server`

| Name | Command | Type |
|------|---------|------|
| agentmemory | `npx -y @agentmemory/agentmemory` | Command |
| basic-memory | `uvx basic-memory mcp` | Command |
| hindsight | `hindsight-server` | Command |
| repomix | `repomix --mcp` | Command |

---

## 🎯 Recommended Setup for Your Workflow

### Primary Setup (Cursor + Claude Code)

```bash
# 1. Install universal memory
npm install -g @agentmemory/agentmemory

# 2. Install human-readable memory
uvx basic-memory mcp

# 3. Install project docs
npm install -g mex-cli

# 4. Install codebase packager
npm install -g repomix

# 5. Configure MCP
# Copy the mcp.json from above to ~/.claude/mcp.json

# 6. Initialize mex in each project
cd ~/your-project && mex init

# 7. Install Context7 plugin in Cursor/Claude
```

### Optional: Full Local Stack

```bash
# Add local inference
# Download LM Studio from lmstudio.ai

# Add knowledge graph
pip install hindsight-server

# Add pattern learning
git clone https://github.com/humanplane/homunculus.git
```

---

## 📁 Repository Structure

```
ai-evolution-stack/
├── README.md                 # This file
├── install.sh                # macOS/Linux installer
├── install.ps1               # Windows installer
├── mcp.json                  # Complete MCP configuration
├── docs/
│   ├── mempalace.md         # Detailed MemPalace guide
│   ├── agentmemory.md       # Detailed agentmemory guide
│   ├── basic-memory.md      # Detailed Basic Memory guide
│   ├── hindsight.md         # Detailed Hindsight guide
│   ├── mex.md               # Detailed mex guide
│   ├── repomix.md           # Detailed Repomix guide
│   ├── homunculus.md        # Detailed homunculus guide
│   ├── context7.md          # Detailed Context7 guide
│   └── lm-studio.md         # Detailed LM Studio guide
├── scripts/
│   ├── setup-mcp.sh         # MCP setup script
│   ├── setup-mcp.ps1        # MCP setup script (Windows)
│   └── verify-install.sh    # Verify everything is installed
└── examples/
    ├── cursor-mcp.json      # Cursor-specific MCP config
    ├── claude-mcp.json      # Claude Code MCP config
    └── lmstudio-mcp.json    # LM Studio MCP config
```

---

## 🔄 Update All Tools

```bash
# Update everything
npm update -g @agentmemory/agentmemory mex-cli repomix
pip install --upgrade mempalace hindsight-server basic-memory

# Or use the update script
./scripts/update-all.sh
```

---

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| MCP server not found | Check PATH: `echo $PATH` |
| Permission denied | `chmod +x install.sh` |
| Port conflicts | Change ports in mcp.json |
| Model not loading | Check LM Studio server is running |
| Memory not persisting | Check ChromaDB/SQLite permissions |

---

## 📜 License

MIT - Use however you want. Keep it local. Stay private.

---

## 🤝 Contributing

Found a new tool? Open a PR! Want better docs? Edit away!

---

**Made with 💜 for the local-first AI community.**
