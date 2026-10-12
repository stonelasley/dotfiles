# PowerShell Functions
# Windows equivalent of zsh/functions

# ============================================
# Directory Functions
# ============================================

# Create and enter directory
function mkcd {
    param([string]$Path)
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    Set-Location $Path
}

# Find files by name
function ff {
    param([string]$Pattern)
    if (Get-Command fd -ErrorAction SilentlyContinue) {
        fd $Pattern
    } else {
        Get-ChildItem -Recurse -Filter "*$Pattern*" | Select-Object FullName
    }
}

# ============================================
# Git Functions
# ============================================

# Git status in all subdirectories
function gsa {
    Get-ChildItem -Directory | ForEach-Object {
        if (Test-Path "$_/.git") {
            Write-Host "`n$($_.Name):" -ForegroundColor Cyan
            Push-Location $_
            git status -s
            Pop-Location
        }
    }
}

# Create feature branch (equivalent to bF alias in gitconfig)
function git-feature {
    param([string]$Name)
    git checkout -b "feature/$Name"
}

# Create bugfix branch (equivalent to bB alias in gitconfig)
function git-bugfix {
    param([string]$Name)
    git checkout -b "bugfix/$Name"
}

# Create chore branch (equivalent to bC alias in gitconfig)
function git-chore {
    param([string]$Name)
    git checkout -b "chore/$Name"
}

# ============================================
# Process & System Functions
# ============================================

# Find process by name
function pgrep {
    param([string]$Name)
    Get-Process | Where-Object { $_.Name -like "*$Name*" }
}

# Kill process by name
function pkill {
    param([string]$Name)
    Get-Process | Where-Object { $_.Name -like "*$Name*" } | Stop-Process -Force
}

# Get disk usage (like 'du')
function diskusage {
    param([string]$Path = ".")
    if (Get-Command dust -ErrorAction SilentlyContinue) {
        dust $Path
    } else {
        Get-ChildItem -Path $Path -Recurse -File |
            Measure-Object -Property Length -Sum |
            Select-Object @{Name="Size(MB)";Expression={[math]::Round($_.Sum / 1MB, 2)}}
    }
}

# ============================================
# Network Functions
# ============================================

# Get public IP
function myip {
    (Invoke-WebRequest -Uri "https://api.ipify.org").Content
}

# Get local IP
function localip {
    Get-NetIPAddress -AddressFamily IPv4 |
        Where-Object { $_.InterfaceAlias -notlike "*Loopback*" } |
        Select-Object IPAddress, InterfaceAlias
}

# Test internet connectivity
function nettest {
    Test-Connection -ComputerName google.com -Count 4
}

# ============================================
# Development Functions
# ============================================

# Quick server (Python HTTP server equivalent)
function serve {
    param([int]$Port = 8000)
    if (Get-Command python -ErrorAction SilentlyContinue) {
        Write-Host "Starting server on http://localhost:$Port" -ForegroundColor Green
        python -m http.server $Port
    } else {
        Write-Host "Python not found. Install via: scoop install python" -ForegroundColor Red
    }
}

# Count lines of code in current directory
function loc {
    if (Get-Command tokei -ErrorAction SilentlyContinue) {
        tokei
    } else {
        Write-Host "Install tokei for better code statistics: scoop install tokei" -ForegroundColor Yellow
        (Get-ChildItem -Recurse -File | Measure-Object).Count
    }
}

# ============================================
# Utility Functions
# ============================================

# Extract archives (supports zip, tar, etc.)
function extract {
    param([string]$Path)

    if (-not (Test-Path $Path)) {
        Write-Host "File not found: $Path" -ForegroundColor Red
        return
    }

    $extension = [System.IO.Path]::GetExtension($Path)

    switch ($extension) {
        ".zip" { Expand-Archive -Path $Path -DestinationPath . }
        ".tar" { tar -xf $Path }
        ".gz"  { tar -xzf $Path }
        ".tgz" { tar -xzf $Path }
        default { Write-Host "Unsupported archive format: $extension" -ForegroundColor Red }
    }
}

# Create backup of file
function backup {
    param([string]$Path)
    if (Test-Path $Path) {
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $backup = "$Path.$timestamp.bak"
        Copy-Item $Path $backup
        Write-Host "Backup created: $backup" -ForegroundColor Green
    } else {
        Write-Host "File not found: $Path" -ForegroundColor Red
    }
}

# ============================================
# FZF Integration Functions
# ============================================

# Change directory with fzf
function cdf {
    $dir = Get-ChildItem -Directory -Recurse |
        ForEach-Object { $_.FullName } |
        fzf
    if ($dir) { Set-Location $dir }
}

# Open file with Neovim using fzf
function vf {
    $file = Get-ChildItem -Recurse -File |
        ForEach-Object { $_.FullName } |
        fzf
    if ($file) { nvim $file }
}

# ============================================
# Dotfiles Management
# ============================================

# Quick access to dotfiles
function dotfiles {
    Set-Location "$env:USERPROFILE\dotfiles"
}

# Edit dotfiles config
function editdot {
    Set-Location "$env:USERPROFILE\dotfiles"
    nvim .
}

# ============================================
# Claude Code
# ============================================

# Upgrade Claude Code via winget
function claude-upgrade {
    winget upgrade Anthropic.ClaudeCode @args
}

# Launch Claude Code, upgrading it first at most once a day.
# Upgrades must happen before launch: Windows locks claude.exe while it runs.
function claude {
    $stamp = "$env:LOCALAPPDATA\claude-upgrade.stamp"
    $last = if (Test-Path $stamp) { (Get-Item $stamp).LastWriteTime } else { [datetime]::MinValue }
    if ($last.Date -lt (Get-Date).Date) {
        Write-Host "Checking for Claude Code updates..." -ForegroundColor DarkGray
        claude-upgrade --silent --accept-source-agreements --accept-package-agreements | Out-Host
        New-Item -ItemType File -Path $stamp -Force | Out-Null
    }
    & (Get-Command claude -CommandType Application | Select-Object -First 1).Source @args
}
