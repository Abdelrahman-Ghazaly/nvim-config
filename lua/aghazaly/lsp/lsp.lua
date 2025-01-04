return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "j-hui/fidget.nvim", tag = "legacy" },
      "RobertBrunhage/dart-tools.nvim",
    },
    config = function()
      local lsp_config = require("lspconfig")
      require("fidget").setup()
      require("mason").setup()
      require("dart-tools")
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>dl", vim.diagnostic.setqflist)


      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = false,
      })

      -- local dartExcludedFolders = {
      --   vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
      --   vim.fn.expand("$HOME/.pub-cache"),
      --   vim.fn.expand("/opt/homebrew/"),
      --   vim.fn.expand("$HOME/fvm/"),
      --   vim.fn.expand("C:/tools/flutter/"),
      -- }

      -- lsp_config["dartls"].setup({
      --   on_attach = function(_, bufnr)
      --     -- Enable folding
      --     vim.api.nvim_buf_set_option(bufnr, 'foldmethod', 'expr')
      --     vim.api.nvim_buf_set_option(bufnr, 'foldexpr', 'nvim_treesitter#foldexpr()')
      --   end,
      --   capabilities = capabilities,
      --   cmd = {
      --     "dart",
      --     "language-server",
      --     "--protocol=lsp",
      --     -- "--port=8123",
      --     -- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
      --   },
      --   filetypes = { "dart" },
      --   init_options = {
      --     onlyAnalyzeProjectsWithOpenFiles = false,
      --     suggestFromUnimportedLibraries = true,
      --     closingLabels = true,
      --     outline = false,
      --     flutterOutline = false,
      --   },
      --   settings = {
      --     dart = {
      --       analysisExcludedFolders = dartExcludedFolders,
      --       updateImportsOnRename = true,
      --       completeFunctionCalls = true,
      --       showTodos = true,
      --     },
      --   },
      -- })

      lsp_config.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },
}
