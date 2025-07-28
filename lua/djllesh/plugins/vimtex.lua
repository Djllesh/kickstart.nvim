return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk_engines = {
      ['_'] = '-lualatex',
    }
    -- force‑reload the viewer
    vim.g.vimtex_view_automatic = 1

    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_view_general_viewer = 'SumatraPDF.exe'
    vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    vim.g.vimtex_syntax_conceal_cites = { type = 'icon', icon = '📑' }
    vim.opt.concealcursor = 'nc'
    vim.g.vimtex_quickfix_open_on_warning = 0
  end,
}
