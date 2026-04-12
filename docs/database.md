# Database MCP Servers

> Two database MCP servers: SQLite for local databases and Postgres for production access.

## 1. SQLite MCP

Full read/write access to SQLite databases. Great for local development and prototyping.

- **Source**: https://github.com/modelcontextprotocol/servers
- **Install**: `uvx mcp-server-sqlite --db-path ./data.db`

### MCP Config

```json
{
  "sqlite": {
    "command": "uvx",
    "args": ["mcp-server-sqlite", "--db-path", "./data.db"]
  }
}
```

### What It Does

- Full CRUD operations (SELECT, INSERT, UPDATE, DELETE)
- Schema inspection (list tables, describe columns)
- Query validation before execution
- Create new databases on the fly

### Usage Tips

- Change `./data.db` to point at your actual SQLite database
- AI can create tables, insert data, and query results
- Great for building quick prototypes with AI assistance

---

## 2. Postgres MCP

Read-only access to PostgreSQL databases with schema introspection. Safe for production.

- **Source**: https://github.com/modelcontextprotocol/servers
- **Install**: `npx -y @modelcontextprotocol/server-postgres "postgresql://user:pass@host/db"`

### MCP Config

```json
{
  "postgres": {
    "command": "npx",
    "args": [
      "-y",
      "@modelcontextprotocol/server-postgres",
      "postgresql://user:pass@localhost:5432/mydb"
    ]
  }
}
```

### What It Does

- Read-only queries (SELECT only — safe for production)
- Full schema introspection (tables, columns, types, constraints)
- Connection string supports SSL and all Postgres options

### Security Note

This server is **read-only by default**. It cannot modify data. Safe to point at staging or even production databases for exploration.

---

## Comparison

| Feature | SQLite MCP | Postgres MCP |
|---------|-----------|--------------|
| Read Access | Yes | Yes |
| Write Access | Yes | No (read-only) |
| Schema Inspection | Yes | Yes |
| Best For | Local dev, prototyping | Production exploration |
| Connection | File path | Connection string |
