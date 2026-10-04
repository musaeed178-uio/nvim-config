--- :checkhealth dopavim
---
--- Verifies everything a fresh clone needs in order to actually work:
--- toolchain, finders, optional integrations, terminal shells and the two
--- state files that make the config reproducible.
local M = {}

local health = vim.health
local is_win = vim.fn.has("win32") == 1

---@param name string
---@return boolean
local function has(name)
  return vim.fn.executable(name) == 1
end

---@param exe string
---@param args string
---@return string|nil version, string|nil raw
local function probe(exe, args)
  -- String form so Windows can resolve .cmd/.bat shims from npm and friends.
  local out = vim.fn.system(exe .. " " .. args)
  if vim.v.shell_error ~= 0 then
    return nil, out
  end
  out = (out or ""):gsub("%s+$", "")
  if out == "" then
    return nil, out
  end
  -- Some tools report two components ("pandoc 3.11"), most report three.
  local version = out:match("(%d+[%d%.]*%d)") or out:match("(%d+%.%d+)") or out:match("(%d+)")
  return version, out
end

---@param a string
---@param b string
---@return boolean true when a >= b
local function at_least(a, b)
  local function parts(v)
    local ma, mi, pa = v:match("^(%d+)%.(%d+)%.(%d+)")
    return tonumber(ma) or 0, tonumber(mi) or 0, tonumber(pa) or 0
  end
  local a1, a2, a3 = parts(a)
  local b1, b2, b3 = parts(b)
  if a1 ~= b1 then
    return a1 > b1
  end
  if a2 ~= b2 then
    return a2 > b2
  end
  return a3 >= b3
end

local function check_core()
  health.start("DopaVim core")

  local nvim_version = ("%d.%d.%d"):format(vim.version().major, vim.version().minor, vim.version().patch)
  -- nvim-treesitter is pinned to its `main` branch, which hard-requires 0.12.0+
  if at_least(nvim_version, "0.12.0") then
    health.ok("Neovim " .. nvim_version)
  else
    health.error(
      "Neovim " .. nvim_version .. " is too old",
      { "DopaVim needs Neovim >= 0.12.0 (nvim-treesitter main branch requirement)." }
    )
  end

  if has("git") then
    local _, raw = probe("git", "--version")
    health.ok("git: " .. ((raw or ""):gsub("^git version ", "")))
  else
    health.error("git not found", { "lazy.nvim cannot bootstrap without git." })
  end

  local config_dir = vim.fn.stdpath("config")
  for _, file in ipairs({ "lazy-lock.json", "lazyvim.json" }) do
    local path = config_dir .. "/" .. file
    if vim.fn.filereadable(path) ~= 1 then
      health.error(file .. " is missing from " .. config_dir, {
        "Both files are required for a reproducible install.",
        "They must be committed to the repository, never git-ignored.",
      })
    else
      local ignored, tracked = false, false
      if has("git") then
        vim.fn.system({ "git", "-C", config_dir, "check-ignore", "-q", "--", file })
        ignored = vim.v.shell_error == 0
        vim.fn.system({ "git", "-C", config_dir, "ls-files", "--error-unmatch", "--", file })
        tracked = vim.v.shell_error == 0
      end

      if ignored then
        health.error(file .. " is git-ignored", {
          "A fresh clone would not get your plugin pins/extras.",
          "Remove it from .gitignore and commit it.",
        })
      elseif has("git") and not tracked then
        health.error(file .. " exists but is not tracked by git", {
          "A fresh clone would not get your plugin pins/extras.",
          "Add and commit it: git add " .. file .. " && git commit",
        })
      else
        health.ok(file .. " present and tracked")
      end
    end
  end
end

local function check_build_toolchain()
  health.start("Treesitter build toolchain")

  for _, tool in ipairs({ "tar", "curl" }) do
    if has(tool) then
      health.ok(tool)
    else
      health.error(tool .. " not found", { "nvim-treesitter needs tar and curl in PATH." })
    end
  end

  local compiler = nil
  for _, cc in ipairs({ "cc", "gcc", "clang", "cl" }) do
    if has(cc) then
      compiler = cc
      break
    end
  end
  if compiler then
    health.ok("C compiler: " .. compiler)
  else
    health.error("No C compiler found", {
      "nvim-treesitter compiles parsers and needs cc/gcc/clang/cl in PATH.",
      is_win and "Install MSYS2/MinGW, LLVM, or Visual Studio Build Tools."
        or "Install build-essential / xcode-select / a distro toolchain group.",
    })
  end

  if not has("tree-sitter") then
    health.error("tree-sitter-cli not found", {
      "nvim-treesitter (main branch) requires tree-sitter-cli >= 0.26.1.",
      "Install it with your package manager (NOT npm).",
      is_win and "scoop install tree-sitter  /  winget install tree-sitter"
        or "pacman -S tree-sitter / apt install tree-sitter-cli / brew install tree-sitter",
    })
    return
  end

  local version, raw = probe("tree-sitter", "--version")
  if version and at_least(version, "0.26.1") then
    health.ok("tree-sitter-cli " .. version)
  elseif version then
    health.error("tree-sitter-cli " .. version .. " is too old", { "Need >= 0.26.1." })
  else
    health.warn("Could not read tree-sitter-cli version: " .. (raw or "unknown output"))
  end

  local path = vim.fn.exepath("tree-sitter"):lower()
  local link = (vim.uv.fs_readlink(vim.fn.exepath("tree-sitter")) or ""):lower()
  if path:find("npm", 1, true) or path:find("node_modules", 1, true) or link:find("node_modules", 1, true) then
    health.warn("tree-sitter-cli is installed via npm", {
      "nvim-treesitter explicitly asks for a package-manager install instead of npm.",
      "It works today, but npm builds are the ones that break on upgrade.",
    })
  end
end

local function check_finders()
  health.start("Fuzzy finding / grep")

  if has("rg") then
    local version = probe("rg", "--version")
    health.ok("ripgrep " .. (version or ""))
  else
    health.error("ripgrep (rg) not found", {
      "Live grep in the picker will not work without it.",
      is_win and "scoop install ripgrep  /  winget install BurntSushi.ripgrep.MSVC"
        or "apt/dnf/pacman install ripgrep, or brew install ripgrep",
    })
  end

  if has("fd") or has("fdfind") then
    health.ok("fd")
  else
    health.warn("fd not found — the picker falls back to a slower scan", {
      is_win and "scoop install fd  /  winget install sharkdp.fd" or "apt/dnf/pacman install fd-find",
    })
  end
end

local function check_optional_integrations()
  health.start("Optional integrations")

  local optional = {
    { exe = "pandoc", why = "nvim-docx (.docx editing)" },
    { exe = "pdftotext", why = "PDFview text extraction (poppler-utils)" },
    { exe = "node", why = "markdown-preview.nvim" },
  }

  for _, item in ipairs(optional) do
    if has(item.exe) then
      local version = probe(item.exe, "--version")
      health.ok(("%s %s — %s"):format(item.exe, version or "", item.why))
    else
      health.info(item.exe .. " not installed — " .. item.why .. " will be unavailable")
    end
  end
end

local function check_terminals()
  health.start("Floating terminals")

  local shells = require("custom.shells")
  local labels = {
    powershell = "Alt+i (PowerShell slot)",
    cmd = "Alt+c (default shell slot)",
    gitbash = "Alt+b (Git Bash slot)",
  }

  for _, slot in ipairs({ "powershell", "cmd", "gitbash" }) do
    local resolved, err = shells.resolve(slot)
    if not resolved then
      health.error(labels[slot] .. ": " .. (err or "no shell"), {
        is_win and "Install Git for Windows / PowerShell." or "Install pwsh or bash.",
      })
    elseif resolved.warn then
      health.warn(labels[slot] .. " -> " .. table.concat(resolved.argv, " ") .. " (" .. resolved.warn .. ")")
    else
      health.ok(labels[slot] .. " -> " .. table.concat(resolved.argv, " "))
    end
  end
end

local function check_notebooks()
  health.start("Jupyter notebooks (.ipynb)")

  local py = nil
  for _, candidate in ipairs(is_win and { "python", "python3" } or { "python3", "python" }) do
    if has(candidate) then
      py = candidate
      break
    end
  end

  if not py then
    health.error("Python not found", {
      "ipynb.nvim runs kernel cells through Python 3.",
      is_win and "winget install Python.Python.3.14" or "apt/dnf/pacman install python3",
    })
    return
  end

  local _, raw = probe(py, "--version")
  health.ok(("%s — %s"):format(py, ((raw or ""):gsub("%s+$", ""))))

  -- List-form system() bypasses the shell, so `-c` needs no extra quoting.
  local function imports(module)
    vim.fn.system({ py, "-c", "import " .. module })
    return vim.v.shell_error == 0
  end

  if imports("jupyter_client") then
    health.ok("jupyter_client — ipynb.nvim can start a kernel")
  else
    health.error("jupyter_client is not installed", {
      "ipynb.nvim cannot execute cells without it.",
      "uv pip install --system jupyter_client ipykernel",
    })
  end

  if imports("ipykernel") then
    health.ok("ipykernel — a Python kernel is available")
  else
    health.warn("ipykernel is not installed", {
      "Without it there is no python3 kernelspec, so Python cells cannot run.",
      "uv pip install --system ipykernel",
    })
  end

  if pcall(vim.treesitter.language.inspect, "ipynb") then
    health.ok("ipynb treesitter parser compiled")
  else
    health.warn("ipynb treesitter parser is not compiled yet", {
      "ipynb.nvim compiles its bundled parser once at startup.",
      "It needs a C compiler; on Windows, tree-sitter CLI asks for cl.exe, so the",
      "ipynb spec points CC at gcc/cc when MSVC is absent.",
    })
  end

  local out = vim.fn.system({
    py,
    "-c",
    "from jupyter_client.kernelspec import KernelSpecManager;"
      .. " print(','.join(sorted(KernelSpecManager().find_kernel_specs())))",
  })
  if vim.v.shell_error == 0 then
    local names = (out or ""):gsub("%s+$", "")
    if names ~= "" then
      health.ok("kernels: " .. names)
    else
      health.warn("no Jupyter kernels registered", { "uv pip install --system ipykernel" })
    end
  else
    health.info("could not list kernels: " .. ((out or ""):gsub("%s+$", "")))
  end

  health.info("Plugin-specific checks live in :checkhealth ipynb")
end

function M.check()
  check_core()
  check_build_toolchain()
  check_finders()
  check_optional_integrations()
  check_notebooks()
  check_terminals()
end

return M
