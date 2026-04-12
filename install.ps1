# AI Evolution Stack — Windows Installer
# 70+ tools across 22 categories. One script installs everything.
# Works on Windows 10/11 with PowerShell 5.1+

param(
    [switch]$Everything,
    [switch]$Core,
    [switch]$Memory,
    [switch]$Web,
    [switch]$Database,
    [switch]$Agents,
    [switch]$Hermes,
    [switch]$Inference,
    [switch]$Capabilities,
    [switch]$Orchestration,
    [switch]$Observability,
    [switch]$Configure,
    [switch]$MCP,
    [switch]$Verify,
    [switch]$Help
)

# ============================================
# COLORS & LOGGING
# ============================================

function Write-Info    { param($M) Write-Host "  [INFO] $M" -ForegroundColor Cyan }
function Write-Success { param($M) Write-Host "  [OK]   $M" -ForegroundColor Green }
function Write-Warn    { param($M) Write-Host "  [WARN] $M" -ForegroundColor Yellow }
function Write-Err     { param($M) Write-Host "  [ERR]  $M" -ForegroundColor Red }
function Write-Header  { param($M) Write-Host "`n  === $M ===`n" -ForegroundColor Magenta }

function Test-Command { param($C) $null -ne (Get-Command $C -ErrorAction SilentlyContinue) }

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# ============================================
# CHECK DEPENDENCIES
# ============================================

function Check-Dependencies {
    Write-Header "Checking Dependencies"

    $missing = @()
    if (-not (Test-Command "node"))   { $missing += "Node.js (https://nodejs.org)" }
    if (-not (Test-Command "npm"))    { $missing += "npm" }
    if (-not (Test-Command "python")) { $missing += "Python (https://python.org)" }
    if (-not (Test-Command "pip"))    { $missing += "pip" }
    if (-not (Test-Command "git"))    { $missing += "git (https://git-scm.com)" }

    if ($missing.Count -gt 0) {
        Write-Err "Missing dependencies:"
        $missing | ForEach-Object { Write-Host "    - $_" -ForegroundColor Red }
        exit 1
    }

    if (Test-Command "uv")  { Write-Success "uv: found (fast Python installer)" }
    else                    { Write-Warn "uv: not found (will use pip)" }

    Write-Success "All required dependencies found!"
}

# ============================================
# HELPERS
# ============================================

function Safe-PipInstall {
    param($Pkg)
    Write-Info "Installing $Pkg via pip..."
    pip install --quiet $Pkg 2>$null
    if ($LASTEXITCODE -eq 0) { Write-Success "$Pkg installed!" }
    else { Write-Warn "$Pkg install may have failed — check manually" }
}

function Safe-NpmInstall {
    param($Pkg)
    Write-Info "Installing $Pkg via npm..."
    npm install -g $Pkg 2>$null
    if ($LASTEXITCODE -eq 0) { Write-Success "$Pkg installed!" }
    else { Write-Warn "$Pkg install may have failed — check manually" }
}

# ============================================
# MEMORY LAYER
# ============================================

function Install-MemoryLayer {
    Write-Header "Memory Layer"

    Safe-NpmInstall "@agentmemory/agentmemory"
    Safe-PipInstall "basic-memory"
    Safe-PipInstall "mempalace"
    Safe-PipInstall "hindsight-server"
}

# ============================================
# PROJECT CONTEXT & CODEBASE INTELLIGENCE
# ============================================

function Install-ProjectContext {
    Write-Header "Project Context & Codebase Intelligence"

    # Graphify — 71.5x token reduction, Karpathy LLM Wiki pattern
    Safe-PipInstall "graphifyy"
    Write-Host "Run 'graphify install' after installation to add Claude Code skill" -ForegroundColor Cyan

    # code-review-graph — 49x token reduction
    Safe-PipInstall "code-review-graph"

    Safe-NpmInstall "repomix"
    Safe-NpmInstall "mex-cli"
}

# ============================================
# CODE SEARCH
# ============================================

function Install-CodeSearch {
    Write-Header "Code Search & Navigation"

    Safe-PipInstall "mcp-ragex"
    Write-Info "Repomix also serves as code search (see Project Context)"
}

# ============================================
# WEB & BROWSER
# ============================================

function Install-WebBrowser {
    Write-Header "Web & Browser"

    Write-Success "Fetch MCP: runs via npx (no global install needed)"
    Write-Success "Playwright MCP: runs via npx (no global install needed)"
    Write-Info "Brave Search MCP: get free API key at https://brave.com/search/api/"
    Write-Info "  Set BRAVE_API_KEY in your mcp.json"
    Write-Success "Brave Search MCP: runs via npx (no global install needed)"
}

# ============================================
# FILE SYSTEM
# ============================================

function Install-FileSystem {
    Write-Header "File System"

    Write-Success "Filesystem MCP: runs via npx (no global install needed)"
    Write-Info "Installing Desktop Commander..."
    npx -y @wonderwhy-er/desktop-commander setup 2>$null
    Write-Success "Desktop Commander: available via npx"
}

# ============================================
# DATABASE
# ============================================

function Install-Database {
    Write-Header "Database"

    Write-Info "SQLite MCP: use 'uvx mcp-server-sqlite --db-path ./db.sqlite'"
    if (Test-Command "uv") {
        uv tool install mcp-server-sqlite 2>$null
        Write-Success "SQLite MCP installed via uv"
    } else {
        Safe-PipInstall "mcp-server-sqlite"
    }
    Write-Success "Postgres MCP: runs via npx (configure connection in mcp.json)"
}

# ============================================
# GIT & GITHUB
# ============================================

function Install-GitTools {
    Write-Header "Git & GitHub"

    if (Test-Command "uv") {
        uv tool install mcp-server-git 2>$null
        Write-Success "Git MCP installed via uv"
    } else {
        Safe-PipInstall "mcp-server-git"
    }

    Write-Info "GitHub MCP requires a Personal Access Token"
    Write-Info "  Generate at: https://github.com/settings/tokens"
    Write-Info "  Then: claude mcp add github --transport http --url https://api.githubcopilot.com/mcp/ --header 'Authorization: Bearer YOUR_PAT'"
}

# ============================================
# TERMINAL & SHELL
# ============================================

function Install-Terminal {
    Write-Header "Terminal & Shell"

    Write-Info "Desktop Commander covers terminal (see File System)"
    Safe-PipInstall "mcp-shell-server"
}

# ============================================
# IMAGE & VISION
# ============================================

function Install-ImageVision {
    Write-Header "Image & Vision"

    Safe-PipInstall "screenshot-mcp-server"
    Write-Info "mcp-vision requires Ollama with a vision model"
    Write-Info "  After installing Ollama: ollama pull llava"
}

# ============================================
# TASK & PROJECT MANAGEMENT
# ============================================

function Install-TaskManagement {
    Write-Header "Task & Project Management"

    Write-Info "Notion MCP: configure via https://developers.notion.com/"
    Write-Info "Jira MCP: pip install jira-mcp-server (requires Jira credentials)"
}

# ============================================
# SECURITY & SECRETS
# ============================================

function Install-Security {
    Write-Header "Security & Secrets"

    Safe-PipInstall "mcp-secrets-vault"
    Write-Info "HashiCorp Vault MCP: see https://github.com/hashicorp/vault-mcp-server"
}

# ============================================
# PERSONAL EVOLUTION
# ============================================

function Install-Homunculus {
    Write-Info "Installing homunculus (pattern learning)..."
    $dir = "$env:USERPROFILE\.homunculus"
    if (Test-Path $dir) {
        Write-Warn "homunculus already exists at $dir — skipping"
        return
    }
    git clone https://github.com/humanplane/homunculus.git $dir 2>$null
    if (Test-Path $dir) {
        Push-Location $dir
        pip install -e . 2>$null
        Pop-Location
        Write-Success "homunculus installed"
    } else {
        Write-Warn "homunculus clone failed"
    }
}

function Install-Hermes {
    Write-Info "Installing Hermes Agent (self-improving agent by NousResearch)..."
    if (Test-Command "hermes") {
        Write-Success "Hermes Agent already installed"
        return
    }
    # Hermes install script is Linux-only; use pip on Windows
    Safe-PipInstall "hermes-agent"
}

function Install-PersonalEvolution {
    Write-Header "Personal Evolution"
    Install-Homunculus
    Install-Hermes
}

# ============================================
# LOCAL INFERENCE
# ============================================

function Install-Ollama {
    Write-Info "Installing Ollama..."
    if (Test-Command "ollama") {
        Write-Success "Ollama already installed"
    } else {
        Write-Info "Download Ollama from: https://ollama.com/download"
        Write-Info "After install, run: ollama pull qwen2.5-coder:7b"
    }
}

function Install-LocalInference {
    Write-Header "Local Inference"
    Install-Ollama
    Write-Info "LocalAI: docker run -p 8080:8080 localai/localai"
    Write-Info "LM Studio: download from https://lmstudio.ai"
}

# ============================================
# AGENT FRAMEWORKS
# ============================================

function Install-AgentFrameworks {
    Write-Header "Agent Frameworks"
    Install-Hermes
    Safe-PipInstall "crewai"
    Safe-PipInstall "smolagents"
    Safe-PipInstall "agno"
    Safe-NpmInstall "claude-flow"
    Safe-PipInstall "hf-agents"
    Safe-PipInstall "huggingface-skills"
    Write-Info "workflow-orchestration: git clone https://github.com/barkain/claude-code-workflow-orchestration"
}

# ============================================
# ADVANCED MEMORY
# ============================================

function Install-AdvancedMemory {
    Write-Header "Advanced Memory Systems"
    Safe-PipInstall "mem0ai"
    Safe-PipInstall "letta"
    Safe-PipInstall "graphiti-core"
    Safe-PipInstall "cognee"
    Safe-PipInstall "langmem"
    Safe-PipInstall "memclaw"
    Write-Info "MemOS: pip install memos (optional)"
}

# ============================================
# AGENT CAPABILITIES
# ============================================

function Install-Capabilities {
    Write-Header "Agent Capabilities"
    Safe-PipInstall "composio-core"
    Safe-PipInstall "browser-use"
    Safe-PipInstall "e2b-code-interpreter"
    Safe-PipInstall "open-interpreter"
    Safe-PipInstall "pipecat-ai"
}

# ============================================
# ORCHESTRATION, EVAL, GUARDRAILS, OBSERVABILITY
# ============================================

function Install-Orchestration {
    Write-Header "Agent Orchestration"
    Safe-PipInstall "langgraph"
    Safe-PipInstall "temporalio"
    Write-Info "A2A Protocol: see https://github.com/a2aproject/A2A"
}

function Install-Evaluation {
    Write-Header "Agent Evaluation"
    Safe-PipInstall "deepeval"
    Safe-PipInstall "inspect-ai"
}

function Install-Guardrails {
    Write-Header "Agent Guardrails"
    Safe-PipInstall "nemoguardrails"
    Write-Info "LlamaFirewall: see https://github.com/meta-llama/PurpleLlama"
}

function Install-Observability {
    Write-Header "Agent Observability"
    Safe-PipInstall "agentops"
    Safe-PipInstall "arize-phoenix"
    Safe-PipInstall "langfuse"
}

# ============================================
# HERMES ECOSYSTEM
# ============================================

function Install-HermesEcosystem {
    Write-Header "Hermes Ecosystem"
    Install-Hermes
    Write-Info "hermes-CCC: git clone https://github.com/AlexAI-MCP/hermes-CCC.git"
    Write-Info "hermes-workspace: git clone https://github.com/outsourc-e/hermes-workspace.git"
    Write-Info "self-evolution: git clone https://github.com/NousResearch/hermes-agent-self-evolution.git"
    Write-Info "awesome-hermes-agent: https://github.com/0xNyk/awesome-hermes-agent"
    Write-Info "Skill packs: browse at hermes-agent.nousresearch.com/docs/skills"
}

# ============================================
# INTERACTIVE CONFIGURATION WIZARD
# ============================================

function Configure-Secrets {
    Write-Header "Configuration Wizard"
    Write-Host ""
    Write-Host "  This will walk you through setting up API keys and secrets." -ForegroundColor White
    Write-Host "  Press Enter to skip any you don't have yet." -ForegroundColor White
    Write-Host ""

    $envFile = "$ScriptDir\.env"
    "" | Out-File -FilePath $envFile -Encoding utf8

    # Brave Search
    Write-Host "  1/6 - Brave Search API" -ForegroundColor Cyan
    Write-Info "Free key at: https://brave.com/search/api/"
    $braveKey = Read-Host "  Brave API Key (Enter to skip)"
    if ($braveKey) {
        "BRAVE_API_KEY=$braveKey" | Add-Content $envFile
        Write-Success "Brave Search key saved"
    } else { Write-Warn "Skipped" }

    # GitHub PAT
    Write-Host "`n  2/6 - GitHub Personal Access Token" -ForegroundColor Cyan
    Write-Info "Generate at: https://github.com/settings/tokens"
    $ghPat = Read-Host "  GitHub PAT (Enter to skip)"
    if ($ghPat) {
        "GITHUB_PAT=$ghPat" | Add-Content $envFile
        Write-Success "GitHub PAT saved"
    } else { Write-Warn "Skipped" }

    # Hermes provider
    Write-Host "`n  3/6 - Hermes Agent LLM Provider" -ForegroundColor Cyan
    $hermesProvider = Read-Host "  Provider (ollama/anthropic/openai) [ollama]"
    if (-not $hermesProvider) { $hermesProvider = "ollama" }
    "HERMES_PROVIDER=$hermesProvider" | Add-Content $envFile

    if ($hermesProvider -eq "anthropic") {
        $anthKey = Read-Host "  Anthropic API Key"
        if ($anthKey) { "ANTHROPIC_API_KEY=$anthKey" | Add-Content $envFile }
    } elseif ($hermesProvider -eq "openai") {
        $oaiKey = Read-Host "  OpenAI API Key"
        if ($oaiKey) { "OPENAI_API_KEY=$oaiKey" | Add-Content $envFile }
    } else {
        Write-Success "Using Ollama (local) - no API key needed"
    }

    # Ollama models
    Write-Host "`n  4/6 - Ollama Model Selection" -ForegroundColor Cyan
    Write-Host "  1) qwen2.5-coder:7b (4GB)"
    Write-Host "  2) qwen2.5-coder:32b (20GB)"
    Write-Host "  3) llama3.3:8b (5GB)"
    Write-Host "  4) nomic-embed-text (300MB)"
    Write-Host "  5) llava (4GB, vision)"
    Write-Host "  6) All  7) Skip"
    $modelChoice = Read-Host "  Choice [1,4]"
    if (-not $modelChoice) { $modelChoice = "1,4" }
    "OLLAMA_MODELS=$modelChoice" | Add-Content $envFile

    # DB path
    Write-Host "`n  5/6 - Default SQLite Database Path" -ForegroundColor Cyan
    $dbPath = Read-Host "  Path [./data.db]"
    if (-not $dbPath) { $dbPath = "./data.db" }
    "SQLITE_DB_PATH=$dbPath" | Add-Content $envFile

    # Postgres
    Write-Host "`n  6/6 - PostgreSQL Connection (optional)" -ForegroundColor Cyan
    $pgConn = Read-Host "  Connection string (Enter to skip)"
    if ($pgConn) { "POSTGRES_CONNECTION=$pgConn" | Add-Content $envFile }

    # Apply to mcp.json
    $mcpContent = Get-Content "$ScriptDir\mcp.json" -Raw
    if ($braveKey) { $mcpContent = $mcpContent -replace "YOUR_BRAVE_API_KEY", $braveKey }
    if ($dbPath -ne "./data.db") { $mcpContent = $mcpContent -replace "\./data\.db", $dbPath }
    if ($pgConn) { $mcpContent = $mcpContent -replace "postgresql://localhost/mydb", $pgConn }
    $mcpContent | Out-File "$ScriptDir\mcp.json" -Encoding utf8

    # Ensure .env in .gitignore
    $gitignore = "$ScriptDir\.gitignore"
    if (Test-Path $gitignore) {
        $content = Get-Content $gitignore -Raw
        if ($content -notmatch "\.env") { ".env" | Add-Content $gitignore }
    }

    Write-Success "Configuration saved to $envFile"
    Write-Info "Re-run with -Configure to update later"
}

# ============================================
# MCP CONFIGURATION
# ============================================

function Setup-MCP {
    Write-Header "MCP Configuration"

    # Claude Code
    $claudeDir = "$env:USERPROFILE\.claude"
    New-Item -ItemType Directory -Force -Path $claudeDir | Out-Null

    $claudeFile = "$claudeDir\mcp.json"
    if (Test-Path $claudeFile) {
        $backup = "mcp.json.backup.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Copy-Item $claudeFile "$claudeDir\$backup"
        Write-Warn "Backed up existing Claude mcp.json"
    }

    Copy-Item "$ScriptDir\mcp.json" $claudeFile -Force
    Write-Success "Claude Code MCP config installed at $claudeFile"

    # Cursor
    $cursorDir = "$env:APPDATA\Cursor"
    New-Item -ItemType Directory -Force -Path $cursorDir | Out-Null
    if (Test-Path "$ScriptDir\examples\cursor-mcp.json") {
        Copy-Item "$ScriptDir\examples\cursor-mcp.json" "$cursorDir\mcp.json" -Force
    } else {
        Copy-Item "$ScriptDir\mcp.json" "$cursorDir\mcp.json" -Force
    }
    Write-Success "Cursor MCP config installed at $cursorDir\mcp.json"
}

# ============================================
# VERIFY INSTALLATION
# ============================================

function Verify-Installation {
    Write-Header "Installation Status"

    $tools = @(
        @{Cat="Memory";       Name="agentmemory";    Cmd="agentmemory"},
        @{Cat="Memory";       Name="basic-memory";   Cmd="basic-memory"},
        @{Cat="Memory";       Name="mempalace";      Cmd="mempalace"},
        @{Cat="Memory";       Name="hindsight";      Cmd="hindsight-server"},
        @{Cat="Context";      Name="repomix";        Cmd="repomix"},
        @{Cat="Context";      Name="mex";            Cmd="mex"},
        @{Cat="Evolution";    Name="hermes";         Cmd="hermes"},
        @{Cat="Inference";    Name="ollama";         Cmd="ollama"},
        @{Cat="Frameworks";   Name="crewai";         Cmd="crewai"}
    )

    $lastCat = ""
    foreach ($t in $tools) {
        if ($t.Cat -ne $lastCat) {
            Write-Host "`n  -- $($t.Cat) --" -ForegroundColor Cyan
            $lastCat = $t.Cat
        }
        if (Test-Command $t.Cmd) {
            Write-Host "    $($t.Name): Installed" -ForegroundColor Green
        } else {
            Write-Host "    $($t.Name): Not found" -ForegroundColor Red
        }
    }

    # homunculus
    Write-Host "`n  -- Evolution --" -ForegroundColor Cyan
    if (Test-Path "$env:USERPROFILE\.homunculus") {
        Write-Host "    homunculus: Installed" -ForegroundColor Green
    } else {
        Write-Host "    homunculus: Not installed" -ForegroundColor Yellow
    }

    Write-Host "`n  -- MCP Servers (via npx) --" -ForegroundColor Cyan
    @("fetch","playwright","brave-search","filesystem","desktop-commander","postgres") | ForEach-Object {
        Write-Host "    ${_}: available (on-demand)" -ForegroundColor Green
    }

    # MCP config
    if (Test-Path "$env:USERPROFILE\.claude\mcp.json") {
        Write-Host "`n  Claude Code MCP config: found" -ForegroundColor Green
    } else {
        Write-Host "`n  Claude Code MCP config: not found" -ForegroundColor Yellow
    }

    Write-Host ""
}

# ============================================
# INSTALL EVERYTHING
# ============================================

function Install-Everything {
    Install-MemoryLayer
    Install-AdvancedMemory
    Install-ProjectContext
    Install-CodeSearch
    Install-WebBrowser
    Install-FileSystem
    Install-Database
    Install-GitTools
    Install-Terminal
    Install-ImageVision
    Install-TaskManagement
    Install-Security
    Install-PersonalEvolution
    Install-LocalInference
    Install-AgentFrameworks
    Install-Capabilities
    Install-Orchestration
    Install-Evaluation
    Install-Guardrails
    Install-Observability
    Install-HermesEcosystem
    Setup-MCP
    Verify-Installation
}

function Install-Core {
    Install-MemoryLayer
    Install-ProjectContext
    Install-CodeSearch
    Setup-MCP
    Verify-Installation
}

# ============================================
# INTERACTIVE MENU
# ============================================

function Show-Menu {
    Write-Host ""
    Write-Host "  AI Evolution Stack Installer" -ForegroundColor Cyan
    Write-Host "  70+ tools across 22 categories" -ForegroundColor White
    Write-Host ""
    Write-Host "  1)  Everything (recommended)"
    Write-Host "  2)  Core only (memory + context + code search + MCP)"
    Write-Host ""
    Write-Host "  -- Foundation --"
    Write-Host "  3)  Memory layer (agentmemory, basic-memory, mempalace, hindsight)"
    Write-Host "  4)  Advanced memory (Mem0, Letta, Graphiti, Cognee, LangMem, MemClaw)"
    Write-Host "  5)  Project context (repomix, mex)"
    Write-Host "  6)  Local inference (ollama, localai, hf-agents)"
    Write-Host ""
    Write-Host "  -- Tools --"
    Write-Host "  7)  Web & browser"
    Write-Host "  8)  Database (sqlite, postgres)"
    Write-Host "  9)  Git & GitHub"
    Write-Host "  10) Agent capabilities (composio, e2b, voice, browser-use)"
    Write-Host ""
    Write-Host "  -- Agents --"
    Write-Host "  11) Agent frameworks (hermes, crewai, claude-flow, smolagents)"
    Write-Host "  12) Hermes ecosystem"
    Write-Host "  13) Orchestration (langgraph, temporal)"
    Write-Host ""
    Write-Host "  -- Quality --"
    Write-Host "  14) Evaluation + Guardrails + Observability"
    Write-Host ""
    Write-Host "  -- Config --"
    Write-Host "  15) Configure secrets & API keys (interactive wizard)"
    Write-Host "  16) Setup MCP configuration only"
    Write-Host "  17) Verify installation"
    Write-Host "  18) Exit"
    Write-Host ""
}

# ============================================
# MAIN
# ============================================

function Main {
    Write-Host ""
    Write-Host "  AI Evolution Stack" -ForegroundColor Cyan
    Write-Host "  The Definitive Local-First AI Toolkit" -ForegroundColor White
    Write-Host "  70+ tools. 22 categories. One script." -ForegroundColor White
    Write-Host ""

    if ($Help) {
        Write-Host "Usage: .\install.ps1 [OPTION]"
        Write-Host ""
        Write-Host "  -Everything    Install all 30+ tools"
        Write-Host "  -Core          Memory + context + code search"
        Write-Host "  -Memory        Memory layer only"
        Write-Host "  -Web           Web & browser tools"
        Write-Host "  -Database      Database tools"
        Write-Host "  -Agents        Agent frameworks"
        Write-Host "  -Inference     Local inference"
        Write-Host "  -MCP           Setup MCP configuration only"
        Write-Host "  -Verify        Check what's installed"
        exit 0
    }

    Check-Dependencies

    if ($Everything)     { Install-Everything; return }
    if ($Core)           { Install-Core; return }
    if ($Memory)         { Install-MemoryLayer; Install-AdvancedMemory; return }
    if ($Web)            { Install-WebBrowser; return }
    if ($Database)       { Install-Database; return }
    if ($Agents)         { Install-AgentFrameworks; return }
    if ($Hermes)         { Install-HermesEcosystem; return }
    if ($Inference)      { Install-LocalInference; return }
    if ($Capabilities)   { Install-Capabilities; return }
    if ($Orchestration)  { Install-Orchestration; return }
    if ($Observability)  { Install-Observability; Install-Evaluation; Install-Guardrails; return }
    if ($Configure)      { Configure-Secrets; return }
    if ($MCP)            { Setup-MCP; return }
    if ($Verify)         { Verify-Installation; return }

    # Interactive
    while ($true) {
        Show-Menu
        $choice = Read-Host "  Enter choice (1-13)"

        switch ($choice) {
            "1"  { Install-Everything; break }
            "2"  { Install-Core; break }
            "3"  { Install-MemoryLayer; break }
            "4"  { Install-AdvancedMemory; break }
            "5"  { Install-ProjectContext; break }
            "6"  { Install-LocalInference; break }
            "7"  { Install-WebBrowser; break }
            "8"  { Install-Database; break }
            "9"  { Install-GitTools; break }
            "10" { Install-Capabilities; break }
            "11" { Install-AgentFrameworks; break }
            "12" { Install-HermesEcosystem; break }
            "13" { Install-Orchestration; break }
            "14" { Install-Evaluation; Install-Guardrails; Install-Observability; break }
            "15" { Configure-Secrets; break }
            "16" { Setup-MCP; break }
            "17" { Verify-Installation; continue }
            "18" { Write-Info "Exiting..."; exit 0 }
            default { Write-Err "Invalid choice" }
        }

        if ($choice -in @("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16")) { break }
    }

    Write-Host ""
    Write-Host "  Installation Complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Next steps:"
    Write-Host "  1. Restart Cursor / Claude Code"
    Write-Host "  2. Check MCP servers: claude mcp list"
    Write-Host "  3. Run 'mex init' in your projects"
    Write-Host "  4. Try: ollama run qwen2.5-coder:7b"
    Write-Host ""
    Write-Host "  Docs: https://github.com/Yousifus/ai-evolution-stack"
    Write-Host ""
}

Main
