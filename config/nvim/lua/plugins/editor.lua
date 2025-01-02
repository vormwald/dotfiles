return {
  -- Essential plugins from kickstart
  { "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
  {                       -- "gc" to comment visual regions/lines
    "numToStr/Comment.nvim",
    opts = {},
  },

  -- { -- Useful plugin to show you pending keybinds.
  --   "folke/which-key.nvim",
  --   event = "VimEnter",
  --   opts = {
  --     icons = {
  --       breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
  --       separator = "➜", -- symbol used between a key and it's label
  --       group = "+", -- symbol prepended to a group
  --     },
  --   },
  -- },

  {                  -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },

      -- Document existing key chains
      spec = {
        { "<leader>c", group = "[C]ode",     mode = { "n", "x" } },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
      },
    },
  },

  -- -- which-key helps you remember key bindings by showing a popup
  -- -- with the active keybindings of the command you started typing.
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   opts_extend = { "spec" },
  --   opts = {
  --     preset = "helix",
  --     defaults = {},
  --     spec = {
  --       {
  --         mode = { "n", "v" },
  --         { "<leader><tab>", group = "tabs" },
  --         { "<leader>c", group = "code" },
  --         { "<leader>d", group = "debug" },
  --         { "<leader>dp", group = "profiler" },
  --         { "<leader>f", group = "file/find" },
  --         { "<leader>g", group = "git" },
  --         { "<leader>gh", group = "hunks" },
  --         { "<leader>q", group = "quit/session" },
  --         { "<leader>s", group = "search" },
  --         { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
  --         { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
  --         { "[", group = "prev" },
  --         { "]", group = "next" },
  --         { "g", group = "goto" },
  --         { "gs", group = "surround" },
  --         { "z", group = "fold" },
  --         {
  --           "<leader>b",
  --           group = "buffer",
  --           expand = function()
  --             return require("which-key.extras").expand.buf()
  --           end,
  --         },
  --         {
  --           "<leader>w",
  --           group = "windows",
  --           proxy = "<c-w>",
  --           expand = function()
  --             return require("which-key.extras").expand.win()
  --           end,
  --         },
  --         -- better descriptions
  --         { "gx", desc = "Open with system app" },
  --       },
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>?",
  --       function()
  --         require("which-key").show({ global = false })
  --       end,
  --       desc = "Buffer Keymaps (which-key)",
  --     },
  --     {
  --       "<c-w><space>",
  --       function()
  --         require("which-key").show({ keys = "<c-w>", loop = true })
  --       end,
  --       desc = "Window Hydra Mode (which-key)",
  --     },
  --   },
  --   config = function(_, opts)
  --     local wk = require("which-key")
  --     wk.setup(opts)
  --     if not vim.tbl_isempty(opts.defaults) then
  --       LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
  --       wk.register(opts.defaults)
  --     end
  --   end,
  -- },

  { -- Adds git related signs to the gutter
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      require("mini.ai").setup({ n_lines = 500 })
      -- Add/delete/replace surroundings
      require("mini.surround").setup()
      -- Simple and easy statusline
      require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })
    end,
  },

  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "html",
        "lua",
        "markdown",
        "vim",
        "vimdoc",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
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
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
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
          },
        },
      },
    },
  },
  "tpope/vim-endwise",    -- add ends to do/if in ruby
  "tpope/vim-rails",      -- projectionist setting for rails
  "tpope/vim-rhubarb",    -- :Gbrowse to view file on github
  "tpope/vim-unimpaired", -- useful plugin to work around pairs of things
}
