# CLAUDE.md

Personal dotfiles repo: Ansible playbooks, Neovim (LazyVim), ZSH config.
Vocabulary for this repo lives in `CONTEXT.md` — read it before an architecture change.

## Commands

```bash
make format    # stylua on lazy/lua/
make verify    # stylua --check, ansible-lint, packages.yml schema check
ansible-playbook main.yml              # full setup (Unix)
ansible-playbook main.yml --tags vim   # single role (packages|dotfiles|shell|vim|lifeos)
pwsh windows-install.ps1               # Windows (standalone, no Ansible — see docs/adr/0001)
```

## Conventions

- **Packages** — add the tool to `packages.yml` with a per-manager name, e.g.
  `ripgrep: { apt: ripgrep, brew: ripgrep, scoop: ripgrep }`. An absent manager key means
  "intentionally not installed there". Direct `.deb` URLs stay in `roles/packages/defaults/main.yml`;
  Scoop buckets and fonts stay in `windows-install.ps1`.
- **Neovim extras** — enable only in `lazy/lazyvim.json` via `:LazyExtras`. Never import extras
  from `lazy/lua/config/lazy.lua`. Plugin overrides go in `lazy/lua/plugins/`.
- **Windows shell files** — `windows/`, mirroring how `zsh/` holds the Unix ones.
- **Vendored deps** — git submodules under `.vendor/`.

## Research Output

Save all research results to `~/Projects/notebook/personal/research/<genre>/`:
- Filename: `YYYY-MM-DD-{slug}.md` (e.g. `tech/2026-02-07-dotnet-swagger-alternatives.md`)
- Create new genre directories as needed
- Always save after displaying results
