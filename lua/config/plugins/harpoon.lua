return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Add to harpoon" })

    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "View harpoon" })

    vim.keymap.set("n", "<C-x>", function()
      harpoon:list():clear()
    end, { desc = "Clear harpoon" })

    vim.keymap.set("n", "<C-h>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<C-j>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<C-k>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<C-l>", function()
      harpoon:list():select(4)
    end)
  end,
}
