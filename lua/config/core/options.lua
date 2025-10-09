vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

local set = vim.o

-- Basic settings
set.number = true                              -- Line numbers
set.relativenumber = true                      -- Relative line numbers
set.cursorline = true                          -- Highlight current line
set.wrap = false                               -- Don't wrap lines
set.scrolloff = 10                             -- Keep 10 lines above/below cursor 
set.sidescrolloff = 8                          -- Keep 8 columns left/right of cursor

-- Indentation
set.tabstop = 2                                -- Tab width
set.shiftwidth = 2                             -- Indent width
set.softtabstop = 2                            -- Soft tab stop
set.expandtab = true                           -- Use spaces instead of tabs
set.smartindent = true                         -- Smart auto-indenting
set.autoindent = true                          -- Copy indent from current line

-- Search settings
set.ignorecase = true                          -- Case insensitive search
set.smartcase = true                           -- Case sensitive if uppercase in search
set.hlsearch = false                           -- Don't highlight search results 
set.incsearch = true                           -- Show matches as you type

-- Visual settings
set.termguicolors = true                       -- Enable 24-bit colors
set.signcolumn = "yes"                         -- Always show sign column
set.showmatch = true                           -- Highlight matching brackets
set.matchtime = 2                              -- How long to show matching bracket
set.cmdheight = 1                              -- Command line height
set.completeopt = "menuone,noinsert,noselect"  -- Completion options 
set.showmode = false                           -- Don't show mode in command line 
set.pumheight = 10                             -- Popup menu height 
set.pumblend = 10                              -- Popup menu transparency 
set.winblend = 0                               -- Floating window transparency 
set.conceallevel = 0                           -- Don't hide markup 
set.concealcursor = ""                         -- Don't hide cursor line markup 
set.lazyredraw = true                          -- Don't redraw during macros
set.synmaxcol = 300                            -- Syntax highlighting limit

-- File handling
set.backup = false                             -- Don't create backup files
set.writebackup = false                        -- Don't create backup before writing
set.swapfile = false                           -- Don't create swap files
set.undofile = true                            -- Persistent undo
set.undodir = vim.fn.expand("~/.vim/undodir")  -- Undo directory
set.updatetime = 250                           -- Faster completion
set.timeoutlen = 300                           -- Key timeout duration
set.ttimeoutlen = 0                            -- Key code timeout
set.autoread = true                            -- Auto reload files changed outside vim
set.autowrite = false                          -- Don't auto save

-- Behavior settings
set.hidden = true                              -- Allow hidden buffers
set.errorbells = false                         -- No error bells
set.backspace = "indent,eol,start"             -- Better backspace behavior
set.autochdir = false                          -- Don't auto change directory
vim.opt.iskeyword:append("-")                      -- Treat dash as part of word
vim.opt.path:append("**")                          -- include subdirectories in search
set.selection = "exclusive"                    -- Selection behavior
set.mouse = "a"                                -- Enable mouse support
vim.opt.clipboard:append("unnamedplus")            -- Use system clipboard
set.modifiable = true                          -- Allow buffer modifications
set.encoding = "UTF-8"                         -- Set encoding

-- Folding settings
set.foldmethod = "expr"                             -- Use expression for folding
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
set.foldlevel = 99                                  -- Start with all folds open

-- Split behavior
set.splitbelow = true                          -- Horizontal splits go below
set.splitright = true                          -- Vertical splits go right

