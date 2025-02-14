require('functions.terminal')
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

-- Easier system clipboard
keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
keymap.set('n', '<leader>p', '"+p', { desc = 'Paste below from system clipboard' })
keymap.set('n', '<leader>P', '"+P', { desc = 'Paste above from system clipboard' })

-- FZF keymaps
keymap.set('n', '<leader><space>', '<cmd>FzfLua files<cr>', { desc = 'Find Files' })
keymap.set('n', '<leader>fo', '<cmd>FzfLua oldfiles include_current_session=true<cr>', { desc = '[F]ind [O]ld Files' })
keymap.set('n', '<leader>fr', '<cmd>FzfLua resume<cr>', { desc = '[F]zf [R]esume Filepicker' })
keymap.set('n', '<leader>fg', '<cmd>FzfLua git_status<cr>', { desc = '[F]ind [G]it Status' })

keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', { desc = '[F]ind [B]uffer' })
keymap.set('n', '<leader>b', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Open Buffers' })
keymap.set('n', '<leader>fc', '<cmd>FzfLua colorschemes<cr>', { desc = 'choose colorscheme' })

-- Search
keymap.set('n', '<leader>ff', '<cmd>FzfLua live_grep<cr>', { desc = '[F]ind in [f]iles (Live Grep)' })
keymap.set('n', '<leader>/', '<cmd>FzfLua grep_curbuf<cr>', { desc = 'Search Buffer' })
keymap.set('n', '<leader>fh', '<cmd>FzfLua help_tags<cr>', { desc = '[F]ind [H]elp Pages' })

-- File system
keymap.set('n', '<leader>fz', '<cmd>FzfLua zoxide<cr>', { desc = 'Recent Directories' })

-- support old vimrc muscle memory
keymap.set('n', '<C-p>', '<cmd>FzfLua files<cr>', { desc = 'Find Files' })
keymap.set('n', '<leader>*', '<cmd>FzfLua grep_cword<cr>', { desc = 'Search Word Under Cursor' })
keymap.set('n', '<C-g>', '<cmd>FzfLua git_status<cr>', { desc = 'Git Status' })
keymap.set('n', '|', '<cmd>FzfLua live_grep<cr>', { desc = 'Live Grep' })
keymap.set('n', '<C-b>', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Open Buffers' })

-- Diagnostic keymaps
keymap.set('n', '<leader>fd', '<cmd>FzfLua diagnostics_document<cr>', { desc = 'Show diagnostic error messages' })

-- Git keymaps (Fugitive only)
keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = '[G]it [c]ommit' })
keymap.set('n', '<leader>gg', ':Git<CR>', { desc = 'Fugitive status' })
keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = '[G]it [p]ush' })
keymap.set('n', '<leader>gl', ':Git pull<CR>', { desc = '[G]it pu[l]l' })

-- Terminal mappings
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- Open a terminal at the bottom of the screen with a fixed height.
keymap.set({'n', 't'}, '<leader>ot', ToggleTerminal, { desc = 't[o]ggle [t]erminal' })

-- Theme switching
keymap.set('n', '<leader>wtt', ':colorscheme tokyonight<CR>', { desc = '[W]orkspace [T]heme [T]okyonight' })
keymap.set('n', '<leader>wtc', ':colorscheme catppuccin<CR>', { desc = '[W]orkspace [T]heme [C]atppuccin' })

-- Toggle Zen Mode (NoNeckPain)
keymap.set('n', '<leader>oz', ':NoNeckPain<CR>', { desc = '[O]pen [Z]en Mode' })

-- Test keymaps
keymap.set('n', '<leader>tt', ':TestNearest<CR>', { desc = '[T]es[t] nearest line' })
keymap.set('n', '<leader>tf', ':TestFile<CR>', { desc = '[T]est current [f]ile' })
keymap.set('n', '<leader>ts', ':TestSuite<CR>', { desc = '[T]est whole [s]uite' })
keymap.set('n', '<leader>tl', ':TestLast<CR>', { desc = '[T]est [l]ast test' })
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
