return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.install').compilers = { 'clang' }
    -- The only way I made the config work without changing the nvim-treesitter.configs file manually
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'python',
        'cpp',
      },

      highlight = {
        enable = true,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-n>', -- set to `false` to disable one of the mappings
          node_incremental = '<C-n>',
          node_decremental = '<C-m>',
          scope_incremental = '<C-c>',
        },
      },
    }
  end,
  build = ':TSUpdate',

  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    -- main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
