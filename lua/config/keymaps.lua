-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-------------------------------------------------------
-- Floating terminal toggle (Alt+i)
-------------------------------------------------------

vim = vim

vim.keymap.set("n", "<M-i>", function()
  require("custom.terminal").toggle()
end, { desc = "Toggle floating terminal" })

-- CMD split terminal toggle (Alt+c)
vim.keymap.set("n", "<M-c>", function()
  require("custom.cmd_terminal").toggle()
end, { desc = "Toggle CMD split terminal" })

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
vim.keymap.set("n", "-", require("oil").open_float, { desc = "Open oil (file explorer)" })

-- Scroll horizontally by 6 columns instead of the default half-screen
vim.keymap.set("n", "zh", "<Cmd>normal! 6zh<CR>", { desc = "Scroll left 6" })
vim.keymap.set("n", "zl", "<Cmd>normal! 6zl<CR>", { desc = "Scroll right 6" })

-- Delete without yanking (into the black hole register)
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete without yank (wait for motion)" })
vim.keymap.set("v", "<leader>d", '"_d', { desc = "Delete without yank (selection)" })

-- In Visual mode, paste over selection without yanking the old text
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yank" })
vim.keymap.set("v", "P", '"_dP', { desc = "Paste without yank (alternative)" })

-- Toggle Alpha Dashboard (open if not exists, close if already open)
vim.keymap.set({ "n", "v" }, "<leader>h", function()
  -- Check if an alpha buffer is already visible
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == "alpha" and vim.api.nvim_buf_is_valid(buf) then
      local wins = vim.fn.bufwinid(buf)
      if #wins > 0 then
        -- Alpha is visible — close all its windows
        for _, win in ipairs(wins) do
          vim.api.nvim_win_close(win, true)
        end
        return
      end
    end
  end
  -- No alpha visible — open it
  vim.cmd("Alpha")
end, { desc = "Toggle Dashboard" })
