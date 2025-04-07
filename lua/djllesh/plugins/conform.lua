return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {

    notify_on_error = false,

    format_on_save = function(bufnr)
      return {
        timeout_ms = 3000,
        lsp_format = 'fallback',
      }
      -- local disable_filetypes = { c = true, cpp = true }
      -- if disable_filetypes[vim.bo[bufnr].filetype] then
      --   return nil
      -- else
      -- end
    end,

    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format' },
      cpp = { 'clang-format' },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      css = { 'prettier' },
      tex = { 'tex-fmt' },
    },

    formatters = {

      shfmt = {
        prepend_args = { '-i', '4' },
      },
      -- ruff = { prepend_args = { '--extend-select', 'I' }, },

      -- Configuration for clang-format
      -- Use ["<name>"] syntax for keys with hyphens or other special chars
      ['clang-format'] = {
        -- Prepend arguments before the filename conform passes
        prepend_args = { '-style={BasedOnStyle: mozilla, IndentWidth: 4}' },
      },
    },
  },
}
