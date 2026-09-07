-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Block night-owl.nvim from stealing the Visual selection highlight group
vim.api.nvim_create_autocmd({ "ColorScheme", "FocusGained", "WinEnter" }, {
  callback = function()
    -- Get the current colorscheme name
    local current_theme = vim.g.colors_name or ""

    -- If we are NOT using night-owl, force Neovim to break the rogue link
    if current_theme ~= "night-owl" then
      -- This unlinks Visual from night-owl and restores a universal dark grey highlight
      vim.api.nvim_set_hl(0, "Visual", { bg = "#3e4452", fg = "NONE", force = true })
    end
  end,
})
