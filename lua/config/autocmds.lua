-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- night-owl.nvim links/overwrites the `Visual` highlight group with a colour
-- that is invisible on dark backgrounds.
--
-- IMPORTANT: the override must only run while night-owl is the active theme.
-- An earlier version of this autocmd ran on every theme *except* night-owl,
-- which silently deleted the `hl.Visual` customisation written in
-- lua/plugins/theme.lua (e.g. silkcircuit's purple selection).
local NIGHT_OWL_VISUAL = "#3e4452"

local function is_night_owl()
  return vim.g.colors_name == "night-owl"
end

local function fix_visual()
  if not is_night_owl() then
    return
  end
  vim.api.nvim_set_hl(0, "Visual", { bg = NIGHT_OWL_VISUAL, fg = "NONE", force = true })
end

local group = vim.api.nvim_create_augroup("dopavim_visual_fix", { clear = true })

-- night-owl's colors/night-owl.lua calls its loader but never writes
-- g:colors_name, so Neovim keeps reporting the *previous* theme after
-- `:colorscheme night-owl` and every check keyed on it (including
-- fix_visual below) silently no-ops. The ColorScheme event's <amatch> is
-- trustworthy, so repair the name there first and then apply the fix.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = "night-owl",
  callback = function()
    vim.g.colors_name = "night-owl"
    fix_visual()
  end,
})

-- Re-apply while night-owl is active (it can re-link on redraw/focus)
vim.api.nvim_create_autocmd({ "FocusGained", "WinEnter" }, {
  group = group,
  callback = fix_visual,
})
