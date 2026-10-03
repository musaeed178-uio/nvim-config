-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-------------------------------------------------------
-- Floating terminals (resolved per-OS by custom/shells.lua)
--   Alt+i -> PowerShell  (Windows: pwsh/powershell, Linux: pwsh or fallback)
--   Alt+c -> default shell (Windows: cmd.exe, Linux: $SHELL)
--   Alt+b -> Git Bash / bash
-------------------------------------------------------

vim.keymap.set("n", "<M-i>", function()
  require("custom.terminal").toggle()
end, { desc = "Toggle PowerShell floating terminal" })

vim.keymap.set("n", "<M-c>", function()
  require("custom.cmd_terminal").toggle()
end, { desc = "Toggle default-shell floating terminal" })

vim.keymap.set("n", "<M-b>", function()
  require("custom.gitbash_terminal").toggle()
end, { desc = "Toggle Git Bash floating terminal" })

-- Select all text
vim.keymap.set("n", "<leader>a", "<cmd>normal! ggVG<CR>", {
  desc = "Select all text",
})
-- Yank entire file without moving your cursor
vim.keymap.set("n", "<leader>Y", "<cmd>%y<CR>", { desc = "Yank all text" })

-- Buffer navigation (like tabs)
for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, function()
    require("bufferline").go_to(i, true)
  end, { desc = "Go to buffer " .. i })
end

vim.keymap.set("n", "<leader>tp", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>tn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "New tab" }) -- if you want Neovim tab pages
-- or if you want a new empty buffer: vim.keymap.set("n", "<leader>to", ":enew<CR>", { desc = "New buffer" })

-- Splits
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })

-- Theme picker
-- vim.keymap.set("n", "<leader>th", ":LazyVimPickColorScheme<CR>", { desc = "Pick colorscheme" })

-- Oil
-- Wrapped in a function so a failed/slow oil.nvim install can never abort the
-- rest of this file (the require used to be evaluated eagerly at line load).
vim.keymap.set("n", "-", function()
  require("oil").open_float()
end, { desc = "Open oil (file explorer)" })

-- Scroll horizontally by 6 columns instead of the default half-screen
vim.keymap.set("n", "zh", "<Cmd>normal! 6zh<CR>", { desc = "Scroll left 6" })
vim.keymap.set("n", "zl", "<Cmd>normal! 6zl<CR>", { desc = "Scroll right 6" })

-- Delete without yanking (into the black hole register)
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete without yank (wait for motion)" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete without yank (selection)" })

-- In Visual mode, paste over selection without yanking the old text
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yank" })
vim.keymap.set("v", "P", '"_dP', { desc = "Paste without yank (alternative)" })

-- Toggle Alpha Dashboard (per-window: toggles in the current split)
vim.keymap.set({ "n", "v" }, "<leader>h", function()
  local cur_win = vim.api.nvim_get_current_win()
  local cur_buf = vim.api.nvim_get_current_buf()

  -- If current window already shows alpha → restore the saved buffer for this window
  if vim.bo[cur_buf].filetype == "alpha" then
    local prev = vim.w._dashboard_prev_buf
    if prev and vim.api.nvim_buf_is_valid(prev) then
      vim.api.nvim_win_set_buf(cur_win, prev)
    end
    return
  end

  -- Save the current buffer for this window, then open alpha
  vim.w._dashboard_prev_buf = cur_buf
  vim.cmd("Alpha")
end, { desc = "Toggle Dashboard" })
