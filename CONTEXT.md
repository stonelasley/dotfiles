# Domain Glossary

Vocabulary for this dotfiles repository. Architecture reviews and refactors
should use these terms.

- **Manifest** — `packages.yml`, the single interface answering "what does my
  environment contain". Maps tool → per-manager package name (`apt`, `brew`,
  `scoop`, `pip`, `npm`). An absent manager key is intentional. Validated by
  `scripts/check-manifest.py`.
- **Adapter** — a consumer of the manifest that installs via one manager: the
  apt/brew/pip/npm tasks in `roles/packages`, and the Scoop/pip/npm loops in
  `windows-install.ps1`. Manager-specific oddities (deb URLs, Scoop buckets,
  fonts, PowerShell modules) live in the adapter, not the manifest.
- **Unix path** — `install.sh` → `main.yml` → Ansible roles (`packages`,
  `dotfiles`, `shell`, `vim`, `lifeos`). Linux and macOS.
- **Windows path** — `windows-install.ps1`, a standalone PowerShell
  implementation (no Ansible; see ADR-0001). Windows shell files live in
  `windows/` (PowerShell profile + modules, starship config), mirroring how
  `zsh/` holds the Unix shell files.
- **Verify interface** — `make verify`: stylua --check, ansible-lint, and the
  manifest schema check. The repo's single entry point for static verification.
- **Extras seam** — `lazy/lazyvim.json`, the only place LazyVim language/extras
  are enabled (managed by `:LazyExtras`). `lazy/lua/config/lazy.lua` must not
  import extras directly.
