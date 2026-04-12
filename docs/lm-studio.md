# LM Studio

> **Run AI models locally on your own hardware**

---

## What It Does

LM Studio lets you download and run large language models (LLMs) entirely on your own computer. No API keys, no cloud, no data leaving your machine. Full privacy, full control.

**Key Features:**
- Download models from Hugging Face
- Chat interface + local server
- MCP server support (0.3.17+)
- GPU acceleration (CUDA, Metal, Vulkan)
- Works with any OpenAI-compatible client

---

## Installation

### macOS

```bash
# Download from official site
curl -LO https://installers.lmstudio.ai/macos/arm64/0.3.17-2/LM-Studio-0.3.17-2-arm64.dmg
open LM-Studio-0.3.17-2-arm64.dmg
```

Or use Homebrew:
```bash
brew install --cask lm-studio
```

### Windows

Download from: https://lmstudio.ai

### Linux

```bash
# Download AppImage
curl -LO https://installers.lmstudio.ai/linux/x64/0.3.17-2/LM-Studio-0.3.17-2-x64.AppImage
chmod +x LM-Studio-0.3.17-2-x64.AppImage
./LM-Studio-0.3.17-2-x64.AppImage
```

---

## Recommended Models for Coding

| Model | Size | Best For | VRAM Required |
|-------|------|----------|---------------|
| **Qwen 2.5 Coder** | 32B | Code generation, refactoring | 20GB |
| **Llama 3.3** | 70B | General purpose, reasoning | 40GB |
| **gpt-oss** | 20B | Balanced performance | 12GB |
| **Qwen 2.5 Coder** | 14B | Fast coding tasks | 8GB |
| **Llama 3.2** | 3B | Quick tasks, low VRAM | 2GB |

### Download Models

1. Open LM Studio
2. Go to "Discover" tab
3. Search for model name
4. Click Download

---

## Start Local Server

### GUI Method

1. Load a model (click on it)
2. Go to "Server" tab
3. Click "Start Server"
4. Default: `http://localhost:1234`

### CLI Method

```bash
# Start server programmatically
lmstudio server start --model "qwen2.5-coder-32b" --port 1234
```

---

## Connect Your Tools

### Hermes Agent

```bash
# Configure Hermes to use LM Studio
hermes config set provider.custom.base_url http://localhost:1234/v1
hermes config set provider.custom.model qwen2.5-coder-32b

# Test
hermes "Hello from local model!"
```

### Claude Code (with Hermes)

```bash
# Use Hermes as bridge
hermes config set provider.custom.base_url http://localhost:1234/v1
```

### Cursor

Cursor doesn't directly support local models, but you can:
1. Use Continue.dev extension
2. Configure it to use LM Studio endpoint

### Cline

Cline supports local models natively:
1. Settings → API Provider → "Local"
2. Set base URL: `http://localhost:1234/v1`

---

## MCP Configuration

LM Studio 0.3.17+ supports MCP servers!

### Setup

Create `~/.lmstudio/mcp.json`:

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
        "HINDSIGHT_API_LLM_PROVIDER": "custom",
        "HINDSIGHT_API_LLM_BASE_URL": "http://localhost:1234/v1"
      },
      "description": "Knowledge graph with semantic search"
    }
  }
}
```

### Enable in LM Studio

1. Go to "Program" tab
2. Click "Install"
3. Edit `mcp.json`
4. Restart LM Studio

---

## Performance Tips

### GPU Acceleration

**macOS (Metal):**
- Automatically enabled on Apple Silicon

**NVIDIA (CUDA):**
- Install CUDA toolkit
- LM Studio auto-detects

**AMD (Vulkan):**
- Enable in Settings → Hardware

### Context Length

```
# Adjust based on your VRAM
- 4K context: ~2GB VRAM
- 8K context: ~4GB VRAM
- 16K context: ~8GB VRAM
- 32K context: ~16GB VRAM
```

### Speed Expectations

| Hardware | Tokens/sec | Use Case |
|----------|------------|----------|
| M3 Max | 50-80 | Excellent for coding |
| RTX 4090 | 100-150 | Best performance |
| RTX 3090 | 60-100 | Great performance |
| M1 Pro | 20-40 | Good for smaller models |
| CPU only | 5-15 | Slow but works |

---

## Complete Local Stack

```
┌─────────────────────────────────────────────────────────────┐
│                    COMPLETE LOCAL AI STACK                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────┐                                            │
│  │   LM Studio  │───▶ Local inference (Qwen, Llama, etc.)   │
│  │   (Server)   │      http://localhost:1234                │
│  └──────────────┘                                            │
│         │                                                    │
│         ▼                                                    │
│  ┌──────────────┐                                            │
│  │ Hermes Agent │───▶ Agent orchestration                   │
│  └──────────────┘                                            │
│         │                                                    │
│         ▼                                                    │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │              MCP SERVERS (Memory Layer)                  │ │
│  │  ├── agentmemory ──▶ Universal memory                   │ │
│  │  ├── basic-memory ─▶ Human-readable knowledge           │ │
│  │  └── hindsight ────▶ Knowledge graph                    │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Model won't load | Check VRAM - need more GPU memory |
| Slow performance | Enable GPU acceleration in settings |
| Server won't start | Check port 1234 isn't in use |
| MCP not working | Update to LM Studio 0.3.17+ |
| Out of memory | Use smaller model or reduce context |

---

## Resources

- Website: https://lmstudio.ai
- Docs: https://lmstudio.ai/docs
- Models: https://huggingface.co/models
- Discord: https://discord.gg/lmstudio
