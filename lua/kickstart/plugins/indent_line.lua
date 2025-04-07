return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    opts = {},
    main = 'ibl',
    config = function()
      require 'rainbow-delimiters'
      local highlight = {
        'RainbowDelimiterOrange',
      }

      local hooks = require 'ibl.hooks'
      vim.g.rainbow_delimiters = { highlight = highlight }
      require('ibl').setup { indent = { char = '╎' }, scope = { highlight = highlight } }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
