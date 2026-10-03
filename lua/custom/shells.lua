--- Cross-platform shell resolution for DopaVim's floating terminals.
---
--- Three logical slots are exposed and mapped to keys in config/keymaps.lua:
---   * "powershell"  -> Alt+i
---   * "cmd"         -> Alt+c   (the platform's default interactive shell)
---   * "gitbash"     -> Alt+b
---
--- Every resolver returns a table `{ argv, title, warn? }`, or nil when no
--- usable shell exists. Fallbacks are resolved here so the UI layer never has
--- to care which OS it is running on.
local M = {}

M.is_win = vim.fn.has("win32") == 1

--- Line terminator to send to a shell over chansend.
--- POSIX shells need a bare "\n"; Windows consoles need "\r\n".
M.eol = M.is_win and "\r\n" or "\n"

--- Windows installations of Git for Windows, most common first.
local WIN_GIT_BASH = {
  "C:/Program Files/Git/bin/bash.exe",
  "C:/Program Files/Git/usr/bin/bash.exe",
  "C:/Program Files (x86)/Git/bin/bash.exe",
}

---@param path string
---@return string
local function basename(path)
  path = tostring(path or ""):gsub("[\\/]+$", "")
  return path:match("([^\\/]+)$") or path
end

---@param path string
---@return string
local function title_of(path)
  return (basename(path):gsub("%.[eE][xX][eE]$", ""))
end

---@param candidates string[]
---@return string|nil
local function first_executable(candidates)
  for _, candidate in ipairs(candidates) do
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end
  return nil
end

--- The platform's default interactive shell.
--- Windows: cmd.exe (Alt+c keeps its original meaning).
--- Everywhere else: $SHELL, falling back to a POSIX shell.
---@return string
function M.default_shell()
  if M.is_win then
    return first_executable({ "cmd.exe" }) or "cmd.exe"
  end
  local shell = vim.env.SHELL
  if shell and shell ~= "" and vim.fn.executable(shell) == 1 then
    return shell
  end
  return first_executable({ "/bin/sh", "/bin/bash", "sh" }) or "sh"
end

---@return { argv: string[], title: string, warn?: string }|nil
local function resolve_powershell()
  if M.is_win then
    local exe = first_executable({ "pwsh.exe", "powershell.exe" })
    if exe then
      return { argv = { exe }, title = title_of(exe) == "pwsh" and "PowerShell 7" or "PowerShell" }
    end
    return nil
  end

  -- pwsh ships on most modern Linux distros, but never assume it.
  local exe = first_executable({ "pwsh" })
  if exe then
    return { argv = { exe }, title = "PowerShell 7" }
  end

  local fallback = M.default_shell()
  return {
    argv = { fallback },
    title = title_of(fallback),
    warn = "pwsh not found on PATH — falling back to " .. fallback,
  }
end

---@return { argv: string[], title: string, warn?: string }|nil
local function resolve_default()
  local shell = M.default_shell()
  return { argv = { shell }, title = M.is_win and "CMD" or title_of(shell) }
end

---@return { argv: string[], title: string, warn?: string }|nil
local function resolve_gitbash()
  if M.is_win then
    local exe = first_executable(WIN_GIT_BASH)
    if not exe then
      -- Fall back to whatever `bash` is on PATH, but never accept the WSL
      -- stub in System32 (or the WindowsApps alias) as "Git Bash".
      local p = vim.fn.exepath("bash")
      local lower = p:lower()
      if p ~= "" and not lower:find("system32", 1, true) and not lower:find("windowsapps", 1, true) then
        exe = p
      end
    end
    if exe then
      return { argv = { exe, "--login" }, title = "Git Bash" }
    end
    return nil
  end

  local exe = first_executable({ "/usr/bin/bash", "/bin/bash", "bash" })
  if exe then
    return { argv = { exe, "--login" }, title = "Bash" }
  end

  local fallback = M.default_shell()
  return {
    argv = { fallback },
    title = title_of(fallback),
    warn = "bash not found — falling back to " .. fallback,
  }
end

local resolvers = {
  powershell = resolve_powershell,
  cmd = resolve_default,
  gitbash = resolve_gitbash,
}

---@param slot string one of "powershell" | "cmd" | "gitbash"
---@return { argv: string[], title: string, warn?: string }|nil
---@return string|nil err
function M.resolve(slot)
  local resolver = resolvers[slot]
  if not resolver then
    return nil, "Unknown terminal slot: " .. tostring(slot)
  end
  local resolved = resolver()
  if not resolved or not resolved.argv or #resolved.argv == 0 then
    return nil, ("No usable shell found for terminal slot '%s' on this system"):format(slot)
  end
  return resolved
end

--- Build the command used to move an already-running terminal to a new cwd.
--- cmd.exe needs `/d` whenever the drive letter changes; every other shell
--- does not accept that flag.
---@param argv string[]
---@param cwd string
---@return string
function M.cd_command(argv, cwd)
  local exe = basename(argv and argv[1] or ""):lower()
  local prefix = exe:match("^cmd") and "cd /d " or "cd "
  -- Quotes cannot appear in a Windows path and are vanishingly rare in POSIX
  -- ones; stripping keeps the command safe in both shells.
  return prefix .. '"' .. tostring(cwd):gsub('"', "") .. '"'
end

return M
