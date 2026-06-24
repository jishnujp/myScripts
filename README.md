# dotfiles

Personal workflow and preference files for a new server/laptop: bash, Neovim, tmux, git, scripts, cron helpers, and a small Pi-only AI scaffold.

The core dotfiles are installed with GNU Stow. Scripts and AI files are kept in the repo but are not stowed into `$HOME` by default.

## Quick installation

```bash
git clone https://github.com/jishnujp/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

One-liner:

```bash
git clone https://github.com/jishnujp/dotfiles.git ~/dotfiles && cd ~/dotfiles && ./install.sh
```

## What `install.sh` does

- Ensures GNU Stow is installed, or prompts to install it.
- Stows only these packages by default:
  - `bash` → `~/.bashrc`, `~/.bash_aliases`, `~/.profile`, `~/.inputrc`, `~/.bashrc.local.example`
  - `nvim` → `~/.config/nvim`
  - `tmux` → `~/.tmux.conf`
  - `git` → `~/.gitconfig`, `~/.gitignore_global`
- Does **not** stow `scripts/`, `ai/`, `assets/`, or `docs/`.
- The managed `~/.bashrc` adds `~/dotfiles/scripts/bin` to `PATH` and sources `~/.bashrc.local` when present.
- Prompts interactively when existing target files conflict:
  - back up existing targets and continue
  - skip that package
  - abort
- Prints a secret-hygiene reminder before you commit anything.

## Repository structure

```text
dotfiles/
├── install.sh
├── README.md
├── nvim/
│   └── .config/nvim/          # Stow package for ~/.config/nvim
├── tmux/
│   └── .tmux.conf             # Stow package for ~/.tmux.conf
├── git/
│   ├── .gitconfig             # Stow package for ~/.gitconfig
│   └── .gitignore_global      # Stow package for ~/.gitignore_global
├── bash/
│   ├── .bashrc                # managed bash baseline copied from this machine
│   ├── .bash_aliases
│   ├── .profile
│   ├── .inputrc
│   └── .bashrc.local.example  # template for ignored machine-local shell config
├── scripts/
│   ├── bin/                   # user-invoked commands, added to PATH by bash/.bashrc
│   └── cron/                  # cron/scheduled-job scripts and templates
├── ai/
│   └── pi/                    # Pi-only scaffold, not installed by default
├── assets/                    # reserved for future assets
└── docs/                      # planning/decision/task docs
```

## Scripts

After installation and reloading your shell, commands in `scripts/bin/` are available on `PATH`.

Current commands include:

- `backup <folder>` — create timestamped tar.gz backups in `~/backup/`
- `practice <project-name>` — create a Python practice environment
- `closeall` — close open windows, requires `wmctrl`
- `simple-server` — start a tiny local HTTP response on port `1500`
- `pi-workflow-init` — helper for Pi workflow setup

Cron helpers live in `scripts/cron/` and are not installed automatically. Review/edit paths before adding them to your crontab.

## Shell local config

Machine-specific shell settings belong in:

```bash
~/.bashrc.local
```

Create it from the example if needed:

```bash
cp ~/.bashrc.local.example ~/.bashrc.local
```

`~/.bashrc.local` is sourced by the managed `~/.bashrc` and should not be committed.

## Manual Stow usage

```bash
cd ~/dotfiles
stow bash
stow nvim
stow tmux
stow git
stow -D nvim   # unstow
stow -R nvim   # restow
```

Do not run `stow */`; that would try to stow non-dotfile directories such as `scripts/`, `ai/`, `assets/`, and `docs/`.

## Dependencies

Required:

- git
- bash
- GNU Stow

Optional, depending on what you use:

- neovim
- jq, curl
- wmctrl
- gsettings/GNOME tools
- xclip, for tmux clipboard behavior

Ubuntu example:

```bash
sudo apt update
sudo apt install git stow neovim jq curl wmctrl xclip
```

## Secret hygiene

Do not commit credentials, OAuth tokens, PATs, local shell settings, `.env` files, or machine-local agent settings.

Before committing, run:

```bash
git status --short --ignored
git ls-files | grep -Ei '(^|/)(\.env|.*\.local|settings\.local\.json|credentials|token.*\.json)$' || true
```

Important: adding a pattern to `.gitignore` does **not** untrack a file that is already tracked. If a secret-like file is tracked, remove it from git without deleting your local copy:

```bash
git rm --cached <file>
```

## Updating

```bash
cd ~/dotfiles
git pull
./install.sh
```
