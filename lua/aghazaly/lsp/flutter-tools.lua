return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
    'mfussenegger/nvim-dap',
  },
  config = function()
    local api = vim.api

    -- Add the toggle log function
    local function toggle_log()
      local wins = api.nvim_list_wins()

      for _, id in pairs(wins) do
        local bufnr = api.nvim_win_get_buf(id)
        if api.nvim_buf_get_name(bufnr):match '.*/([^/]+)$' == '__FLUTTER_DEV_LOG__' then
          return vim.api.nvim_win_close(id, true)
        end
      end

      pcall(function()
        vim.api.nvim_command 'split + __FLUTTER_DEV_LOG__ | resize 15'
      end)
    end

    -- Set up the keymap for toggling the Flutter dev log
    vim.keymap.set("n", "<leader>fl", toggle_log, { desc = "Toggle Flutter dev log" })
    vim.keymap.set("n", "<leader>fS", "<cmd>FlutterRun<cr>", { desc = "Start Flutter Project" })
    vim.keymap.set("n", "<leader>fr", "<cmd>FlutterReload<cr>", { desc = "Flutter Hot Reload" })
    vim.keymap.set("n", "<leader>fR", "<cmd>FlutterRestart<cr>", { desc = "Flutter Hot Restart" })
    vim.keymap.set("n", "<leader>fe", "<cmd>FlutterEmulators<cr>", { desc = "List of available emulators" })
    vim.keymap.set("n", "<leader>fd", "<cmd>FlutterDevices<cr>", { desc = "List of availabl devices" })
    vim.keymap.set("n", "<leader>cl", "<cmd>FlutterLogClear<cr>", { desc = "Clear the flutter logs" })
    vim.keymap.set("n", "<leader>fd", "<cmd>FlutterDevTools<cr>", { desc = "Open Flutter DevTools" })
    vim.keymap.set("n", "<leader>pg", "<cmd>FlutterPubGet<cr>", { desc = "Run Flutter Pub Get" })
    vim.keymap.set("n", "<leader>pu", "<cmd>FlutterPubUpgrade<cr>", { desc = "Run Flutter Pub Upgrade" })


    -- require("telescope").load_extension("flutter")
    require("flutter-tools").setup {
      ui = {
        border = "rounded",
        notification_style = 'native',
      },
      decorations = {
        statusline = {
          app_version = false,
          device = true,
          project_config = true,
        }
      },
      debugger = {
        enabled = false,
        run_via_dap = true,
        exception_breakpoints = { "raised" },
        evaluate_to_string_in_debug_views = true,
        register_configurations = function(paths)
          local dap = require("dap")
          dap.adapters.dart = {
            type = "executable",
            command = paths.flutter_bin,
            args = { "debug-adapter" },
          }
          dap.configurations.dart = {
            type = "flutter",
            request = "launch",
            name = "Launch flutter",
            dartSdkPath = "$HOME/fvm/default/bin/flutter",
            flutterSdkPath = "$HOME/fvm/default/bin/flutter",
            program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
            cwd = "${workspaceFolder}",

          }
          require("dap.ext.vscode").load_launchjs()
        end,
      },
      root_patterns = { ".git", "pubspec.yaml" },
      fvm = true,
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        enabled = true,
        highlight = 'LineNr',
        prefix = '// ',
        priority = 0,
      },
      dev_log = {
        enabled = true,
        filter = nil,
        notify_errors = false,
        open_cmd = "15split",
      },
      dev_tools = {
        autostart = false,
        auto_open_browser = false,
      },
      outline = {
        open_cmd = "30vnew",
        auto_open = false
      },
      lsp = {
        color = { -- show the derived colours for dart variables
          enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
          background = false, -- highlight the background
          background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
          foreground = false, -- highlight the foreground
          virtual_text = true, -- show the highlight using virtual text
          virtual_text_str = "■", -- the virtual text character to highlight
        },
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = false,
          suggestFromUnimportedLibraries = true,
          closingLabels = true,
          outline = false,
          flutterOutline = false,
        },
        -- see the link below for details on each option:
        -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
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
      --
    }
  end,
}
