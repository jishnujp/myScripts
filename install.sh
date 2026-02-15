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

show_help() {
    cat << EOF
${GREEN}myScripts Installation${NC}

${YELLOW}Usage:${NC}
  ./install.sh [OPTIONS]

${YELLOW}Options:${NC}
  --nvim-only         Install only Neovim configuration
  --scripts-only      Install only bin/ scripts
  --no-nvim           Install everything except Neovim config
  --no-scripts        Install everything except bin/ scripts
  --minimal           Create directories only (no scripts or nvim)
  --no-path           Don't modify shell PATH configuration
  --dry-run           Show what would be installed without making changes
  --force             Skip backup of existing nvim config
  -h, --help          Show this help message

${YELLOW}Components:${NC}
  Scripts:            Command-line tools in bin/ (backup, practice, closeall, etc.)
  Neovim:             Neovim configuration with plugins
  Config:             Setup config files and directories
  PATH:               Add ~/.local/bin to shell PATH

${YELLOW}Examples:${NC}
  # Install everything (default)
  ./install.sh

  # Install only Neovim configuration
  ./install.sh --nvim-only

  # Install scripts but don't modify PATH
  ./install.sh --scripts-only --no-path

  # Preview what would be installed
  ./install.sh --dry-run

  # Update only scripts, skip nvim
  ./install.sh --no-nvim

EOF
    exit 0
}

# Installation flags (defaults to full install for backwards compatibility)
INSTALL_NVIM=true
INSTALL_SCRIPTS=true
INSTALL_CONFIG=true
ADD_TO_PATH=true
DRY_RUN=false
FORCE_INSTALL=false

# Parse command-line arguments
while [ $# -gt 0 ]; do
    case "$1" in
        --nvim-only)
            INSTALL_NVIM=true
            INSTALL_SCRIPTS=false
            INSTALL_CONFIG=false
            ADD_TO_PATH=false
            shift
            ;;
        --scripts-only)
            INSTALL_NVIM=false
            INSTALL_SCRIPTS=true
            INSTALL_CONFIG=true
            ADD_TO_PATH=true
            shift
            ;;
        --no-nvim)
            INSTALL_NVIM=false
            shift
            ;;
        --no-scripts)
            INSTALL_SCRIPTS=false
            ADD_TO_PATH=false
            shift
            ;;
        --minimal)
            INSTALL_NVIM=false
            INSTALL_SCRIPTS=false
            INSTALL_CONFIG=false
            ADD_TO_PATH=false
            shift
            ;;
        --no-path)
            ADD_TO_PATH=false
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --force)
            FORCE_INSTALL=true
            shift
            ;;
        -h|--help)
            show_help
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Run './install.sh --help' for usage information"
            exit 1
            ;;
    esac
done

echo -e "${GREEN}=== myScripts Installation ===${NC}\n"

if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}[DRY RUN MODE - No changes will be made]${NC}\n"
fi

# Create necessary directories
echo "Setting up directories..."
mkdir -p "$SCRIPTS_DIR"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/backup"
mkdir -p "$HOME/Pictures/Background"

# Install executable scripts from bin/
if [ "$INSTALL_SCRIPTS" = true ]; then
    echo -e "\n${YELLOW}Installing command-line scripts...${NC}"
    if [ "$DRY_RUN" = true ]; then
        print_warning "[DRY RUN] Would install scripts from bin/ to $SCRIPTS_DIR"
    elif [ -d "$REPO_DIR/bin" ]; then
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
fi

# Add to PATH if needed
if [ "$INSTALL_SCRIPTS" = true ] && [ "$ADD_TO_PATH" = true ]; then
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

        if [ "$DRY_RUN" = true ]; then
            print_warning "[DRY RUN] Would add PATH to $SHELL_CONFIG"
        elif ! grep -q "export PATH=\"\$HOME/.local/bin:\$PATH\"" "$SHELL_CONFIG" 2>/dev/null; then
            echo '' >> "$SHELL_CONFIG"
            echo '# Added by myScripts installer' >> "$SHELL_CONFIG"
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_CONFIG"
            print_status "Added to $SHELL_CONFIG"
            print_warning "Run 'source $SHELL_CONFIG' to use scripts immediately"
        else
            print_status "PATH already configured"
        fi
    fi
fi

# Setup config files
if [ "$INSTALL_CONFIG" = true ]; then
    echo -e "\n${YELLOW}Setting up configuration...${NC}"
    if [ "$DRY_RUN" = true ]; then
        if [ -f "$REPO_DIR/config/keys.json.example" ] && [ ! -f "$REPO_DIR/config/keys.json" ]; then
            print_warning "[DRY RUN] Would create config/keys.json from example"
        fi
    elif [ -f "$REPO_DIR/config/keys.json.example" ] && [ ! -f "$REPO_DIR/config/keys.json" ]; then
        cp "$REPO_DIR/config/keys.json.example" "$REPO_DIR/config/keys.json"
        print_warning "Created config/keys.json - add your API keys!"
    fi
fi

# Install Neovim configuration
if [ "$INSTALL_NVIM" = true ]; then
    echo -e "\n${YELLOW}Installing Neovim configuration...${NC}"
    if [ "$DRY_RUN" = true ]; then
        if [ -d "$REPO_DIR/nvim" ]; then
            print_warning "[DRY RUN] Would symlink nvim config to $NVIM_CONFIG_DIR"
            if [ -d "$NVIM_CONFIG_DIR" ] || [ -L "$NVIM_CONFIG_DIR" ]; then
                if [ "$FORCE_INSTALL" = false ]; then
                    print_warning "[DRY RUN] Would backup existing config"
                else
                    print_warning "[DRY RUN] Would overwrite existing config (--force)"
                fi
            fi
        else
            print_warning "[DRY RUN] No nvim/ directory found"
        fi
    elif [ -d "$REPO_DIR/nvim" ]; then
        if [ -d "$NVIM_CONFIG_DIR" ] || [ -L "$NVIM_CONFIG_DIR" ]; then
            if [ "$FORCE_INSTALL" = false ]; then
                backup_dir="$NVIM_CONFIG_DIR.backup.$(date +%Y%m%d_%H%M%S)"
                print_warning "Backing up existing config to: $(basename $backup_dir)"
                mv "$NVIM_CONFIG_DIR" "$backup_dir"
            else
                print_warning "Removing existing config (--force)"
                rm -rf "$NVIM_CONFIG_DIR"
            fi
        fi

        ln -s "$REPO_DIR/nvim" "$NVIM_CONFIG_DIR"
        print_status "Neovim config symlinked"
    else
        print_warning "No nvim/ directory found"
    fi
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

# Optional - check based on what's being installed
if [ "$INSTALL_NVIM" = true ]; then
    if command -v nvim &> /dev/null; then
        print_status "nvim installed"
    else
        print_warning "nvim not installed (required for Neovim config)"
    fi
fi

if [ "$INSTALL_SCRIPTS" = true ]; then
    for cmd in jq curl wmctrl; do
        if command -v $cmd &> /dev/null; then
            print_status "$cmd installed"
        else
            print_warning "$cmd not installed (optional for some scripts)"
        fi
    done
fi

if [ ${#missing_deps[@]} -gt 0 ]; then
    print_error "Missing required: ${missing_deps[*]}"
    echo "Install with: sudo apt install ${missing_deps[*]}"
fi

if [ "$DRY_RUN" = true ]; then
    echo -e "\n${GREEN}=== Dry Run Complete ===${NC}"
    echo -e "${YELLOW}No changes were made. Remove --dry-run to perform installation.${NC}"
    exit 0
fi

echo -e "\n${GREEN}=== Installation Complete! ===${NC}"

# Dynamic next steps based on what was installed
declare -a next_steps=()
if [ "$INSTALL_SCRIPTS" = true ] && [ "$ADD_TO_PATH" = true ]; then
    next_steps+=("Reload shell: source ~/.bashrc (or restart terminal)")
fi
if [ "$INSTALL_CONFIG" = true ]; then
    next_steps+=("Edit config/keys.json with your API keys")
    next_steps+=("Setup cron jobs if needed (see config/cron_jobs.txt)")
fi
if [ "$INSTALL_SCRIPTS" = true ]; then
    next_steps+=("Available commands: backup, practice, closeall, simple-server")
fi
if [ "$INSTALL_NVIM" = true ]; then
    next_steps+=("Launch nvim to install plugins automatically")
fi

if [ ${#next_steps[@]} -gt 0 ]; then
    echo -e "\n${YELLOW}Next steps:${NC}"
    for i in "${!next_steps[@]}"; do
        echo "$((i+1)). ${next_steps[$i]}"
    done
fi

echo -e "\n${YELLOW}Update later:${NC} cd $REPO_DIR && git pull && ./install.sh"