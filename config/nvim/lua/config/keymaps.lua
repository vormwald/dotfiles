local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Delete single character without copying into register
keymap.set("n", "x", '"_x')

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- Buffer navigation
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate window left" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate window down" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate window up" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate window right" })

-- Stay in indent mode
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv") 

-- File navigation in current directory
-- vim.keymap.set('n', '<Leader>e', function()
--   vim.cmd('e ' .. vim.fn.expand('%:p:h') .. '/')
-- end, { desc = 'Edit file in current directory' })

-- vim.keymap.set('n', '<Leader>x', function()
--   vim.cmd('split ' .. vim.fn.expand('%:p:h') .. '/')
-- end, { desc = 'Split and edit file in current directory' })

-- vim.keymap.set('n', '<Leader>v', function()
--   vim.cmd('vsplit ' .. vim.fn.expand('%:p:h') .. '/')
-- end, { desc = 'Vertical split and edit file in current directory' })

-- Easier saving
vim.keymap.set('n', '<C-s>', '<cmd>update<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<cmd>update<CR><Esc>a', { desc = 'Save file and stay in insert mode' })
