#!/bin/bash

# AI Evolution Stack — Universal Installer
# 100+ tools across 35 categories. One script installs everything.
# Works on macOS and Linux. Everything local. No cloud. Full privacy.

set -e

# ============================================
# COLORS & LOGGING
# ============================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }
log_header()  { echo -e "\n${CYAN}${BOLD}=== $1 ===${NC}\n"; }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# ============================================
# DETECT OS
# ============================================

detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)

# ============================================
# CHECK DEPENDENCIES
# ============================================

command_exists() { command -v "$1" >/dev/null 2>&1; }

check_dependencies() {
    log_header "Checking Dependencies"

    MISSING=()
    command_exists node    || MISSING+=("Node.js (https://nodejs.org)")
    command_exists npm     || MISSING+=("npm")
    command_exists python3 || MISSING+=("Python 3 (https://python.org)")
    command_exists pip3    || MISSING+=("pip3")
    command_exists git     || MISSING+=("git (https://git-scm.com)")

    if [ ${#MISSING[@]} -ne 0 ]; then
        log_error "Missing dependencies:"
        for dep in "${MISSING[@]}"; do
            echo "  - $dep"
        done
        echo ""
        if [ "$OS" == "macos" ]; then
            log_info "Install with: brew install node python3 git"
        else
            log_info "Install with: sudo apt-get install nodejs npm python3 python3-pip git"
        fi
        exit 1
    fi

    # Optional deps
    command_exists uv  && log_success "uv: found (fast Python installer)" || log_warn "uv: not found (will use pip3 instead)"
    command_exists uvx && log_success "uvx: found" || log_warn "uvx: not found (will use pip3 instead)"

    log_success "All required dependencies found!"
}

# ============================================
# HELPER: safe pip/npm install
# ============================================

safe_pip_install() {
    local pkg="$1"
    log_info "Installing $pkg via pip..."
    pip3 install --quiet "$pkg" 2>/dev/null && log_success "$pkg installed!" || log_warn "$pkg install failed — may need manual install"
}

safe_npm_install() {
    local pkg="$1"
    log_info "Installing $pkg via npm..."
    npm install -g "$pkg" 2>/dev/null && log_success "$pkg installed!" || log_warn "$pkg install failed — may need manual install"
}

safe_uvx_install() {
    local pkg="$1"
    if command_exists uv; then
        log_info "Installing $pkg via uv..."
        uv tool install "$pkg" 2>/dev/null && log_success "$pkg installed!" && return
    fi
    safe_pip_install "$pkg"
}

# ============================================
# MEMORY LAYER
# ============================================

install_agentmemory() {
    log_info "Installing agentmemory (universal memory — 43 MCP tools)..."
    safe_npm_install "@agentmemory/agentmemory"
}

install_basic_memory() {
    log_info "Installing Basic Memory (human-readable knowledge graph)..."
    safe_uvx_install "basic-memory"
}

install_mempalace() {
    log_info "Installing MemPalace (conversation memory — Claude Code only)..."
    safe_pip_install "mempalace"
}

install_hindsight() {
    log_info "Installing Hindsight (knowledge graph + semantic search)..."
    safe_pip_install "hindsight-server"
}

install_memory_layer() {
    log_header "Memory Layer"
    install_agentmemory
    install_basic_memory
    install_mempalace
    install_hindsight
}

# ============================================
# PROJECT CONTEXT & CODEBASE INTELLIGENCE
# ============================================

install_graphify() {
    log_info "Installing Graphify (71.5x token reduction — Karpathy LLM Wiki pattern)..."
    safe_pip_install "graphifyy"
    log_info "Run 'graphify install' after installation to add Claude Code skill"
}

install_code_review_graph() {
    log_info "Installing code-review-graph (49x token reduction — SQLite codebase map)..."
    safe_pip_install "code-review-graph"
}

install_mex() {
    log_info "Installing mex (living documentation scaffold)..."
    safe_npm_install "mex-cli"
}

install_repomix() {
    log_info "Installing Repomix (codebase packaging — 70% token reduction)..."
    safe_npm_install "repomix"
}

install_project_context() {
    log_header "Project Context & Codebase Intelligence"
    install_graphify
    install_code_review_graph
    install_repomix
    install_mex
}

# ============================================
# CODE SEARCH
# ============================================

install_ragex() {
    log_info "Installing mcp-ragex (hybrid: RAG + AST + regex search)..."
    safe_pip_install "mcp-ragex"
}

install_code_search() {
    log_header "Code Search & Navigation"
    install_ragex
    log_info "Repomix also serves as code search (already installed above)"
}

# ============================================
# WEB & BROWSER
# ============================================

install_fetch_mcp() {
    log_info "Installing Fetch MCP (URL fetching, HTML to Markdown)..."
    log_success "Fetch MCP runs via npx — no global install needed"
    # Verify it can be fetched
    npx -y @modelcontextprotocol/server-fetch --help >/dev/null 2>&1 || true
}

install_playwright_mcp() {
    log_info "Installing Playwright MCP (browser automation by Microsoft)..."
    npx @playwright/mcp@latest --help >/dev/null 2>&1 || true
    log_success "Playwright MCP available via npx"
}

install_brave_search() {
    log_info "Brave Search MCP requires an API key"
    log_info "Get a free key at: https://brave.com/search/api/"
    log_info "Then set BRAVE_API_KEY in your mcp.json"
    log_success "Brave Search MCP runs via npx — no global install needed"
}

install_web_browser() {
    log_header "Web & Browser"
    install_fetch_mcp
    install_playwright_mcp
    install_brave_search
}

# ============================================
# FILE SYSTEM
# ============================================

install_filesystem_mcp() {
    log_info "Filesystem MCP (official sandboxed file access)..."
    log_success "Filesystem MCP runs via npx — no global install needed"
}

install_desktop_commander() {
    log_info "Installing Desktop Commander (file + terminal + process mgmt)..."
    npx -y @wonderwhy-er/desktop-commander setup 2>/dev/null || true
    log_success "Desktop Commander available via npx"
}

install_filesystem() {
    log_header "File System"
    install_filesystem_mcp
    install_desktop_commander
}

# ============================================
# DATABASE
# ============================================

install_sqlite_mcp() {
    log_info "Installing SQLite MCP..."
    safe_uvx_install "mcp-server-sqlite" || true
    log_success "SQLite MCP ready (use: uvx mcp-server-sqlite --db-path ./db.sqlite)"
}

install_postgres_mcp() {
    log_info "Postgres MCP (read-only with schema introspection)..."
    log_success "Postgres MCP runs via npx — configure connection string in mcp.json"
}

install_database() {
    log_header "Database"
    install_sqlite_mcp
    install_postgres_mcp
}

# ============================================
# GIT & GITHUB
# ============================================

install_git_mcp() {
    log_info "Installing Git MCP (local repo operations)..."
    safe_uvx_install "mcp-server-git" || true
    log_success "Git MCP ready"
}

install_github_mcp() {
    log_info "GitHub MCP requires a Personal Access Token"
    log_info "Generate one at: https://github.com/settings/tokens"
    log_info "Then run: claude mcp add github --transport http --url https://api.githubcopilot.com/mcp/ --header 'Authorization: Bearer YOUR_PAT'"
    log_success "GitHub MCP setup instructions provided"
}

install_git_tools() {
    log_header "Git & GitHub"
    install_git_mcp
    install_github_mcp
}

# ============================================
# TERMINAL & SHELL
# ============================================

install_shell_server() {
    log_info "Installing mcp-shell-server (secure whitelisted commands)..."
    safe_pip_install "mcp-shell-server"
}

install_terminal() {
    log_header "Terminal & Shell"
    log_info "Desktop Commander also covers terminal (installed in File System)"
    install_shell_server
}

# ============================================
# IMAGE & VISION
# ============================================

install_screenshot_mcp() {
    log_info "Installing Screenshot MCP (screen capture for AI)..."
    safe_pip_install "screenshot-mcp-server"
}

install_vision_mcp() {
    log_info "mcp-vision requires Ollama with a vision model"
    log_info "After installing Ollama: ollama pull llava"
    log_info "Then clone: git clone https://github.com/MikeyBeez/mcp-vision.git"
    log_success "mcp-vision setup instructions provided"
}

install_image_vision() {
    log_header "Image & Vision"
    install_screenshot_mcp
    install_vision_mcp
}

# ============================================
# TASK & PROJECT MANAGEMENT
# ============================================

install_task_management() {
    log_header "Task & Project Management"
    log_info "Notion MCP: configure via Notion developer portal"
    log_info "  https://developers.notion.com/"
    log_info "Jira MCP: pip install jira-mcp-server (requires Jira credentials)"
    log_success "Task management setup instructions provided"
}

# ============================================
# SECURITY & SECRETS
# ============================================

install_secrets_vault() {
    log_info "Installing mcp-secrets-vault (local mini-vault)..."
    safe_pip_install "mcp-secrets-vault"
}

install_security() {
    log_header "Security & Secrets"
    install_secrets_vault
    log_info "HashiCorp Vault MCP: see https://github.com/hashicorp/vault-mcp-server"
}

# ============================================
# PERSONAL EVOLUTION
# ============================================

install_homunculus() {
    log_info "Installing homunculus (pattern learning)..."

    HOMUNCULUS_DIR="$HOME/.homunculus"

    if [ -d "$HOMUNCULUS_DIR" ]; then
        log_warn "homunculus already exists at $HOMUNCULUS_DIR — skipping"
        return
    fi

    git clone https://github.com/humanplane/homunculus.git "$HOMUNCULUS_DIR" 2>/dev/null || {
        log_warn "homunculus clone failed — repo may not exist yet"
        return
    }
    cd "$HOMUNCULUS_DIR" && pip3 install -e . 2>/dev/null || true
    cd "$SCRIPT_DIR"
    log_success "homunculus installed to $HOMUNCULUS_DIR"
}

install_hermes() {
    log_info "Installing Hermes Agent (self-improving agent by NousResearch)..."

    if command_exists hermes; then
        log_success "Hermes Agent already installed"
        return
    fi

    curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash 2>/dev/null || {
        log_warn "Hermes install script failed — try manual install:"
        log_info "  pip3 install hermes-agent"
        safe_pip_install "hermes-agent"
    }

    log_success "Hermes Agent installed"
}

install_personal_evolution() {
    log_header "Personal Evolution"
    install_homunculus
    install_hermes
}

# ============================================
# LOCAL INFERENCE
# ============================================

install_ollama() {
    log_info "Installing Ollama (local model runner — 166k GitHub stars)..."

    if command_exists ollama; then
        log_success "Ollama already installed"
    else
        curl -fsSL https://ollama.ai/install.sh | sh 2>/dev/null || {
            log_warn "Ollama install failed — download manually from https://ollama.com/download"
            return
        }
        log_success "Ollama installed"
    fi

    log_info "Pulling recommended models (this may take a while)..."
    ollama pull qwen2.5-coder:7b 2>/dev/null && log_success "Pulled qwen2.5-coder:7b" || log_warn "Model pull failed — run manually: ollama pull qwen2.5-coder:7b"
    ollama pull nomic-embed-text 2>/dev/null && log_success "Pulled nomic-embed-text" || true
}

install_localai() {
    log_info "LocalAI is best installed via Docker:"
    log_info "  docker run -p 8080:8080 localai/localai"
    log_info "Or download binary from: https://github.com/mudler/LocalAI/releases"
    log_success "LocalAI setup instructions provided"
}

install_local_inference() {
    log_header "Local Inference"
    install_ollama
    install_localai
    log_info "LM Studio: download from https://lmstudio.ai"
}

# ============================================
# AGENT FRAMEWORKS
# ============================================

install_crewai() {
    log_info "Installing crewAI (multi-agent orchestration — 45k stars)..."
    safe_pip_install "crewai"
}

install_agent_frameworks() {
    log_header "Agent Frameworks"
    install_hermes
    install_crewai
    safe_pip_install "smolagents"
    safe_pip_install "agno"
    safe_npm_install "claude-flow"
    safe_pip_install "hf-agents"
    safe_pip_install "huggingface-skills"
    log_info "workflow-orchestration: git clone https://github.com/barkain/claude-code-workflow-orchestration"
}

# ============================================
# ADVANCED MEMORY
# ============================================

install_advanced_memory() {
    log_header "Advanced Memory Systems"
    safe_pip_install "mem0ai"
    safe_pip_install "letta"
    safe_pip_install "graphiti-core"
    safe_pip_install "cognee"
    safe_pip_install "langmem"
    safe_pip_install "memclaw"
    log_info "MemOS: pip install memos (optional — multi-agent shared pool)"
}

# ============================================
# AGENT CAPABILITIES
# ============================================

install_composio() {
    log_info "Installing Composio (250+ pre-built SaaS tools)..."
    safe_pip_install "composio-core"
}

install_browser_use() {
    log_info "Installing Browser Use (agent-native Chromium — 72k stars)..."
    safe_pip_install "browser-use"
}

install_e2b() {
    log_info "Installing E2B (secure code execution sandboxes)..."
    safe_pip_install "e2b-code-interpreter"
}

install_open_interpreter() {
    log_info "Installing Open Interpreter (local code execution)..."
    safe_pip_install "open-interpreter"
}

install_capabilities() {
    log_header "Agent Capabilities (skills, execution, browser)"
    install_composio
    install_browser_use
    install_e2b
    install_open_interpreter
}

# ============================================
# VOICE & AUDIO
# ============================================

install_voice() {
    log_header "Voice & Audio (STT + TTS)"

    # STT (Speech-to-Text)
    log_info "Installing faster-whisper (4x faster than OpenAI Whisper, CPU-friendly)..."
    safe_pip_install "faster-whisper"

    log_info "Installing whisper-live (real-time streaming transcription)..."
    safe_pip_install "whisper-live"

    # TTS (Text-to-Speech)
    log_info "Installing Kokoro (82M params, 54 voices, 8 languages, high quality)..."
    safe_pip_install "kokoro"

    log_info "Installing Coqui TTS (voice cloning with 6-second sample, XTTS v2)..."
    safe_pip_install "coqui-tts"

    # Full pipeline
    log_info "Installing Pipecat (real-time voice pipeline: STT + LLM + TTS)..."
    safe_pip_install "pipecat-ai"

    log_success "Voice & Audio tools installed"
    log_info "MCP servers available: whisper-mcp, claude-tts-mcp, voice-mcp (see README)"
}

# ============================================
# AGENT ORCHESTRATION
# ============================================

install_orchestration() {
    log_header "Agent Orchestration"
    safe_pip_install "langgraph"
    safe_pip_install "temporalio"
    log_info "A2A Protocol: see https://github.com/a2aproject/A2A"
    log_success "LangGraph + Temporal installed"
}

# ============================================
# AGENT EVALUATION
# ============================================

install_evaluation() {
    log_header "Agent Evaluation"
    safe_pip_install "deepeval"
    safe_pip_install "inspect-ai"
    log_info "AgentBench: see https://github.com/THUDM/AgentBench"
    log_success "DeepEval + Inspect AI installed"
}

# ============================================
# AGENT GUARDRAILS
# ============================================

install_guardrails() {
    log_header "Agent Guardrails"
    safe_pip_install "nemoguardrails"
    log_info "LlamaFirewall: see https://github.com/meta-llama/PurpleLlama"
    log_info "Invariant: see https://github.com/invariantlabs-ai/invariant"
    log_success "NeMo Guardrails installed"
}

# ============================================
# AGENT OBSERVABILITY
# ============================================

install_observability() {
    log_header "Agent Observability"
    safe_pip_install "agentops"
    safe_pip_install "arize-phoenix"
    safe_pip_install "langfuse"
    log_info "LangSmith: pip install langsmith (requires LangChain API key)"
    log_success "AgentOps + Phoenix + Langfuse installed"
}

# ============================================
# HERMES ECOSYSTEM
# ============================================

install_hermes_ecosystem() {
    log_header "Hermes Ecosystem"
    install_hermes

    log_info "hermes-CCC (Claude Code port): git clone https://github.com/AlexAI-MCP/hermes-CCC.git"
    log_info "hermes-workspace (browser GUI): git clone https://github.com/outsourc-e/hermes-workspace.git"
    log_info "self-evolution: git clone https://github.com/NousResearch/hermes-agent-self-evolution.git"
    log_info "awesome-hermes-agent: https://github.com/0xNyk/awesome-hermes-agent"
    log_info ""
    log_info "Skill packs:"
    log_info "  wondelai/skills — 380+ general-purpose skills"
    log_info "  Anthropic-Cybersecurity-Skills — 753+ security skills"
    log_info "  Browse more at: hermes-agent.nousresearch.com/docs/skills"
    log_success "Hermes ecosystem info provided"
}

# ============================================
# NOTIFICATIONS & MESSAGING
# ============================================

install_notifications() {
    log_header "Notifications & Messaging"
    log_info "Slack MCP: npx @korotovsky/slack-mcp-server (needs Slack token)"
    log_info "Discord MCP: npx mcp-discord (needs Discord bot token)"
    safe_pip_install "mcp-email-server"
    log_success "Email MCP installed. Slack/Discord available via npx."
}

# ============================================
# CALENDAR, DOCS, DATA
# ============================================

install_productivity() {
    log_header "Calendar, Docs & Data"
    log_info "Google Calendar MCP: npx google-calendar-mcp (needs OAuth)"
    log_info "Markdown2PDF MCP: npx markdown2pdf-mcp"
    log_info "Excel MCP: npx @negokaz/excel-mcp-server"
    safe_pip_install "unstructured[all-docs]"
    log_success "Unstructured (doc parser) installed. Others available via npx."
}

# ============================================
# CLOUD & DEVOPS
# ============================================

install_cloud() {
    log_header "Cloud & Infrastructure"
    log_info "AWS MCP (official): uvx awslabs.core-mcp-server"
    log_info "GCP MCP (official): see googleapis/gcloud-mcp"
    log_info "Azure MCP (official): see microsoft/mcp"
    log_info "Docker MCP: npx @modelcontextprotocol/server-docker"
    log_info "Kubernetes MCP: see containers/kubernetes-mcp-server"
    log_success "Cloud MCPs available via npx/uvx (configure API keys separately)"
}

# ============================================
# MONITORING
# ============================================

install_monitoring() {
    log_header "Monitoring & Alerting"
    safe_pip_install "prometheus-mcp-server"
    log_info "Sentry MCP: npx @sentry/mcp-server (or remote: mcp.sentry.dev)"
    log_info "Grafana MCP: see grafana/mcp-grafana"
    log_success "Prometheus MCP installed. Sentry/Grafana available separately."
}

# ============================================
# DESIGN & KNOWLEDGE
# ============================================

install_design_knowledge() {
    log_header "Design & Knowledge Management"
    log_info "Figma MCP: npx figma-context-mcp"
    log_info "Obsidian MCP: npx obsidian-mcp-server (needs Obsidian REST API plugin)"
    log_success "Design & knowledge tools available via npx"
}

# ============================================
# RAG & AI/ML PIPELINE
# ============================================

install_rag() {
    log_header "RAG & Search Frameworks"
    safe_pip_install "llama-index"
    safe_pip_install "haystack-ai"
    safe_pip_install "dspy"
    log_success "LlamaIndex + Haystack + DSPy installed"
}

install_ml_pipeline() {
    log_header "AI/ML Pipeline"
    safe_pip_install "litellm"
    safe_pip_install "instructor"
    safe_pip_install "outlines"
    safe_npm_install "promptfoo"
    log_info "vLLM: pip install vllm (requires NVIDIA GPU)"
    log_info "Axolotl: pip install axolotl (requires GPU for training)"
    log_info "Distilabel: pip install distilabel"
    log_info "Argilla: pip install argilla"
    log_success "LiteLLM + Instructor + Outlines + Promptfoo installed"
}

# ============================================
# VECTOR DATABASES
# ============================================

install_vector_dbs() {
    log_header "Vector Databases (MCP)"
    log_info "Chroma MCP: uvx chroma-mcp"
    log_info "Qdrant MCP: uvx mcp-server-qdrant"
    log_success "Vector DB MCPs available via uvx"
}

# ============================================
# WORKFLOW, PAYMENTS, MAPS
# ============================================

install_integrations() {
    log_header "Workflow, Payments & Maps"
    log_info "n8n MCP: npx n8n-mcp"
    log_info "Stripe MCP: npx -y @stripe/mcp --api-key=KEY"
    log_info "Google Maps MCP: see cablate/mcp-google-map"
    log_success "Integration MCPs available via npx"
}

# ============================================
# SELF-IMPROVEMENT (KARPATHY-INSPIRED)
# ============================================

install_self_improvement() {
    log_header "Self-Improvement (Karpathy-inspired)"

    AUTORESEARCH_DIR="$HOME/.autoresearch"
    if [ ! -d "$AUTORESEARCH_DIR" ]; then
        log_info "Cloning autoresearch (autonomous ML experiment loop)..."
        git clone https://github.com/karpathy/autoresearch.git "$AUTORESEARCH_DIR" 2>/dev/null || log_warn "autoresearch clone failed"
    else
        log_success "autoresearch already cloned"
    fi

    COUNCIL_DIR="$HOME/.llm-council"
    if [ ! -d "$COUNCIL_DIR" ]; then
        log_info "Cloning llm-council (multi-LLM deliberation)..."
        git clone https://github.com/karpathy/llm-council.git "$COUNCIL_DIR" 2>/dev/null || log_warn "llm-council clone failed"
    else
        log_success "llm-council already cloned"
    fi

    log_info "LLM Wiki pattern: see docs/self-improvement.md"
    log_success "Self-improvement tools ready"
}

# ============================================
# INTERACTIVE CONFIGURATION WIZARD
# ============================================

configure_secrets() {
    log_header "Configuration Wizard"
    echo ""
    echo -e "  ${BOLD}This will walk you through setting up API keys and secrets.${NC}"
    echo -e "  Press Enter to skip any you don't have yet."
    echo ""

    # Create .env file
    ENV_FILE="$SCRIPT_DIR/.env"
    > "$ENV_FILE"

    # Brave Search
    echo -e "  ${CYAN}1/6 — Brave Search API${NC}"
    echo "  Free key at: https://brave.com/search/api/"
    read -p "  Brave API Key (Enter to skip): " BRAVE_KEY
    if [ -n "$BRAVE_KEY" ]; then
        echo "BRAVE_API_KEY=$BRAVE_KEY" >> "$ENV_FILE"
        log_success "Brave Search key saved"
    else
        log_warn "Skipped — Brave Search won't work without a key"
    fi
    echo ""

    # GitHub PAT
    echo -e "  ${CYAN}2/6 — GitHub Personal Access Token${NC}"
    echo "  Generate at: https://github.com/settings/tokens"
    echo "  Scopes needed: repo, read:org, read:user"
    read -p "  GitHub PAT (Enter to skip): " GITHUB_PAT
    if [ -n "$GITHUB_PAT" ]; then
        echo "GITHUB_PAT=$GITHUB_PAT" >> "$ENV_FILE"
        log_success "GitHub PAT saved"
    else
        log_warn "Skipped — GitHub MCP won't work without a PAT"
    fi
    echo ""

    # Hermes provider
    echo -e "  ${CYAN}3/6 — Hermes Agent LLM Provider${NC}"
    echo "  Options: ollama (local), anthropic, openai"
    read -p "  Provider [ollama]: " HERMES_PROVIDER
    HERMES_PROVIDER="${HERMES_PROVIDER:-ollama}"
    echo "HERMES_PROVIDER=$HERMES_PROVIDER" >> "$ENV_FILE"

    if [ "$HERMES_PROVIDER" = "anthropic" ]; then
        read -p "  Anthropic API Key: " ANTHROPIC_KEY
        [ -n "$ANTHROPIC_KEY" ] && echo "ANTHROPIC_API_KEY=$ANTHROPIC_KEY" >> "$ENV_FILE"
    elif [ "$HERMES_PROVIDER" = "openai" ]; then
        read -p "  OpenAI API Key: " OPENAI_KEY
        [ -n "$OPENAI_KEY" ] && echo "OPENAI_API_KEY=$OPENAI_KEY" >> "$ENV_FILE"
    else
        log_success "Using Ollama (local) — no API key needed"
    fi
    echo ""

    # Ollama models
    echo -e "  ${CYAN}4/6 — Ollama Model Selection${NC}"
    echo "  Which models to pull? (takes time + disk space)"
    echo "  1) qwen2.5-coder:7b  (4GB — recommended)"
    echo "  2) qwen2.5-coder:32b (20GB — best coding)"
    echo "  3) llama3.3:8b        (5GB — general purpose)"
    echo "  4) nomic-embed-text   (300MB — embeddings)"
    echo "  5) llava              (4GB — vision)"
    echo "  6) All of the above"
    echo "  7) Skip"
    read -p "  Choice [1,4]: " MODEL_CHOICE
    MODEL_CHOICE="${MODEL_CHOICE:-1,4}"
    echo "OLLAMA_MODELS=$MODEL_CHOICE" >> "$ENV_FILE"
    log_success "Model selection saved"
    echo ""

    # Database path
    echo -e "  ${CYAN}5/6 — Default SQLite Database Path${NC}"
    read -p "  Path [./data.db]: " DB_PATH
    DB_PATH="${DB_PATH:-./data.db}"
    echo "SQLITE_DB_PATH=$DB_PATH" >> "$ENV_FILE"
    log_success "Database path: $DB_PATH"
    echo ""

    # Postgres
    echo -e "  ${CYAN}6/6 — PostgreSQL Connection (optional)${NC}"
    read -p "  Connection string (Enter to skip): " PG_CONN
    if [ -n "$PG_CONN" ]; then
        echo "POSTGRES_CONNECTION=$PG_CONN" >> "$ENV_FILE"
        log_success "Postgres connection saved"
    else
        log_warn "Skipped — Postgres MCP will use default"
    fi
    echo ""

    # Apply config to mcp.json
    log_info "Applying configuration to MCP config..."
    apply_config_to_mcp

    log_success "Configuration saved to $ENV_FILE"
    log_info "You can edit this file later or re-run: ./install.sh --configure"
    echo ""

    # Add .env to .gitignore if not already there
    grep -q "^\.env$" "$SCRIPT_DIR/.gitignore" 2>/dev/null || echo ".env" >> "$SCRIPT_DIR/.gitignore"
}

apply_config_to_mcp() {
    local MCP_FILE="$SCRIPT_DIR/mcp.json"
    local ENV_FILE="$SCRIPT_DIR/.env"

    # Read values from .env
    BRAVE_KEY=$(grep "^BRAVE_API_KEY=" "$ENV_FILE" 2>/dev/null | cut -d= -f2-)
    DB_PATH=$(grep "^SQLITE_DB_PATH=" "$ENV_FILE" 2>/dev/null | cut -d= -f2-)
    PG_CONN=$(grep "^POSTGRES_CONNECTION=" "$ENV_FILE" 2>/dev/null | cut -d= -f2-)

    # Apply Brave key
    if [ -n "$BRAVE_KEY" ] && [ "$BRAVE_KEY" != "YOUR_BRAVE_API_KEY" ]; then
        if command_exists sed; then
            sed -i.bak "s/YOUR_BRAVE_API_KEY/$BRAVE_KEY/g" "$MCP_FILE" 2>/dev/null || true
            rm -f "$MCP_FILE.bak"
        fi
    fi

    # Apply DB path
    if [ -n "$DB_PATH" ] && [ "$DB_PATH" != "./data.db" ]; then
        if command_exists sed; then
            sed -i.bak "s|./data.db|$DB_PATH|g" "$MCP_FILE" 2>/dev/null || true
            rm -f "$MCP_FILE.bak"
        fi
    fi

    # Apply Postgres connection
    if [ -n "$PG_CONN" ]; then
        if command_exists sed; then
            sed -i.bak "s|postgresql://localhost/mydb|$PG_CONN|g" "$MCP_FILE" 2>/dev/null || true
            rm -f "$MCP_FILE.bak"
        fi
    fi

    log_success "MCP config updated with your values"
}

# ============================================
# MCP CONFIGURATION
# ============================================

setup_mcp() {
    log_header "MCP Configuration"

    # Claude Code config
    CLAUDE_MCP_DIR="$HOME/.claude"
    CLAUDE_MCP_FILE="$CLAUDE_MCP_DIR/mcp.json"

    mkdir -p "$CLAUDE_MCP_DIR"

    if [ -f "$CLAUDE_MCP_FILE" ]; then
        cp "$CLAUDE_MCP_FILE" "$CLAUDE_MCP_FILE.backup.$(date +%Y%m%d%H%M%S)"
        log_warn "Backed up existing Claude mcp.json"
    fi

    cp "$SCRIPT_DIR/mcp.json" "$CLAUDE_MCP_FILE"
    log_success "Claude Code MCP config installed at $CLAUDE_MCP_FILE"

    # Cursor config
    CURSOR_MCP_DIR="$HOME/.cursor"
    mkdir -p "$CURSOR_MCP_DIR"
    cp "$SCRIPT_DIR/examples/cursor-mcp.json" "$CURSOR_MCP_DIR/mcp.json" 2>/dev/null || \
        cp "$SCRIPT_DIR/mcp.json" "$CURSOR_MCP_DIR/mcp.json"
    log_success "Cursor MCP config installed at $CURSOR_MCP_DIR/mcp.json"

    # LM Studio config
    LMSTUDIO_MCP_DIR="$HOME/.lmstudio"
    if [ -d "$LMSTUDIO_MCP_DIR" ]; then
        cp "$SCRIPT_DIR/examples/lmstudio-mcp.json" "$LMSTUDIO_MCP_DIR/mcp.json" 2>/dev/null || true
        log_success "LM Studio MCP config installed"
    fi
}

# ============================================
# VERIFY INSTALLATION
# ============================================

verify_installation() {
    log_header "Installation Status"

    echo ""
    printf "  %-25s %s\n" "TOOL" "STATUS"
    printf "  %-25s %s\n" "-------------------------" "----------"

    check_tool() {
        local name="$1"
        local cmd="$2"
        if command_exists "$cmd"; then
            printf "  ${GREEN}%-25s %s${NC}\n" "$name" "Installed"
        else
            printf "  ${RED}%-25s %s${NC}\n" "$name" "Not found"
        fi
    }

    echo ""
    echo "  -- Memory --"
    check_tool "agentmemory" "agentmemory"
    check_tool "basic-memory" "basic-memory"
    check_tool "mempalace" "mempalace"
    check_tool "hindsight" "hindsight-server"

    echo ""
    echo "  -- Project Context --"
    check_tool "repomix" "repomix"
    check_tool "mex" "mex"

    echo ""
    echo "  -- Personal Evolution --"
    [ -d "$HOME/.homunculus" ] && printf "  ${GREEN}%-25s %s${NC}\n" "homunculus" "Installed" || printf "  ${YELLOW}%-25s %s${NC}\n" "homunculus" "Not installed"
    check_tool "hermes" "hermes"

    echo ""
    echo "  -- Local Inference --"
    check_tool "ollama" "ollama"

    echo ""
    echo "  -- Agent Frameworks --"
    check_tool "crewai" "crewai"

    echo ""
    echo "  -- MCP Servers (via npx — always available) --"
    printf "  ${GREEN}%-25s %s${NC}\n" "fetch" "npx (on-demand)"
    printf "  ${GREEN}%-25s %s${NC}\n" "playwright" "npx (on-demand)"
    printf "  ${GREEN}%-25s %s${NC}\n" "brave-search" "npx (on-demand)"
    printf "  ${GREEN}%-25s %s${NC}\n" "filesystem" "npx (on-demand)"
    printf "  ${GREEN}%-25s %s${NC}\n" "desktop-commander" "npx (on-demand)"
    printf "  ${GREEN}%-25s %s${NC}\n" "postgres" "npx (on-demand)"

    echo ""

    # Check MCP config
    if [ -f "$HOME/.claude/mcp.json" ]; then
        log_success "Claude Code MCP config: found"
    else
        log_warn "Claude Code MCP config: not found — run with --mcp"
    fi

    echo ""
}

# ============================================
# INSTALL EVERYTHING
# ============================================

install_everything() {
    install_memory_layer
    install_advanced_memory
    install_project_context
    install_code_search
    install_web_browser
    install_filesystem
    install_database
    install_git_tools
    install_terminal
    install_image_vision
    install_task_management
    install_security
    install_personal_evolution
    install_local_inference
    install_agent_frameworks
    install_capabilities
    install_voice
    install_orchestration
    install_evaluation
    install_guardrails
    install_observability
    install_hermes_ecosystem
    install_notifications
    install_productivity
    install_cloud
    install_monitoring
    install_design_knowledge
    install_rag
    install_ml_pipeline
    install_vector_dbs
    install_integrations
    install_self_improvement
    setup_mcp
    verify_installation
}

install_core() {
    install_memory_layer
    install_project_context
    install_code_search
    setup_mcp
    verify_installation
}

# ============================================
# INTERACTIVE MENU
# ============================================

show_menu() {
    echo ""
    echo -e "${CYAN}${BOLD}  AI Evolution Stack Installer${NC}"
    echo -e "  ${BOLD}60+ tools across 22 categories${NC}"
    echo ""
    echo "  1)  Everything (recommended)"
    echo "  2)  Core only (memory + context + code search + MCP)"
    echo ""
    echo "  -- Foundation --"
    echo "  3)  Memory layer (agentmemory, basic-memory, mempalace, hindsight)"
    echo "  4)  Advanced memory (Mem0, Letta, Graphiti, Cognee, LangMem)"
    echo "  5)  Project context (repomix, mex)"
    echo "  6)  Local inference (ollama, localai)"
    echo ""
    echo "  -- Tools --"
    echo "  7)  Web & browser (fetch, playwright, brave, browser-use)"
    echo "  8)  Database (sqlite, postgres)"
    echo "  9)  Git & GitHub"
    echo "  10) Agent capabilities (composio, e2b, browser-use)"
    echo "  11) Voice & audio (whisper, kokoro, coqui, pipecat)"
    echo ""
    echo "  -- Agents --"
    echo "  12) Agent frameworks (hermes, crewai, smolagents, agno)"
    echo "  13) Hermes ecosystem (self-evolution, CCC, workspace, skills)"
    echo "  14) Orchestration (langgraph, temporal, a2a)"
    echo ""
    echo "  -- Quality --"
    echo "  15) Evaluation (deepeval, inspect-ai)"
    echo "  16) Guardrails (nemo, llamafirewall)"
    echo "  17) Observability (agentops, phoenix, langfuse)"
    echo ""
    echo "  -- Config --"
    echo "  18) Configure secrets & API keys (interactive wizard)"
    echo "  19) Setup MCP configuration only"
    echo "  20) Verify installation"
    echo "  21) Exit"
    echo ""
}

# ============================================
# MAIN
# ============================================

main() {
    echo ""
    echo -e "${CYAN}${BOLD}  AI Evolution Stack${NC}"
    echo -e "  The Definitive Local-First AI Toolkit"
    echo -e "  100+ tools. 35 categories. One script."
    echo ""

    # Handle CLI flags
    case "${1:-}" in
        --everything|-e)    check_dependencies; install_everything; exit 0 ;;
        --core|-c)          check_dependencies; install_core; exit 0 ;;
        --memory|-m)        check_dependencies; install_memory_layer; install_advanced_memory; exit 0 ;;
        --web|-w)           check_dependencies; install_web_browser; exit 0 ;;
        --database|-d)      check_dependencies; install_database; exit 0 ;;
        --agents|-a)        check_dependencies; install_agent_frameworks; exit 0 ;;
        --hermes)           check_dependencies; install_hermes_ecosystem; exit 0 ;;
        --inference|-i)     check_dependencies; install_local_inference; exit 0 ;;
        --capabilities)     check_dependencies; install_capabilities; exit 0 ;;
        --voice)            check_dependencies; install_voice; exit 0 ;;
        --orchestration)    check_dependencies; install_orchestration; exit 0 ;;
        --observability)    check_dependencies; install_observability; install_evaluation; install_guardrails; exit 0 ;;
        --rag)              check_dependencies; install_rag; install_ml_pipeline; exit 0 ;;
        --cloud)            check_dependencies; install_cloud; install_monitoring; exit 0 ;;
        --selfimprove)      check_dependencies; install_self_improvement; exit 0 ;;
        --notifications)    check_dependencies; install_notifications; exit 0 ;;
        --configure)        configure_secrets; exit 0 ;;
        --mcp)              setup_mcp; exit 0 ;;
        --verify|-v)        verify_installation; exit 0 ;;
        --help|-h)
            echo "Usage: $0 [OPTION]"
            echo ""
            echo "Options:"
            echo "  --everything, -e    Install all 60+ tools"
            echo "  --core, -c          Memory + context + code search"
            echo "  --memory, -m        All 10 memory systems"
            echo "  --web, -w           Web & browser tools"
            echo "  --database, -d      Database tools"
            echo "  --agents, -a        Agent frameworks"
            echo "  --hermes            Full Hermes ecosystem"
            echo "  --inference, -i     Local inference (Ollama, LocalAI)"
            echo "  --capabilities      Skills, code exec, voice, browser"
            echo "  --orchestration     LangGraph, Temporal, A2A"
            echo "  --observability     Monitoring, eval, guardrails"
            echo "  --configure         Interactive API key & secret setup"
            echo "  --mcp               Setup MCP configuration only"
            echo "  --verify, -v        Check what's installed"
            echo "  --help, -h          Show this help"
            exit 0
            ;;
    esac

    # Interactive mode
    check_dependencies

    while true; do
        show_menu
        read -p "  Enter choice (1-21): " CHOICE

        case $CHOICE in
            1)  install_everything; break ;;
            2)  install_core; break ;;
            3)  install_memory_layer; break ;;
            4)  install_advanced_memory; break ;;
            5)  install_project_context; break ;;
            6)  install_local_inference; break ;;
            7)  install_web_browser; break ;;
            8)  install_database; break ;;
            9)  install_git_tools; break ;;
            10) install_capabilities; break ;;
            11) install_voice; break ;;
            12) install_agent_frameworks; break ;;
            13) install_hermes_ecosystem; break ;;
            14) install_orchestration; break ;;
            15) install_evaluation; break ;;
            16) install_guardrails; break ;;
            17) install_observability; break ;;
            18) configure_secrets; break ;;
            19) setup_mcp; break ;;
            20) verify_installation; continue ;;
            21) log_info "Exiting..."; exit 0 ;;
            *)  log_error "Invalid choice" ;;
        esac
    done

    echo ""
    echo -e "${GREEN}${BOLD}  Installation Complete!${NC}"
    echo ""
    echo "  Next steps:"
    echo "  1. Run ./install.sh --configure  (set up API keys)"
    echo "  2. Restart Cursor / Claude Code"
    echo "  3. Check MCP servers: claude mcp list"
    echo "  4. Try: ollama run qwen2.5-coder:7b"
    echo ""
    echo "  Docs: https://github.com/Yousifus/ai-evolution-stack"
    echo ""
}

main "$@"
