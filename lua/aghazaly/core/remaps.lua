vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>pq", "<cmd>Ex<CR>")

keymap.set("n", ";", ":", { desc = "Enters Command mode" })

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<C-s>", ":wa<CR>", { desc = "Saves all files" })

keymap.set("i", "<C-s>", "<ESC> :wa<CR>", { desc = "Saves all files" })
