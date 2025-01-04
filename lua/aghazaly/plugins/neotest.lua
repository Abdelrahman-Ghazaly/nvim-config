return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    'sidlatau/neotest-dart',
  },
  config = function()
    local neotest = require("neotest")
    neotest.setup({
      adapters = {
        require("neotest-dart") {
          command = 'flutter test --machine',
          use_lsp = true,
        }
      }
    })

    vim.keymap.set("n", "<leader>tc", function()
      neotest.run.run()
    end, { desc = "Runn all tests" })

    vim.keymap.set("n", "<leader>tf", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Run current test file" })
  end
}
