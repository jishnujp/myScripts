return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen origin/main...HEAD<cr>", desc = "Diff vs main" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close diff" },
    { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Diff unstaged" },
    { "<leader>gv", "<cmd>Gvdiffsplit origin/main:%<cr>", desc = "Diff file vs main" },
  },
  config = function()
    local actions = require("diffview.actions")

    require("diffview").setup({
      enhanced_diff_hl = true,
      diff_binaries = false,
      use_icons = true,
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        file_history = {
          layout = "diff2_horizontal",
        },
      },
      file_panel = {
        win_config = {
          width = 35,
        },
      },
      default_args = {
        DiffviewOpen = { "--imply-local" },
        DiffviewFileHistory = { "--base=LOCAL" },
      },
      hooks = {
        diff_buf_read = function(bufnr)
          -- Disable folding to show full file
          vim.opt_local.foldenable = false
        end,
      },
      keymaps = {
        view = {
          { "n", "<leader>e", actions.toggle_files, { desc = "Toggle file panel" } },
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } },
          { "n", "<leader>tf", function()
            vim.opt_local.foldenable = not vim.opt_local.foldenable:get()
          end, { desc = "Toggle fold (full/hunks)" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close" } },
        },
      },
    })
  end,
}
