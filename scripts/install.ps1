<#
.SYNOPSIS
  Install or update DopaVim on Windows.

.DESCRIPTION
  Backs up any existing Neovim configuration, clones DopaVim into
  %LOCALAPPDATA%\nvim, restores the pinned plugin set from lazy-lock.json and
  finishes by telling you how to run the dependency check.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File scripts\install.ps1

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File scripts\install.ps1 -SkipBackup -Force
#>
[CmdletBinding()]
param(
  # Repository to install from.
  [string]$Repo = "https://github.com/musaeed178-uio/nvim-config.git",

  # Do not move an existing config aside; fail instead.
  [switch]$SkipBackup,

  # Re-clone even if the target already is this repository.
  [switch]$Force
)

$ErrorActionPreference = "Stop"

$ConfigDir = Join-Path $env:LOCALAPPDATA "nvim"
$Stamp = Get-Date -Format "yyyyMMdd-HHmmss"

function Write-Step([string]$Message) {
  Write-Host "==> $Message" -ForegroundColor Cyan
}

function Test-Command([string]$Name) {
  return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

Write-Step "Checking prerequisites"
if (-not (Test-Command "git")) {
  throw "git was not found on PATH. Install it with: winget install Git.Git"
}
if (-not (Test-Command "nvim")) {
  Write-Warning "nvim was not found on PATH. Install it first with: winget install Neovim.Neovim"
}

$missing = @()
foreach ($tool in @("rg", "fd")) {
  if (-not (Test-Command $tool)) { $missing += $tool }
}
if ($missing.Count -gt 0) {
  Write-Warning ("Optional tools not found: {0}. Install with 'scoop install ripgrep fd' or 'winget install ...'." -f ($missing -join ", "))
}

Write-Step "Preparing $ConfigDir"
if (Test-Path $ConfigDir) {
  $isGitRepo = Test-Path (Join-Path $ConfigDir ".git")
  $hasFiles = (Get-ChildItem -Force $ConfigDir | Measure-Object).Count -gt 0

  if ($hasFiles -and -not $isGitRepo -and -not $SkipBackup) {
    $backup = "$ConfigDir.bak-$Stamp"
    Write-Warning "Existing config found. Moving it to $backup"
    Rename-Item -LiteralPath $ConfigDir -NewName (Split-Path $backup -Leaf)
  }
  elseif ($hasFiles -and -not $isGitRepo) {
    throw "$ConfigDir already exists and is not empty. Move it aside or re-run without -SkipBackup."
  }
  elseif ($Force -and $isGitRepo) {
    Write-Warning "Re-cloning into a temporary directory, then replacing $ConfigDir"
    $tmp = Join-Path $env:TEMP "dopavim-$Stamp"
    git clone --depth 1 $Repo $tmp
    if ($LASTEXITCODE -ne 0) { throw "git clone failed" }
    Remove-Item -LiteralPath $ConfigDir -Recurse -Force
    Move-Item -LiteralPath $tmp -Destination $ConfigDir
  }
}

if (-not (Test-Path (Join-Path $ConfigDir ".git"))) {
  Write-Step "Cloning DopaVim into $ConfigDir"
  git clone $Repo $ConfigDir
  if ($LASTEXITCODE -ne 0) { throw "git clone failed" }
}
else {
  Write-Step "Updating existing clone"
  git -C $ConfigDir pull --ff-only
  if ($LASTEXITCODE -ne 0) { throw "git pull failed (local changes?)" }
}

if (Test-Command "nvim") {
  Write-Step "Restoring pinned plugins from lazy-lock.json"
  # Bootstrapping happens on first launch; restore pins every plugin to the
  # commit recorded in lazy-lock.json. stderr redirection must not be turned
  # into a terminating error by $ErrorActionPreference.
  $prevEAP = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  $null = & nvim --headless "+Lazy! restore" +qa 2>&1
  $restoreCode = $LASTEXITCODE
  $ErrorActionPreference = $prevEAP
  if ($restoreCode -ne 0) {
    Write-Warning "Plugin restore did not complete cleanly. Start 'nvim' once and run ':Lazy restore'."
  }
}

Write-Host ""
Write-Host "DopaVim installed." -ForegroundColor Green
Write-Host "  1. Run:  nvim"
Write-Host "  2. Inside Neovim run:  :checkhealth dopavim"
Write-Host "  3. Any WARNING/ERROR there tells you exactly what is still missing."
