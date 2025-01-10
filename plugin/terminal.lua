local state = {
  buf = -1,
  win = -1,
}

local function create_terminal(opts)
  opts = opts or {}
  local height = opts.width or math.floor(vim.o.lines * 0.25)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    split = 'below',
    win = 0,
    height = height,
    style = "minimal",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

vim.api.nvim_create_user_command("ToggleTerminal", function()
  if not vim.api.nvim_win_is_valid(state.win) then
    state = create_terminal { buf = state.buf, height = 15, }
    if vim.bo[state.buf].buftype ~= "terminal" then
      vim.cmd.term()
    end
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "n", false)
  else
    vim.api.nvim_win_hide(state.win)
  end
end, {})

vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerminal<CR>")
