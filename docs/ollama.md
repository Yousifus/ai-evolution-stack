# Ollama

> The most popular local model runner. 166k GitHub stars. Run Llama, Qwen, DeepSeek, Gemma, and more — entirely on your machine.

- **GitHub**: https://github.com/ollama/ollama
- **Stars**: 166,000+
- **Category**: Local Inference

## What It Does

Ollama makes running LLMs locally as easy as `ollama run llama3.3`. It:
- Downloads and manages model weights automatically
- Runs a local REST API compatible with OpenAI's format
- Works with every MCP-based tool that supports custom endpoints
- Handles GPU/CPU inference, quantization, and model management

## Install

### macOS / Linux

```bash
curl -fsSL https://ollama.ai/install.sh | sh
```

### Windows

Download from https://ollama.com/download

### Docker

```bash
docker run -d --gpus=all -p 11434:11434 ollama/ollama
```

## Recommended Models

### For Coding

```bash
ollama pull qwen2.5-coder:7b     # Good balance (4GB VRAM)
ollama pull qwen2.5-coder:32b    # Best coding model (20GB VRAM)
ollama pull deepseek-coder-v2     # Alternative coding model
```

### For General Use

```bash
ollama pull llama3.3:70b          # Best general model (requires 40GB+ VRAM)
ollama pull llama3.3:8b           # Lighter general model
ollama pull gemma2:27b            # Google's model
```

### For Embeddings (used by memory tools)

```bash
ollama pull nomic-embed-text      # Text embeddings
```

### For Vision

```bash
ollama pull llava                 # Vision model (used by mcp-vision)
ollama pull llava:34b             # Larger vision model
```

## Usage

```bash
# Chat with a model
ollama run qwen2.5-coder:7b

# Start the server (runs on http://localhost:11434)
ollama serve

# List downloaded models
ollama list

# Pull a specific model
ollama pull modelname

# Remove a model
ollama rm modelname
```

## Connect to Other Tools

### Hindsight (Knowledge Graph)

```bash
export HINDSIGHT_API_LLM_PROVIDER=ollama
export HINDSIGHT_API_LLM_BASE_URL=http://localhost:11434
```

### Hermes Agent

```bash
hermes config set provider ollama
hermes config set provider.ollama.base_url http://localhost:11434
```

### Any OpenAI-compatible tool

Ollama's API is compatible with OpenAI's format:
- Base URL: `http://localhost:11434/v1`
- No API key required (leave blank or use "ollama")

## Hardware Requirements

| Model Size | RAM Needed | GPU VRAM | Example Models |
|------------|-----------|----------|----------------|
| 7B params  | 8GB       | 4-6GB   | qwen2.5-coder:7b, llama3.3:8b |
| 13B params | 16GB      | 8-10GB  | codellama:13b |
| 32B params | 32GB      | 20GB+   | qwen2.5-coder:32b |
| 70B params | 64GB      | 40GB+   | llama3.3:70b |

Ollama automatically uses GPU if available (NVIDIA CUDA, Apple Metal, AMD ROCm). Falls back to CPU if not.

## vs LM Studio

| Feature | Ollama | LM Studio |
|---------|--------|-----------|
| Interface | CLI + REST API | GUI + REST API |
| Model Management | `ollama pull/rm` | Visual download manager |
| Server | Built-in (`ollama serve`) | Start from GUI |
| Best For | Automation, scripting, CI | Visual exploration, beginners |
| OS Support | macOS, Linux, Windows | macOS, Linux, Windows |
