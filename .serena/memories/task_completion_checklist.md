# Task Completion Checklist

When a task is completed, run the following as appropriate:

## After editing Lua files (Neovim config)
1. `make format` - Run stylua formatter
2. `make test` - Run plenary tests (if tests exist for changed code)

## After editing Ansible files
1. Verify YAML syntax is valid
2. Optionally run: `ansible-playbook main.yml --tags <relevant-tag> --check` (dry run)

## After any code changes
1. `git status` - Review changed files
2. Ensure no sensitive data (API keys, credentials) is staged
3. Commit with structured message if requested

## Important Notes
- NEVER commit to public repos from this private dotfiles repo
- Always check `git remote -v` before pushing
- Research output goes to `~/Projects/notebook/personal/research/<genre>/`
