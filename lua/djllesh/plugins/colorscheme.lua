vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'vsassist',
  callback = function()
    vim.cmd 'hi! link NormalFloat Normal'
    vim.cmd 'hi! link FloatBorder NormalFloat'
  end,
})

line_numbers = function()
  local groups = {
    'LineNrAbove6',
    'LineNrAbove5',
    'LineNrAbove4',
    'LineNrAbove3',
    'LineNrAbove2',
    'LineNrAbove1',
    'CursorLineNr',
    'LineNrBelow1',
    'LineNrBelow2',
    'LineNrBelow3',
    'LineNrBelow4',
    'LineNrBelow5',
    'LineNrBelow6',
  }

  hl_groups = {}

  for idx, group in ipairs(groups) do
    -- hl_groups is the map {[shift from the current line] = [highlight group]}
    hl_groups[idx - math.ceil(#groups / 2)] = group
  end

  vim.api.nvim_set_hl(0, 'LineNrAbove6', { fg = '#664743' })
  vim.api.nvim_set_hl(0, 'LineNrAbove5', { fg = '#7b180b' })
  vim.api.nvim_set_hl(0, 'LineNrAbove4', { fg = '#df3712' })
  vim.api.nvim_set_hl(0, 'LineNrAbove3', { fg = '#ed530f' })
  vim.api.nvim_set_hl(0, 'LineNrAbove2', { fg = '#f36c0a' })
  vim.api.nvim_set_hl(0, 'LineNrAbove1', { fg = '#f98705' })
  vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#FFA500', bold = true })
  vim.api.nvim_set_hl(0, 'LineNrBelow1', { fg = '#f98705' })
  vim.api.nvim_set_hl(0, 'LineNrBelow2', { fg = '#f36c0a' })
  vim.api.nvim_set_hl(0, 'LineNrBelow3', { fg = '#ed530f' })
  vim.api.nvim_set_hl(0, 'LineNrBelow4', { fg = '#df3712' })
  vim.api.nvim_set_hl(0, 'LineNrBelow5', { fg = '#7b180b' })
  vim.api.nvim_set_hl(0, 'LineNrBelow6', { fg = '#664743' })

  -- Namespace for our highlights to avoid conflicts and allow easy clearing
  local ns = vim.api.nvim_create_namespace 'AdjacentLineNrHighlight'

  local function update_adjacent_line_nr_highlights()
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()
    -- Check if the buffer is valid and listed
    if not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].buflisted then
      return
    end

    local line = vim.api.nvim_win_get_cursor(win)[1] -- 1-based line number
    local total_lines = vim.api.nvim_buf_line_count(buf)

    -- Clear previous extmarks in our namespace for the current buffer
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    -- Apply new extmarks for adjacent lines
    for shift, hl_group in pairs(hl_groups) do
      local target_line_1based = line + shift
      -- Ensure the target line is within buffer bounds
      if target_line_1based >= 1 and target_line_1based <= total_lines then
        -- API uses 0-based line index
        local target_line_0based = target_line_1based - 1
        -- Set extmark for the number column highlight on the target line
        vim.api.nvim_buf_set_extmark(buf, ns, target_line_0based, 0, {
          number_hl_group = hl_group,
        })
      end
    end
  end

  -- Autocommand group to ensure clean setup
  local group = vim.api.nvim_create_augroup('AdjacentLineNrHighlighter', { clear = true })

  -- Trigger update on cursor movement and buffer entry
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufWinEnter', 'WinEnter' }, {
    group = group,
    pattern = '*', -- Apply to all buffers/windows
    callback = function()
      -- Basic check to avoid running in non-normal buffers
      if vim.bo.buftype == '' and vim.api.nvim_win_is_valid(vim.api.nvim_get_current_win()) then
        pcall(update_adjacent_line_nr_highlights)
      end
    end,
    desc = 'Update adjacent line number highlights',
  })

  -- Call once on startup for the initial buffer
  -- This needs to be deferred slightly until UI is ready
  vim.defer_fn(function()
    if vim.bo.buftype == '' and vim.api.nvim_win_is_valid(vim.api.nvim_get_current_win()) then
      pcall(update_adjacent_line_nr_highlights)
    end
  end, 100) -- Delay 100ms, adjust if needed
end

vim.keymap.set('n', '<leader>vl', '<cmd>lua line_numbers()<CR>', { desc = 'Set the line numbers colors' })

return {
  {
    'vague2k/vague.nvim',
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require('vague').setup {
        -- optional configuration here
        transparent = false, -- don't set background
        style = {
          -- "none" is the same thing as default. But "none" and "bold" are also valid options
          boolean = 'bold',
          number = 'none',
          float = 'none',
          error = 'bold',
          comments = 'none',
          conditionals = 'none',
          functions = 'none',
          headings = 'bold',
          operators = 'none',
          strings = 'none',
          variables = 'none',

          -- keywords
          keywords = 'none',
          keyword_return = 'none',
          keywords_loop = 'none',
          keywords_label = 'none',
          keywords_exception = 'none',

          -- builtin
          builtin_constants = 'bold',
          builtin_functions = 'none',
          builtin_types = 'bold',
          builtin_variables = 'none',
        },
        -- plugin styles where applicable
        -- make an issue/pr if you'd like to see more styling options!
        plugins = {
          cmp = {
            match = 'bold',
            match_fuzzy = 'bold',
          },
          dashboard = {
            footer = 'none',
          },
          lsp = {
            diagnostic_error = 'bold',
            diagnostic_hint = 'none',
            diagnostic_info = 'none',
            diagnostic_warn = 'bold',
          },
          neotest = {
            focused = 'bold',
            adapter_name = 'bold',
          },
          telescope = {
            match = 'bold',
          },
        },

        colors = {
          bg = '#050401',
        },
      }
      vim.cmd.colorscheme 'vague'
      line_numbers()
    end,
  },

  {
    'BoHomola/vsassist.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      local c = require('vsassist.colors').get_colors()
      require('vsassist').setup {
        -- Alternatively set style in setup
        style = 'dark',

        -- Enable transparent background
        transparent = false,

        -- Enable italic comment
        italic_comments = false,

        -- Underline `@markup.link.*` variants
        underline_links = true,

        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,

        -- Apply theme colors to terminal
        terminal_colors = true,

        -- Override colors (see ./lua/vscode/colors.lua)
        color_overrides = {
          vscLineNumber = '#FFFFFF',
          vscBack = '#050401',
        },

        -- Override highlight groups (see ./lua/vscode/theme.lua)
        group_overrides = {
          -- this supports the same val table as vim.api.nvim_set_hl
          -- use colors from this colorscheme by requiring vscode.colors!
          Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
        },
      }
      -- vim.cmd.colorscheme 'vsassist'
      line_numbers()
    end,
  },

  -- load the theme without affecting devicon colors.
  -- vim.cmd.colorscheme "vscode"
  -- config = function()
  --   ---@diagnostic disable-next-line: missing-fields
  --   require('catppuccin').setup {
  --     flavour = 'mocha',
  --     no_italic = true,
  --   }

  -- Load the colorscheme here.
  -- Like many other themes, this one has different styles, and you could load
  -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  -- vim.cmd.colorscheme 'catppuccin'
  -- end,
}

--
-- return {
--   'gruvbox-community/gruvbox',
--   priority = 1000, -- Make sure to load this before all the other start plugins.
--   config = function()
--     vim.g.gruvbox_contrast_dark = 'hard'
--     vim.cmd.colorscheme 'gruvbox'
--   end,
-- }
