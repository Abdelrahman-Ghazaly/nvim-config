vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Remove line numbers and relative numbers for the terminal window',
  group = vim.api.nvim_create_augroup('cutom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- For testing, use a 5-second interval
local test_interval = 5000
local final_interval = 8 * 3600 * 1000  -- 8 hours in ms

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    print("VimEnter: Setting up Typr timer")
    vim.fn.timer_start(final_interval, function()
      vim.schedule(function()
        print("Timer triggered, running Typr")
        vim.cmd("Typr")
      end)
    end, {["repeat"] = -1}) 
  end,
})
