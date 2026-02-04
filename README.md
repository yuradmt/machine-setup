# Machine Setup

Dev machine configuration for VPS - Claude instructions, environment template, and setup scripts.

## Quick Start

```bash
# Clone to ~/dev
git clone https://github.com/pttpos/machine-setup.git ~/dev/machine-setup

# Run setup
chmod +x ~/dev/machine-setup/setup.sh
~/dev/machine-setup/setup.sh

# Fill in your API keys
nano ~/.env

# Reload shell
source ~/.bashrc
```

## What's Included

- `CLAUDE.md` - Global instructions for Claude Code (symlinked to ~/.claude/)
- `.env.example` - Template for API keys (copy to ~/.env)
- `setup.sh` - Automated setup script

## Structure After Setup

```
~/.claude/CLAUDE.md  -> ~/dev/machine-setup/CLAUDE.md (symlink)
~/.env               # Your actual secrets (not in git)
~/dev/               # All projects
```
