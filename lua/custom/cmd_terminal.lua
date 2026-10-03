--- Alt+c — default-shell floating terminal (CMD on Windows, $SHELL on Linux).
local floating_term = require("custom.floating_term")

local M = {}

local cfg = {
  id = "default",
  slot = "cmd",
  toggle_key = "<M-c>",
  border = "rounded",
  winblend = 8,
  width_ratio = 0.65,
  height_ratio = 0.65,
}

function M.toggle()
  floating_term.toggle(cfg)
end

return M
