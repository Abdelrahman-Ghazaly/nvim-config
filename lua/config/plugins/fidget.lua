return {
  "j-hui/fidget.nvim",
  opts = {},
  config = function()
    require("fidget").setup {
      text = {
        spinner = "dots",
      },
      window = {
        blend = 0,
        border = "rounded",
      },
    }
  end
}
