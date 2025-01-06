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

-- Window management
keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
keymap.set('n', '<leader>sx', ':close<CR>', { desc = 'Close current split' })

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

-- Terminal mode escape
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- FZF keymaps
keymap.set('n', '<leader>/', '<cmd>FzfLua live_grep<cr>', { desc = 'Live Grep' })
keymap.set('n', '<leader><space>', '<cmd>FzfLua files<cr>', { desc = 'Find Files' })
keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>', { desc = 'Find Files' })
keymap.set('n', '<leader>fr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Recent Files' })
keymap.set('n', '<leader>fg', '<cmd>FzfLua git_status<cr>', { desc = 'Git Status' })
keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<cr>', { desc = 'Open Buffers' })

-- Search
keymap.set('n', '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>', { desc = 'Search Buffer' })
keymap.set('n', '<leader>sg', '<cmd>FzfLua live_grep<cr>', { desc = 'Grep' })
keymap.set('n', '<leader>sh', '<cmd>FzfLua help_tags<cr>', { desc = 'Help Pages' })
keymap.set('n', '<leader>sm', '<cmd>FzfLua marks<cr>', { desc = 'Jump to Mark' })
keymap.set('n', '<leader>*', '<cmd>FzfLua grep_cword<cr>', { desc = 'Search Word Under Cursor' })

-- Git keymaps (Fugitive only)
keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
keymap.set('n', '<leader>gg', ':Git<CR>', { desc = 'Fugitive status' })
keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git push' })
keymap.set('n', '<leader>gl', ':Git pull<CR>', { desc = 'Git pull' })

-- Test keymaps
keymap.set('n', '<leader>tn', function()
  require('neotest').run.run()
end, { desc = 'Run nearest test' })
keymap.set('n', '<leader>tf', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { desc = 'Run current file' })
keymap.set('n', '<leader>ts', function()
  require('neotest').run.run(vim.fn.getcwd())
end, { desc = 'Run all tests' })
keymap.set('n', '<leader>tl', function()
  require('neotest').run.run_last()
end, { desc = 'Run last test' })
keymap.set('n', '<leader>to', function()
  require('neotest').output.open()
end, { desc = 'Show test output' })
keymap.set('n', '<leader>tp', function()
  require('neotest').output_panel.toggle()
end, { desc = 'Toggle test panel' })
keymap.set('n', '<leader>tw', function()
  require('neotest').watch.toggle()
end, { desc = 'Toggle test watching' })

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
