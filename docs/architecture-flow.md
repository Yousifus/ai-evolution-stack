# Architecture Flow

> How all layers in the AI Evolution Stack talk to each other.

## Layer Interconnection Map

```mermaid
graph TD
    subgraph USER["You (Developer)"]
        IDE["Cursor / Claude Code / Cline"]
    end

    subgraph INFERENCE["Local Inference"]
        OL["Ollama"]
        LMS["LM Studio"]
        LAI["LocalAI"]
    end

    subgraph MEM["Memory Layer"]
        direction TB
        AM["agentmemory<br/><small>universal, 43 tools</small>"]
        BM["Basic Memory<br/><small>Markdown files</small>"]
        MP["MemPalace<br/><small>conversations</small>"]
        HS["Hindsight<br/><small>knowledge graph</small>"]
        M0["Mem0<br/><small>auto-consolidation</small>"]
        LT["Letta<br/><small>self-editable</small>"]
        GR["Graphiti<br/><small>temporal KG</small>"]
        CG["Cognee<br/><small>auto-prune</small>"]
        LM["LangMem<br/><small>procedural</small>"]
        MO["MemOS<br/><small>shared pool</small>"]
    end

    subgraph CTX["Context Layer"]
        RP["Repomix<br/><small>codebase packaging</small>"]
        MX["mex<br/><small>living docs</small>"]
        RG["mcp-ragex<br/><small>hybrid search</small>"]
        C7["Context7<br/><small>library docs</small>"]
    end

    subgraph CAPS["Capabilities"]
        direction TB

        subgraph WEB["Web & Browser"]
            FT["Fetch MCP"]
            PW["Playwright"]
            BS["Brave Search"]
            BU["Browser Use"]
        end

        subgraph SYS["System Access"]
            FS["Filesystem MCP"]
            DC["Desktop Commander"]
            SH["mcp-shell-server"]
            SQ["SQLite MCP"]
            PG["Postgres MCP"]
            GI["Git MCP"]
            GH["GitHub MCP"]
        end

        subgraph MEDIA["Media & Execution"]
            SS["Screenshot MCP"]
            VIS["mcp-vision"]
            PC["Pipecat<br/><small>voice</small>"]
            E2["E2B<br/><small>sandbox</small>"]
            OI["Open Interpreter"]
        end
    end

    subgraph AGENTS["Agent Layer"]
        direction TB

        subgraph FW["Frameworks"]
            HA["Hermes Agent"]
            CR["crewAI"]
            SM["smolagents"]
            AG["Agno"]
        end

        subgraph HERMES["Hermes Ecosystem"]
            SE["self-evolution"]
            HC["hermes-CCC"]
            HW["hermes-workspace"]
            SF["skill-factory"]
            RL["ralph-loop"]
        end

        subgraph ORCH["Orchestration"]
            LG["LangGraph"]
            A2["A2A Protocol"]
            TM["Temporal"]
        end

        subgraph SKILLS["Pre-built Skills"]
            CO["Composio<br/><small>250+ SaaS tools</small>"]
            LC["LangChain Tools<br/><small>100+ tools</small>"]
        end
    end

    subgraph QUALITY["Quality & Safety"]
        direction TB

        subgraph EVAL["Evaluation"]
            DE["DeepEval"]
            AB["AgentBench"]
            IA["Inspect AI"]
        end

        subgraph OBS["Observability"]
            AO["AgentOps"]
            AP["Arize Phoenix"]
            LF["Langfuse"]
            LS["LangSmith"]
        end

        subgraph GUARD["Guardrails"]
            NM["NeMo Guardrails"]
            LW["LlamaFirewall"]
            IV["Invariant"]
        end
    end

    subgraph INTEG["Integrations"]
        NO["Notion MCP"]
        JI["Jira MCP"]
        SV["secrets-vault"]
        VA["Vault MCP"]
        HO["homunculus"]
    end

    %% Primary flows
    IDE -->|"prompts"| AGENTS
    INFERENCE -->|"LLM calls"| AGENTS
    INFERENCE -->|"embeddings"| MEM

    AGENTS -->|"read/write"| MEM
    AGENTS -->|"search"| CTX
    AGENTS -->|"use tools"| CAPS
    AGENTS -->|"external"| INTEG

    %% Quality feedback loops
    AGENTS -->|"traces"| OBS
    AGENTS -->|"test"| EVAL
    GUARD -->|"enforce"| AGENTS

    %% Cross-layer flows
    MEM -.->|"shared memory pool"| ORCH
    EVAL -.->|"results feed back"| MEM
    HO -.->|"pattern learning"| MEM
    SE -.->|"skill improvement"| HA
    RL -.->|"iterative loops"| IDE

    %% Secrets flow
    SV -.->|"inject secrets"| WEB
    SV -.->|"inject secrets"| SYS
```

## Data Flow Summary

### How a typical agent request flows:

```mermaid
sequenceDiagram
    participant U as You (IDE)
    participant A as Agent (Hermes/crewAI)
    participant M as Memory Layer
    participant C as Context Layer
    participant T as Tools (MCP)
    participant Q as Quality Layer
    participant I as Inference (Ollama)

    U->>A: "Research KSA fintech trends"
    A->>M: Check existing memory
    M-->>A: Previous findings, entities
    A->>C: Search codebase context
    C-->>A: Relevant files, docs
    A->>I: Generate plan (LLM call)
    I-->>A: Structured plan
    A->>T: Brave Search: "KSA fintech 2026"
    T-->>A: Search results
    A->>T: Fetch top URLs
    T-->>A: Markdown content
    A->>M: Store new findings
    A->>Q: Log trace (AgentOps)
    A->>U: Report with citations
    Q->>M: Eval results → memory
```

### How memory layers interact:

```mermaid
flowchart LR
    subgraph SHORT["Short-Term"]
        S1["Active conversation"]
        S2["Current tool calls"]
    end

    subgraph MID["Mid-Term"]
        M1["agentmemory<br/><small>session memory</small>"]
        M2["Basic Memory<br/><small>Markdown notes</small>"]
    end

    subgraph LONG["Long-Term"]
        L1["Mem0<br/><small>consolidated facts</small>"]
        L2["Graphiti<br/><small>temporal KG</small>"]
        L3["Hindsight<br/><small>knowledge graph</small>"]
    end

    subgraph META["Meta-Memory"]
        X1["LangMem<br/><small>procedural: how to act</small>"]
        X2["Cognee<br/><small>auto-prune stale</small>"]
        X3["Letta<br/><small>self-editable blocks</small>"]
    end

    SHORT -->|"extract"| MID
    MID -->|"consolidate"| LONG
    LONG -->|"reflect"| META
    META -.->|"update behavior"| SHORT
```

### How Hermes self-improvement works:

```mermaid
flowchart TD
    A["Hermes receives task"] --> B["Execute with tools"]
    B --> C{"5+ tool calls?"}
    C -->|"No"| D["Return result"]
    C -->|"Yes"| E["Auto-create skill"]
    E --> F["Store in skill library"]
    F --> G["self-evolution optimizes"]
    G --> H["Improved skill version"]
    H --> I["Next similar task uses skill"]
    I --> B

    D --> J["DeepEval tests quality"]
    J -->|"Pass"| K["AgentOps logs success"]
    J -->|"Fail"| L["Feedback → LangMem"]
    L -->|"Update system prompt"| A
```

## Layer Responsibilities

| Layer | Role | Reads From | Writes To |
|-------|------|-----------|-----------|
| **Infrastructure** | Run LLMs locally | -- | Embeddings, completions |
| **Memory** | Remember across sessions | All layers | Retrieval results |
| **Context** | Understand current codebase | File system | Packaged context |
| **Capabilities** | Interact with the world | Web, DBs, files, APIs | Action results |
| **Agent** | Reason, plan, execute | Memory + Context + Capabilities | Actions, memory updates |
| **Quality** | Test, monitor, constrain | Agent traces | Eval results, alerts |
| **Integrations** | Connect to external tools | Agent requests | External system updates |
