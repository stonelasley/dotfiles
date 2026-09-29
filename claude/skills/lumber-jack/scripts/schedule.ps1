# Register/unregister an hourly Windows scheduled task that runs lumber-jack.sh directly (no model, zero tokens).
# Usage: pwsh schedule.ps1 -Repo C:\path\to\repo [-Remove] [-IdleDays 7]
param(
    [Parameter(Mandatory)] [string] $Repo,
    [switch] $Remove,
    [int] $IdleDays = 7
)
$ErrorActionPreference = 'Stop'
$repoFull = (Resolve-Path $Repo).Path
$taskName = "lumber-jack $(Split-Path $repoFull -Leaf)"

if ($Remove) {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    "Removed scheduled task '$taskName'"
    return
}

$bash = 'C:\Program Files\Git\bin\bash.exe'
if (-not (Test-Path $bash)) { throw "Git Bash not found at $bash" }
$script = (Join-Path $PSScriptRoot 'lumber-jack.sh') -replace '\\', '/'
$repoArg = $repoFull -replace '\\', '/'

# conhost --headless keeps a console window from flashing up every hour.
$action = New-ScheduledTaskAction -Execute 'conhost.exe' `
    -Argument "--headless `"$bash`" -lc `"'$script' --repo '$repoArg' --idle-days $IdleDays`"" `
    -WorkingDirectory $repoFull
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(5) -RepetitionInterval (New-TimeSpan -Hours 1)
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -DontStopIfGoingOnBatteries -AllowStartIfOnBatteries `
    -MultipleInstances IgnoreNew -ExecutionTimeLimit (New-TimeSpan -Minutes 50)

# Interactive logon so gh can read its token from Windows Credential Manager.
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -Force | Out-Null
"Registered '$taskName' hourly. Log: $(git -C $repoFull rev-parse --path-format=absolute --git-common-dir)/lumber-jack.log"
