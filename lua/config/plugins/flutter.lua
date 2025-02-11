return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
    'mfussenegger/nvim-dap',
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    local function toggle_log()
      local wins = vim.api.nvim_list_wins()

      for _, id in pairs(wins) do
        local bufnr = vim.api.nvim_win_get_buf(id)
        if vim.api.nvim_buf_get_name(bufnr):match '.*/([^/]+)$' == '__FLUTTER_DEV_LOG__' then
          return vim.api.nvim_win_close(id, true)
        end
      end

      pcall(function()
        vim.api.nvim_command 'bot split + __FLUTTER_DEV_LOG__ | resize 15'
      end)
    end

    vim.keymap.set("n", "<leader>fl", toggle_log, { desc = "Toggle Flutter dev log" })

    require("flutter-tools").setup {
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

          -- Add default configuration if none exists
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
      dev_log = {
        enabled = true,
        open_cmd = "bot 15split", -- Changed to open at bottom
      },
      widget_guides = {
        enabled = false,
      },
      lsp = {
        autostart = true,
        capabilities = capabilities,
        on_attach = function(client, buffer) -- <-- Use on_attach instead of LspAttach autocmd
          -- Format-on-save handler
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = buffer,
              callback = function()
                -- Check if client is still active before formatting
                local active_clients = vim.lsp.get_active_clients({ bufnr = buffer })
                if vim.tbl_contains(active_clients, client) then
                  vim.lsp.buf.format({ bufnr = buffer })
                end
              end,
            })
          end
        end,
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
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
        }
      }
    }
  end,
}
