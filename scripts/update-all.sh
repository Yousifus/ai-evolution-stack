#!/bin/bash

# Update all AI Evolution Stack tools

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }

echo ""
echo "Updating AI Evolution Stack..."
echo ""

# npm packages
log_info "Updating npm packages..."
npm update -g @agentmemory/agentmemory mex-cli repomix 2>/dev/null || log_warn "npm update failed for some packages"

# pip packages
log_info "Updating pip packages..."
pip3 install --upgrade --quiet mempalace hindsight-server basic-memory mcp-ragex mcp-shell-server screenshot-mcp-server mcp-secrets-vault crewai 2>/dev/null || log_warn "pip update failed for some packages"

# Hermes
if command -v hermes >/dev/null 2>&1; then
    log_info "Updating Hermes Agent..."
    pip3 install --upgrade --quiet hermes-agent 2>/dev/null || log_warn "Hermes update failed"
fi

# homunculus
if [ -d "$HOME/.homunculus" ]; then
    log_info "Updating homunculus..."
    cd "$HOME/.homunculus" && git pull 2>/dev/null && pip3 install -e . 2>/dev/null || log_warn "homunculus update failed"
fi

# Ollama models
if command -v ollama >/dev/null 2>&1; then
    log_info "Updating Ollama models..."
    ollama pull qwen2.5-coder:7b 2>/dev/null || true
    ollama pull nomic-embed-text 2>/dev/null || true
fi

echo ""
log_success "All tools updated!"
echo ""
