#!/bin/bash

# Verify AI Evolution Stack Installation
# Checks that all tools are installed and working

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[!]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo ""
echo "========================================"
echo "  AI Evolution Stack - Verification"
echo "========================================"
echo ""

# Track results
INSTALLED=0
MISSING=0
OPTIONAL=0

# ============================================
# CHECK CORE TOOLS
# ============================================

echo "🔧 Core Tools"
echo "-------------"

if command_exists agentmemory; then
    log_success "agentmemory: Installed"
    ((INSTALLED++))
else
    log_error "agentmemory: Not found"
    ((MISSING++))
fi

if command_exists basic-memory; then
    log_success "basic-memory: Installed"
    ((INSTALLED++))
else
    log_error "basic-memory: Not found"
    ((MISSING++))
fi

if command_exists mempalace; then
    log_success "mempalace: Installed"
    ((INSTALLED++))
else
    log_error "mempalace: Not found"
    ((MISSING++))
fi

if command_exists hindsight-server; then
    log_success "hindsight-server: Installed"
    ((INSTALLED++))
else
    log_error "hindsight-server: Not found"
    ((MISSING++))
fi

if command_exists mex; then
    log_success "mex: Installed"
    ((INSTALLED++))
else
    log_error "mex: Not found"
    ((MISSING++))
fi

if command_exists repomix; then
    log_success "repomix: Installed"
    ((INSTALLED++))
else
    log_error "repomix: Not found"
    ((MISSING++))
fi

echo ""

# ============================================
# CHECK OPTIONAL TOOLS
# ============================================

echo "⚡ Optional Tools"
echo "----------------"

if [ -d "$HOME/.homunculus" ]; then
    log_success "homunculus: Installed"
    ((INSTALLED++))
else
    log_warn "homunculus: Not installed (optional)"
    ((OPTIONAL++))
fi

if command_exists lmstudio; then
    log_success "LM Studio: Installed"
    ((INSTALLED++))
else
    log_warn "LM Studio: Not installed (optional)"
    ((OPTIONAL++))
fi

echo ""

# ============================================
# CHECK MCP CONFIGURATION
# ============================================

echo "🔌 MCP Configuration"
echo "--------------------"

CLAUDE_MCP="$HOME/.claude/mcp.json"
CURSOR_MCP="$HOME/.cursor/mcp.json"
LMSTUDIO_MCP="$HOME/.lmstudio/mcp.json"

if [ -f "$CLAUDE_MCP" ]; then
    log_success "Claude Code MCP: Configured"
    ((INSTALLED++))
else
    log_error "Claude Code MCP: Not configured"
    ((MISSING++))
fi

if [ -f "$CURSOR_MCP" ]; then
    log_success "Cursor MCP: Configured"
    ((INSTALLED++))
else
    log_error "Cursor MCP: Not configured"
    ((MISSING++))
fi

if [ -f "$LMSTUDIO_MCP" ]; then
    log_success "LM Studio MCP: Configured"
    ((INSTALLED++))
else
    log_warn "LM Studio MCP: Not configured (optional)"
    ((OPTIONAL++))
fi

echo ""

# ============================================
# SUMMARY
# ============================================

echo "========================================"
echo "  Summary"
echo "========================================"
echo ""
echo -e "Installed: ${GREEN}$INSTALLED${NC}"
echo -e "Missing: ${RED}$MISSING${NC}"
echo -e "Optional (not installed): ${YELLOW}$OPTIONAL${NC}"
echo ""

if [ $MISSING -eq 0 ]; then
    echo -e "${GREEN}✓ All required tools are installed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Restart Cursor/Claude Code"
    echo "  2. Check MCP servers are loaded"
    echo "  3. Run 'mex init' in your projects"
    echo "  4. Start building your AI evolution!"
    exit 0
else
    echo -e "${RED}✗ Some tools are missing.${NC}"
    echo ""
    echo "To install missing tools, run:"
    echo "  ./install.sh"
    exit 1
fi
