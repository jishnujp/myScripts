return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- Load before other plugins so the UI has a consistent theme
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- Options: latte, frappe, macchiato, mocha

      -- Optional minimalistic tweaks
      transparent_background = true,
      term_colors = true,

      integrations = {
        nvimtree = true,
        telescope = true,
        treesitter = true,
        gitsigns = true,
        cmp = true,
        markdown = true,
        native_lsp = {
          enabled = true,
        },
      },
    })

    -- Apply the colorscheme
    vim.cmd.colorscheme("catppuccin")
  end,
}

