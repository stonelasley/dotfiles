# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages development environment configuration through Ansible playbooks. It contains:

- **Neovim Configuration**: LazyVim-based setup with extensive plugins
- **Ansible Automation**: Playbooks for setting up development environments
- **Shell Configuration**: ZSH with custom plugins and completions
- **Package Management**: Automated installation of development tools

## Common Commands

### Testing and Formatting
```bash
# Format Lua code using stylua (formats nvim/lua/ directory)
make format

# Test configuration (runs test suite via plenary)
make test
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
- **Language Support**: Configured for TypeScript, Vue, with AI copilot integration
- **Testing**: Testing framework available via Makefile commands

### Ansible Role Architecture
- **Main Playbook**: `main.yml` orchestrates four core roles in order:
  1. `packages` - installs system packages (apt/homebrew/pip/debs)
  2. `dotfiles` - manages configuration files
  3. `shell` - configures ZSH environment
  4. `vim` - sets up Neovim
- **Package Management**: Centralized in `roles/packages/defaults/main.yml` with cross-platform package lists
- **Dotfile Strategy**: Template-based deployment from `roles/dotfiles/files/`

## Development Workflow

### Neovim Plugin Development
- Main config: `lazy/lua/config/lazy.lua`
- Plugin customizations: `lazy/lua/plugins/`
- Key plugins: ChatGPT, Claude Code, Copilot, Copilot Chat, LSP config, Telescope
- Stylua config: `lazy/stylua.toml` (2-space indents, 120 column width)
- Language extras: TypeScript, Vue, OmniSharp (.NET), Test framework

### Adding New Packages
- Update package lists in `roles/packages/defaults/main.yml`
- Separate lists for `packages` (apt), `casks` (homebrew), `debs` (direct downloads), `pips` (Python)

### Git Submodule Management
- Third-party dependencies in `.vendor/` as git submodules
- ZSH plugins and extensions managed this way

## Key Technologies

- **LazyVim**: Neovim distribution with lazy loading and automatic plugin updates
- **Ansible**: Infrastructure as code for environment setup
- **Plenary.nvim**: Lua testing framework for Neovim
- **Stylua**: Lua formatter with project-specific configuration