# Project Overview

## Purpose
Personal dotfiles repository that manages development environment configuration through Ansible playbooks. Manages Neovim (LazyVim), ZSH shell, system packages, and PAI (Personal AI Infrastructure) setup.

## Owner
Stone C. Lasley (stonelasley)

## Tech Stack
- **Configuration Management**: Ansible (playbooks + roles)
- **Editor**: Neovim with LazyVim distribution
- **Shell**: ZSH with custom plugins/completions
- **Lua Formatter**: Stylua
- **Testing**: Plenary.nvim (Neovim test framework)
- **Package Management**: apt (Linux), Homebrew (macOS), pip (Python)
- **Version Control**: Git with submodules in `.vendor/`
- **Platform**: macOS (Darwin) primary, Windows support via separate roles

## Repository Structure
```
.
├── CLAUDE.md            # Claude Code instructions
├── Makefile             # format + test commands
├── main.yml             # Ansible main playbook
├── lazy/                # Neovim/LazyVim configuration
│   ├── lua/config/      # Core config (autocmds, keymaps, options, lazy bootstrap)
│   └── lua/plugins/     # Plugin specs (LSP, Copilot, ChatGPT, Claude, Telescope, etc.)
├── roles/               # Ansible roles
│   ├── packages/        # System package installation
│   ├── dotfiles/        # Config file deployment
│   ├── shell/           # ZSH setup
│   ├── vim/             # Neovim setup
│   └── pai/             # PAI infrastructure setup
├── zsh/                 # ZSH configuration files
│   ├── aliases, bindings, colors, corrections, functions, hooks, theme
│   └── completion/      # Shell completions
├── .vendor/             # Git submodules (powerline-fonts, base16, zsh plugins, PAI)
└── claude/              # Claude Code custom commands
```

## Ansible Roles (executed in order)
1. `packages` - System packages
2. `dotfiles` - Configuration files
3. `shell` - ZSH environment
4. `vim` - Neovim setup
5. `pai` - Personal AI Infrastructure
