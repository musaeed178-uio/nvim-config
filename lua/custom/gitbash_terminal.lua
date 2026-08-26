local M = {}

--------------------------------------------------
-- Configuration
--------------------------------------------------

M.border = "rounded"
M.winblend = 10
M.title = "Git Bash"

local state = {
  win = nil,
  buf = nil,
  chan = nil,
  last_cwd = nil,
}

--------------------------------------------------
-- Helpers
--------------------------------------------------

local function terminal_alive()
  return state.chan and vim.fn.jobwait({ state.chan }, 0)[1] == -1
end

local function apply_window_options()
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = "no"
  vim.wo.winblend = M.winblend
end

--------------------------------------------------
-- Toggle
--------------------------------------------------

function M.toggle()
  -- Hide if visible
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
    state.win = nil
    return
  end

  -- Calculate target directory
  local source_buf = vim.api.nvim_get_current_buf()
  local source_file = vim.api.nvim_buf_get_name(source_buf)
  local target_cwd = source_file ~= "" and vim.fn.fnamemodify(source_file, ":h") or vim.fn.getcwd()

  -- Window geometry
  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.7)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Re‑open existing terminal (and update cwd if needed)
  if state.buf and vim.api.nvim_buf_is_valid(state.buf) and terminal_alive() then
    if state.chan and target_cwd and target_cwd ~= state.last_cwd then
      local escaped = '"' .. target_cwd .. '"'
      vim.fn.chansend(state.chan, "cd " .. escaped .. "\r\n")
      state.last_cwd = target_cwd
    end

    state.win = vim.api.nvim_open_win(state.buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      border = M.border,
      style = "minimal",
      title = M.title,
      title_pos = "center",
    })
    apply_window_options()
    vim.cmd.startinsert()
    return
  end

  -- Create new terminal (first time)
  state.buf = vim.api.nvim_create_buf(false, true)
  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = M.border,
    style = "minimal",
    title = M.title,
    title_pos = "center",
  })
  apply_window_options()

  -- Find Git Bash (avoid the WSL stub in WindowsApps)
  local git_bash = nil
  local candidates = {
    "C:/Program Files/Git/bin/bash.exe",
    "C:/Program Files (x86)/Git/bin/bash.exe",
    "C:/Program Files/Git/usr/bin/bash.exe",
  }
  for _, path in ipairs(candidates) do
    if vim.fn.executable(path) == 1 then
      git_bash = path
      break
    end
  end
  if not git_bash then
    vim.notify("Git Bash not found. Install Git for Windows.", vim.log.levels.ERROR)
    return
  end

  -- Launch Git Bash (use a list to bypass cmd.exe shell parsing on Windows,
  -- which would split the path at spaces in "Program Files")
  state.chan = vim.fn.termopen({ git_bash, "--login" }, {
    cwd = target_cwd,
    on_exit = function()
      vim.schedule(function()
        if state.win and vim.api.nvim_win_is_valid(state.win) then
          pcall(vim.api.nvim_win_close, state.win, true)
        end
        if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
          pcall(vim.api.nvim_buf_delete, state.buf, { force = true })
        end
        state.win = nil
        state.buf = nil
        state.chan = nil
        state.last_cwd = nil
      end)
    end,
  })
  state.last_cwd = target_cwd
  vim.cmd.startinsert()

  -- Map Esc to exit terminal mode to normal mode
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {
    buffer = state.buf,
    silent = true,
  })

  -- Alt+b toggles inside terminal
  vim.keymap.set("t", "<M-b>", function() M.toggle() end, {
    buffer = state.buf,
    silent = true,
  })
end

return M
