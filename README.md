# myScripts

Quick Ubuntu server setup with useful scripts and Neovim configuration.

## 🚀 Quick Installation

```bash
git clone https://github.com/jishnujp/myScripts.git ~/myScripts
cd ~/myScripts
chmod +x install.sh
./install.sh
```

Or one-liner:
```bash
git clone https://github.com/jishnujp/myScripts.git ~/myScripts && cd ~/myScripts && chmod +x install.sh && ./install.sh
```

### Installation Options

**Install everything (default):**
```bash
./install.sh
```

**Install only Neovim configuration:**
```bash
./install.sh --nvim-only
```

**See all options:**
```bash
./install.sh --help
```

## 🎯 Installation Modes

The installer supports flexible installation options to suit your needs:

| Option | Description |
|--------|-------------|
| `--nvim-only` | Install only Neovim configuration |
| `--scripts-only` | Install only command-line scripts (bin/) |
| `--no-nvim` | Install everything except Neovim config |
| `--no-scripts` | Install everything except scripts |
| `--minimal` | Create directories only, no scripts or nvim |
| `--no-path` | Don't modify shell PATH configuration |
| `--dry-run` | Preview what would be installed |
| `--force` | Skip backup of existing nvim config |
| `-h, --help` | Show help message |

### Common Use Cases

**Neovim configuration only:**
```bash
./install.sh --nvim-only
```

**Scripts without modifying PATH:**
```bash
./install.sh --scripts-only --no-path
```

**Everything except Neovim:**
```bash
./install.sh --no-nvim
```

**Preview before installing:**
```bash
./install.sh --dry-run
```

**Quick nvim update (skip existing backup):**
```bash
./install.sh --nvim-only --force
```

## 📦 What's Included

### Command-Line Tools (added to PATH)

- **`backup <folder>`** - Create timestamped tar.gz backups
  ```bash
  backup ~/Documents
  ```

- **`practice <project-name>`** - Create Python practice environment with venv
  ```bash
  practice django
  ```

- **`closeall`** - Close all open windows (requires wmctrl)
  ```bash
  closeall
  ```

- **`simple-server`** - Start a simple HTTP server on localhost:1500
  ```bash
  simple-server
  ```

### Automated Scripts (cron)

- **`wallpaper.sh`** - Randomly change GNOME wallpaper
- **`unsplashed.sh`** - Download wallpapers from Unsplash API
- **`cleaner.sh`** - Clean old screenshots, downloads, and duplicates

## ⚙️ Configuration

### 1. API Keys Setup

```bash
cd ~/myScripts
cp config/keys.json.example config/keys.json
nano config/keys.json  # Add your Unsplash API key
```

Get your Unsplash API key at: https://unsplash.com/developers

### 2. Cron Jobs Setup

```bash
crontab -e
# Add lines from config/cron_jobs.txt (update paths first!)
```

**Update the paths in cron_jobs.txt before adding them!**

## 📁 Repository Structure

```
myScripts/
├── install.sh              # Main installer
├── bin/                    # Executable scripts (added to PATH)
│   ├── backup
│   ├── practice
│   ├── closeall
│   └── simple-server
├── cron/                   # Automated scripts
│   ├── wallpaper.sh
│   ├── unsplashed.sh
│   └── cleaner.sh
├── config/                 # Configuration files
│   ├── cron_jobs.txt
│   └── keys.json.example
└── nvim/                   # Neovim configuration
```

## 🔄 Updating

**Update everything:**
```bash
cd ~/myScripts
git pull
./install.sh
```

**Update only Neovim config:**
```bash
cd ~/myScripts
git pull
./install.sh --nvim-only
```

**Update only scripts:**
```bash
cd ~/myScripts
git pull
./install.sh --scripts-only
```

## 🛠️ Dependencies

**Required:**
- git
- bash

**Optional:**
- neovim (for nvim config)
- jq, curl (for unsplashed.sh)
- wmctrl (for closeall)
- gsettings/GNOME (for wallpaper.sh)

Install on Ubuntu:
```bash
sudo apt update
sudo apt install git neovim jq curl wmctrl
```

## 📝 Notes

- Backups are stored in `~/backup/`
- Wallpapers are stored in `~/Pictures/Background/`
- Practice projects go to `~/Desktop/practice/`
- Scripts use `$HOME` for portability across servers
- Nvim config is symlinked (changes sync with repo)

## 🤝 Contributing

Feel free to fork and customize for your own use!