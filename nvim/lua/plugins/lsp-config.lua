return {
  -- Mason: Package manager for LSP servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-lspconfig: Bridge between Mason and LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "pyright",
          "ts_ls",
          "vue_ls", -- This is vue-language-server in mason-lspconfig
          "gopls",
          "bashls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- nvim-lspconfig: Provides base configurations for servers
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Set up LspAttach autocommand for keybindings (runs per-buffer)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local bufnr = ev.buf

          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
          end

          map("n", "gd", vim.lsp.buf.definition, "Definition")
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "gi", vim.lsp.buf.implementation, "Implementation")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "gr", vim.lsp.buf.references, "References")

          -- Diagnostics
          map("n", "<leader>d", vim.diagnostic.open_float, "Line Diagnostics")
          map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
          map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics List")
        end,
      })

      -- Server-specific configurations
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      vim.lsp.config("vue_ls", {
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
      })

      -- Enable all servers (auto-starts when matching filetype is opened)
      vim.lsp.enable({
        "lua_ls",
        "clangd",
        "pyright",
        "ts_ls",
        "vue_ls",
        "gopls",
        "bashls",
      })
    end,
  },
}
