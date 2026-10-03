--- Alt+i — PowerShell floating terminal.
--- On Windows this picks pwsh/Windows PowerShell; on Linux it picks pwsh and
--- falls back to the default shell (with a notification) when pwsh is absent.
local floating_term = require("custom.floating_term")

local M = {}

local cfg = {
  id = "powershell",
  slot = "powershell",
  toggle_key = "<M-i>",
  border = "rounded",
  winblend = 10,
  width_ratio = 0.7,
  height_ratio = 0.7,
}

function M.toggle()
  floating_term.toggle(cfg)
end

return M
