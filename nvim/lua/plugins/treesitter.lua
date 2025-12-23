return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc", "bash",
        "javascript", "typescript", "json",
        "python", "html", "css",
        "c", "cpp", "go", "vue",
        "yaml", "markdown", "markdown_inline",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
