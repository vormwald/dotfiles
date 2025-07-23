return {
  {
    'vim-test/vim-test',
    config = function()
      -- Set test runner commands
      vim.g['test#strategy'] = 'neovim'
      vim.g['test#neovim#term_position'] = 'botright 15'
      vim.g['test#ruby#rspec#executable'] = 'bundle exec rspec'
      -- Preserve cursor position when running tests
      vim.g['test#preserve_screen'] = true
      vim.g['test#echo_command'] = 0
      vim.g['test#neovim#start_normal'] = 1
      vim.g['test#ruby#rspec#options'] = {
        nearest = '--backtrace',
        file = '--format progress',
        suite = '--fail-fast',
      }
    end
  },

  {
    'folke/which-key.nvim',
    opts = {
      defaults = {
        ['<leader>t'] = { name = '+test' },
        ['<leader>tn'] = { name = 'Run nearest test' },
        ['<leader>tf'] = { name = 'Run current file' },
        ['<leader>ts'] = { name = 'Run all tests' },
        ['<leader>tl'] = { name = 'Run last test' },
      },
    },
  },
}
