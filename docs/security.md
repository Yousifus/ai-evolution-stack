# Security & Secrets MCP Servers

> Two options for managing secrets: enterprise-grade HashiCorp Vault and a lightweight local mini-vault.

## 1. mcp-secrets-vault (Local)

Lightweight local secrets manager. AI can call external APIs without ever seeing your actual keys.

- **GitHub**: https://github.com/RachidChabane/mcp-secrets-vault
- **Install**: `pip install mcp-secrets-vault`

### MCP Config

```json
{
  "secrets-vault": {
    "command": "python",
    "args": ["-m", "mcp_secrets_vault"]
  }
}
```

### How It Works

1. You store secrets mapped to secret IDs (e.g., `openai_key` -> `sk-abc123...`)
2. AI references secrets by ID, never sees the actual value
3. When AI makes an API call, the vault injects the real secret at runtime
4. Full JSONL audit trail of all secret access

### Best For

Individual developers and small teams. Quick setup, no infrastructure needed.

---

## 2. HashiCorp Vault MCP (Enterprise)

Official HashiCorp Vault integration for enterprise secret management.

- **GitHub**: https://github.com/hashicorp/vault-mcp-server
- **Requires**: Running Vault instance

### Setup

Requires a running HashiCorp Vault server. See https://developer.hashicorp.com/vault for installation.

### What It Does

- Full secret lifecycle management (create, read, update, delete)
- Policy-based access control
- Secret rotation and versioning
- Audit logging
- Supports stdio and StreamableHTTP transports

### Best For

Production environments, teams, and organizations with existing Vault infrastructure.

---

## Comparison

| Feature | mcp-secrets-vault | Vault MCP |
|---------|-------------------|-----------|
| Setup | `pip install` | Vault server required |
| Scope | Local, single user | Enterprise, multi-user |
| Access Control | File-based | Policy-based |
| Audit Trail | JSONL file | Enterprise audit backend |
| Secret Rotation | Manual | Automatic |
| Best For | Dev workflows | Production environments |

## General Security Tips

- Never commit API keys to git — use `.gitignore` for `.env` files
- Use the secrets vault instead of environment variables when possible
- Rotate keys regularly, especially if they were ever exposed
- The `mcp-shell-server` has a whitelist to prevent dangerous commands
