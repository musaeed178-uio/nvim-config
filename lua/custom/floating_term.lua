--- Shared implementation for DopaVim's floating terminals.
---
--- Each terminal slot (PowerShell / default shell / Git Bash) is just a
--- config table; everything else — window geometry, cwd tracking, lifecycle
--- and keymaps — lives here so the three wrappers stay tiny.
local M = {}

local shells = require("custom.shells")

---@type table<string, table>
local state = {}

---@param id string
---@return table
local function slot_state(id)
  local s = state[id]
  if not s then
    s = {}
    state[id] = s
  end
  return s
end

---@param s table
---@return boolean
local function is_alive(s)
  return s.chan ~= nil and vim.fn.jobwait({ s.chan }, 0)[1] == -1
end

---@param cfg table
---@return integer width, integer height, integer row, integer col
local function geometry(cfg)
  local width = math.floor(vim.o.columns * (cfg.width_ratio or 0.7))
  local height = math.floor(vim.o.lines * (cfg.height_ratio or 0.7))
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  return width, height, row, col
end

---@param s table
---@param cfg table
---@param buf integer
---@param title string|nil
local function open_window(s, cfg, buf, title)
  local width, height, row, col = geometry(cfg)
  s.win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = cfg.border or "rounded",
    style = "minimal",
    title = title or "",
    title_pos = "center",
  })
  -- nvim_open_win(.., true, ..) makes the new window current, so `vim.wo` applies.
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = "no"
  vim.wo.winblend = cfg.winblend or 10
end

---@return string
local function target_cwd()
  local source_file = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local dir = source_file ~= "" and vim.fn.fnamemodify(source_file, ":h") or vim.fn.getcwd()
  if vim.fn.isdirectory(dir) ~= 1 then
    dir = vim.fn.getcwd()
  end
  return dir
end

---@param s table
local function cleanup(s)
  if s.win and vim.api.nvim_win_is_valid(s.win) then
    pcall(vim.api.nvim_win_close, s.win, true)
  end
  if s.buf and vim.api.nvim_buf_is_valid(s.buf) then
    pcall(vim.api.nvim_buf_delete, s.buf, { force = true })
  end
  s.win = nil
  s.buf = nil
  s.chan = nil
  s.last_cwd = nil
  s.argv = nil
  s.title = nil
end

---@param s table
---@param cfg table
local function attach_terminal_keymaps(s, cfg)
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {
    buffer = s.buf,
    silent = true,
    desc = "Leave terminal mode",
  })

  if cfg.toggle_key then
    vim.keymap.set("t", cfg.toggle_key, function()
      M.toggle(cfg)
    end, {
      buffer = s.buf,
      silent = true,
      desc = "Toggle " .. (s.title or "terminal"),
    })
  end
end

---@param cfg { id: string, slot: string, title?: string, toggle_key?: string,
---            border?: string, winblend?: number,
---            width_ratio?: number, height_ratio?: number }
function M.toggle(cfg)
  local s = slot_state(cfg.id)

  -- Hide if visible
  if s.win and vim.api.nvim_win_is_valid(s.win) then
    vim.api.nvim_win_hide(s.win)
    s.win = nil
    return
  end

  local cwd = target_cwd()

  -- Re-open an existing terminal, updating its cwd if the source moved
  if s.buf and vim.api.nvim_buf_is_valid(s.buf) and is_alive(s) then
    if cwd ~= s.last_cwd then
      vim.fn.chansend(s.chan, shells.cd_command(s.argv, cwd) .. shells.eol)
      s.last_cwd = cwd
    end
    open_window(s, cfg, s.buf, s.title)
    vim.cmd.startinsert()
    return
  end

  -- Resolve the shell BEFORE opening a window: a missing shell used to leave
  -- an orphan empty floating window behind.
  local resolved, err = shells.resolve(cfg.slot)
  if not resolved then
    vim.notify(err, vim.log.levels.ERROR, { title = "DopaVim terminal" })
    return
  end
  if resolved.warn then
    vim.notify(resolved.warn, vim.log.levels.WARN, { title = "DopaVim terminal" })
  end

  s.buf = vim.api.nvim_create_buf(false, true)
  open_window(s, cfg, s.buf, resolved.title)
  s.argv = resolved.argv
  s.title = resolved.title

  local ok, chan = pcall(vim.fn.termopen, resolved.argv, {
    cwd = cwd,
    on_exit = function()
      vim.schedule(function()
        cleanup(s)
      end)
    end,
  })

  if not ok or chan == nil or chan == 0 then
    vim.notify(
      ("Failed to start %s: %s"):format(resolved.title, ok and "exit code 0" or tostring(chan)),
      vim.log.levels.ERROR,
      { title = "DopaVim terminal" }
    )
    cleanup(s)
    return
  end

  s.chan = chan
  s.last_cwd = cwd
  vim.cmd.startinsert()
  attach_terminal_keymaps(s, cfg)
end

return M
