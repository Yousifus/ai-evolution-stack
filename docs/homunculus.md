# homunculus

> **AI that learns YOUR patterns and evolves with you**

---

## What It Does

homunculus is a Claude Code plugin that observes how you work, learns your patterns, and evolves from simple instincts into full skills, commands, and even specialist agents. It becomes an AI that knows how YOU code.

**Key Features:**
- Learns from your actual work (not generic patterns)
- 100% reliable observation via hooks
- Evolution path: Instincts → Skills → Commands → Agents
- Export/import learned patterns
- Background observer (no slowdown)

---

## Installation

```bash
# Clone the repository
git clone https://github.com/humanplane/homunculus.git ~/.homunculus

# Install
cd ~/.homunculus
pip install -e .

# Verify installation
homunculus --version
```

---

## Quick Start

```bash
# Navigate to your project
cd ~/my-project

# Initialize homunculus
homunculus init

# This creates:
# .claude/
# └── homunculus/
#     ├── config.json          # Configuration
#     ├── instincts/           # Learned instincts
#     ├── skills/              # Evolved skills
#     ├── commands/            # Custom commands
#     └── agents/              # Specialist agents
```

---

## How It Works

```
┌─────────────────────────────────────────────────────────────┐
│                    HOMUNCULUS EVOLUTION                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Session Start                                               │
│       │                                                      │
│       ▼                                                      │
│  ┌──────────────┐                                            │
│  │   Observer   │───▶ Analyzes your work                    │
│  │   (Haiku)    │      - Code patterns                       │
│  └──────────────┘      - File structures                     │
│       │                - Naming conventions                  │
│       │                - Error handling                      │
│       ▼                                                      │
│  Creates Instincts (atomic learned behaviors)                │
│       │                                                      │
│       ▼                                                      │
│  ┌──────────────┐                                            │
│  │  Evolution   │───▶ Clusters instincts by domain          │
│  │   Engine     │      Evolves into:                         │
│  └──────────────┘      - Skills (reusable patterns)          │
│       │                - Commands (custom actions)           │
│       ▼                - Agents (specialist assistants)      │
│  Next Session ──▶ Loaded automatically                       │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Commands

In Claude Code, use these commands:

| Command | Description |
|---------|-------------|
| `/homunculus:init` | Initialize observer for this project |
| `/homunculus:status` | Check evolution progress |
| `/homunculus:evolve` | Trigger manual evolution |
| `/homunculus:export` | Export your instincts to file |
| `/homunculus:import` | Import someone else's instincts |

---

## Instincts

Instincts are the atomic unit of learning. Each has:
- **Pattern**: What was learned (e.g., "prefer functional components")
- **Confidence**: How sure the AI is (0-1)
- **Domain**: Where it applies (e.g., "react", "api", "testing")
- **Examples**: Supporting evidence

Example instinct:
```json
{
  "id": "inst-001",
  "pattern": "Prefer functional components over class components",
  "confidence": 0.92,
  "domain": "react",
  "examples": [
    "src/components/Button.tsx uses function",
    "src/components/Card.tsx uses function",
    "No class components found in src/components/"
  ],
  "created_at": "2024-01-15T10:30:00Z"
}
```

---

## Evolution Path

```
Instincts (100s)
    │
    ▼ Cluster by domain
Skills (10s)
    │
    ▼ Combine related skills
Commands (custom actions)
    │
    ▼ Specialize for tasks
Agents (specialist AIs)
```

### Example Evolution

```
Instinct: "Use async/await for API calls"
Instinct: "Always handle errors in try/catch"
Instinct: "Prefer axios over fetch"
    │
    ▼
Skill: "API Integration Pattern"
    │
    ▼
Command: `/api-call <endpoint>`
    │
    ▼
Agent: "API Specialist" (handles all API-related tasks)
```

---

## Export/Import

### Export Your Learned Patterns

```bash
# Export all instincts
/homunculus:export --all --output my-instincts.json

# Export by domain
/homunculus:export --domain react --output react-patterns.json
```

### Import Someone Else's Patterns

```bash
# Import community patterns
/homunculus:import --url https://example.com/patterns.json

# Import from file
/homunculus:import --file ./team-patterns.json
```

---

## Configuration

Edit `.claude/homunculus/config.json`:

```json
{
  "observer": {
    "enabled": true,
    "model": "claude-3-haiku-20240307",
    "interval_seconds": 300
  },
  "evolution": {
    "auto_evolve": true,
    "min_confidence": 0.7,
    "min_examples": 3
  },
  "domains": [
    "react",
    "api",
    "testing",
    "database",
    "deployment"
  ],
  "export": {
    "include_examples": true,
    "anonymize": false
  }
}
```

---

## Best Practices

1. **Let it observe** - Don't disable the observer
2. **Review weekly** - Check `/homunculus:status`
3. **Export regularly** - Backup your learned patterns
4. **Share with team** - Import team patterns
5. **Evolve manually** - Trigger `/homunculus:evolve` after big changes

---

## Comparison with Other Tools

| Feature | homunculus | agentmemory | Basic Memory |
|---------|------------|-------------|--------------|
| Learns YOUR style | ✅ Yes | ⚠️ Partial | ❌ No |
| Pattern evolution | ✅ Yes | ❌ No | ❌ No |
| Export/Import | ✅ Yes | ✅ Yes | ✅ Yes |
| Works with Cursor | ❌ No | ✅ Yes | ✅ Yes |
| Background observer | ✅ Yes | ✅ Yes | ✅ Yes |

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Observer not starting | Check config.json is valid |
| No instincts learned | Work on more code - needs examples |
| Evolution stuck | Lower min_confidence in config |
| Import fails | Check JSON format matches schema |
| Slow performance | Switch observer model to faster one |

---

## Resources

- GitHub: https://github.com/humanplane/homunculus
- Docs: https://docs.homunculus.dev
- Community Patterns: https://patterns.homunculus.dev
