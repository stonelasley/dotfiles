# Suggested Commands

## Development Commands
| Command | Description |
|---------|-------------|
| `make format` | Format Lua code with stylua (targets nvim/lua/) |
| `make test` | Run Neovim tests via plenary.nvim |

## Ansible Deployment
| Command | Description |
|---------|-------------|
| `ansible-playbook main.yml` | Run full dotfiles setup |
| `ansible-playbook main.yml --tags packages` | Install system packages only |
| `ansible-playbook main.yml --tags dotfiles` | Deploy config files only |
| `ansible-playbook main.yml --tags shell` | Configure ZSH only |
| `ansible-playbook main.yml --tags vim` | Setup Neovim only |
| `ansible-playbook main.yml --tags pai` | Setup PAI only |

## Git / Submodules
| Command | Description |
|---------|-------------|
| `git submodule update --init --recursive` | Initialize/update all submodules |
| `git status` | Check working tree status |

## System Utilities (macOS/Darwin)
| Command | Description |
|---------|-------------|
| `git` | Version control |
| `ls`, `find`, `grep` | File system navigation (note: macOS versions, not GNU) |
| `brew` | Homebrew package manager |
| `stylua` | Lua code formatter |
