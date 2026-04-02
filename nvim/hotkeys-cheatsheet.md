# Neovim Hotkey Cheatsheet

Leader key: `Space`

---

## Navigation & Files

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep across project |
| `<leader>fb` | Find open buffers |
| `<leader>fh` | Search help tags |
| `<leader>e` | Toggle file explorer (Neo-tree) |

---

## LSP (works in any language)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>d` | Show line diagnostics |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>q` | Diagnostics list |

---

## Formatting

| Key | Action |
|-----|--------|
| `<leader>f` | Format buffer (Conform / Prettier) |

---

## Git — Fugitive

| Key | Action |
|-----|--------|
| `<leader>gs` | Git status |

## Git — Diffview

| Key | Action |
|-----|--------|
| `<leader>gd` | Diff current branch vs `origin/main` |
| `<leader>gD` | Diff unstaged changes |
| `<leader>gh` | File history (current file) |
| `<leader>gc` | Close diff view |
| `<leader>gv` | Vertical diff: file vs main |

### Inside Diffview
| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file panel |
| `<leader>tf` | Toggle fold (full file / hunks only) |
| `q` | Close diffview |

---

## Line Movement (all filetypes)

| Key | Mode | Action |
|-----|------|--------|
| `<Alt-j>` | Normal | Move current line down |
| `<Alt-k>` | Normal | Move current line up |
| `<Alt-j>` | Visual | Move selection down |
| `<Alt-k>` | Visual | Move selection up |

---

## Markdown (only active in `.md` files)

### Rendering
| Key | Action |
|-----|--------|
| `<leader>mr` | Toggle markdown rendering on/off |

### Checkboxes
| Key | Mode | Action |
|-----|------|--------|
| `<leader>mx` | Normal / Visual | Toggle checkbox `[ ]` ↔ `[x]` |

### Headings
| Key | Action |
|-----|--------|
| `<leader>m]` | Increase heading level (`##` → `#`) |
| `<leader>m[` | Decrease heading level (`#` → `##`) |
| `]]` | Jump to next heading |
| `[[` | Jump to previous heading |

### Folding (collapse / expand sections)
| Key | Action |
|-----|--------|
| `za` | Toggle fold under cursor |
| `zc` | Close fold |
| `zo` | Open fold |
| `zM` | Close all folds |
| `zR` | Open all folds |

### Tables (`<leader>mt` to enable table mode first)
| Key | Action |
|-----|--------|
| `<leader>mt` | Toggle table mode (auto-format on `\|`) |
| `<leader>mT` | Realign table manually |
| `<Tab>` | Move to next cell |
| `<S-Tab>` | Move to previous cell |
| `<leader>mic` | Insert column after cursor |
| `<leader>miC` | Insert column before cursor |
| `<leader>mdc` | Delete column |
| `<leader>mdr` | Delete row |

> To move a column: insert a new column in the target position, fill it, then delete the old one.

### Lists
| Key | Action |
|-----|--------|
| `<Enter>` | (insert mode, inside list) Add next list item |
| `<leader>mo` | Insert list item below (normal mode) |
| `<leader>mO` | Insert list item above (normal mode) |

> Ordered lists (`1.`, `2.`, ...) auto-increment when new items are added.

### Inline Formatting (markdown.nvim operators)
| Key | Action |
|-----|--------|
| `gsib` | Surround inner word with **bold** |
| `gsii` | Surround inner word with *italic* |
| `gsic` | Surround inner word with `code` |
| `ds*` | Remove surrounding `*bold*` markers |
| `cs**_` | Change `**bold**` to `_italic_` |

### Links & Backlinks (markdown-oxide LSP)
| Key | Action |
|-----|--------|
| `<leader>ml` | Follow link under cursor |
| `gd` | Go to `[[wikilink]]` target file |
| `gr` | Show all backlinks to current file |
| `K` | Hover preview of linked note |
| `<leader>rn` | Rename file + update all `[[links]]` |

> In insert mode, typing `[[` triggers autocomplete for filenames in the vault.

---

## Spell Check (auto-enabled in markdown)

| Key | Action |
|-----|--------|
| `]s` | Next misspelled word |
| `[s` | Previous misspelled word |
| `z=` | Suggest corrections |
| `zg` | Add word to dictionary |

---

## Setup / Install

After editing config, run inside Neovim:
```
:Lazy sync          " install / update Lua plugins
:MasonInstall markdown-oxide   " if not auto-installed
```
