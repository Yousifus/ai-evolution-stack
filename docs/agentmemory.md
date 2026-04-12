# agentmemory

> **Universal memory layer for ALL your AI coding agents**

---

## What It Does

agentmemory provides persistent, context-aware memory that works across Claude Code, Cursor, Cline, Gemini CLI, Codex, and any other AI tool. It remembers what you've done, what you've learned, and what you need to know.

**Key Stats:**
- 95.2% retrieval accuracy on LongMemEval
- 92% token reduction vs full context
- 43 MCP tools available
- 12 auto-capture hooks

---

## Installation

```bash
# Global install
npm install -g @agentmemory/agentmemory

# Or run without installing
npx -y @agentmemory/agentmemory
```

---

## MCP Configuration

### Claude Code

Edit `~/.claude/mcp.json`:

```json
{
  "mcpServers": {
    "agentmemory": {
      "command": "npx",
      "args": ["-y", "@agentmemory/agentmemory"]
    }
  }
}
```

### Cursor

Settings → MCP → Add Server:
- **Name:** agentmemory
- **Command:** `npx -y @agentmemory/agentmemory`
- **Type:** Command

### LM Studio

Edit `~/.lmstudio/mcp.json`:

```json
{
  "mcpServers": {
    "agentmemory": {
      "command": "npx",
      "args": ["-y", "@agentmemory/agentmemory"]
    }
  }
}
```

---

## Usage

### In Claude Code / Cursor

```
# Store something important
"Remember that I prefer functional programming patterns over OOP"

# Recall later
"What patterns do I prefer?"

# Search memory
"Find all decisions about authentication"

# Get context for current task
"Load relevant context for this React component"
```

### Available MCP Tools

| Tool | Description |
|------|-------------|
| `memory_store` | Store a new memory |
| `memory_search` | Search existing memories |
| `memory_recall` | Recall memories by context |
| `memory_update` | Update an existing memory |
| `memory_delete` | Delete a memory |
| `memory_list` | List all memories |
| `memory_export` | Export memories to file |
| `memory_import` | Import memories from file |
| `context_get` | Get context for current task |
| `context_set` | Set context for current task |
| `session_start` | Start a new session |
| `session_end` | End current session |

---

## How It Works

```
┌─────────────────────────────────────────────────────────────┐
│                    AGENTMEMORY ARCHITECTURE                  │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐  │
│  │   AI Agent   │───▶│  MCP Server  │───▶│   ChromaDB   │  │
│  │ (Any tool)   │◀───│  (43 tools)  │◀───│  (Vector DB) │  │
│  └──────────────┘    └──────────────┘    └──────────────┘  │
│                                                              │
│  Auto-capture hooks:                                         │
│  - File changes                                              │
│  - Commands executed                                         │
│  - Decisions made                                            │
│  - Errors encountered                                        │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Configuration

### Environment Variables

```bash
# Storage location
export AGENTMEMORY_DB_PATH="~/.agentmemory/db"

# Embedding model (local by default)
export AGENTMEMORY_EMBEDDING_MODEL="all-MiniLM-L6-v2"

# Max memories to retrieve
export AGENTMEMORY_MAX_RESULTS=10

# Enable auto-capture
export AGENTMEMORY_AUTO_CAPTURE=true
```

---

## Best Practices

1. **Let it capture automatically** - The hooks work great
2. **Review weekly** - Export and review your memories
3. **Tag important items** - Use consistent tags
4. **Share across projects** - Memory is cross-project by default
5. **Backup regularly** - The DB is just files

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| MCP not found | Check PATH: `which agentmemory` |
| Slow searches | Reduce max results or use time filters |
| Memory not persisting | Check write permissions on DB path |
| Duplicate memories | Use `memory_update` instead of `memory_store` |

---

## Integration with Other Tools

### With mex
```
agentmemory stores patterns → mex documents them in .mex/
```

### With homunculus
```
agentmemory provides context → homunculus learns your style
```

### With Repomix
```
Repomix packages code → agentmemory stores insights
```

---

## Resources

- GitHub: https://github.com/agentmemory/agentmemory
- NPM: https://www.npmjs.com/package/@agentmemory/agentmemory
- Docs: https://docs.agentmemory.dev
