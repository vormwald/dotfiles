return {
  { -- Tokyonight theme
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'moon',
        light_style = 'day',
        transparent = false,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
      }
    end,
  },
  { -- Catppuccin theme
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'macchiato', -- lattee, frappe, macchiato, mocha
        background = { light = 'latte', dark = 'macchiato' },
        transparent_background = false,
        show_end_of_buffer = false,
        styles = {
          comments = { 'italic' },
          keywords = { 'italic' },
        },
      }
      -- Set catppuccin as the default colorscheme
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanso').setup {
        theme = 'zen', -- Load "zen" theme
        background = { -- map the value of 'background' option to a theme
          dark = 'zen', -- try "ink" !
          light = 'pearl',
        },
      }
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
    },
  },
}
