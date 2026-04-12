# 🧠 AI Evolution Stack - Windows Installer
# Works on Windows 10/11 with PowerShell 5.1+
# Everything local. No cloud. Full privacy.

param(
    [switch]$Everything,
    [switch]$Core,
    [switch]$Memory,
    [switch]$Context,
    [switch]$MCP,
    [switch]$Verify,
    [switch]$Help
)

# Colors for PowerShell
function Write-Info { param($Message) Write-Host "[INFO] $Message" -ForegroundColor Cyan }
function Write-Success { param($Message) Write-Host "[SUCCESS] $Message" -ForegroundColor Green }
function Write-Warn { param($Message) Write-Host "[WARN] $Message" -ForegroundColor Yellow }
function Write-Error { param($Message) Write-Host "[ERROR] $Message" -ForegroundColor Red }

# Check if command exists
function Test-Command {
    param($Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# ============================================
# CHECK DEPENDENCIES
# ============================================

function Check-Dependencies {
    Write-Info "Checking dependencies..."
    
    $missingDeps = @()
    
    if (-not (Test-Command "node")) {
        $missingDeps += "Node.js"
    }
    
    if (-not (Test-Command "npm")) {
        $missingDeps += "npm"
    }
    
    if (-not (Test-Command "python")) {
        $missingDeps += "Python"
    }
    
    if (-not (Test-Command "pip")) {
        $missingDeps += "pip"
    }
    
    if (-not (Test-Command "git")) {
        $missingDeps += "git"
    }
    
    if ($missingDeps.Count -gt 0) {
        Write-Error "Missing dependencies: $($missingDeps -join ', ')"
        Write-Info "Please install them first:"
        Write-Info "  1. Install Node.js from https://nodejs.org"
        Write-Info "  2. Install Python from https://python.org"
        Write-Info "  3. Install Git from https://git-scm.com"
        exit 1
    }
    
    Write-Success "All dependencies found!"
}

# ============================================
# INSTALL TOOLS
# ============================================

function Install-AgentMemory {
    Write-Info "Installing agentmemory (universal memory)..."
    npm install -g @agentmemory/agentmemory
    Write-Success "agentmemory installed!"
}

function Install-BasicMemory {
    Write-Info "Installing Basic Memory (human-readable knowledge)..."
    
    # Try pip first
    pip install basic-memory
    
    Write-Success "Basic Memory installed!"
}

function Install-MemPalace {
    Write-Info "Installing MemPalace (conversation memory)..."
    pip install mempalace
    Write-Success "MemPalace installed!"
}

function Install-Hindsight {
    Write-Info "Installing Hindsight (knowledge graph)..."
    pip install hindsight-server
    Write-Success "Hindsight installed!"
}

function Install-Mex {
    Write-Info "Installing mex (project documentation)..."
    npm install -g mex-cli
    Write-Success "mex installed!"
}

function Install-Repomix {
    Write-Info "Installing Repomix (codebase packaging)..."
    npm install -g repomix
    Write-Success "Repomix installed!"
}

function Install-Homunculus {
    Write-Info "Installing homunculus (pattern learning)..."
    
    $homunculusDir = "$env:USERPROFILE\.homunculus"
    
    if (Test-Path $homunculusDir) {
        Write-Warn "homunculus already exists at $homunculusDir"
        $reinstall = Read-Host "Reinstall? (y/N)"
        if ($reinstall -match '^[Yy]$') {
            Remove-Item -Recurse -Force $homunculusDir
        } else {
            Write-Info "Skipping homunculus installation"
            return
        }
    }
    
    git clone https://github.com/humanplane/homunculus.git $homunculusDir
    Set-Location $homunculusDir
    pip install -e .
    
    Write-Success "homunculus installed to $homunculusDir"
}

# ============================================
# SETUP MCP CONFIGURATION
# ============================================

function Setup-MCP {
    Write-Info "Setting up MCP configuration..."
    
    $claudeMcpDir = "$env:APPDATA\Claude"
    $claudeMcpFile = "$claudeMcpDir\mcp.json"
    
    # Create directory if it doesn't exist
    New-Item -ItemType Directory -Force -Path $claudeMcpDir | Out-Null
    
    # Backup existing config
    if (Test-Path $claudeMcpFile) {
        $backupName = "mcp.json.backup.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Copy-Item $claudeMcpFile "$claudeMcpDir\$backupName"
        Write-Warn "Backed up existing mcp.json"
    }
    
    # Create new MCP config
    $mcpConfig = @{
        mcpServers = @{
            agentmemory = @{
                command = "npx"
                args = @("-y", "@agentmemory/agentmemory")
                description = "Universal memory for all AI tools"
            }
            "basic-memory" = @{
                command = "python"
                args = @("-m", "basic_memory", "mcp")
                description = "Human-readable knowledge graph"
            }
            hindsight = @{
                command = "hindsight-server"
                env = @{
                    HINDSIGHT_API_LLM_PROVIDER = "ollama"
                }
                description = "Knowledge graph with semantic search"
            }
            repomix = @{
                command = "repomix"
                args = @("--mcp")
                description = "Full codebase context"
            }
        }
    } | ConvertTo-Json -Depth 10
    
    $mcpConfig | Out-File -FilePath $claudeMcpFile -Encoding utf8
    
    Write-Success "MCP configuration created at $claudeMcpFile"
    
    # Also create Cursor config
    $cursorMcpDir = "$env:APPDATA\Cursor"
    New-Item -ItemType Directory -Force -Path $cursorMcpDir | Out-Null
    
    $cursorConfig = @{
        mcpServers = @{
            agentmemory = @{
                command = "npx"
                args = @("-y", "@agentmemory/agentmemory")
            }
            "basic-memory" = @{
                command = "python"
                args = @("-m", "basic_memory", "mcp")
            }
            hindsight = @{
                command = "hindsight-server"
            }
            repomix = @{
                command = "repomix"
                args = @("--mcp")
            }
        }
    } | ConvertTo-Json -Depth 10
    
    $cursorConfig | Out-File -FilePath "$cursorMcpDir\mcp.json" -Encoding utf8
    
    Write-Success "Cursor MCP configuration created at $cursorMcpDir\mcp.json"
}

# ============================================
# VERIFY INSTALLATION
# ============================================

function Verify-Installation {
    Write-Info "Verifying installation..."
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  AI Evolution Stack - Status Check" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    
    $tools = @(
        @{ Name = "agentmemory"; Command = "agentmemory" },
        @{ Name = "basic-memory"; Command = "basic-memory" },
        @{ Name = "mempalace"; Command = "mempalace" },
        @{ Name = "hindsight"; Command = "hindsight-server" },
        @{ Name = "mex"; Command = "mex" },
        @{ Name = "repomix"; Command = "repomix" }
    )
    
    foreach ($tool in $tools) {
        if (Test-Command $tool.Command) {
            Write-Success "$($tool.Name): Installed"
        } else {
            Write-Error "$($tool.Name): Not found"
        }
    }
    
    # Check homunculus separately
    $homunculusDir = "$env:USERPROFILE\.homunculus"
    if (Test-Path $homunculusDir) {
        Write-Success "homunculus: Installed"
    } else {
        Write-Warn "homunculus: Not installed (optional)"
    }
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
}

# ============================================
# MAIN MENU
# ============================================

function Show-Menu {
    Write-Host ""
    Write-Host "🧠 AI Evolution Stack Installer" -ForegroundColor Cyan
    Write-Host "================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "What would you like to install?"
    Write-Host ""
    Write-Host "  1) Everything (recommended)"
    Write-Host "  2) Core only (agentmemory + basic-memory + mex + repomix)"
    Write-Host "  3) Memory layer only"
    Write-Host "  4) Project context only"
    Write-Host "  5) Individual selection"
    Write-Host "  6) Just setup MCP configuration"
    Write-Host "  7) Verify existing installation"
    Write-Host "  8) Exit"
    Write-Host ""
}

function Install-Everything {
    Write-Info "Installing everything..."
    Install-AgentMemory
    Install-BasicMemory
    Install-MemPalace
    Install-Hindsight
    Install-Mex
    Install-Repomix
    Install-Homunculus
    Setup-MCP
    Verify-Installation
    Write-Success "Installation complete! 🎉"
}

function Install-Core {
    Write-Info "Installing core tools..."
    Install-AgentMemory
    Install-BasicMemory
    Install-Mex
    Install-Repomix
    Setup-MCP
    Verify-Installation
    Write-Success "Core installation complete! 🎉"
}

function Install-MemoryLayer {
    Write-Info "Installing memory layer..."
    Install-AgentMemory
    Install-BasicMemory
    Install-MemPalace
    Install-Hindsight
    Setup-MCP
    Verify-Installation
    Write-Success "Memory layer installation complete! 🎉"
}

function Install-ProjectContext {
    Write-Info "Installing project context tools..."
    Install-Mex
    Install-Repomix
    Setup-MCP
    Verify-Installation
    Write-Success "Project context installation complete! 🎉"
}

function Install-Individual {
    Write-Host ""
    Write-Host "Select tools to install (y/n):"
    Write-Host ""
    
    $installAgentMemory = Read-Host "Install agentmemory? (y/N)"
    $installBasicMemory = Read-Host "Install Basic Memory? (y/N)"
    $installMemPalace = Read-Host "Install MemPalace? (y/N)"
    $installHindsight = Read-Host "Install Hindsight? (y/N)"
    $installMex = Read-Host "Install mex? (y/N)"
    $installRepomix = Read-Host "Install Repomix? (y/N)"
    $installHomunculus = Read-Host "Install homunculus? (y/N)"
    
    if ($installAgentMemory -match '^[Yy]$') { Install-AgentMemory }
    if ($installBasicMemory -match '^[Yy]$') { Install-BasicMemory }
    if ($installMemPalace -match '^[Yy]$') { Install-MemPalace }
    if ($installHindsight -match '^[Yy]$') { Install-Hindsight }
    if ($installMex -match '^[Yy]$') { Install-Mex }
    if ($installRepomix -match '^[Yy]$') { Install-Repomix }
    if ($installHomunculus -match '^[Yy]$') { Install-Homunculus }
    
    Setup-MCP
    Verify-Installation
    Write-Success "Installation complete! 🎉"
}

# ============================================
# MAIN
# ============================================

function Main {
    Write-Host ""
    Write-Host "🧠 Welcome to AI Evolution Stack Installer" -ForegroundColor Cyan
    Write-Host "   Everything local. No cloud. Full privacy." -ForegroundColor Cyan
    Write-Host ""
    
    # Handle command-line arguments
    if ($Help) {
        Write-Host "Usage: .\install.ps1 [OPTION]"
        Write-Host ""
        Write-Host "Options:"
        Write-Host "  -Everything    Install everything"
        Write-Host "  -Core          Install core tools only"
        Write-Host "  -Memory        Install memory layer only"
        Write-Host "  -Context       Install project context only"
        Write-Host "  -MCP           Setup MCP configuration only"
        Write-Host "  -Verify        Verify existing installation"
        Write-Host "  -Help          Show this help"
        Write-Host ""
        exit 0
    }
    
    if ($Everything) {
        Check-Dependencies
        Install-Everything
        exit 0
    }
    
    if ($Core) {
        Check-Dependencies
        Install-Core
        exit 0
    }
    
    if ($Memory) {
        Check-Dependencies
        Install-MemoryLayer
        exit 0
    }
    
    if ($Context) {
        Check-Dependencies
        Install-ProjectContext
        exit 0
    }
    
    if ($MCP) {
        Setup-MCP
        exit 0
    }
    
    if ($Verify) {
        Verify-Installation
        exit 0
    }
    
    # Interactive menu
    Check-Dependencies
    
    while ($true) {
        Show-Menu
        $choice = Read-Host "Enter choice (1-8)"
        
        switch ($choice) {
            "1" { Install-Everything; break }
            "2" { Install-Core; break }
            "3" { Install-MemoryLayer; break }
            "4" { Install-ProjectContext; break }
            "5" { Install-Individual; break }
            "6" { Setup-MCP; Verify-Installation; break }
            "7" { Verify-Installation; break }
            "8" { Write-Info "Exiting..."; exit 0 }
            default { Write-Error "Invalid choice. Please try again." }
        }
        
        if ($choice -in @("1", "2", "3", "4", "5", "6")) {
            break
        }
    }
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "  🎉 Installation Complete!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:"
    Write-Host "  1. Restart Cursor/Claude Code"
    Write-Host "  2. Check MCP servers are loaded"
    Write-Host "  3. Run 'mex init' in your projects"
    Write-Host "  4. Start building your AI evolution!"
    Write-Host ""
    Write-Host "For help: https://github.com/YOUR_USERNAME/ai-evolution-stack"
    Write-Host ""
}

Main
