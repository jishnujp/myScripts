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

