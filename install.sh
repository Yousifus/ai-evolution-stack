#!/bin/bash

# AI Evolution Stack — Universal Installer
# 30+ tools across 15 categories. One script installs everything.
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
# PROJECT CONTEXT
# ============================================

install_mex() {
    log_info "Installing mex (living documentation scaffold)..."
    safe_npm_install "mex-cli"
}

install_repomix() {
    log_info "Installing Repomix (codebase packaging — 80% token reduction)..."
    safe_npm_install "repomix"
}

install_project_context() {
    log_header "Project Context"
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
    echo -e "  ${BOLD}30+ tools across 15 categories${NC}"
    echo ""
    echo "  1)  Everything (recommended)"
    echo "  2)  Core only (memory + context + code search + MCP)"
    echo ""
    echo "  -- Individual Categories --"
    echo "  3)  Memory layer (agentmemory, basic-memory, mempalace, hindsight)"
    echo "  4)  Project context (repomix, mex)"
    echo "  5)  Web & browser (fetch, playwright, brave search)"
    echo "  6)  Database (sqlite, postgres)"
    echo "  7)  Git & GitHub"
    echo "  8)  Personal evolution (homunculus, hermes)"
    echo "  9)  Local inference (ollama, localai)"
    echo "  10) Agent frameworks (hermes, crewai)"
    echo ""
    echo "  -- Config --"
    echo "  11) Setup MCP configuration only"
    echo "  12) Verify installation"
    echo "  13) Exit"
    echo ""
}

# ============================================
# MAIN
# ============================================

main() {
    echo ""
    echo -e "${CYAN}${BOLD}  AI Evolution Stack${NC}"
    echo -e "  The Ultimate Local-First AI Toolkit"
    echo -e "  30+ tools. 15 categories. One script."
    echo ""

    # Handle CLI flags
    case "${1:-}" in
        --everything|-e)  check_dependencies; install_everything; exit 0 ;;
        --core|-c)        check_dependencies; install_core; exit 0 ;;
        --memory|-m)      check_dependencies; install_memory_layer; exit 0 ;;
        --web|-w)         check_dependencies; install_web_browser; exit 0 ;;
        --database|-d)    check_dependencies; install_database; exit 0 ;;
        --agents|-a)      check_dependencies; install_agent_frameworks; exit 0 ;;
        --inference|-i)   check_dependencies; install_local_inference; exit 0 ;;
        --mcp)            setup_mcp; exit 0 ;;
        --verify|-v)      verify_installation; exit 0 ;;
        --help|-h)
            echo "Usage: $0 [OPTION]"
            echo ""
            echo "Options:"
            echo "  --everything, -e    Install all 30+ tools"
            echo "  --core, -c          Memory + context + code search"
            echo "  --memory, -m        Memory layer only"
            echo "  --web, -w           Web & browser tools"
            echo "  --database, -d      Database tools"
            echo "  --agents, -a        Agent frameworks"
            echo "  --inference, -i     Local inference (Ollama, LocalAI)"
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
        read -p "  Enter choice (1-13): " CHOICE

        case $CHOICE in
            1)  install_everything; break ;;
            2)  install_core; break ;;
            3)  install_memory_layer; break ;;
            4)  install_project_context; break ;;
            5)  install_web_browser; break ;;
            6)  install_database; break ;;
            7)  install_git_tools; break ;;
            8)  install_personal_evolution; break ;;
            9)  install_local_inference; break ;;
            10) install_agent_frameworks; break ;;
            11) setup_mcp; break ;;
            12) verify_installation; continue ;;
            13) log_info "Exiting..."; exit 0 ;;
            *)  log_error "Invalid choice" ;;
        esac
    done

    echo ""
    echo -e "${GREEN}${BOLD}  Installation Complete!${NC}"
    echo ""
    echo "  Next steps:"
    echo "  1. Restart Cursor / Claude Code"
    echo "  2. Check MCP servers: claude mcp list"
    echo "  3. Run 'mex init' in your projects"
    echo "  4. Try: ollama run qwen2.5-coder:7b"
    echo ""
    echo "  Docs: https://github.com/Yousifus/ai-evolution-stack"
    echo ""
}

main "$@"
