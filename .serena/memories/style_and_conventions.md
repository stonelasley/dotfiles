# Style and Conventions

## Lua (Neovim Config)
- **Formatter**: Stylua
- **Indent**: 2 spaces
- **Column width**: 120
- **Line endings**: Unix (LF)
- **Quote style**: Auto-prefer double quotes
- **Call parentheses**: Omitted (`no_call_parentheses = true`)
- **Config location**: `.stylua.toml` and `lazy/stylua.toml`

## Ansible (YAML)
- Standard Ansible YAML conventions
- Roles organized under `roles/` with standard structure (defaults, tasks, files, templates)
- Tags used for selective role execution

## ZSH
- Config split into modular files: aliases, bindings, colors, corrections, functions, hooks, theme
- Completions in `zsh/completion/` subdirectory

## General
- LazyVim plugin specs follow LazyVim conventions (return table with plugin spec)
- Git submodules used for third-party dependencies in `.vendor/`
- No HTML tags for content (use Markdown)
- TypeScript preferred over Python for new tools
