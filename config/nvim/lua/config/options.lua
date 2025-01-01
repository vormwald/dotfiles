-- Set options (vim.opt.{option} = {value})
local opt = vim.opt

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Line numbers
opt.number = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
-- opt.hlsearch = false
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 8
opt.completeopt = "menuone,noselect"

-- Behavior
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.iskeyword:append("-")
opt.mouse:append('a')
-- opt.clipboard:append("unnamedplus")
opt.modifiable = true
opt.encoding = "UTF-8"


-- old kickstart


-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300
-- Enable break indent
vim.opt.breakindent = true
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Show which line your cursor is on
vim.opt.cursorline = true

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds from my old vimrc
vim.api.nvim_set_keymap("n", "<Leader>e", ":e " .. vim.fn.expand("%:p:h") .. "/", { noremap = true, silent = false })
vim.api.nvim_set_keymap(
	"n",
	"<Leader>x",
	":split " .. vim.fn.expand("%:p:h") .. "/",
	{ noremap = true, silent = false }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>v",
	":vsplit " .. vim.fn.expand("%:p:h") .. "/",
	{ noremap = true, silent = false }
)

-- Easier saving
vim.api.nvim_set_keymap("n", "<C-s>", ":update<CR>", { noremap = true, silent = true }) -- Normal mode mapping
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:update<CR>gi", { noremap = true, silent = true }) -- Insert mode mapping
