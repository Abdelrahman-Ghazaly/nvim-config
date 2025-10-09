return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
    'mfussenegger/nvim-dap',
    'saghen/blink.cmp',
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
    local flutter_tools = require("flutter-tools")

    local util = require("lspconfig.util")

    vim.keymap.set("n", "<leader>fs", "<cmd>FlutterRun<cr>", { desc = "Run Flutter project" })
    vim.keymap.set("n", "<leader>fq", "<cmd>FlutterQuit<cr>", { desc = "Quit Flutter project" })
    vim.keymap.set("n", "<leader>fe", "<cmd>FlutterEmulators<cr>", { desc = "Open Flutter devices" })
    vim.keymap.set("n", "<leader>fr", "<cmd>FlutterReload<cr>", { desc = "Flutter Hot Reload" })
    vim.keymap.set("n", "<leader>fR", "<cmd>FlutterRestart<cr>", { desc = "Flutter Hot Restart" })
    vim.keymap.set("n", "<leader>fd", "<cmd>FlutterOpenDevTools<cr>", { desc = "Open Flutter Dev Tools" })

    flutter_tools.setup {
      ui = {
        border = "rounded",
        notification_style = 'fidget',
      },
      decorations = {
        statusline = {
          device = true,
          project_config = true,
        }
      },
      debugger = {
        enabled = true,
        exception_breakpoints = { "raised" },
        register_configurations = function(_)
          local dap = require("dap")
          dap.configurations.dart = {}
          require("dap.ext.vscode").load_launchjs()
          if not dap.configurations.dart or #dap.configurations.dart == 0 then
            dap.configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "${workspaceFolderBasename} - Debug",
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
                toolArgs = {},
              }
            }
          end
        end,
      },
      dev_log = { enabled = false },
      widget_guides = {
        enabled = false,
      },
      lsp = {
        autostart = true,
        capabilities = capabilities,
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = true,
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = {
            vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
            vim.fn.expand("$HOME/.pub-cache"),
            "/opt/homebrew/",
            vim.fn.expand("$HOME/tools/flutter/"),
          },
          renameFilesWithClasses = "always",
          enableSnippets = true,
          updateImportsOnRename = true,
        },
        root_dir = function(fname)
          local git_root = util.find_git_ancestor(fname)
          if git_root then
            return git_root
          end

          return util.root_pattern("pubspec.yaml")(fname)
        end,
      }
    }
  end,
}
