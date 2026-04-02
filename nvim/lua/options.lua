local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation (2 spaces for web dev)
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"

-- Behavior
opt.hidden = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- File handling
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- ── Markdown-specific overrides ────────────────────────────────────────
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local wo = vim.wo
    -- Treesitter-based fold by heading: za/zc/zo to open/close sections
    wo.foldmethod  = "expr"
    wo.foldexpr    = "v:lua.vim.treesitter.foldexpr()"
    wo.foldlevel   = 99    -- start fully unfolded
    -- Prose display
    wo.wrap        = true
    wo.linebreak   = true
    wo.breakindent = true
    -- Concealment (markview uses this to render inline elements)
    wo.conceallevel  = 2
    wo.concealcursor = "nc"
    -- Spell check (spell is window-local, spelllang is buffer-local)
    wo.spell = true
    vim.opt_local.spelllang = "en_us"
    -- No 80-char ruler for prose
    wo.colorcolumn = ""
  end,
})
