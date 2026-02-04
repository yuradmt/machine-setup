#!/bin/bash
# Machine setup script - run on a fresh VPS

set -e

echo "=== Dev Machine Setup ==="

# Create directories
mkdir -p ~/dev ~/.claude

# Symlink CLAUDE.md
ln -sf ~/dev/machine-setup/CLAUDE.md ~/.claude/CLAUDE.md

# Copy .env template if ~/.env doesn't exist
if [ ! -f ~/.env ]; then
    cp ~/dev/machine-setup/.env.example ~/.env
    chmod 600 ~/.env
    echo "Created ~/.env - fill in your API keys!"
else
    echo "~/.env already exists, skipping"
fi

# Add .env sourcing to bashrc if not present
if ! grep -q "source.*\.env" ~/.bashrc; then
    echo -e '\n# Load global secrets\nset -a; source ~/.env 2>/dev/null; set +a' >> ~/.bashrc
    echo "Added .env sourcing to ~/.bashrc"
fi

# Install Bun if not present
if ! command -v bun &> /dev/null; then
    echo "Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
else
    echo "Bun already installed"
fi

echo ""
echo "=== Setup complete ==="
echo "1. Edit ~/.env with your API keys"
echo "2. Run 'source ~/.bashrc' to load environment"
echo "3. Projects go in ~/dev/"
