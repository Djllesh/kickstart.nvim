vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'vsassist',
  group = vim.api.nvim_create_augroup('SnacksColoring', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, 'SnacksPickerMatch', { fg = '#fa6002', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'SnacksDashboardNormal', { fg = '#f15d02', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'SnacksPickerFile', { fg = '#894905', bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'SnacksPickerBorder', { fg = '#894905', bg = 'NONE' })
  end,
})

---@diagnostic disable: undefined-global
return {
  'folke/snacks.nvim',
  priority = 999,
  lazy = false,
  ---@diagnostic disable-next-line: undefined-doc-name
  ---@type snacks.Config
  opts = {
    picker = {
      layout = {
        preset = 'ivy',
        cycle = false,
      },
      -- debug = { scores = true },
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {
            -- I'm used to scrolling like this in LazyGit
            ['J'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['K'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['H'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
            ['L'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
          },
        },
      },
    },
    dashboard = {
      preset = {
        header = {
          [[
                                                           
              _/  _/  _/  _/                      _/       
         _/_/_/      _/  _/    _/_/      _/_/_/  _/_/_/    
      _/    _/  _/  _/  _/  _/_/_/_/  _/_/      _/    _/   
     _/    _/  _/  _/  _/  _/            _/_/  _/    _/    
      _/_/_/  _/  _/  _/    _/_/_/  _/_/_/    _/    _/     
             _/                                            
          _/                                               ]],
        },
      },
      sections = {
        { section = 'header' },
        -- { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
        { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        -- { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        { section = 'startup' },
      },
    },
    notifier = {},
  },

  keys = {
    -- Top Pickers & Explorer
    {
      '<leader><space>s',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>n',
      function()
        Snacks.picker.notifications { -- Start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
        }
      end,
      desc = 'Notification History',
    },

    -- find
    {
      '<leader>fb',
      function()
        Snacks.picker.buffers { -- Start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
        }
      end,
      desc = 'Buffers',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>fg',
      function()
        Snacks.picker.git_files()
      end,
      desc = 'Find Git Files',
    },
    {
      '<leader>fp',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent { -- Start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
        }
      end,
      desc = 'Recent',
    },

    -- git
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Git Branches',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>gL',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = 'Git Log Line',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status { -- Start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
          layout = 'sidebar',
        }
      end,
      desc = 'Git Status',
    },
    {
      '<leader>gS',
      function()
        Snacks.picker.git_stash()
      end,
      desc = 'Git Stash',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git Diff (Hunks)',
    },
    {
      '<leader>gf',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Git Log File',
    },

    -- Grep
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },

    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.search_history()
      end,
      desc = 'Search History',
    },
    {
      '<leader>sa',
      function()
        Snacks.picker.autocmds()
      end,
      desc = 'Autocmds',
    },
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics {
          layout = 'ivy_split',
          on_show = function()
            vim.cmd.stopinsert()
          end,
        }
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer {
          layout = 'ivy_split',
          on_show = function()
            vim.cmd.stopinsert()
          end,
        }
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function()
        Snacks.picker.highlights()
      end,
      desc = 'Highlights',
    },
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = 'Icons',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps { layout = 'ivy_split' }
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function()
        Snacks.picker.loclist()
      end,
      desc = 'Location List',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.lazy()
      end,
      desc = 'Search for Plugin Spec',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sr',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo History',
    },
    {
      '<leader>uc',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
  },
}
