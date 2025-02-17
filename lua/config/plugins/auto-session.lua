return {
  "rmagatti/auto-session",
  enabled = false,
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      bypass_save_filetypes = { 'alpha' },
      auto_restore_last_session = true,
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
  end,
}
