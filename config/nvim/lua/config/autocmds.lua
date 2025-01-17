local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = '200' }
  end,
})

-- Don't auto comment new lines
autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o',
})

-- Settings for filetypes:
-- Disable line length marker
augroup('setLineLength', { clear = true })
autocmd('Filetype', {
  group = 'setLineLength',
  pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
  command = 'setlocal cc=0',
})

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript', 'yaml', 'lua' },
  command = 'setlocal shiftwidth=2 tabstop=2',
})

-- Restore cursor position when reopening a file
augroup('RestoreCursor', { clear = true })
autocmd('BufReadPost', {
  group = 'RestoreCursor',
  callback = function()
    -- Don't restore for git commits
    if vim.bo.filetype == 'gitcommit' then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Set cwd when opening a direcotry
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local path = vim.fn.expand '%:p:h'
    if vim.fn.isdirectory(path) == 1 then
      vim.cmd('cd ' .. path)
    end
  end,
})

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', {}),
  callback = function()
    vim.wo.scrolloff = 0
    vim.bo.filetype = 'terminal'
    
    -- Create buffer-local autocmds to toggle numbers based on mode
    local term_buf = vim.api.nvim_get_current_buf()
    local term_group = vim.api.nvim_create_augroup('terminal-numbers-' .. term_buf, { clear = true })
    
    -- Disable numbers when entering insert mode
    vim.api.nvim_create_autocmd('TermEnter', {
      group = term_group,
      buffer = term_buf,
      callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
      end,
    })
    
    -- Enable numbers when leaving insert mode
    vim.api.nvim_create_autocmd('TermLeave', {
      group = term_group,
      buffer = term_buf,
      callback = function()
        vim.wo.number = true
        vim.wo.relativenumber = true
      end,
    })
    
    -- Start in insert mode with numbers disabled
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd('startinsert')
  end,
})
