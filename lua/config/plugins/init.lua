return {
  {
    'nvzone/typr',
    dependencies = 'nvzone/volt',
    cmd = { 'Typr', 'TyprStats' },
    config = function()
      local typr = require 'typr.state'
      typr.linecount = 3
      typr.random = false
    end,
  },
  {
    'karb94/neoscroll.nvim',
    opts = {},
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
}
