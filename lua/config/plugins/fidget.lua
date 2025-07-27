return {
  'j-hui/fidget.nvim',
  opts = {
    text = {
      spinner = 'dots',
    },
    window = {
      blend = 0,
      border = 'rounded',
    },
  },
  config = function()
    require('fidget').setup {}
  end,
}
