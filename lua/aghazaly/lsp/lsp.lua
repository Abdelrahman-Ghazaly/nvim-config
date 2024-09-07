return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    -- bridges the gap between mason and lspconfig
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lsp_config = require("lspconfig")
      require("mason").setup()
      require("mason-lspconfig").setup({
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()


      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>dl", vim.diagnostic.setqflist)

      vim.keymap.set({ "n", "i" }, "<C-b>", function()
        vim.lsp.inlay_hint(0, nil)
      end)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          local keymap = vim.keymap -- for conciseness

          -- set keybinds
          opts.desc = "Show LSP references"
          keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

          opts.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

          opts.desc = "Show LSP definitions"
          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

          opts.desc = "Smart rename"
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

          opts.desc = "Show buffer diagnostics"
          keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

          opts.desc = "Show line diagnostics"
          keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

          opts.desc = "Go to next diagnostic"
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

          opts.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end,
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = false,
      })

      local dartExcludedFolders = {
        vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
        vim.fn.expand("$HOME/.pub-cache"),
        vim.fn.expand("/opt/homebrew/"),
        vim.fn.expand("$HOME/fvm/"),
        vim.fn.expand("C:/tools/flutter/"),
      }

      lsp_config["dartls"].setup({
        capabilities = capabilities,
        cmd = {
          "dart",
          "language-server",
          "--protocol=lsp",
          -- "--port=8123",
          -- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
        },
        filetypes = { "dart" },
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = false,
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
          outline = false,
          flutterOutline = false,
        },
        settings = {
          dart = {
            analysisExcludedFolders = dartExcludedFolders,
            updateImportsOnRename = true,
            completeFunctionCalls = true,
            showTodos = true,
          },
        },
      })

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

      -- Tooltip for the lsp in bottom right
      require("fidget").setup({})

      -- Hot reload :)
      require("dart-tools")
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",

      { "j-hui/fidget.nvim", tag = "legacy" },
      -- support for dart hot reload on save
      "RobertBrunhage/dart-tools.nvim",
    },
  },
}
