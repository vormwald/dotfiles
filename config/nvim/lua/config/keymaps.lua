local keymap = vim.keymap

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

---------------------
-- General Keymaps
---------------------

-- Clear search highlights
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Delete single character without copying into register
keymap.set('n', 'x', '"_x')

-- use U for redo :))
keymap.set('n', 'U', '<C-r>', { desc = 'undo with U' })

-- Using H/L to go to the begining and the end of line
keymap.set('n', 'H', '_', { desc = 'Go to the first non-whitespace character of a line' })
keymap.set('n', 'L', '$', { desc = 'Go to the end of a line' })

-- Window management
keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
keymap.set('n', '<leader>sx', '<C-w>s', { desc = 'Split window horizontally' })
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })

-- Buffer navigation
keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })

-- Window navigation
keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate window left' })
keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Navigate window down' })
keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate window up' })
keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate window right' })

-- Stay in indent mode
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

-- Move text up and down
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Easier saving
keymap.set('n', '<C-s>', '<cmd>update<CR>', { desc = 'Save file' })
keymap.set('i', '<C-s>', '<cmd>update<CR><Esc>a', { desc = 'Save file and stay in insert mode' })

-- FZF keymaps
keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Live Grep' })
keymap.set('n', '<leader><space>', '<cmd>FzfLua files<cr>', { desc = 'Find Files' })
keymap.set('n', '<leader>fr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Recent Files' })
keymap.set('n', '<leader>fg', '<cmd>FzfLua git_status<cr>', { desc = 'Git Status' })
keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Open Buffers' })
keymap.set('n', '<leader>ff', function()
  local buffer_dir = vim.fn.expand '%:p:h'
  require('fzf-lua').files { cwd = buffer_dir }
end, { desc = 'Find Files in current buffer dir' })
keymap.set('n', '<leader>fc', '<cmd>FzfLua colorschemes<cr>', { desc = 'choose colorscheme' })

-- Search
keymap.set('n', '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>', { desc = 'Search Buffer' })
keymap.set('n', '<leader>sg', '<cmd>FzfLua live_grep<cr>', { desc = 'Grep' })
keymap.set('n', '<leader>sh', '<cmd>FzfLua help_tags<cr>', { desc = 'Help Pages' })
keymap.set('n', '<leader>*', '<cmd>FzfLua grep_cword<cr>', { desc = 'Search Word Under Cursor' })

-- Diagnostic keymaps
keymap.set('n', '<leader>fd', '<cmd>FzfLua diagnostics_document<cr>', { desc = 'Show diagnostic error messages' })

-- Git keymaps (Fugitive only)
keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
keymap.set('n', '<leader>gg', ':Git<CR>', { desc = 'Fugitive status' })
keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git push' })
keymap.set('n', '<leader>gl', ':Git pull<CR>', { desc = 'Git pull' })

-- Terminal mappings
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- Open a terminal at the bottom of the screen with a fixed height.
keymap.set("n", "<leader>ot", function()
  vim.cmd.new()
  -- vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end, { desc = 'Open terminal at bottom of screen' })

-- Theme switching
keymap.set('n', '<leader>wtt', ':colorscheme tokyonight<CR>', { desc = '[W]orkspace [T]heme [T]okyonight' })
keymap.set('n', '<leader>wtc', ':colorscheme catppuccin<CR>', { desc = '[W]orkspace [T]heme [C]atppuccin' })

-- Test keymaps
keymap.set('n', '<leader>tt', ':TestNearest<CR>', { desc = 'Run nearest test' })
keymap.set('n', '<leader>tf', ':TestFile<CR>', { desc = 'Run current file' })
keymap.set('n', '<leader>ts', ':TestSuite<CR>', { desc = 'Run all tests' })
keymap.set('n', '<leader>tl', ':TestLast<CR>', { desc = 'Run last test' })
keymap.set('n', '<leader>tg', ':TestVisit<CR>', { desc = 'Go to last test run' })

-- Toggle Quickfix and location list
vim.keymap.set('n', '<leader>oq', function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd 'cclose'
  else
    -- Only open if there are items
    if vim.fn.getqflist({ size = 0 }).size > 0 then
      vim.cmd 'copen'
    else
      vim.notify('Quickfix list is empty', vim.log.levels.INFO)
    end
  end
end, { desc = 'T[o]ggle [Q]uickfix' })

vim.keymap.set('n', '<leader>ol', function()
  local loc_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['loclist'] == 1 then
      loc_exists = true
    end
  end
  if loc_exists == true then
    vim.cmd 'lclose'
  else
    -- Only open if there are items
    if vim.fn.getloclist(0, { size = 0 }).size > 0 then
      vim.cmd 'lopen'
    else
      vim.notify('Location list is empty', vim.log.levels.INFO)
    end
  end
end, { desc = 'T[o]ggle [L]ocation List' })
