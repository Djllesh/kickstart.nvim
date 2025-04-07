-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Source the file' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

-- Easy visual indentation
vim.keymap.set('v', '<', '<gv', { desc = 'Indend to the left without leaving the visual mode' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indend to the right without leaving the visual mode' })

vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move with centered position' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move with centered position' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next with centered position' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous with centered postition' })
vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Copy without losing the buffer' })

vim.keymap.set('n', 'o', 'o<Esc>0"_D', { desc = 'Create the line under, no insert mode' })
vim.keymap.set('n', 'O', 'O<Esc>0"_D', { desc = 'Create the line above, no insert mode' })

-- Navigation within windows
vim.keymap.set('n', '<leader>we', '<C-w>w', { desc = 'Go to opposite window' })
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split the window vertically' })
vim.keymap.set('n', '<leader>wu', '<C-w>s', { desc = 'Split the window horizontally' })
vim.keymap.set('n', '<leader>wq', '<C-w>q', { desc = 'Close the current window' })
vim.keymap.set('n', '<leader>wx', '<C-w>x', { desc = 'Exchange current window with next one' })

-- Resizing the windows
vim.keymap.set('n', '<A-<>', '<C-w>3<', { desc = 'Decrease current window width' })
vim.keymap.set('n', '<A->>', '<C-w>3>', { desc = 'Increase curernt window width' })
vim.keymap.set('n', '<A-S>', '<C-w>-', { desc = 'Decrease current window height' })
vim.keymap.set('n', '<A-T>', '<C-w>+', { desc = 'Increase curernt window height' })
vim.keymap.set('n', '<A-=>', '<C-w>=', { desc = 'Make windows equally high and wide' })

-- Moving the windows
vim.keymap.set('n', '<leader>wj', '<C-w>J', { desc = 'Move the window down' })
vim.keymap.set('n', '<leader>wk', '<C-w>K', { desc = 'Move the window up' })
vim.keymap.set('n', '<leader>wh', '<C-w>H', { desc = 'Move the window left' })
vim.keymap.set('n', '<leader>wl', '<C-w>L', { desc = 'Move the window right' })

-- NOTE: Some terminals have coliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
