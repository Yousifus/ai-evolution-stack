#!/bin/bash

# 🧠 AI Evolution Stack - Universal Installer
# Works on macOS and Linux
# Everything local. No cloud. Full privacy.

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect OS
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
log_info "Detected OS: $OS"

# ============================================
# CHECK DEPENDENCIES
# ============================================

check_dependencies() {
    log_info "Checking dependencies..."
    
    MISSING_DEPS=()
    
    if ! command_exists node; then
        MISSING_DEPS+=("Node.js")
    fi
    
    if ! command_exists npm; then
        MISSING_DEPS+=("npm")
    fi
    
    if ! command_exists python3; then
        MISSING_DEPS+=("Python 3")
    fi
    
    if ! command_exists pip3; then
        MISSING_DEPS+=("pip3")
    fi
    
    if ! command_exists git; then
        MISSING_DEPS+=("git")
    fi
    
    if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
        log_error "Missing dependencies: ${MISSING_DEPS[*]}"
        log_info "Please install them first:"
        
        if [ "$OS" == "macos" ]; then
            log_info "  brew install node python3 git"
        else
            log_info "  sudo apt-get install nodejs npm python3 python3-pip git"
        fi
        exit 1
    fi
    
    log_success "All dependencies found!"
}

# ============================================
# INSTALL TOOLS
# ============================================

install_agentmemory() {
    log_info "Installing agentmemory (universal memory)..."
    npm install -g @agentmemory/agentmemory
    log_success "agentmemory installed!"
}

install_basic_memory() {
    log_info "Installing Basic Memory (human-readable knowledge)..."
    
    # Try uv first (fastest)
    if command_exists uv; then
        log_info "Using uv for installation..."
        uv tool install basic-memory
    elif command_exists uvx; then
        log_info "Using uvx..."
        # Already have uvx, just need to ensure basic-memory is available
        uvx basic-memory --version 2>/dev/null || true
    else
        log_info "Installing via pip..."
        pip3 install basic-memory
    fi
    
    log_success "Basic Memory installed!"
}

install_mempalace() {
    log_info "Installing MemPalace (conversation memory)..."
    pip3 install mempalace
    log_success "MemPalace installed!"
}

install_hindsight() {
    log_info "Installing Hindsight (knowledge graph)..."
    pip3 install hindsight-server
    log_success "Hindsight installed!"
}

install_mex() {
    log_info "Installing mex (project documentation)..."
    npm install -g mex-cli
    log_success "mex installed!"
}

install_repomix() {
    log_info "Installing Repomix (codebase packaging)..."
    npm install -g repomix
    log_success "Repomix installed!"
}

install_homunculus() {
    log_info "Installing homunculus (pattern learning)..."
    
    HOMUNCULUS_DIR="$HOME/.homunculus"
    
    if [ -d "$HOMUNCULUS_DIR" ]; then
        log_warn "homunculus already exists at $HOMUNCULUS_DIR"
        read -p "Reinstall? (y/N): " REINSTALL
        if [[ $REINSTALL =~ ^[Yy]$ ]]; then
            rm -rf "$HOMUNCULUS_DIR"
        else
            log_info "Skipping homunculus installation"
            return
        fi
    fi
    
    git clone https://github.com/humanplane/homunculus.git "$HOMUNCULUS_DIR"
    cd "$HOMUNCULUS_DIR"
    pip3 install -e .
    
    log_success "homunculus installed to $HOMUNCULUS_DIR"
}

# ============================================
# SETUP MCP CONFIGURATION
# ============================================

setup_mcp() {
    log_info "Setting up MCP configuration..."
    
    CLAUDE_MCP_DIR="$HOME/.claude"
    CLAUDE_MCP_FILE="$CLAUDE_MCP_DIR/mcp.json"
    
    # Create directory if it doesn't exist
    mkdir -p "$CLAUDE_MCP_DIR"
    
    # Backup existing config
    if [ -f "$CLAUDE_MCP_FILE" ]; then
        cp "$CLAUDE_MCP_FILE" "$CLAUDE_MCP_FILE.backup.$(date +%Y%m%d%H%M%S)"
        log_warn "Backed up existing mcp.json"
    fi
    
    # Create new MCP config
    cat > "$CLAUDE_MCP_FILE" << 'EOF'
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
        "HINDSIGHT_API_LLM_PROVIDER": "ollama"
      },
      "description": "Knowledge graph with semantic search"
    },
    "repomix": {
      "command": "repomix",
      "args": ["--mcp"],
      "description": "Full codebase context"
    }
  }
}
EOF
    
    log_success "MCP configuration created at $CLAUDE_MCP_FILE"
    
    # Also create Cursor config
    CURSOR_MCP_DIR="$HOME/.cursor"
    mkdir -p "$CURSOR_MCP_DIR"
    
    cat > "$CURSOR_MCP_DIR/mcp.json" << 'EOF'
{
  "mcpServers": {
    "agentmemory": {
      "command": "npx",
      "args": ["-y", "@agentmemory/agentmemory"]
    },
    "basic-memory": {
      "command": "uvx",
      "args": ["basic-memory", "mcp"]
    },
    "hindsight": {
      "command": "hindsight-server"
    },
    "repomix": {
      "command": "repomix",
      "args": ["--mcp"]
    }
  }
}
EOF
    
    log_success "Cursor MCP configuration created at $CURSOR_MCP_DIR/mcp.json"
}

# ============================================
# VERIFY INSTALLATION
# ============================================

verify_installation() {
    log_info "Verifying installation..."
    
    echo ""
    echo "========================================"
    echo "  AI Evolution Stack - Status Check"
    echo "========================================"
    echo ""
    
    # Check each tool
    TOOLS=(
        "agentmemory:agentmemory"
        "basic-memory:basic-memory"
        "mempalace:mempalace"
        "hindsight:hindsight-server"
        "mex:mex"
        "repomix:repomix"
    )
    
    for tool_info in "${TOOLS[@]}"; do
        IFS=':' read -r name cmd <<< "$tool_info"
        if command_exists "$cmd"; then
            log_success "$name: ✓ Installed"
        else
            log_error "$name: ✗ Not found"
        fi
    done
    
    # Check homunculus separately
    if [ -d "$HOME/.homunculus" ]; then
        log_success "homunculus: ✓ Installed"
    else
        log_warn "homunculus: Not installed (optional)"
    fi
    
    echo ""
    echo "========================================"
    echo ""
}

# ============================================
# MAIN MENU
# ============================================

show_menu() {
    echo ""
    echo "🧠 AI Evolution Stack Installer"
    echo "================================"
    echo ""
    echo "What would you like to install?"
    echo ""
    echo "  1) Everything (recommended)"
    echo "  2) Core only (agentmemory + basic-memory + mex + repomix)"
    echo "  3) Memory layer only"
    echo "  4) Project context only"
    echo "  5) Individual selection"
    echo "  6) Just setup MCP configuration"
    echo "  7) Verify existing installation"
    echo "  8) Exit"
    echo ""
}

install_everything() {
    log_info "Installing everything..."
    install_agentmemory
    install_basic_memory
    install_mempalace
    install_hindsight
    install_mex
    install_repomix
    install_homunculus
    setup_mcp
    verify_installation
    log_success "Installation complete! 🎉"
}

install_core() {
    log_info "Installing core tools..."
    install_agentmemory
    install_basic_memory
    install_mex
    install_repomix
    setup_mcp
    verify_installation
    log_success "Core installation complete! 🎉"
}

install_memory_layer() {
    log_info "Installing memory layer..."
    install_agentmemory
    install_basic_memory
    install_mempalace
    install_hindsight
    setup_mcp
    verify_installation
    log_success "Memory layer installation complete! 🎉"
}

install_project_context() {
    log_info "Installing project context tools..."
    install_mex
    install_repomix
    setup_mcp
    verify_installation
    log_success "Project context installation complete! 🎉"
}

individual_selection() {
    echo ""
    echo "Select tools to install (y/n):"
    echo ""
    
    read -p "Install agentmemory? (y/N): " INSTALL_AGENTMEMORY
    read -p "Install Basic Memory? (y/N): " INSTALL_BASIC_MEMORY
    read -p "Install MemPalace? (y/N): " INSTALL_MEMPALACE
    read -p "Install Hindsight? (y/N): " INSTALL_HINDSIGHT
    read -p "Install mex? (y/N): " INSTALL_MEX
    read -p "Install Repomix? (y/N): " INSTALL_REPOMIX
    read -p "Install homunculus? (y/N): " INSTALL_HOMUNCULUS
    
    [[ $INSTALL_AGENTMEMORY =~ ^[Yy]$ ]] && install_agentmemory
    [[ $INSTALL_BASIC_MEMORY =~ ^[Yy]$ ]] && install_basic_memory
    [[ $INSTALL_MEMPALACE =~ ^[Yy]$ ]] && install_mempalace
    [[ $INSTALL_HINDSIGHT =~ ^[Yy]$ ]] && install_hindsight
    [[ $INSTALL_MEX =~ ^[Yy]$ ]] && install_mex
    [[ $INSTALL_REPOMIX =~ ^[Yy]$ ]] && install_repomix
    [[ $INSTALL_HOMUNCULUS =~ ^[Yy]$ ]] && install_homunculus
    
    setup_mcp
    verify_installation
    log_success "Installation complete! 🎉"
}

# ============================================
# MAIN
# ============================================

main() {
    echo ""
    echo "🧠 Welcome to AI Evolution Stack Installer"
    echo "   Everything local. No cloud. Full privacy."
    echo ""
    
    check_dependencies
    
    # If called with arguments, handle them
    case "${1:-}" in
        --everything|-e)
            install_everything
            exit 0
            ;;
        --core|-c)
            install_core
            exit 0
            ;;
        --memory|-m)
            install_memory_layer
            exit 0
            ;;
        --context|-x)
            install_project_context
            exit 0
            ;;
        --mcp)
            setup_mcp
            exit 0
            ;;
        --verify|-v)
            verify_installation
            exit 0
            ;;
        --help|-h)
            echo "Usage: $0 [OPTION]"
            echo ""
            echo "Options:"
            echo "  --everything, -e    Install everything"
            echo "  --core, -c          Install core tools only"
            echo "  --memory, -m        Install memory layer only"
            echo "  --context, -x       Install project context only"
            echo "  --mcp               Setup MCP configuration only"
            echo "  --verify, -v        Verify existing installation"
            echo "  --help, -h          Show this help"
            echo ""
            exit 0
            ;;
    esac
    
    # Interactive menu
    while true; do
        show_menu
        read -p "Enter choice (1-8): " CHOICE
        
        case $CHOICE in
            1) install_everything; break ;;
            2) install_core; break ;;
            3) install_memory_layer; break ;;
            4) install_project_context; break ;;
            5) individual_selection; break ;;
            6) setup_mcp; verify_installation; break ;;
            7) verify_installation; break ;;
            8) log_info "Exiting..."; exit 0 ;;
            *) log_error "Invalid choice. Please try again." ;;
        esac
    done
    
    echo ""
    echo "========================================"
    echo "  🎉 Installation Complete!"
    echo "========================================"
    echo ""
    echo "Next steps:"
    echo "  1. Restart Cursor/Claude Code"
    echo "  2. Check MCP servers are loaded"
    echo "  3. Run 'mex init' in your projects"
    echo "  4. Start building your AI evolution!"
    echo ""
    echo "For help: https://github.com/YOUR_USERNAME/ai-evolution-stack"
    echo ""
}

main "$@"
