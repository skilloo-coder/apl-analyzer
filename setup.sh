#!/bin/bash
set -e

echo "Setting up APL Threat Analyzer..."

# Step 1: Install Docker if missing
if ! command -v docker &>/dev/null; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com | sh
fi

# Step 2: Clone analyzer repo
if [ ! -d "$HOME/apl-analyzer" ]; then
    echo "Cloning analyzer repository..."
    git clone https://github.com/YOUR_USERNAME/apl-analyzer.git $HOME/apl-analyzer
fi

# Step 3: Build Docker image
cd $HOME/apl-analyzer
echo "Building Docker image..."
docker build -t apl-analyzer .

# Step 4: Create a command alias for easy usage
if ! grep -q "apl-analyzer" ~/.bashrc; then
    echo "alias apl-analyzer='docker run --rm -v \$(pwd):/app apl-analyzer'" >> ~/.bashrc
    source ~/.bashrc
fi

echo "Setup complete!"
echo "Usage: apl-analyzer /path/to/access.log"
echo "Outputs: Terminal alerts, report.json, report.csv"

