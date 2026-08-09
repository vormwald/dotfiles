local M = {}

local uv = vim.uv or vim.loop
local omarchy_theme = vim.fn.expand('~/.config/omarchy/current/theme/neovim.lua')
local fallback_theme = vim.fn.stdpath('config') .. '/lua/config/theme_fallback.lua'

local catppuccin_options = {
  flavour = 'macchiato',
  background = { light = 'latte', dark = 'macchiato' },
  transparent_background = false,
  show_end_of_buffer = false,
  styles = {
    comments = { 'italic' },
    keywords = { 'italic' },
  },
}

local function theme_path()
  if vim.fn.filereadable(omarchy_theme) == 1 then
    return omarchy_theme
  end

  return fallback_theme
end

function M.current()
  local ok, theme = pcall(dofile, theme_path())
  if not ok or type(theme) ~= 'table' then
    vim.notify('Unable to load Neovim theme configuration', vim.log.levels.WARN)
    return require('config.theme_fallback')
  end

  if theme.colorscheme then
    return theme
  end

  local selected = {}
  for _, spec in ipairs(theme) do
    if spec[1] == 'LazyVim/LazyVim' then
      selected.colorscheme = spec.opts and spec.opts.colorscheme
    elseif spec[1] then
      selected.plugin = spec.name or vim.fn.fnamemodify(spec[1], ':t')
      selected.plugin_spec = spec
    end
  end

  if not selected.colorscheme or not selected.plugin then
    vim.notify('Omarchy Neovim theme is incomplete; using fallback', vim.log.levels.WARN)
    return require('config.theme_fallback')
  end

  return selected
end

local function configure_theme(theme)
  if theme.plugin == 'catppuccin' or theme.plugin == 'catppuccin/nvim' then
    local options = vim.tbl_deep_extend('force', {}, catppuccin_options, theme.plugin_spec and theme.plugin_spec.opts or {})
    require('catppuccin').setup(options)
  elseif theme.plugin_spec and theme.plugin_spec.config then
    theme.plugin_spec.config()
  end
end

function M.apply()
  local theme = M.current()
  local ok, lazy = pcall(require, 'lazy')
  if not ok then
    return
  end

  local loaded = pcall(lazy.load, { plugins = { theme.plugin }, wait = true })
  if not loaded then
    vim.notify('Theme plugin is not installed: ' .. theme.plugin, vim.log.levels.WARN)
    return
  end

  local configured, err = pcall(configure_theme, theme)
  if not configured then
    vim.notify('Unable to configure theme: ' .. err, vim.log.levels.WARN)
    return
  end

  local applied, colorscheme_err = pcall(vim.cmd.colorscheme, theme.colorscheme)
  if not applied then
    vim.notify('Unable to apply colorscheme ' .. theme.colorscheme .. ': ' .. colorscheme_err, vim.log.levels.WARN)
  end
end

function M.setup()
  vim.schedule(M.apply)

  -- Omarchy atomically replaces the theme directory, so watch its stable parent.
  local directory = vim.fn.fnamemodify(omarchy_theme, ':h:h')
  if vim.fn.isdirectory(directory) ~= 1 then
    return
  end

  local timer = uv.new_timer()
  M.watcher = uv.new_fs_event()
  M.watcher:start(directory, {}, function()
    timer:stop()
    timer:start(100, 0, vim.schedule_wrap(M.apply))
  end)

  vim.api.nvim_create_autocmd('VimLeavePre', {
    once = true,
    callback = function()
      M.watcher:stop()
      M.watcher:close()
      timer:stop()
      timer:close()
    end,
  })
end

return M
