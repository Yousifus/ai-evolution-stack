# Git & GitHub MCP Servers

> Local git operations and GitHub API access as MCP servers.

## 1. Git MCP (Local)

Local repository operations: commit history, diffs, branches, blame. Read-only by default.

- **Source**: https://github.com/modelcontextprotocol/servers
- **Install**: `uvx mcp-server-git`

### MCP Config

```json
{
  "git": {
    "command": "uvx",
    "args": ["mcp-server-git"]
  }
}
```

### What It Does

- Browse commit history and messages
- View diffs between commits/branches
- List and inspect branches
- Git blame for line-by-line authorship
- Read-only — safe for any repository

### Best For

Exploring git history, understanding who changed what and when, reviewing diffs.

---

## 2. GitHub MCP (Official)

Official GitHub MCP server for managing repositories, PRs, issues, and code search.

- **GitHub**: https://github.com/github/github-mcp-server
- **Requires**: GitHub Personal Access Token (PAT)

### Setup

```bash
# Generate a PAT at https://github.com/settings/tokens
# Required scopes: repo, read:org, read:user

# Add to Claude Code
claude mcp add github \
  --transport http \
  --url https://api.githubcopilot.com/mcp/ \
  --header "Authorization: Bearer YOUR_GITHUB_PAT"
```

### What It Does

- Create, update, and merge Pull Requests
- Create and manage Issues
- Search code across repositories
- Trigger and monitor GitHub Actions workflows
- Manage repository settings and collaborators

### Best For

Full GitHub workflow automation — create PRs, review issues, search code, manage repos.

---

## Comparison

| Feature | Git MCP | GitHub MCP |
|---------|---------|------------|
| Scope | Local repo only | GitHub API (cloud) |
| Commit History | Yes | Yes |
| Diffs | Yes | Yes |
| Pull Requests | No | Yes |
| Issues | No | Yes |
| Code Search | No | Yes (cross-repo) |
| API Key | No | Yes (PAT) |
| Write Operations | No | Yes |
