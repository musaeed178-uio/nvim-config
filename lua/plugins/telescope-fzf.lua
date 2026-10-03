-- telescope-fzf-native supplies Telescope's fast C sorter, but it has to be
-- compiled. LazyVim already skips it when there is no build tool at all, but
-- on Windows a lone `cmake` is not enough: configure falls back to a
-- generator that needs nmake/make, fails, and LazyVim then retries the build
-- (with two noisy messages) on *every* start. So only keep the plugin when a
-- generator we can actually drive is on PATH; otherwise Telescope falls back
-- to its built-in sorter and nothing else changes.
local build_tools = { "make", "gmake", "ninja", "nmake", "mingw32-make" }

local has_build_tool = false
for _, tool in ipairs(build_tools) do
  if vim.fn.executable(tool) == 1 then
    has_build_tool = true
    break
  end
end

return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = has_build_tool,
  },
}
