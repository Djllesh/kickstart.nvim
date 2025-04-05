vim.opt.shell = 'pwsh'
-- Terminal settings
local job_id = 0
local filename = ''
-- CWD meaning the directory from which the terminal was called
local cwd = ''

local float_state = {
  buf = -1,
  win = -1,
  job_id = -1,
}

local function open_bottom_term()
  filename = vim.fn.expand '%:p'
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 10)
  job_id = vim.bo.channel
end

local function open_float_term(opts)
  cwd = vim.fn.expand '%:h'
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.9)
  local height = opts.heigth or math.floor(vim.o.lines * 0.9)

  -- Calculate the position
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file scratch buffer
  end

  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    border = 'single',
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

vim.keymap.set('n', '<leader>ft', function()
  if not vim.api.nvim_win_is_valid(float_state.win) then
    float_state = open_float_term { buf = float_state.buf }
    if vim.bo[float_state.buf].buftype ~= 'terminal' then
      vim.cmd.term()
      vim.fn.chansend(vim.bo.channel, 'cd ' .. cwd .. '\r\n' .. 'lazygit \r\n')
      vim.cmd.startinsert()
    end
  else
    vim.api.nvim_win_hide(float_state.win)
  end
end)

-- Open terminal in insert mode
vim.keymap.set('n', '<leader>st', function()
  open_bottom_term()
  vim.cmd.startinsert()
end)

-- Run the python file
vim.keymap.set('n', '<leader>rp', function()
  open_bottom_term()
  vim.fn.chansend(job_id, 'python ' .. filename .. '\r\n')
end)
