# ADR-0001: Windows installs via windows-install.ps1, not Ansible

Date: 2026-07-18

## Status

Accepted

## Context

The repo briefly carried two parallel Windows implementations: four
`-windows` Ansible roles orchestrated by `windows.yml`, and the standalone
`windows-install.ps1`. Ansible cannot run as a control node on native
Windows — `windows.yml` only worked via WinRM gymnastics or from WSL, and
its own comments pointed users at the PowerShell script instead. The two
paths each carried their own package lists and symlink logic, which had
already diverged.

## Decision

`windows-install.ps1` is the Windows implementation. The `-windows` roles
and `windows.yml` were deleted. The script consumes the shared package
manifest (`packages.yml`) via the `powershell-yaml` module, and links the
Windows shell files from the top-level `windows/` directory.

## Consequences

- One Windows implementation, one package manifest shared with Unix.
- Future architecture reviews should not re-propose "demote the ps1 script
  to an Ansible bootstrap": Ansible-on-native-Windows is the reason the
  script exists.
- Anyone wanting the full Unix toolchain on Windows uses WSL2 with the
  regular `install.sh` path (see README-WINDOWS.md).
