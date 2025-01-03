return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
      "haydenmeade/neotest-jest",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
      { "<leader>ts", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run all tests" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
      { "<leader>to", function() require("neotest").output.open() end, desc = "Show test output" },
      { "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Toggle test panel" },
      { "<leader>tw", function() require("neotest").watch.toggle() end, desc = "Toggle test watching" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    },
    config = function()
      require("neotest").setup({
        -- General options
        icons = {
          passed = "✔",
          failed = "✖",
          running = "⟳",
          skipped = "ﰸ",
        },
        output = {
          enabled = true,
          open_on_run = true,
        },
        quickfix = {
          enabled = true,
          open = false,
        },

        -- Configure test adapters
        adapters = {
          require("neotest-rspec")({
            rspec_cmd = function()
              return vim.tbl_flatten({
                "bundle",
                "exec",
                "rspec",
              })
            end,
            transform_spec_path = function(path)
              return path
            end,
            results_path = "tmp/rspec.output",
          }),

          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function(_path)
              return vim.fn.getcwd()
            end,
          }),
        }
      })
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-neotest/neotest",
    },
    event = "VeryLazy",
    opts = function(_, opts)
      opts = opts or {}
      opts.sections = opts.sections or {
        lualine_c = {},
      }
      table.insert(opts.sections.lualine_c, {
        function()
          local ok, neotest = pcall(require, "neotest")
          if not ok then
            return ""
          end

          local status = neotest.status
          local status_text = {
            running = "🏃 Testing",
            passed = "✅ Tests Passed",
            failed = "❌ Tests Failed",
          }
          return status_text[status.status] or ""
        end,
      })

      return opts
    end,
  },

   {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>t"] = { name = "+test" },
        ["<leader>tn"] = { name = "Run nearest test" },
        ["<leader>tf"] = { name = "Run current file" },
        ["<leader>ts"] = { name = "Run all tests" },
        ["<leader>tl"] = { name = "Run last test" },
        ["<leader>to"] = { name = "Show test output" },
        ["<leader>tp"] = { name = "Toggle test panel" },
        ["<leader>tw"] = { name = "Toggle test watching" },
        ["<leader>ts"] = { name = "Toggle test summary" },
      },
    },
  },
}
