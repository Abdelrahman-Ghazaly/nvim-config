vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

local set = vim.o

set.number = true
set.relativenumber = true

set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.autoindent = true

set.wrap = false

set.ignorecase = true
set.smartcase = true

set.cursorline = true

set.termguicolors = true
set.background = 'dark'
set.signcolumn = 'yes'

set.backspace = 'indent,eol,start'

set.splitright = true

set.swapfile = false

set.conceallevel = 1

set.mouse = 'a'

set.showmode = false

set.breakindent = true

set.undofile = true

set.ignorecase = true
set.smartcase = true

set.signcolumn = 'yes'

set.updatetime = 250

set.timeoutlen = 300

set.splitright = true
set.splitbelow = true

set.list = true

set.inccommand = 'split'

set.scrolloff = 15

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.clipboard:append 'unnamedplus'
