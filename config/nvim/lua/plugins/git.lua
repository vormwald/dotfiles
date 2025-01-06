return {
  { -- Git related plugins
    'tpope/vim-rhubarb',
  },
  {
    -- Add fugitive for git commands
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)

      -- Load keymaps after gitsigns is available
      local keymap = vim.keymap

      -- Navigation
      keymap.set('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          require('gitsigns').next_hunk()
        end
      end, { desc = 'Jump to next git [c]hange' })

      keymap.set('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          require('gitsigns').prev_hunk()
        end
      end, { desc = 'Jump to previous git [c]hange' })

      -- Actions
      keymap.set('v', '<leader>hs', function()
        require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Git [s]tage hunk' })
      keymap.set('v', '<leader>hr', function()
        require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Git [r]eset hunk' })
      keymap.set('n', '<leader>hs', require('gitsigns').stage_hunk, { desc = 'Git [s]tage hunk' })
      keymap.set('n', '<leader>hr', require('gitsigns').reset_hunk, { desc = 'Git [r]eset hunk' })
      keymap.set('n', '<leader>hS', require('gitsigns').stage_buffer, { desc = 'Git [S]tage buffer' })
      keymap.set('n', '<leader>hu', require('gitsigns').undo_stage_hunk, { desc = 'Git [u]ndo stage hunk' })
      keymap.set('n', '<leader>hR', require('gitsigns').reset_buffer, { desc = 'Git [R]eset buffer' })
      keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { desc = 'Git [p]review hunk' })
      keymap.set('n', '<leader>hb', require('gitsigns').blame_line, { desc = 'Git [b]lame line' })
      keymap.set('n', '<leader>hd', require('gitsigns').diffthis, { desc = 'Git [d]iff against index' })
      keymap.set('n', '<leader>hD', function()
        require('gitsigns').diffthis '@'
      end, { desc = 'Git [D]iff against last commit' })

      -- Toggles
      keymap.set('n', '<leader>ob', require('gitsigns').toggle_current_line_blame, { desc = 'T[o]ggle git show [b]lame line' })
      keymap.set('n', '<leader>od', require('gitsigns').toggle_deleted, { desc = 'T[o]ggle git show [d]eleted' })
    end,
  },
}
