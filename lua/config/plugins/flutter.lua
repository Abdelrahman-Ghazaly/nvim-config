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
        vim.api.nvim_command 'split + __FLUTTER_DEV_LOG__ | resize 15'
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
          require("dap").configurations.dart = {}
          require("dap.ext.vscode").load_launchjs()
        end,
      },
      dev_log = {
        enabled = true,
        open_cmd = "15split",
      },
      widget_guides = {
        enabled = false,
      },
      lsp = {
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
            "$HOME/AppData/Local/Pub/Cache",
            "$HOME/.pub-cache",
            "/opt/homebrew/",
            "$HOME/tools/flutter/",
          },
          renameFilesWithClasses = "prompt",
          enableSnippets = true,
          updateImportsOnRename = true,
        }
      }
    }
  end,
}
--[[
]] --
