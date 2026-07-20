# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages development environment configuration through Ansible playbooks. It contains:

- **Neovim Configuration**: LazyVim-based setup with extensive plugins
- **Ansible Automation**: Playbooks for setting up development environments
- **Shell Configuration**: ZSH with custom plugins and completions
- **Package Management**: Automated installation of development tools

## Common Commands

### Formatting and Verification
```bash
# Format Lua code using stylua (formats lazy/lua/ directory)
make format

# Verify: stylua --check, ansible-lint, and package-manifest schema check
make verify
```

### Ansible Deployment
```bash
# Run full dotfiles setup
ansible-playbook main.yml

# Run specific role only
ansible-playbook main.yml --tags packages
ansible-playbook main.yml --tags dotfiles
ansible-playbook main.yml --tags shell
ansible-playbook main.yml --tags vim
```

## Architecture Overview

### LazyVim Configuration Structure
- **Entry Point**: `lazy/lua/config/lazy.lua` - bootstraps lazy.nvim and loads plugin specs
- **Core Config**: `lazy/lua/config/` - autocmds, keymaps, options
- **Plugin Overrides**: `lazy/lua/plugins/` - custom plugin configurations that override LazyVim defaults
- **Language Support**: LazyVim extras are managed solely in `lazy/lazyvim.json` (via `:LazyExtras`) — TypeScript, Vue, .NET, JSON, test framework

### Ansible Role Architecture
- **Main Playbook**: `main.yml` orchestrates four core roles in order:
  1. `packages` - installs system packages (apt/homebrew/pip/debs)
  2. `dotfiles` - manages configuration files
  3. `shell` - configures ZSH environment
  4. `vim` - sets up Neovim
- **Package Management**: `packages.yml` at the repo root is the single manifest (tool → per-manager name for apt/brew/scoop/pip/npm), consumed by `roles/packages` and `windows-install.ps1`
- **Dotfile Strategy**: Template-based deployment from `roles/dotfiles/files/`
- **Windows**: `windows-install.ps1` is the Windows implementation (Scoop + symlinks, no Ansible); Windows shell files live in `windows/`

## Development Workflow

### Neovim Plugin Development
- Main config: `lazy/lua/config/lazy.lua`
- Plugin customizations: `lazy/lua/plugins/`
- Key plugins: ChatGPT, Claude Code, Copilot, Copilot Chat, LSP config, Telescope
- Stylua config: `lazy/stylua.toml` (2-space indents, 120 column width)
- Language extras: TypeScript, Vue, OmniSharp (.NET), Test framework

### Adding New Packages
- Add the tool to `packages.yml` with a per-manager name for each OS it belongs on, e.g. `ripgrep: { apt: ripgrep, brew: ripgrep, scoop: ripgrep }`
- An absent manager key means "intentionally not installed via that manager"
- Direct `.deb` downloads stay in `roles/packages/defaults/main.yml`; Scoop buckets/fonts stay in `windows-install.ps1`
- `make verify` validates the manifest schema

### Git Submodule Management
- Third-party dependencies in `.vendor/` as git submodules
- ZSH plugins and extensions managed this way

## Research Output

Save all research results (extract_wisdom, summaries, analysis, etc.) to `~/Projects/notebook/personal/research/<genre>/` with the format:
- **Directory**: Organize by genre subdirectory (e.g. `tech/`, `health/`). Create new genre directories as needed.
- **Filename**: `YYYY-MM-DD-{slug}.md` (e.g. `tech/2026-02-07-dotnet-swagger-alternatives.md`)
- **Content**: Full pattern output in markdown
- Always save after displaying results in the conversation

## Key Technologies

- **LazyVim**: Neovim distribution with lazy loading and automatic plugin updates
- **Ansible**: Infrastructure as code for environment setup
- **Plenary.nvim**: Lua testing framework for Neovim
- **Stylua**: Lua formatter with project-specific configuration