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
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = 'yes'
opt.scrolloff = 8
opt.completeopt = 'menuone,noselect'

-- Behavior
opt.hidden = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.backspace = 'indent,eol,start'
opt.splitright = true
opt.splitbelow = true
opt.mouse:append 'a'
opt.modifiable = true
opt.encoding = 'UTF-8'
-- Decrease update time
opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300
-- Enable break indent
opt.breakindent = true
-- Preview substitutions live, as you type!
opt.inccommand = 'split'
-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true
-- Show which line your cursor is on
opt.cursorline = true
-- save buffers before leaving or running tests
opt.autowrite = true
