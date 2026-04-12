# Self-Improvement (Karpathy-Inspired)

> Tools and patterns for agents that improve themselves — the holy grail of AI agent development.

## The Core Pattern

Andrej Karpathy's **autoresearch** demonstrates the canonical self-improving agent loop:

```
Define metric → Modify code → Run experiment → Evaluate → Loop
```

Applied to an AI agent's own tools, skills, and MCP servers:

```
Define quality metric → Modify agent config/skills → Run task → Evaluate output → Loop
```

## Tools

### autoresearch

- **GitHub**: https://github.com/karpathy/autoresearch
- **What it does**: Autonomously modifies a training script, runs 5-minute experiments, evaluates validation loss, and iterates — ~12 experiments/hour without human supervision.
- **Install**: `git clone` + `uv sync`
- **Requires**: Python 3.10+, `uv`, PyTorch, single NVIDIA GPU

**Adaptation for agent self-improvement**: Instead of optimizing `train.py` against validation loss, optimize:
- Agent system prompts against DeepEval test cases
- MCP server configs against latency/accuracy metrics
- Skill definitions against task completion rates
- Memory consolidation strategies against retrieval accuracy

### llm-council

- **GitHub**: https://github.com/karpathy/llm-council
- **Stars**: 16,900+
- **What it does**: Routes a query to multiple LLMs simultaneously, they anonymously peer-review each other, then a chairman synthesizes the best answer.
- **Install**: `git clone` + `uv sync` + `cd frontend && npm install`
- **Requires**: OpenRouter API key

**Adaptation for agent self-improvement**: Use the council pattern for:
- Multiple models evaluate an agent's output quality
- Peer-review of generated skills before they enter the skill library
- Multi-perspective analysis of pipeline outputs (instead of single-model evaluation)

### Karpathy's LLM Wiki Pattern

From [this gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) — a design pattern, not runnable code.

**The idea**: Replace RAG with an LLM-maintained wiki. Three operations:

| Operation | What It Does | Self-Improvement Use |
|-----------|-------------|---------------------|
| **Ingest** | LLM summarizes new sources into structured wiki pages | Agent ingests its own experiment results, pipeline outputs |
| **Query** | Answer questions from compiled wiki with citations | Agent queries its own knowledge base for past learnings |
| **Lint** | Detect contradictions, staleness, gaps | Agent self-reflects: "what do I believe that's wrong?" |

**Implementation: Graphify** (the pattern as working code)

Karpathy ended his gist with "I think there is room here for an incredible new product instead of a hacky collection of scripts." [Graphify](https://github.com/safishamsi/graphify) is that product:

```bash
pip install graphifyy && graphify install
/graphify ./raw
```

- **71.5x fewer tokens per query** vs reading raw files (tested on Karpathy's own repos)
- AST extraction for 20 languages (deterministic, no LLM calls)
- Reads PDFs, images, video, audio via Claude subagents + local Whisper
- Edges tagged EXTRACTED (from source), INFERRED (model-reasoned), or AMBIGUOUS
- Persistent across sessions — `--update` merges new content
- Native Claude Code skill — call `/graphify` from anywhere

**Alternative implementations** (more DIY):
- **Basic Memory** for the wiki (Markdown files, git-friendly)
- **Cognee** for the Lint step (auto-prunes stale nodes)
- **LangMem** for procedural updates (agent rewrites its own prompts)
- **Obsidian MCP** for visualization (browse the wiki in Obsidian)

### hermes-agent-self-evolution

- **GitHub**: https://github.com/NousResearch/hermes-agent-self-evolution
- **What it does**: Uses DSPy + GEPA (Genetic-Pareto Prompt Evolution) to auto-optimize Hermes skills, tool descriptions, and system prompts.
- **Cost**: ~$2-10 per optimization run (API calls, no GPU needed)

### ralph-loop

- **Type**: Claude Code plugin
- **What it does**: Feeds the same prompt to Claude repeatedly, letting it see its own previous edits each cycle. Iterative self-improvement through reflection.
- **Best for**: Well-defined tasks with measurable quality criteria.

## The Self-Improvement Stack

Combining these tools creates a full self-improvement pipeline:

```
1. DeepEval defines quality metrics for agent outputs
2. autoresearch pattern iterates on agent configs
3. hermes-self-evolution optimizes prompts via genetic search
4. llm-council provides multi-model quality judgment
5. LLM Wiki pattern maintains evolving knowledge base
6. ralph-loop handles iterative refinement of specific tasks
7. LangMem updates agent system prompts from feedback
8. AgentOps tracks what improved and what regressed
```

## Getting Started

```bash
# Install the self-improvement tools
./install.sh --selfimprove

# Clone autoresearch
git clone https://github.com/karpathy/autoresearch.git
cd autoresearch && uv sync

# Clone llm-council
git clone https://github.com/karpathy/llm-council.git
cd llm-council && uv sync && cd frontend && npm install
```
