vim.g.mapleader = " "

local set = vim.opt

set.number = true
set.relativenumber = true

set.tabstop = 2       -- 2 spaces for tabs
set.shiftwidth = 2    -- 2 spaces for indent width
set.expandtab = true  -- expand tab to spaces
set.autoindent = true -- copy indent from current line when starting new one

set.wrap = false

set.ignorecase = true -- ignore case when searching
set.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

set.cursorline = true

set.termguicolors = true
set.background = "dark"             -- colorschemes that can be light or dark will be made dark
set.signcolumn = "yes"              -- show sign column so that text doesn't shift

set.backspace = "indent,eol,start"  -- allow backspace on indent, end of line or insert mode start position

set.clipboard:append("unnamedplus") -- use system clipboard as default register

set.splitright = true               -- split vertical window to the right

set.swapfile = false
