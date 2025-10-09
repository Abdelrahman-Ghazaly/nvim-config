return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local nvimtree = require 'nvim-tree'

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      nvimtree.setup {
        notify = {
          threshold = vim.log.levels.OFF,
        },
        view = {
          width = 35,
          relativenumber = true,
          side = 'right',
        },

        renderer = {
          indent_markers = {
            enable = true,
          },
          icons = {
            glyphs = {
              folder = {
                arrow_closed = '',
                arrow_open = '',
              },
            },
          },
        },

        actions = {
          open_file = {
            quit_on_open = true,
            window_picker = {
              enable = true,
            },
          },
        },
        filters = {
          custom = { '.DS_Store', '^.git$' },
        },
        git = {
          ignore = false,
        },
      }

      local keymap = vim.keymap

      keymap.set('n', '<leader>ee', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Toggle file explorer on current file' })
      keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = 'Collapse file explorer' })
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
  },
}
