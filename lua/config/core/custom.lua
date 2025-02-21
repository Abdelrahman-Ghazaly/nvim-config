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

local data_path = vim.fn.stdpath('data') .. '/typr_timer_data.json'

local function read_data()
  local file = io.open(data_path, 'r')
  if not file then return {} end
  local content = file:read('*a')
  file:close()
  local ok, data = pcall(vim.json.decode, content)
  return ok and data or {}
end

local function write_data(data)
  local file = io.open(data_path, 'w')
  if file then
    file:write(vim.json.encode(data))
    file:close()
  end
end

local function setup_typr_timer()
  local data = read_data()
  local current_time = os.time()

  -- Initialize or read stored times
  local last_run = data.last_run or 0
  local next_scheduled = data.next_scheduled or 0

  -- Check if we should run Typr immediately
  if current_time >= next_scheduled or (current_time - last_run) >= 8 * 3600 then
    print("Running Typr after system wake/start")
    vim.cmd("Typr")
    last_run = current_time
    next_scheduled = current_time + 8 * 3600
    data.last_run = last_run
    data.next_scheduled = next_scheduled
    write_data(data)
  end

  -- Calculate remaining time for next scheduled run
  local time_remaining = math.max(next_scheduled - current_time, 0) * 1000

  -- Setup the timer with explicit empty dict for options
  vim.fn.timer_start(time_remaining, function()
    vim.schedule(function()
      print("Timer triggered, running Typr")
      vim.cmd("Typr")
      local new_data = read_data()
      new_data.last_run = os.time()
      new_data.next_scheduled = os.time() + 8 * 3600
      write_data(new_data)

      -- Setup recurring timer now that we're active
      vim.fn.timer_start(8 * 3600 * 1000, function()
        vim.schedule(function()
          print("Recurring timer triggered, running Typr")
          vim.cmd("Typr")
          local current_time = os.time()
          write_data({
            last_run = current_time,
            next_scheduled = current_time + 8 * 3600
          })
        end)
      end, { ['repeat'] = -1 }) -- Dictionary with repeat key
    end)
  end, vim.empty_dict())        -- Use explicit empty dictionary here
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = setup_typr_timer
})
