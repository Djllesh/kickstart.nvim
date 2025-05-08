return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- 1) Compiler: use latexmk -pdf + synctex + nonstopmode + -pvc
    -- vim.g.vimtex_compiler_latexmk = {
    --   out_dir = '',
    --   callback = 1,
    --   continuous = 1,
    --   executable = 'latexmk',
    --   options = {
    --     '-pdflatex=lualatex',
    --     -- '-pdf',
    --     '-synctex=1',
    --     '-interaction=nonstopmode',
    --   },
    -- }

    -- 3) **Very important**: after *every* successful compile,
    -- Use latexmk with LuaLaTeX for all TeX files
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk_engines = {
      ['_'] = '-lualatex',
    }
    --    force‑reload the viewer
    vim.g.vimtex_view_automatic = 1

    vim.g.vimtex_subfile_start_local = 1
    vim.g.vimtex_view_method = 'general'
    vim.g.vimtex_view_general_viewer = 'SumatraPDF.exe'
    vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    vim.g.vimtex_syntax_conceal_cites = { type = 'icon', icon = '📑' }
    vim.opt.concealcursor = 'nc'
    vim.g.vimtex_quickfix_open_on_warning = 0
    -- vim.opt.conceallevel = 2
  end,
}
