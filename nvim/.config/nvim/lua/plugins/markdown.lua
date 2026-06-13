return {
  -- ── markview.nvim ─────────────────────────────────────────────────────
  -- Hybrid inline rendering: renders headings/bullets/code blocks
  -- everywhere EXCEPT the line the cursor is on (so you always edit raw).
  -- Extras: checkbox toggle, heading level change.
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("markview").setup({
        preview = {
          -- Render in these modes, show raw markdown on the cursor line
          modes = { "n", "i", "v", "c" },
          hybrid_modes = { "n", "i", "v" },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(ev)
          local buf = ev.buf
          local map = function(m, lhs, rhs, desc)
            vim.keymap.set(m, lhs, rhs, { buffer = buf, silent = true, desc = desc })
          end

          -- Checkbox toggle
          map("n", "<leader>mx", function()
            require("markview.extras.checkboxes").toggle()
          end, "Toggle checkbox")
          map("v", "<leader>mx", function()
            require("markview.extras.checkboxes").toggle()
          end, "Toggle checkboxes (visual)")

          -- Heading level
          map("n", "<leader>m]", function()
            require("markview.extras.headings").increase()
          end, "Increase heading level")
          map("n", "<leader>m[", function()
            require("markview.extras.headings").decrease()
          end, "Decrease heading level")

          -- Toggle render on/off (useful for copy-pasting raw markdown)
          map("n", "<leader>mr", "<cmd>Markview toggle<cr>", "Toggle markdown render")
        end,
      })
    end,
  },

  -- ── vim-table-mode ────────────────────────────────────────────────────
  -- Auto-formats markdown tables as you type (insert | to trigger).
  -- Tab/Shift-Tab for cell navigation.
  -- <leader>mic/miC to insert columns, <leader>mdc to delete.
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    init = function()
      vim.g.table_mode_corner = "|" -- standard markdown table corners
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(ev)
          local buf = ev.buf
          local map = function(m, lhs, rhs, desc)
            vim.keymap.set(m, lhs, rhs, { buffer = buf, silent = true, desc = desc })
          end

          map("n", "<leader>mt", "<cmd>TableModeToggle<cr>", "Toggle table mode")
          map("n", "<leader>mT", "<cmd>TableModeRealign<cr>", "Realign table")
          -- Column operations (move column = insert new + delete old)
          map("n", "<leader>mic", "<Plug>(table-mode-insert-column-after)", "Insert column after")
          map("n", "<leader>miC", "<Plug>(table-mode-insert-column-before)", "Insert column before")
          map("n", "<leader>mdc", "<Plug>(table-mode-delete-column)", "Delete column")
          map("n", "<leader>mdr", "<Plug>(table-mode-delete-row)", "Delete row")
        end,
      })
    end,
  },

  -- ── markdown.nvim ─────────────────────────────────────────────────────
  -- Treesitter-aware list operations:
  --   Enter in insert mode adds the next list item (- or 1. etc.)
  --   Ordered lists auto-increment numbers.
  -- Inline formatting: gs/ds/cs act on bold/italic/code spans like
  --   text objects (e.g. gsib = surround inner with bold).
  -- Heading navigation: ]] / [[ jump between headings.
  {
    "tadmccorkle/markdown.nvim",
    ft = { "markdown" },
    opts = {
      on_attach = function(bufnr)
        local map = function(m, lhs, rhs, desc)
          vim.keymap.set(m, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        -- List item insertion
        map("n", "<leader>mo", "<Plug>(markdown-insert-item-below)", "Insert list item below")
        map("n", "<leader>mO", "<Plug>(markdown-insert-item-above)", "Insert list item above")

        -- Follow link under cursor ([[wiki]] or [text](url))
        map("n", "<leader>ml", "<Plug>(markdown-follow-link)", "Follow link")

        -- Heading navigation
        map("n", "]]", "<Plug>(markdown-next-heading)", "Next heading")
        map("n", "[[", "<Plug>(markdown-prev-heading)", "Previous heading")
      end,
    },
  },
}
