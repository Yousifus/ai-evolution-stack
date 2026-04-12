# mcp-ragex

> Hybrid code search MCP server combining three search modes: RAG (vector), AST (tree-sitter), and regex (ripgrep) — all in one tool.

- **GitHub**: https://github.com/jbenshetler/mcp-ragex
- **Category**: Code Search & Navigation

## What It Does

mcp-ragex gives AI assistants deep code search capabilities across three complementary modes:

- **RAG (vector) search**: Semantic search using local embeddings — find code by meaning, not just keywords
- **AST (tree-sitter) search**: Structural search using abstract syntax trees — find functions, classes, imports by their role in the code
- **Regex (ripgrep) search**: Fast pattern matching — find exact strings, patterns, symbols

All three modes work together. Ask "find authentication middleware" and it searches semantically, structurally, and literally.

## Install

```bash
pip install mcp-ragex
```

## MCP Config

Add to `~/.claude/mcp.json`:

```json
{
  "mcp-ragex": {
    "command": "python",
    "args": ["-m", "mcp_ragex"],
    "description": "Hybrid code search: RAG + AST + regex"
  }
}
```

## Key Features

- **Local embeddings** — no API key needed, everything runs on your machine
- **Multi-language** — tree-sitter parsers for Python, JavaScript, TypeScript, Go, Rust, Java, and more
- **Fast** — ripgrep backend for regex mode, no cold start
- **MCP native** — designed specifically for Claude Code and AI coding assistants

## When to Use

| Search Mode | Best For | Example |
|---|---|---|
| RAG (semantic) | "Find code that handles user auth" | Meaning-based discovery |
| AST (structural) | "Find all async functions in src/" | Language-aware search |
| Regex (literal) | "Find all TODO comments" | Exact pattern matching |

## vs Other Code Search

| Feature | mcp-ragex | Repomix | Built-in Grep |
|---|---|---|---|
| Semantic search | Yes | No | No |
| AST-aware | Yes | No | No |
| Regex | Yes | No | Yes |
| Token reduction | High | ~80% | None |
| MCP server | Yes | Yes | No |
