return {
  { -- Git related plugins
    "tpope/vim-rhubarb",
  },
  {
    -- Add fugitive for git commands
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    config = function()
      vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git [c]ommit" })
      vim.keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Fu[g]itive status" })
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git [p]ush" })
      vim.keymap.set("n", "<leader>gl", ":Git pull<CR>", { desc = "Git pu[l]l" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.next_hunk()
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.prev_hunk()
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Git [s]tage hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'Git [r]eset hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'Git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'Git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  }
}

