#!/bin/bash

# Update all AI Evolution Stack tools

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

echo ""
echo "🔄 Updating AI Evolution Stack..."
echo ""

# Update npm packages
log_info "Updating npm packages..."
npm update -g @agentmemory/agentmemory mex-cli repomix

# Update pip packages
log_info "Updating pip packages..."
pip install --upgrade mempalace hindsight-server basic-memory

# Update homunculus (if installed)
if [ -d "$HOME/.homunculus" ]; then
    log_info "Updating homunculus..."
    cd "$HOME/.homunculus"
    git pull
    pip install -e .
fi

echo ""
log_success "All tools updated!"
echo ""

# Verify
./scripts/verify-install.sh
