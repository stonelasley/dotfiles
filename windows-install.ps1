#!/usr/bin/env pwsh
# Windows Dotfiles Installation Script
# This script sets up your development environment on Windows
# Run this in PowerShell 5.1+ or PowerShell 7+
#
# Usage: .\windows-install.ps1

#Requires -Version 5.1

param(
    [switch]$SkipPackages,
    [switch]$SkipDotfiles,
    [switch]$SkipShell,
    [switch]$SkipVim,
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

# ============================================
# Helper Functions
# ============================================

function Write-Step {
    param([string]$Message)
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠ $Message" -ForegroundColor Yellow
}

function Write-Failure {
    param([string]$Message)
    Write-Host "✗ $Message" -ForegroundColor Red
}

function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Install-ScoopIfNeeded {
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        Write-Success "Scoop is already installed"
        return
    }

    Write-Step "Installing Scoop package manager"

    # Set execution policy for current user
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

    # Install Scoop
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        Write-Success "Scoop installed successfully"
    } else {
        Write-Failure "Failed to install Scoop"
        exit 1
    }
}

function Install-GitIfNeeded {
    if (Get-Command git -ErrorAction SilentlyContinue) {
        Write-Success "Git is already installed"
        return
    }

    Write-Step "Installing Git via Scoop"
    scoop install git

    if (Get-Command git -ErrorAction SilentlyContinue) {
        Write-Success "Git installed successfully"
    } else {
        Write-Failure "Failed to install Git"
        exit 1
    }
}

# ============================================
# Main Installation Steps
# ============================================

Write-Host @"

╔══════════════════════════════════════════════════╗
║   Windows Dotfiles Installation                  ║
║   Setting up your development environment        ║
╚══════════════════════════════════════════════════╝

"@ -ForegroundColor Cyan

# Check PowerShell version
$psVersion = $PSVersionTable.PSVersion
Write-Host "PowerShell Version: $psVersion"

if ($psVersion.Major -lt 5) {
    Write-Failure "PowerShell 5.1 or higher is required"
    Write-Host "Please upgrade PowerShell: https://aka.ms/powershell"
    exit 1
}

# Get dotfiles directory (where this script is located)
$dotfilesDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host "Dotfiles directory: $dotfilesDir`n"

# ============================================
# Step 1: Install Scoop and Git
# ============================================

Write-Step "Installing prerequisites"
Install-ScoopIfNeeded
Install-GitIfNeeded

# ============================================
# Step 2: Install Packages
# ============================================

if (-not $SkipPackages) {
    Write-Step "Installing packages via Scoop"

    # Add Scoop buckets
    Write-Host "Adding Scoop buckets..."
    $buckets = @('extras', 'nerd-fonts', 'versions')
    foreach ($bucket in $buckets) {
        Write-Host "  Adding bucket: $bucket"
        scoop bucket add $bucket 2>$null
    }
    Write-Success "Buckets added"

    # Core packages
    Write-Host "`nInstalling core packages..."
    $packages = @(
        'fnm',              # Fast Node Manager
        'rustup',           # Rust toolchain
        'neovim',           # Neovim editor
        'ripgrep',          # Better grep
        'fzf',              # Fuzzy finder
        'curl',             # HTTP client
        'sqlite',           # Database
        'lua',              # Lua language
        'luarocks',         # Lua package manager
        'go',               # Go language
        'python',           # Python language
        'cmake',            # Build system
        'ninja',            # Build tool
        'make',             # Build tool
        'dotnet-sdk',       # .NET SDK
        'pwsh',             # PowerShell 7+
        'starship',         # Prompt
        'zoxide',           # Better cd
        'gh',               # GitHub CLI
        'delta',            # Better git diff
        'bat',              # Better cat
        'eza',              # Better ls
        'fd',               # Better find
        'jq',               # JSON processor
        'stylua',           # Lua formatter
        'tree-sitter'       # Parser generator
    )

    foreach ($package in $packages) {
        if (scoop list $package 2>$null) {
            Write-Host "  ✓ $package (already installed)" -ForegroundColor Gray
        } else {
            Write-Host "  Installing $package..." -NoNewline
            $result = scoop install $package 2>&1
            if ($LASTEXITCODE -eq 0) {
                Write-Host " ✓" -ForegroundColor Green
            } else {
                Write-Host " ⚠" -ForegroundColor Yellow
            }
        }
    }

    # Install Nerd Fonts
    Write-Host "`nInstalling Nerd Fonts..."
    $fonts = @('FiraCode-NF', 'CascadiaCode-NF')
    foreach ($font in $fonts) {
        if (scoop list $font 2>$null) {
            Write-Host "  ✓ $font (already installed)" -ForegroundColor Gray
        } else {
            Write-Host "  Installing $font..." -NoNewline
            scoop install $font 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Host " ✓" -ForegroundColor Green
            } else {
                Write-Host " ⚠" -ForegroundColor Yellow
            }
        }
    }

    # Install Python packages
    Write-Host "`nInstalling Python packages..."
    $pips = @('pynvim', 'ansible-lint', 'openai')
    foreach ($pip in $pips) {
        Write-Host "  Installing $pip..." -NoNewline
        python -m pip install $pip --quiet 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host " ✓" -ForegroundColor Green
        } else {
            Write-Host " ⚠" -ForegroundColor Yellow
        }
    }

    Write-Success "Package installation complete"
}

# ============================================
# Step 3: Install PowerShell Modules
# ============================================

if (-not $SkipShell) {
    Write-Step "Installing PowerShell modules"

    $modules = @('PSReadLine', 'PSFzf', 'posh-git', 'Terminal-Icons')
    foreach ($module in $modules) {
        if (Get-Module -ListAvailable -Name $module) {
            Write-Host "  ✓ $module (already installed)" -ForegroundColor Gray
        } else {
            Write-Host "  Installing $module..." -NoNewline
            Install-Module -Name $module -Scope CurrentUser -Force -SkipPublisherCheck -ErrorAction SilentlyContinue
            if (Get-Module -ListAvailable -Name $module) {
                Write-Host " ✓" -ForegroundColor Green
            } else {
                Write-Host " ⚠" -ForegroundColor Yellow
            }
        }
    }

    Write-Success "PowerShell modules installed"
}

# ============================================
# Step 4: Setup Dotfiles (Symlinks)
# ============================================

if (-not $SkipDotfiles) {
    Write-Step "Setting up dotfiles"

    # Create necessary directories
    $configDir = "$env:LOCALAPPDATA"
    $docsDir = "$env:USERPROFILE\Documents\PowerShell"

    New-Item -ItemType Directory -Path $docsDir -Force | Out-Null

    # Link Git configuration
    Write-Host "`nLinking Git configuration..."
    $gitFiles = @('gitconfig', 'gitignore')
    foreach ($file in $gitFiles) {
        $source = "$dotfilesDir\roles\dotfiles\files\$file"
        $target = "$env:USERPROFILE\.$file"

        if (Test-Path $source) {
            if (Test-Path $target) {
                Remove-Item $target -Force -ErrorAction SilentlyContinue
            }

            try {
                New-Item -ItemType SymbolicLink -Path $target -Target $source -Force -ErrorAction Stop | Out-Null
                Write-Host "  ✓ Linked .$file" -ForegroundColor Green
            } catch {
                Write-Host "  ⚠ Could not link .$file (try running as Administrator)" -ForegroundColor Yellow
                Copy-Item $source $target -Force
                Write-Host "    Copied instead of symlinked" -ForegroundColor Yellow
            }
        }
    }

    # Link PowerShell profile
    Write-Host "`nLinking PowerShell profile..."
    $profileSource = "$dotfilesDir\roles\dotfiles-windows\files\Microsoft.PowerShell_profile.ps1"
    $profileTarget = $PROFILE

    if (Test-Path $profileSource) {
        $profileDir = Split-Path $profileTarget -Parent
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null

        if (Test-Path $profileTarget) {
            Remove-Item $profileTarget -Force -ErrorAction SilentlyContinue
        }

        try {
            New-Item -ItemType SymbolicLink -Path $profileTarget -Target $profileSource -Force -ErrorAction Stop | Out-Null
            Write-Host "  ✓ Linked PowerShell profile" -ForegroundColor Green
        } catch {
            Copy-Item $profileSource $profileTarget -Force
            Write-Host "  ⚠ Copied PowerShell profile (try running as Administrator for symlink)" -ForegroundColor Yellow
        }
    }

    # Link PowerShell modules
    Write-Host "`nLinking PowerShell modules..."
    $modulesSource = "$dotfilesDir\roles\dotfiles-windows\files\powershell"
    $modulesTarget = "$docsDir\powershell"

    if (Test-Path $modulesSource) {
        try {
            New-Item -ItemType SymbolicLink -Path $modulesTarget -Target $modulesSource -Force -ErrorAction Stop | Out-Null
            Write-Host "  ✓ Linked PowerShell modules" -ForegroundColor Green
        } catch {
            Copy-Item $modulesSource $modulesTarget -Recurse -Force
            Write-Host "  ⚠ Copied PowerShell modules" -ForegroundColor Yellow
        }
    }

    # Link Starship config
    Write-Host "`nLinking Starship configuration..."
    $starshipSource = "$dotfilesDir\roles\shell-windows\files\starship.toml"
    $starshipTarget = "$env:USERPROFILE\.config\starship.toml"

    if (Test-Path $starshipSource) {
        $starshipDir = Split-Path $starshipTarget -Parent
        New-Item -ItemType Directory -Path $starshipDir -Force | Out-Null

        try {
            New-Item -ItemType SymbolicLink -Path $starshipTarget -Target $starshipSource -Force -ErrorAction Stop | Out-Null
            Write-Host "  ✓ Linked Starship config" -ForegroundColor Green
        } catch {
            Copy-Item $starshipSource $starshipTarget -Force
            Write-Host "  ⚠ Copied Starship config" -ForegroundColor Yellow
        }
    }

    Write-Success "Dotfiles setup complete"
}

# ============================================
# Step 5: Setup Neovim
# ============================================

if (-not $SkipVim) {
    Write-Step "Setting up Neovim"

    # Create local directories
    $localBin = "$env:USERPROFILE\.local\bin"
    New-Item -ItemType Directory -Path $localBin -Force | Out-Null

    # Link Neovim config
    $nvimSource = "$dotfilesDir\lazy"
    $nvimTarget = "$env:LOCALAPPDATA\nvim"

    if (Test-Path $nvimSource) {
        if (Test-Path $nvimTarget) {
            Write-Host "  Removing existing Neovim config..."
            Remove-Item $nvimTarget -Recurse -Force -ErrorAction SilentlyContinue
        }

        try {
            New-Item -ItemType SymbolicLink -Path $nvimTarget -Target $nvimSource -Force -ErrorAction Stop | Out-Null
            Write-Host "  ✓ Linked Neovim config" -ForegroundColor Green
        } catch {
            Copy-Item $nvimSource $nvimTarget -Recurse -Force
            Write-Host "  ⚠ Copied Neovim config (try running as Administrator for symlink)" -ForegroundColor Yellow
        }
    }

    # Verify Neovim installation
    if (Get-Command nvim -ErrorAction SilentlyContinue) {
        $nvimVersion = (nvim --version | Select-Object -First 1).Trim()
        Write-Success "Neovim setup complete: $nvimVersion"
    } else {
        Write-Warning "Neovim not found in PATH. You may need to restart your terminal."
    }
}

# ============================================
# Step 6: Initialize Tools
# ============================================

if (-not $SkipShell) {
    Write-Step "Initializing development tools"

    # Initialize fnm and install Node.js LTS
    if (Get-Command fnm -ErrorAction SilentlyContinue) {
        Write-Host "  Installing Node.js LTS via fnm..." -NoNewline
        fnm install --lts 2>&1 | Out-Null
        fnm default lts-latest 2>&1 | Out-Null
        Write-Host " ✓" -ForegroundColor Green
    }

    # Initialize Rust
    if (Get-Command rustup -ErrorAction SilentlyContinue) {
        Write-Host "  Updating Rust toolchain..." -NoNewline
        rustup default stable 2>&1 | Out-Null
        Write-Host " ✓" -ForegroundColor Green
    }

    Write-Success "Development tools initialized"
}

# ============================================
# Completion Message
# ============================================

Write-Host @"

╔══════════════════════════════════════════════════╗
║   Installation Complete!                         ║
╚══════════════════════════════════════════════════╝

Next steps:

1. RESTART YOUR TERMINAL (or run: . `$PROFILE)
2. Run 'nvim' to start Neovim (plugins will auto-install)
3. Customize your setup:
   - Edit PowerShell profile: `$PROFILE
   - Edit Neovim config: $env:LOCALAPPDATA\nvim
   - Edit Starship prompt: $env:USERPROFILE\.config\starship.toml

Useful commands:

  nvim              Open Neovim
  z <dir>           Jump to directory (zoxide)
  fnm list          List installed Node versions
  scoop update *    Update all packages
  gh repo clone     Clone GitHub repository

"@ -ForegroundColor Green

Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
