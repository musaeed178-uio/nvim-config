--- Alt+b — Git Bash floating terminal.
--- Windows: Git for Windows install paths (never the WSL stub).
--- Linux/macOS: bash.
local floating_term = require("custom.floating_term")

local M = {}

local cfg = {
  id = "gitbash",
  slot = "gitbash",
  toggle_key = "<M-b>",
  border = "rounded",
  winblend = 10,
  width_ratio = 0.7,
  height_ratio = 0.7,
}

function M.toggle()
  floating_term.toggle(cfg)
end

return M
