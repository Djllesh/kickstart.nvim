vim.opt.shell = 'pwsh'
-- Terminal settings
local job_id = 0
local filename = ''
local function open_bottom_term()
  filename = vim.fn.expand '%:p'
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 10)
  job_id = vim.bo.channel
end

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
