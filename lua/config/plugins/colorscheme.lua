return {
  'folke/tokyonight.nvim',
  priority = 1000,
  config = function()
    local liine_number_color = '#6C7076'

    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      on_highlights = function(highlights, _)
        highlights.LineNrAbove = { fg = liine_number_color }
        highlights.LineNrBelow = { fg = liine_number_color }
      end,
    }
    vim.cmd 'colorscheme tokyonight-night'
  end,
}
