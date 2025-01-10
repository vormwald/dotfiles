return {
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      -- Set header
      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___   ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\ ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find file', ':FzfLua files<CR>'),
        dashboard.button('n', '  New file', ':ene <BAR> startinsert<CR>'),
        dashboard.button('r', '  Recent files', ':FzfLua oldfiles<CR>'),
        dashboard.button('g', '  Find text', ':FzfLua live_grep<CR>'),
        dashboard.button('c', '  Configuration', ':e $MYVIMRC<CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      -- Helper function to wrap text at a maximum width
      local function wrap_text(text, width)
        local wrapped_lines = {}
        local line = ''
        for word in text:gmatch '%S+' do
          if #line + #word + 1 <= width then
            line = line .. (line == '' and '' or ' ') .. word
          else
            table.insert(wrapped_lines, line)
            line = word
          end
        end
        if line ~= '' then
          table.insert(wrapped_lines, line)
        end
        return wrapped_lines
      end

      -- Random quotes (shorter versions)
      local quotes = {
        {
          'The future is uncertain and you will never know less than you know right now.',
          '- Sandi Metz',
        },
        {
          'Persist. Practice. Experiment. Imagine. Do your best work, and all else will follow.',
          '- Sandi Metz',
        },
        {
          'Design is the art of arranging code to work today, and be changeable forever.',
          '- Sandi Metz',
        },
        {
          'When in doubt, use brute force.',
          '- Ken Thompson',
        },
        {
          'If you can’t write it down in English, you can’t code it.',
          '- Peter Halpern',
        },
        {
          'Any fool can write code that a computer can understand. Good programmers write code that humans can understand.',
          '- Martin Fowler',
        },
        {
          'Programming isn’t about what you know; it’s about what you can figure out.',
          '- Chris Pine',
        },
        {
          'Complexity is anything that makes software hard to understand or to modify.',
          '- John Ousterhout',
        },
        {
          'Simplicity is prerequisite for reliability.',
          '- Edsger W. Dijkstra',
        },
        {
          'Make it work, make it right, make it fast.',
          '- Kent Beck',
        },
        {
          'Clean code always looks like it was written by someone who cares.',
          '- Robert C. Martin',
        },
      }

      -- Set footer
      local function footer()
        local datetime = os.date '%m/%d/%Y %H:%M:%S'

        -- Get git branch with error handling
        local git_branch = ''
        local success, handle = pcall(io.popen, 'git branch --show-current 2> /dev/null')
        if success and handle then
          git_branch = handle:read('*a'):gsub('\n', '') or ''
          handle:close()
        end

        local icon = ''
        pcall(function()
          icon = require('nvim-web-devicons').get_icon('.git', 'git', { default = true })
        end)
        git_branch = git_branch ~= '' and icon .. ' ' .. git_branch or 'No git'

        -- Get random quote and wrap it
        local quote = quotes[math.random(#quotes)]
        local wrapped_quote = wrap_text(quote[1], 50)
        local quote_text = table.concat(wrapped_quote, '\n')

        return string.format('%s - %s\n%s\n%s\n%s', git_branch, datetime, ' ', quote_text, quote[2])
      end

      -- Seed random number generator
      math.randomseed(os.time())

      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.padding = { top = 8, bottom = 2, left = 2, right = 2 }

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd [[
        autocmd FileType alpha setlocal nofoldenable
      ]]
    end,
  },
}
