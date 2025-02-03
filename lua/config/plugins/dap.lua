return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      vim.keymap.set('n', '<F5>', function() dap.continue() end)
      vim.keymap.set('n', '<F10>', function() dap.step_over() end)
      vim.keymap.set('n', '<F11>', function() dap.step_into() end)
      vim.keymap.set('n', '<F12>', function() dap.step_out() end)
      vim.keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
      vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
      vim.keymap.set('n', '<Leader>dc', function() dap.repl.toggle() end)
      vim.keymap.set('n', '<Leader>bc', function() dap.clear_breakpoints() end)
      vim.keymap.set('n', '<Leader>bl', function() 
        local dap = require('dap')
        local session = dap.session()
        local qf_list = {}

        if session then
          -- Get breakpoints from active session
          local breakpoints = session.breakpoints
          for _, bp in ipairs(breakpoints) do
            local filename = vim.uri_to_fname(bp.source.path)
            table.insert(qf_list, {
              filename = filename,
              lnum = bp.line,
              text = "Breakpoint at line " .. bp.line
            })
          end
        end

        -- Fallback to standard breakpoints if no active session
        if #qf_list == 0 then
          local default_breakpoints = require('dap.breakpoints').get()
          for _, bp in ipairs(default_breakpoints) do
            local filename = vim.uri_to_fname(bp.uri)
            table.insert(qf_list, {
              filename = filename,
              lnum = bp.line,
              text = "Breakpoint at line " .. bp.line
            })
          end
        end

        if #qf_list == 0 then
          vim.notify("No breakpoints set", vim.log.levels.INFO)
          return
        end

        vim.fn.setqflist(qf_list)
        vim.cmd('copen')  -- Open quickfix window
        vim.notify(string.format("Found %d breakpoints", #qf_list), vim.log.levels.INFO)
      end, { desc = 'List breakpoints in quickfix' })
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  }
}
