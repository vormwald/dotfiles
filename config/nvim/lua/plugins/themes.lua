return {
  { -- Tokyonight theme
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'storm',
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
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      -- Remove previous settings that didn't work
      -- Add autocommand to quit when last buffer is closed
      vim.api.nvim_create_autocmd('BufEnter', {
        callback = function()
          if #vim.fn.getbufinfo { buflisted = 1 } == 0 then
            vim.cmd 'quit'
          end
        end,
      })
    end,
    config = function()
      --  plucking from https://tailwindcss.com/docs/customizing-colors
      local colors = {
        red = '#dc2626', -- red-600
        grey = '#4b5563', -- gray-600
        black = '#09090b', -- zinc-950
        white = '#f3f3f3',
        light_green = '#a3e635',
        orange = '#fb923c', -- orange-400 ,
        green = '#8ec07c',
        light_blue = '#38bdf8',
        sky_blue = '#7dd3fc',
        indigo = '#a5b4fc',
      }

      local theme = {
        normal = {
          a = { fg = colors.black, bg = colors.light_blue },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.white, bg = colors.white },
          z = { fg = colors.white, bg = colors.grey },
        },
        insert = { a = { fg = colors.black, bg = colors.light_green } },
        visual = { a = { fg = colors.black, bg = colors.white } },
        replace = { a = { fg = colors.black, bg = colors.green } },
      }

      local empty = require('lualine.component'):extend()
      function empty:draw(default_highlight)
        self.status = ''
        self.applied_separator = ''
        self:apply_highlights(default_highlight)
        self:apply_section_separators()
        return self.status
      end

      -- Put proper separators and gaps between components in sections
      local function process_sections(sections)
        for name, section in pairs(sections) do
          local left = name:sub(9, 10) < 'x'
          for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
            table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
          end
          for id, comp in ipairs(section) do
            if type(comp) ~= 'table' then
              comp = { comp }
              section[id] = comp
            end
            comp.separator = left and { right = '' } or { left = '' }
          end
        end
        return sections
      end

      local function search_result()
        if vim.v.hlsearch == 0 then
          return ''
        end
        local last_search = vim.fn.getreg '/'
        if not last_search or last_search == '' then
          return ''
        end
        local searchcount = vim.fn.searchcount { maxcount = 9999 }
        return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
      end

      local function modified()
        if vim.bo.modified then
          return '+'
        elseif vim.bo.modifiable == false or vim.bo.readonly == true then
          return '-'
        end
        return ''
      end

      require('lualine').setup {
        options = {
          theme = theme,
          component_separators = '',
          section_separators = { left = '', right = '' },
        },
        sections = process_sections {
          lualine_a = { 'mode' },
          lualine_b = {
            'branch',
            'diff',
            {
              'diagnostics',
              source = { 'nvim' },
              sections = { 'error' },
              diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
            },
            {
              'diagnostics',
              source = { 'nvim' },
              sections = { 'warn' },
              diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
            },
            { 'filename', file_status = false, path = 1 },
            { modified, color = { bg = colors.red } },
            {
              '%w',
              cond = function()
                return vim.wo.previewwindow
              end,
            },
            {
              '%r',
              cond = function()
                return vim.bo.readonly
              end,
            },
            {
              '%q',
              cond = function()
                return vim.bo.buftype == 'quickfix'
              end,
            },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { search_result, 'filetype' },
          lualine_z = { '%l:%c', '%p%%/%L' },
        },
        inactive_sections = {
          lualine_c = { '%f %y %m' },
          lualine_x = {},
        },
      }
    end,
  },
}
