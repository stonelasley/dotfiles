# CLAUDE.md

Personal dotfiles repo: Ansible playbooks, Neovim (LazyVim), ZSH config.

## Commands

```bash
make format    # stylua on lazy/lua/
make test      # plenary test suite
ansible-playbook main.yml              # full setup
ansible-playbook main.yml --tags vim   # single role (packages|dotfiles|shell|vim)
```

## Research Output

Save all research results to `~/Projects/notebook/personal/research/<genre>/`:
- Filename: `YYYY-MM-DD-{slug}.md` (e.g. `tech/2026-02-07-dotnet-swagger-alternatives.md`)
- Create new genre directories as needed
- Always save after displaying results