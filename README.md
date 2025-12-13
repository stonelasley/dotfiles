# Personal Dotfiles
<a href="https://dotfyle.com/stonelasley/dotfiles-lazy"><img src="https://dotfyle.com/stonelasley/dotfiles-lazy/badges/plugins?style=for-the-badge" /></a>
<a href="https://dotfyle.com/stonelasley/dotfiles-lazy"><img src="https://dotfyle.com/stonelasley/dotfiles-lazy/badges/leaderkey?style=for-the-badge" /></a>
<a href="https://dotfyle.com/stonelasley/dotfiles-lazy"><img src="https://dotfyle.com/stonelasley/dotfiles-lazy/badges/plugin-manager?style=for-the-badge" /></a>

A comprehensive dotfiles repository that automates the setup of a complete development environment using Ansible playbooks. This configuration provides a consistent, reproducible development setup across different machines with LazyVim-based Neovim configuration, ZSH shell customization, and automated package management.

## 🚀 Quick Start

```bash
# Clone the repository
git clone <repository-url> ~/.dotfiles
cd ~/.dotfiles

# Run the complete setup
ansible-playbook main.yml

# Or run specific components
ansible-playbook main.yml --tags packages
ansible-playbook main.yml --tags dotfiles
ansible-playbook main.yml --tags shell
ansible-playbook main.yml --tags vim
```

## 📋 What's Included

### Core Components

- **🔧 Neovim Configuration**: LazyVim-based setup with extensive plugin ecosystem
- **🐚 Shell Environment**: ZSH with custom plugins and enhanced productivity features
- **📦 Package Management**: Cross-platform automated installation of development tools
- **⚙️ Dotfile Management**: Template-based configuration file deployment

### Development Tools

- **Languages**: TypeScript, Vue.js, Python, Go, Rust, .NET Core
- **Version Control**: Git with optimized configuration
- **Terminal**: Tmux with tmuxinator for session management
- **AI Integration**: GitHub Copilot and ChatGPT plugins for Neovim
- **Code Quality**: Stylua, ESLint, and language-specific linters

## 🏗️ Architecture

### Ansible Automation
The setup is orchestrated by four core roles executed in sequence:

1. **`packages`** - Installs system packages (apt/homebrew/pip/debs)
2. **`dotfiles`** - Deploys configuration files from templates
3. **`shell`** - Configures ZSH environment with custom plugins
4. **`vim`** - Sets up Neovim with LazyVim distribution

### Neovim Configuration Structure
```
lazy/
├── lua/config/           # Core LazyVim configuration
│   ├── lazy.lua         # Plugin manager bootstrap
│   ├── keymaps.lua      # Custom key mappings
│   ├── options.lua      # Editor options
│   └── autocmds.lua     # Auto commands
├── lua/plugins/         # Plugin customizations
│   ├── lsp-config.lua   # Language server configuration
│   ├── telescope.lua    # Fuzzy finder setup
│   ├── chatgpt.lua      # AI integration
│   └── ...
└── stylua.toml          # Lua formatter configuration
```

### Package Management
Centralized package definitions support multiple package managers:
- **`packages`** - APT packages for Ubuntu/Debian
- **`casks`** - Homebrew packages for macOS
- **`debs`** - Direct .deb package downloads
- **`pips`** - Python packages via pip

## 🛠️ Development Workflow

### Testing Neovim Configuration
```bash
# Run all tests
make test

# Format Lua code
make format

# Run specific test file
nvim --headless --noplugin -u nvim/tests/minimal_init.vim -c "PlenaryBustedFile nvim/tests/st1/utils/init_spec.lua {minimal_init = 'nvim/tests/minimal_init.vim'}"
```

### Adding New Packages
Edit `roles/packages/defaults/main.yml` and add packages to the appropriate list:
- `packages` for APT packages
- `casks` for Homebrew packages
- `debs` for direct downloads
- `pips` for Python packages

### Customizing Neovim
- **Core config**: Modify files in `lazy/lua/config/`
- **Plugin overrides**: Add/edit files in `lazy/lua/plugins/`
- **New tests**: Create test files in `nvim/tests/st1/`

## 📁 Key Files and Directories

```
.
├── main.yml                    # Main Ansible playbook
├── Makefile                   # Development commands
├── CLAUDE.md                  # AI assistant instructions
├── roles/                     # Ansible roles
│   ├── packages/              # Package installation
│   ├── dotfiles/              # Configuration file management
│   ├── shell/                 # ZSH setup
│   └── vim/                   # Neovim installation
├── lazy/                      # LazyVim configuration
│   ├── lua/config/           # Core configuration
│   └── lua/plugins/          # Plugin customizations
└── .vendor/                   # Git submodules for dependencies
```

## 🔧 Configuration Highlights

### Language Support
- **TypeScript/JavaScript**: Full LSP support with Vue.js integration
- **Python**: Development environment with testing frameworks
- **Go**: Complete toolchain with debugging support
- **Rust**: Cargo integration with rustup management
- **.NET**: Multi-version SDK support (6.0, 7.0, 8.0)
- **Lua**: Lua support with LuaRocks

### Productivity Features
- **Fuzzy Finding**: Telescope integration for files, commands, and symbols
- **Git Integration**: Advanced Git workflows with GitHub CLI
- **Terminal Integration**: Seamless tmux navigation and session management
- **AI Assistance**: Built-in ChatGPT and Copilot integration
- **Code Formatting**: Automatic formatting with language-specific tools

### Cross-Platform Support
- **Linux**: APT package management for Ubuntu/Debian systems
- **macOS**: Homebrew integration for package installation
- **Consistent Environment**: Same configuration across all platforms

## 🚀 Advanced Usage

### Running Partial Updates
```bash
# Update only packages
ansible-playbook main.yml --tags packages

# Update only dotfiles
ansible-playbook main.yml --tags dotfiles

# Update shell configuration
ansible-playbook main.yml --tags shell

# Update Neovim setup
ansible-playbook main.yml --tags vim
```

### Development and Testing
```bash
# Lint Ansible playbooks
ansible-lint main.yml

# Test Neovim configuration
make test

# Format all Lua code
make format
```

## 📝 Contributing

This is a personal dotfiles repository, but the structure and automation patterns can serve as inspiration for your own setup. Key principles:

1. **Automation First**: Everything should be reproducible via Ansible
2. **Cross-Platform**: Support both Linux and macOS environments
3. **Modular Design**: Each component (packages, dotfiles, shell, vim) is independent
4. **Testing**: Neovim configuration includes comprehensive test coverage
5. **Documentation**: Clear instructions and architectural decisions

## 🔗 Dependencies

### Required Tools
- **Ansible**: For automation and orchestration
- **Git**: For version control and submodule management
- **Python 3**: For Ansible and various development tools

### Managed Tools
All development tools are automatically installed via the playbooks:
- Neovim with LazyVim distribution
- ZSH with custom configuration
- Tmux and tmuxinator
- Language servers and development tools
- Package managers (npm, cargo, pip, etc.)

---

*This dotfiles repository represents a battle-tested development environment optimized for modern software development workflows. The automation ensures consistency and reduces setup time when configuring new development machines.*
