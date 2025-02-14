return {
  -- Essential plugins from kickstart
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
  { -- "gc" to comment visual regions/lines
    'numToStr/Comment.nvim',
    opts = {},
  },

  -- { -- Useful plugin to show you pending keybinds.
  --   "folke/which-key.nvim",
  --   event = "VimEnter",
  --   opts = {
  --     icons = {
  --     },
  --   },
  -- },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '➜', -- symbol used between a key and it's label
        group = '+', -- symbol prepended to a group
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]est' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>g', group = '[G]it' },
        { '<leader>x', group = 'Split' },
        { '<leader>o', group = 'T[o]ggle' },
      },
    },
  },

  { -- Adds git related signs to the gutter
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }
      -- Add/delete/replace surroundings
      require('mini.surround').setup()
      -- Simple and easy statusline
      require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'html',
        'lua',
        'markdown',
        'vim',
        'vimdoc',
        'javascript',
        'typescript',
        'ruby',
        'python',
        'json',
        'yaml',
        'css',
        'scss',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = '<C-s>',
          node_decremental = '<C-backspace>',
        },
      },
    },
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
  {
    -- autopairs
    -- https://github.com/windwp/nvim-autopairs
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
            ['-'] = 'navigate_up',
          },
        },
        filtered_items = {
          hide_dotfiles = false,
        },
        follow_current_file = {
          enabled = true,
        },
      },
      close_if_last_window = true,
      popup_border_style = 'rounded',
      enable_normal_mode_for_inputs = true,
      default_component_configs = {
        message = {
          highlight = 'NormalFloat', -- This will use your theme's normal float color
        },
      },
      window = {
        popup = {
          -- Use NormalFloat for the background
          highlight = 'NormalFloat',
        },
        mappings = {
          ['<space>'] = 'none',
          ['Y'] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg('+', path, 'c')
            end,
            desc = 'Copy Path to Clipboard',
          },
          ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
          ['l'] = 'focus_preview',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
        },
      },
      ui = {
        popup = {
          -- Customize the popup background and text colors
          border = {
            text = {
              fg = 'white', -- or any color you prefer
            },
            highlight = 'NormalFloat', -- This ensures the border uses the same background
          },
          position = '50%',
          size = {
            width = '60%',
            height = '20%',
          },
        },
      },
    },
  },
  {
    'shortcuts/no-neck-pain.nvim',
    config = function()
      require('no-neck-pain').setup {
        buffers = {
          colors = {
            blend = -0.8,
          },
          wo = {
            fillchars = 'eob: ',
          },
        },
      }
    end,
  },
  'tpope/vim-endwise', -- add ends to do/if in ruby
  'tpope/vim-rails', -- projectionist setting for rails
  'tpope/vim-unimpaired', -- useful plugin to work around pairs of things
  {
    'linrongbin16/gitlinker.nvim',
    cmd = 'GitLink',
    opts = { message = false },
    keys = {
      { '<leader>gl', '<cmd>GitLink<cr>', mode = { 'n', 'v' }, desc = 'Yank [g]it [l]ink' },
      { '<leader>gL', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open [g]it [L]ink' },
    },
  },
}
