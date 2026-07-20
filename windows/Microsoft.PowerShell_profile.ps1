# PowerShell Profile
# Windows equivalent of .zshrc
# Location: $PROFILE (usually ~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1)

# Import custom modules
$scriptPath = Split-Path -Parent $PROFILE
. "$scriptPath\powershell\env.ps1"
. "$scriptPath\powershell\aliases.ps1"
. "$scriptPath\powershell\functions.ps1"

# ============================================
# Environment Variables
# ============================================

# .NET Development
$env:DOTNET_ROOT = "$env:USERPROFILE\.dotnet"
$env:ASPNETCORE_ENVIRONMENT = "Development"

# Add local bin to PATH
$env:PATH = "$env:USERPROFILE\.local\bin;$env:PATH"

# ============================================
# Tool Initialization
# ============================================

# fnm (Fast Node Manager) - replaces NVM
if (Get-Command fnm -ErrorAction SilentlyContinue) {
    fnm env --use-on-cd | Out-String | Invoke-Expression
}

# Starship prompt (modern, fast prompt)
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
}

# Zoxide (smarter cd)
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# PSFzf (FZF integration)
if (Get-Module -ListAvailable -Name PSFzf) {
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}

# ============================================
# PSReadLine Configuration (like ZSH vi-mode)
# ============================================

# Import PSReadLine for better command line editing
Import-Module PSReadLine

# Emacs-style key bindings (or use Vi for Vi-mode)
Set-PSReadLineOption -EditMode Emacs

# History settings
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -MaximumHistoryCount 10000
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Key bindings
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# ============================================
# Windows Terminal Integration
# ============================================

# Set window title
$Host.UI.RawUI.WindowTitle = "PowerShell - $PWD"

# Update title on directory change
$ExecutionContext.InvokeCommand.LocationChangedAction = {
    $Host.UI.RawUI.WindowTitle = "PowerShell - $PWD"
}

# ============================================
# Welcome Message
# ============================================

Write-Host "PowerShell $($PSVersionTable.PSVersion) - Dotfiles loaded" -ForegroundColor Green
