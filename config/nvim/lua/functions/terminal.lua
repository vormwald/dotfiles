local te_buf = nil
local te_win_id = nil

local v = vim
local fun = v.fn
local cmd = v.api.nvim_command
local gotoid = fun.win_gotoid
local getid = fun.win_getid

local function openTerminal()
    if fun.bufexists(te_buf) ~= 1 then
        -- Create autocmd for terminal appearance
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "*",
            callback = function()
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                vim.opt_local.signcolumn = "no"
            end
        })

        -- Split and setup terminal
        vim.cmd.split()
        vim.cmd.wincmd('J')
        vim.api.nvim_win_set_height(0, 16)
        vim.cmd.terminal()

        te_win_id = getid()
        te_buf = fun.bufnr('%')
    elseif gotoid(te_win_id) ~= 1 then
        cmd("sb " .. te_buf .. "| winc J | res 16")
        te_win_id = getid()
    end
    cmd("startinsert")
end

local function hideTerminal()
    if gotoid(te_win_id) == 1 then
        cmd("hide")
    end
end

function ToggleTerminal()
    if gotoid(te_win_id) == 1 then
        hideTerminal()
    else
        openTerminal()
    end
end
