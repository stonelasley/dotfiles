# PowerShell Aliases
# Windows equivalent of zsh/aliases

# ============================================
# Editor Aliases
# ============================================
Set-Alias -Name v -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias -Name vi -Value nvim

# ============================================
# Git Aliases (supplement gitconfig)
# ============================================
function gs { git status }
function ga { git add $args }
function gc { git commit -m $args }
function gp { git push }
function gl { git pull }
function gd { git diff }
function gco { git checkout $args }
function gb { git branch }

# ============================================
# Navigation Aliases
# ============================================
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
function ..... { Set-Location ..\..\..\.. }

# Go to home
function ~ { Set-Location $env:USERPROFILE }

# ============================================
# Modern CLI Tools (if installed via Scoop)
# ============================================

# Use 'bat' instead of 'cat' if available
if (Get-Command bat -ErrorAction SilentlyContinue) {
    Set-Alias -Name cat -Value bat -Option AllScope
}

# Use 'eza' instead of 'ls' if available
if (Get-Command eza -ErrorAction SilentlyContinue) {
    Remove-Item Alias:ls -Force -ErrorAction SilentlyContinue
    function ls { eza --icons $args }
    function ll { eza --icons -l $args }
    function la { eza --icons -la $args }
    function lt { eza --icons --tree $args }
} else {
    # Fallback to standard ls with better defaults
    function ll { Get-ChildItem $args }
    function la { Get-ChildItem -Force $args }
}

# Use 'fd' instead of 'find' if available
if (Get-Command fd -ErrorAction SilentlyContinue) {
    Set-Alias -Name find -Value fd
}

# Use 'ripgrep' instead of 'grep' if available
if (Get-Command rg -ErrorAction SilentlyContinue) {
    Set-Alias -Name grep -Value rg
}

# ============================================
# Development Aliases
# ============================================

# Quick directory access (customize these for your projects)
function dev { Set-Location "$env:USERPROFILE\dev" }
function projects { Set-Location "$env:USERPROFILE\projects" }
function downloads { Set-Location "$env:USERPROFILE\Downloads" }
function documents { Set-Location "$env:USERPROFILE\Documents" }

# ============================================
# System Aliases
# ============================================

# Quick system info
function sysinfo { Get-ComputerInfo }

# Reload profile
function reload { . $PROFILE }

# Edit profile
function ep { nvim $PROFILE }

# Which command (like Unix 'which')
function which { Get-Command $args | Select-Object -ExpandProperty Definition }

# ============================================
# Package Management
# ============================================

# Scoop shortcuts
function sup { scoop update * }
function sls { scoop list }
function si { scoop install $args }
function sr { scoop uninstall $args }
function ss { scoop search $args }
