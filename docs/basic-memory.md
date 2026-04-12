# Basic Memory

> **Human-readable knowledge graph from Markdown files**

---

## What It Does

Basic Memory stores everything as plain Markdown files you can read, edit, and version control. No black box - your knowledge is always accessible and portable.

**Key Features:**
- All knowledge in Markdown files
- Works with Obsidian, Notion, any Markdown editor
- Semantic + time-based search
- Import from Claude/ChatGPT history
- MCP server for AI integration

---

## Installation

```bash
# Via uv (fastest)
uvx basic-memory mcp

# Or install via pip
pip install basic-memory

# Or via Homebrew (macOS)
brew install basic-memory
```

---

## MCP Configuration

### Claude Code

Edit `~/.claude/mcp.json`:

```json
{
  "mcpServers": {
    "basic-memory": {
      "command": "uvx",
      "args": ["basic-memory", "mcp"]
    }
  }
}
```

### Cursor

Settings → MCP → Add Server:
- **Name:** basic-memory
- **Command:** `uvx basic-memory mcp`
- **Type:** Command

---

## Usage

### Initialize

```bash
# Initialize in your home directory
basic-memory init

# Or in a specific directory
basic-memory init --path ~/my-knowledge-base
```

### Store Knowledge

```bash
# Create a new note
basic-memory create "Project Decisions" --content "We chose React over Vue..."

# Or use the AI to create from conversation
"Save this decision to Basic Memory"
```

### Search

```bash
# Semantic search
basic-memory search "authentication patterns"

# Time-based search
basic-memory search --since "2024-01-01" --until "2024-06-01"

# Tag search
basic-memory search --tag "architecture"
```

### Import from Claude/ChatGPT

```bash
# Import Claude conversations
basic-memory import claude ~/Downloads/conversations.json

# Import ChatGPT conversations
basic-memory import chatgpt ~/Downloads/chatgpt_export.json
```

---

## File Structure

```
~/basic-memory/
├── README.md              # Overview
├── index.md               # Auto-generated index
├── projects/
│   ├── my-app/
│   │   ├── decisions.md
│   │   ├── patterns.md
│   │   └── lessons.md
│   └── another-project/
├── patterns/
│   ├── react-patterns.md
│   └── api-design.md
├── decisions/
│   └── 2024-01-15-auth-choice.md
└── .basic-memory/
    └── index.json         # Search index
```

---

## MCP Tools

| Tool | Description |
|------|-------------|
| `memory_create` | Create a new memory |
| `memory_read` | Read a memory by ID/path |
| `memory_update` | Update an existing memory |
| `memory_search` | Search memories (semantic + time) |
| `memory_list` | List all memories |
| `memory_delete` | Delete a memory |
| `memory_tag` | Tag a memory |
| `memory_import` | Import from external source |
| `memory_export` | Export to file |
| `knowledge_graph` | Get knowledge graph view |
| `obsidian_sync` | Sync with Obsidian vault |
| `index_rebuild` | Rebuild search index |

---

## Obsidian Integration

```bash
# Set your Obsidian vault path
export BASIC_MEMORY_OBSIDIAN_VAULT="~/Obsidian Vault"

# Sync both ways
basic-memory sync obsidian
```

Your Basic Memory becomes an Obsidian vault you can browse, edit, and link.

---

## Best Practices

1. **Use consistent tags** - Makes searching easier
2. **Link related notes** - Build a knowledge graph
3. **Review weekly** - Keep it organized
4. **Version control** - `git init` in your memory folder
5. **Backup** - It's just Markdown files

---

## Comparison with Other Tools

| Feature | Basic Memory | agentmemory | MemPalace |
|---------|--------------|-------------|-----------|
| Storage | Markdown files | ChromaDB | ChromaDB |
| Human-readable | ✅ Yes | ❌ No | ❌ No |
| Edit by hand | ✅ Yes | ❌ No | ❌ No |
| AI search | ✅ Yes | ✅ Yes | ✅ Yes |
| Version control | ✅ Git | ⚠️ Export | ⚠️ Export |
| Obsidian sync | ✅ Native | ❌ No | ❌ No |

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| MCP not starting | Check uvx is installed: `which uvx` |
| Search not working | Rebuild index: `basic-memory index rebuild` |
| Import fails | Check JSON format matches expected schema |
| Sync issues | Check Obsidian vault path is correct |

---

## Resources

- GitHub: https://github.com/basic-memory/basic-memory
- Docs: https://docs.basic-memory.dev
- PyPI: https://pypi.org/project/basic-memory/
