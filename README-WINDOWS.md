# Windows Dotfiles Setup Guide

This guide explains how to use this dotfiles repository on Windows with native tools (Scoop, PowerShell, etc.).

## Table of Contents

- [Quick Start](#quick-start)
- [What Gets Installed](#what-gets-installed)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Post-Installation](#post-installation)
- [Key Differences from Linux/macOS](#key-differences-from-linuxmacos)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Alternative: Using WSL2](#alternative-using-wsl2)

## Quick Start

**TL;DR:** Run this in PowerShell (not as Administrator):

```powershell
cd $env:USERPROFILE
git clone <your-repo-url> dotfiles
cd dotfiles
.\windows-install.ps1
```

Restart your terminal, then run `nvim` to finish setup.

## What Gets Installed

### Development Tools

- **fnm** - Fast Node Manager (replaces NVM)
- **Neovim** - Modern text editor with LazyVim configuration
- **Git** - Version control
- **Rust** - Rust toolchain via rustup
- **Go** - Go programming language
- **Python** - Python 3 with pip
- **.NET SDK** - .NET 8.0 SDK
- **Lua & LuaRocks** - Lua language and package manager

### Build Tools

- CMake, Ninja, Make
- Compilers included with dotnet-sdk

### Shell Enhancement

- **PowerShell 7+** - Modern PowerShell
- **Starship** - Cross-platform prompt (like Agnoster theme)
- **Zoxide** - Smarter cd command (learns your habits)
- **PSFzf** - Fuzzy finder for PowerShell
- **PSReadLine** - Better command line editing

### Modern CLI Tools

Improved replacements for classic Unix tools:

| Classic | Modern Alternative | Description |
|---------|-------------------|-------------|
| cat     | bat              | Syntax highlighting |
| ls      | eza              | Icons and colors |
| find    | fd               | Faster, simpler syntax |
| grep    | ripgrep          | Much faster searching |
| sed     | sd               | Simpler replacements |
| du      | dust             | Better disk usage |
| top     | bottom           | Better system monitor |

### Other Tools

- **gh** - GitHub CLI
- **delta** - Better git diff viewer
- **jq/yq** - JSON/YAML processors
- **stylua** - Lua code formatter
- **tree-sitter** - Parser generator
- **Nerd Fonts** - Patched fonts for terminal icons

## Prerequisites

- **Windows 10** (version 1809+) or **Windows 11**
- **PowerShell 5.1+** (comes with Windows)
- **Internet connection**
- **~2GB free disk space**

Optional but recommended:
- **Windows Terminal** - Modern terminal app (free from Microsoft Store)

## Installation

### Method 1: Automated Installation (Recommended)

1. **Clone the repository:**

   ```powershell
   cd $env:USERPROFILE
   git clone <your-repo-url> dotfiles
   cd dotfiles
   ```

   *If git is not installed, download and install from https://git-scm.com/download/win first, or the script will install it via Scoop.*

2. **Run the installation script:**

   ```powershell
   .\windows-install.ps1
   ```

   The script will:
   - Install Scoop package manager
   - Install all development tools
   - Set up PowerShell profile
   - Configure Neovim
   - Link all dotfiles

3. **Restart your terminal**

4. **Verify installation:**

   ```powershell
   # Check tools are installed
   fnm --version
   nvim --version
   starship --version

   # Check Node.js (via fnm)
   node --version
   ```

### Method 2: Manual Installation

If you prefer to install step-by-step:

```powershell
# 1. Install Scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
irm get.scoop.sh | iex

# 2. Add Scoop buckets
scoop bucket add extras
scoop bucket add nerd-fonts

# 3. Install core tools
scoop install git neovim fnm rust go python dotnet-sdk

# 4. Install shell enhancement
scoop install pwsh starship zoxide fzf

# 5. Install modern CLI tools
scoop install ripgrep bat eza fd delta jq

# 6. Install fonts
scoop install FiraCode-NF CascadiaCode-NF

# 7. Install PowerShell modules
Install-Module PSReadLine, PSFzf, posh-git, Terminal-Icons -Scope CurrentUser

# 8. Link dotfiles (from dotfiles directory)
$dotfiles = "$env:USERPROFILE\dotfiles"

# Link Git config
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitconfig" -Target "$dotfiles\roles\dotfiles\files\gitconfig" -Force
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gitignore" -Target "$dotfiles\roles\dotfiles\files\gitignore" -Force

# Link PowerShell profile
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$dotfiles\roles\dotfiles-windows\files\Microsoft.PowerShell_profile.ps1" -Force

# Link Neovim config
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Target "$dotfiles\lazy" -Force

# 9. Install Node.js via fnm
fnm install --lts
fnm default lts-latest
```

### Method 3: Selective Installation

You can skip certain steps:

```powershell
# Skip package installation (if already done)
.\windows-install.ps1 -SkipPackages

# Skip shell setup
.\windows-install.ps1 -SkipShell

# Skip Neovim setup
.\windows-install.ps1 -SkipVim

# Only install dotfiles/configs
.\windows-install.ps1 -SkipPackages -SkipShell -SkipVim
```

## Post-Installation

### 1. Configure Windows Terminal (Optional)

If using Windows Terminal, set the default profile to PowerShell 7:

1. Open Windows Terminal settings (Ctrl+,)
2. Set **Default profile** to "PowerShell"
3. Under PowerShell profile settings:
   - Set **Font face** to "FiraCode Nerd Font" or "CascadiaCode NF"
   - Enable **Acrylic transparency** if desired

### 2. First Neovim Launch

Launch Neovim for the first time:

```powershell
nvim
```

LazyVim will automatically:
- Install lazy.nvim plugin manager
- Download all configured plugins
- Set up LSP servers via Mason
- Configure syntax highlighting

This takes 2-5 minutes. Wait for completion.

### 3. Install Node.js Versions

Use fnm to manage Node.js versions:

```powershell
# Install specific version
fnm install 20.10.0

# Install LTS
fnm install --lts

# List installed versions
fnm list

# Use a version
fnm use 20.10.0

# Set default version
fnm default 20.10.0
```

### 4. Configure Git

Update the git configuration with your details:

```powershell
# Edit gitconfig
nvim $env:USERPROFILE\.gitconfig

# Or use git commands
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Key Differences from Linux/macOS

### Shell: PowerShell vs ZSH

| ZSH Feature | PowerShell Equivalent |
|-------------|---------------------|
| Oh-My-Zsh   | Oh-My-Posh / Starship |
| .zshrc      | $PROFILE (Microsoft.PowerShell_profile.ps1) |
| ~/.zsh/     | ~/Documents/PowerShell/powershell/ |
| zsh plugins | PowerShell modules |

### Configuration Paths

| Linux/macOS | Windows |
|-------------|---------|
| ~/.config/nvim | $env:LOCALAPPDATA\nvim |
| ~/.local/bin | $env:USERPROFILE\.local\bin |
| ~/.gitconfig | $env:USERPROFILE\.gitconfig |
| ~/.config/starship.toml | $env:USERPROFILE\.config\starship.toml |

### Package Managers

| Linux/macOS | Windows |
|-------------|---------|
| apt / brew  | scoop / chocolatey / winget |
| nvm         | fnm (cross-platform) |
| Oh-My-Zsh installer | PowerShell modules |

### No Direct Equivalents

Some Linux/macOS tools have no Windows equivalent:

- **tmux** → Use Windows Terminal with tabs/panes
- **mutt** → Use Thunderbird, Outlook, or web clients
- **X11 (.Xdefaults)** → Not applicable

## Customization

### PowerShell Profile

Edit your PowerShell profile:

```powershell
nvim $PROFILE
```

The profile is located at:
```
~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
```

### Starship Prompt

Edit the Starship configuration:

```powershell
nvim $env:USERPROFILE\.config\starship.toml
```

See https://starship.rs/config/ for options.

### Neovim Configuration

Your Neovim config is at:
```
$env:LOCALAPPDATA\nvim
```

This is symlinked to the `lazy/` directory in this repo.

Edit configs:
```powershell
nvim $env:LOCALAPPDATA\nvim\lua\config\options.lua
nvim $env:LOCALAPPDATA\nvim\lua\plugins\
```

### Adding Scoop Packages

Edit the package list:
```powershell
nvim .\roles\packages-windows\defaults\main.yml
```

Then reinstall:
```powershell
.\windows-install.ps1 -SkipDotfiles -SkipShell -SkipVim
```

Or manually:
```powershell
scoop install <package-name>
```

## Troubleshooting

### Execution Policy Error

If you get "cannot be loaded because running scripts is disabled":

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

### Symlink Errors

If symbolic links fail to create:

1. **Option 1:** Run PowerShell as Administrator once during setup
2. **Option 2:** Enable Developer Mode in Windows Settings:
   - Settings → Update & Security → For developers → Developer Mode
3. **Option 3:** The script will copy files instead of symlinking

### fnm Not Found After Installation

Restart your terminal or run:

```powershell
. $PROFILE
```

### Neovim Plugins Not Installing

1. Ensure you have internet connection
2. Delete plugin cache:
   ```powershell
   Remove-Item -Recurse -Force $env:LOCALAPPDATA\nvim-data
   ```
3. Relaunch Neovim

### Fonts Not Showing Icons

1. Install Nerd Fonts:
   ```powershell
   scoop install FiraCode-NF
   ```
2. Set your terminal font to "FiraCode Nerd Font"
3. Restart terminal

### Scoop Install Fails

Some packages may be unavailable in Scoop. Alternatives:

- **Chocolatey:** `choco install <package>`
- **winget:** `winget install <package>`
- **Direct download:** Install manually

## Alternative: Using WSL2

For maximum compatibility (95%+ of your Linux/macOS setup), use WSL2:

### Install WSL2

```powershell
# Run as Administrator
wsl --install -d Ubuntu-22.04
```

### Use Your Existing Setup

Inside WSL, use your regular installation:

```bash
cd ~
git clone <your-repo-url> dotfiles
cd dotfiles
./install.sh
```

Your existing Ansible playbooks work unchanged in WSL2.

### Access Windows Files from WSL

```bash
# Windows C:\ drive
cd /mnt/c/Users/YourName

# Edit Windows files with Neovim in WSL
nvim /mnt/c/path/to/file
```

### WSL2 + Windows Terminal

Windows Terminal works great with WSL2:
1. Open Windows Terminal
2. Select "Ubuntu" profile
3. All your ZSH configs work!

## Useful Commands

### Package Management

```powershell
# Update all packages
scoop update *

# List installed packages
scoop list

# Search for packages
scoop search <name>

# Uninstall package
scoop uninstall <name>
```

### Node Version Management (fnm)

```powershell
# Install Node versions
fnm install 18
fnm install 20
fnm install --lts

# Switch versions
fnm use 20

# Set default
fnm default 20

# List versions
fnm list

# Auto-switch based on .nvmrc
# (automatic with shell integration)
```

### Git Shortcuts (from gitconfig)

```powershell
# From your gitconfig aliases
git ci          # commit
git co          # checkout
git br          # branch
git st          # status
git lg          # log with graph

# Branch creation
git bF feat     # Creates feature/feat
git bB bug      # Creates bugfix/bug
git bC task     # Creates chore/task
```

### Custom PowerShell Aliases

```powershell
# Navigation
..              # cd ..
...             # cd ..\..
....            # cd ..\..\..

# Editor
v               # nvim
vim             # nvim

# Modern tools
ls              # eza --icons (if installed)
ll              # eza --icons -l
la              # eza --icons -la
cat             # bat (with syntax highlighting)

# Git
gs              # git status
ga              # git add
gc              # git commit
gp              # git push
gl              # git pull

# Development
dev             # cd $env:USERPROFILE\dev
projects        # cd $env:USERPROFILE\projects
```

## Getting Help

- **PowerShell help:** `Get-Help <command>`
- **Scoop help:** `scoop help`
- **fnm help:** `fnm --help`
- **Neovim help:** `:help` inside Neovim
- **Starship docs:** https://starship.rs

## Contributing

Found Windows-specific improvements? Please contribute:

1. Test your changes on Windows
2. Update this README if needed
3. Submit a pull request

## License

Same license as the main repository.
