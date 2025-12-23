#!/bin/bash
# myScripts Installation Script

set -e

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
SCRIPTS_DIR="$HOME/.local/bin"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_status() { echo -e "${GREEN}[✓]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }

echo -e "${GREEN}=== myScripts Installation ===${NC}\n"

# Create necessary directories
echo "Setting up directories..."
mkdir -p "$SCRIPTS_DIR"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/backup"
mkdir -p "$HOME/Pictures/Background"

# Install executable scripts from bin/
echo -e "\n${YELLOW}Installing command-line scripts...${NC}"
if [ -d "$REPO_DIR/bin" ]; then
    for script in "$REPO_DIR/bin"/*; do
        if [ -f "$script" ]; then
            script_name=$(basename "$script")
            cp "$script" "$SCRIPTS_DIR/$script_name"
            chmod +x "$SCRIPTS_DIR/$script_name"
            print_status "Installed: $script_name"
        fi
    done
else
    print_warning "No bin/ directory found"
fi

# Add to PATH if needed
if [[ ":$PATH:" != *":$SCRIPTS_DIR:"* ]]; then
    echo -e "\n${YELLOW}Adding $SCRIPTS_DIR to PATH...${NC}"
    
    # Detect shell config
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_CONFIG="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        SHELL_CONFIG="$HOME/.bashrc"
    else
        SHELL_CONFIG="$HOME/.profile"
    fi
    
    if ! grep -q "export PATH=\"\$HOME/.local/bin:\$PATH\"" "$SHELL_CONFIG" 2>/dev/null; then
        echo '' >> "$SHELL_CONFIG"
        echo '# Added by myScripts installer' >> "$SHELL_CONFIG"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_CONFIG"
        print_status "Added to $SHELL_CONFIG"
        print_warning "Run 'source $SHELL_CONFIG' to use scripts immediately"
    else
        print_status "PATH already configured"
    fi
fi

# Setup config files
echo -e "\n${YELLOW}Setting up configuration...${NC}"
if [ -f "$REPO_DIR/config/keys.json.example" ] && [ ! -f "$REPO_DIR/config/keys.json" ]; then
    cp "$REPO_DIR/config/keys.json.example" "$REPO_DIR/config/keys.json"
    print_warning "Created config/keys.json - add your API keys!"
fi

# Install Neovim configuration
echo -e "\n${YELLOW}Installing Neovim configuration...${NC}"
if [ -d "$REPO_DIR/nvim" ]; then
    if [ -d "$NVIM_CONFIG_DIR" ] || [ -L "$NVIM_CONFIG_DIR" ]; then
        backup_dir="$NVIM_CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Backing up existing config to: $(basename $backup_dir)"
        mv "$NVIM_CONFIG_DIR" "$backup_dir"
    fi
    
    ln -s "$REPO_DIR/nvim" "$NVIM_CONFIG_DIR"
    print_status "Neovim config symlinked"
else
    print_warning "No nvim/ directory found"
fi

# Setup cron jobs (optional)
echo -e "\n${YELLOW}Cron jobs setup${NC}"
if [ -f "$REPO_DIR/config/cron_jobs.txt" ]; then
    print_warning "Cron jobs available in config/cron_jobs.txt"
    echo "To install: crontab -e and add the jobs manually"
    echo "Or run: cat $REPO_DIR/config/cron_jobs.txt >> ~/mycron && crontab ~/mycron && rm ~/mycron"
else
    print_warning "No cron jobs template found"
fi

# Check dependencies
echo -e "\n${YELLOW}Checking dependencies...${NC}"
declare -a missing_deps=()

# Required
for cmd in git; do
    if ! command -v $cmd &> /dev/null; then
        missing_deps+=("$cmd")
    else
        print_status "$cmd installed"
    fi
done

# Optional
for cmd in nvim jq curl wmctrl; do
    if command -v $cmd &> /dev/null; then
        print_status "$cmd installed"
    else
        print_warning "$cmd not installed (optional)"
    fi
done

if [ ${#missing_deps[@]} -gt 0 ]; then
    print_error "Missing required: ${missing_deps[*]}"
    echo "Install with: sudo apt install ${missing_deps[*]}"
fi

echo -e "\n${GREEN}=== Installation Complete! ===${NC}"
echo -e "\n${YELLOW}Next steps:${NC}"
echo "1. Reload shell: source ~/.bashrc (or restart terminal)"
echo "2. Edit config/keys.json with your API keys"
echo "3. Setup cron jobs if needed (see config/cron_jobs.txt)"
echo "4. Available commands: backup, practice, closeall, simple-server"
echo -e "\n${YELLOW}Update later:${NC} cd $REPO_DIR && git pull && ./install.sh"