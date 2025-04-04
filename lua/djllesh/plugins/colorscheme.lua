return {
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
      },

      -- Override highlight groups (see ./lua/vscode/theme.lua)
      group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
      },
    }
    vim.cmd.colorscheme 'vsassist'
  end,

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
