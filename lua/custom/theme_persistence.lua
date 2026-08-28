local M = {}

local theme_file = vim.fn.stdpath("data") .. "/last_theme"

--- Save the current colorscheme name to disk
function M.save(theme_name)
  if not theme_name or theme_name == "" then
    return
  end
  local f = io.open(theme_file, "w")
  if f then
    f:write(theme_name)
    f:close()
  end
end

--- Load the saved colorscheme name from disk
---@return string|nil
function M.load()
  local f = io.open(theme_file, "r")
  if f then
    local name = f:read("*l")
    f:close()
    if name then
      name = name:gsub("%s+", "")
    end
    return name
  end
  return nil
end

--- Set up autocmd to auto-save theme on change
function M.setup_autosave()
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function(args)
      M.save(args.match)
    end,
  })
end

return M
