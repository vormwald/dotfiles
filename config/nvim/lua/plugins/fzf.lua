return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local fzf = require("fzf-lua")
			local actions = require("fzf-lua.actions")
			local config = require("fzf-lua.config")

			-- Core FZF keymaps
			config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
			config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
			config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
			config.defaults.keymap.fzf["ctrl-x"] = "jump"
			config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
			config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"

			-- Setup core configuration
			fzf.setup({
				fzf_colors = true,
				fzf_opts = {
					["--no-scrollbar"] = true,
				},
				defaults = {
					-- formatter = "path.filename_first",
					formatter = "path.dirname_first",
				},
				winopts = {
					width = 0.8,
					height = 0.8,
					row = 0.5,
					col = 0.5,
					preview = {
						scrollchars = { "┃", "" },
					},
				},
				files = {
					cwd_prompt = false,
					actions = {
						["alt-i"] = { actions.toggle_ignore },
						["alt-h"] = { actions.toggle_hidden },
					},
				},
				grep = {
					actions = {
						["alt-i"] = { actions.toggle_ignore },
						["alt-h"] = { actions.toggle_hidden },
					},
				},
				lsp = {
					symbols = {
						symbol_hl = function(s)
							return "TroubleIcon" .. s
						end,
						symbol_fmt = function(s)
							return s:lower() .. "\t"
						end,
						child_prefix = false,
					},
					code_actions = {
						previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
					},
				},
			})

			-- Essential keymaps
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
			end

			-- Files and buffers
			map("n", "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", "Switch Buffer")
			map("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", "Live Grep")
			map("n", "<leader><space>", "<cmd>FzfLua files<cr>", "Find Files")
			map("n", "<leader>ff", "<cmd>FzfLua files<cr>", "Find Files")
			map("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", "Recent Files")
			map("n", "<leader>fg", "<cmd>FzfLua git_status<cr>", "Git Status")

			-- Search
			map("n", "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", "Search Buffer")
			map("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>", "Grep")
			map("n", "<leader>sh", "<cmd>FzfLua help_tags<cr>", "Help Pages")
			map("n", "<leader>sm", "<cmd>FzfLua marks<cr>", "Jump to Mark")
			map("n", "<leader>*", "<cmd>FzfLua grep_cword<cr>", "Search Word Under Cursor")

			-- LSP
			map(
				"n",
				"gd",
				"<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>",
				"Goto Definition"
			)
			map(
				"n",
				"gr",
				"<cmd>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<cr>",
				"Goto References"
			)
			map(
				"n",
				"gI",
				"<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>",
				"Goto Implementation"
			)
			map(
				"n",
				"gy",
				"<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>",
				"Goto Type Definition"
			)
			map(
				"n",
				"ds",
				"<cmd>FzfLua lsp_document_symbols jump_to_single_result=true ignore_current_line=true<cr>",
				"Document Symbols"
			)
			map(
				"n",
				"ws",
				"<cmd>FzfLua lsp_workspace_symbols jump_to_single_result=true ignore_current_line=true<cr>",
				"Workspace Symbols"
			)
		end,
	},
	{
		"folke/todo-comments.nvim",
		optional = true,
		keys = {
			{
				"<leader>st",
				function()
					require("todo-comments.fzf").todo()
				end,
				desc = "Todo",
			},
			{
				"<leader>sT",
				function()
					require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } })
				end,
				desc = "Todo/Fix/Fixme",
			},
		},
	},
}
