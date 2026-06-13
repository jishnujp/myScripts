local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Leader key
vim.g.mapleader = " "

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", "Find files")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", "Live grep")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", "Find buffers")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", "Help search")

-- Neo-tree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", "Toggle file explorer")

-- Git (Fugitive)
map("n", "<leader>gs", "<cmd>Git<cr>", "Git status")

-- ── Move lines up/down (all filetypes) ────────────────────────────────
map("n", "<A-j>", "<cmd>move .+1<cr>==", "Move line down")
map("n", "<A-k>", "<cmd>move .-2<cr>==", "Move line up")
map("v", "<A-j>", ":move '>+1<cr>gv=gv", "Move selection down")
map("v", "<A-k>", ":move '<-2<cr>gv=gv", "Move selection up")

