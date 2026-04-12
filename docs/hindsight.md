# Hindsight

> Knowledge graph with semantic search that learns from your work. Stores entities, relationships, and context — then retrieves them intelligently.

- **GitHub**: https://github.com/cfortuner/hindsight
- **Category**: Memory Layer

## What It Does

Hindsight builds a knowledge graph from your interactions and work artifacts. Unlike flat memory stores, it understands **relationships** between concepts:

- Entities (people, projects, tools, decisions)
- Relationships ("uses", "depends on", "authored by", "decided in")
- Temporal context (when things happened)

It combines graph traversal with vector search — so you can ask both "what tools does Project X use?" (graph) and "find things related to authentication" (semantic).

## Install

```bash
pip install hindsight-server
```

## MCP Config

Add to `~/.claude/mcp.json`:

```json
{
  "hindsight": {
    "command": "hindsight-server",
    "env": {
      "HINDSIGHT_API_LLM_PROVIDER": "ollama",
      "HINDSIGHT_API_LLM_BASE_URL": "http://localhost:11434"
    },
    "description": "Knowledge graph with semantic search"
  }
}
```

## Provider Configuration

### Fully Local (Ollama)

```bash
export HINDSIGHT_API_LLM_PROVIDER=ollama
export HINDSIGHT_API_LLM_BASE_URL=http://localhost:11434
hindsight-server
```

### Local via LM Studio

```bash
export HINDSIGHT_API_LLM_PROVIDER=custom
export HINDSIGHT_API_LLM_BASE_URL=http://localhost:1234/v1
hindsight-server
```

### Cloud (OpenAI)

```bash
export HINDSIGHT_API_LLM_PROVIDER=openai
export OPENAI_API_KEY=sk-...
hindsight-server
```

## Key Features

| Feature | Details |
|---|---|
| **Storage** | SQLite (local, portable) |
| **Search** | Graph traversal + vector similarity |
| **MCP Tools** | 8 tools exposed |
| **Auto-Capture** | Yes — learns from conversations |
| **Export** | Yes |
| **Works With** | Claude Code, Cursor, Cline, LM Studio |

## vs Other Memory Tools

| Feature | Hindsight | agentmemory | Basic Memory |
|---|---|---|---|
| Storage | SQLite | ChromaDB | Markdown files |
| Knowledge graph | Yes | No | No |
| Relationship tracking | Yes | No | No |
| Semantic search | Yes | Yes | Yes |
| Human-readable | Via queries | No | Yes (Markdown) |
| Best for | Understanding connections | Universal memory | Git-friendly notes |

## Tips

- Start with Ollama for a fully local setup — no API costs
- The knowledge graph gets more useful over time as it accumulates relationships
- Use it alongside agentmemory — Hindsight for "how things connect", agentmemory for "what happened"
