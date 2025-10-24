# PowerShell Environment Variables
# Windows equivalent of environment setup in .zshrc

# ============================================
# Development Environment
# ============================================

# .NET Configuration
$env:DOTNET_ROOT = "$env:USERPROFILE\.dotnet"
$env:ASPNETCORE_ENVIRONMENT = "Development"
$env:DOTNET_CLI_TELEMETRY_OPTOUT = "1"  # Disable telemetry

# ============================================
# XDG Base Directory (for cross-platform tools)
# ============================================

$env:XDG_CONFIG_HOME = "$env:LOCALAPPDATA"
$env:XDG_DATA_HOME = "$env:LOCALAPPDATA"
$env:XDG_CACHE_HOME = "$env:TEMP"

# ============================================
# Tool-specific Configuration
# ============================================

# Neovim
$env:EDITOR = "nvim"
$env:VISUAL = "nvim"

# FZF Configuration
$env:FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border"

# Use ripgrep for FZF if available
if (Get-Command rg -ErrorAction SilentlyContinue) {
    $env:FZF_DEFAULT_COMMAND = "rg --files --hidden --follow --glob '!.git'"
    $env:FZF_CTRL_T_COMMAND = $env:FZF_DEFAULT_COMMAND
}

# Bat (better cat) theme
$env:BAT_THEME = "Monokai Extended"

# ============================================
# PATH Management
# ============================================

# Add custom bin directories to PATH
$paths = @(
    "$env:USERPROFILE\.local\bin",
    "$env:USERPROFILE\.cargo\bin",
    "$env:USERPROFILE\go\bin"
)

foreach ($path in $paths) {
    if ((Test-Path $path) -and ($env:PATH -notlike "*$path*")) {
        $env:PATH = "$path;$env:PATH"
    }
}

# ============================================
# Development Shortcuts
# ============================================

# Common project directories (customize these)
$env:DEV = "$env:USERPROFILE\dev"
$env:PROJECTS = "$env:USERPROFILE\projects"

# ============================================
# Language-specific Settings
# ============================================

# Python: Don't create __pycache__ directories
$env:PYTHONDONTWRITEBYTECODE = "1"

# Go: Set GOPATH
if (-not $env:GOPATH) {
    $env:GOPATH = "$env:USERPROFILE\go"
}

# Rust: Cargo home
if (-not $env:CARGO_HOME) {
    $env:CARGO_HOME = "$env:USERPROFILE\.cargo"
}

# ============================================
# OpenAI (if using ChatGPT.nvim or similar)
# ============================================

# Uncomment and set your API key if needed
# $env:OPENAI_API_KEY = "your-api-key-here"

# ============================================
# Windows-specific Settings
# ============================================

# Enable UTF-8 encoding for PowerShell
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8

# ============================================
# Optional: Windows Terminal Integration
# ============================================

# Detect if running in Windows Terminal
if ($env:WT_SESSION) {
    # Running in Windows Terminal
    # Add any Windows Terminal specific configuration here
}
