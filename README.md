<!--
  DopaVim – Neovim configuration powered by LazyVim and dopamine.
  https://github.com/musaeed178-uio/nvim-config
-->

<p align="center">
  <img src="https://raw.githubusercontent.com/musaeed178-uio/nvim-config/main/assets/logo.png" width="120" alt="DopaVim logo" />
</p>

<h1 align="center">DopaVim</h1>

<p align="center">
  <strong>A Neovim configuration that feels like home.</strong><br>
  Built on <a href="https://github.com/LazyVim/LazyVim">LazyVim</a> – customized with care, caffeine, and a touch of dopamine.
</p>

<p align="center">
  <a href="https://neovim.io/">
    <img src="https://img.shields.io/badge/Neovim-0.10+-57A143?style=flat&logo=neovim&logoColor=white" alt="Neovim version" />
  </a>
  <a href="https://github.com/LazyVim/LazyVim">
    <img src="https://img.shields.io/badge/LazyVim-stable-7b9d6b?style=flat&logo=lazyvim" alt="LazyVim" />
  </a>
  <a href="https://github.com/musaeed178-uio/nvim-config/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/musaeed178-uio/nvim-config?color=blue" alt="License" />
  </a>
  <a href="https://github.com/musaeed178-uio/nvim-config/stargazers">
    <img src="https://img.shields.io/github/stars/musaeed178-uio/nvim-config?style=flat" alt="Stars" />
  </a>
</p>

---

## ✨ Features

- 🚀 **LazyVim core** – modern plugin management, fast startup, sane defaults.
- 🎨 **Neofusion theme** – a vibrant, cohesive colorscheme.
- 🖥️ **Floating terminals** – <kbd>Alt+i</kbd> for PowerShell, <kbd>Alt+c</kbd> for CMD – both with titles and independent state.
- 📁 **Oil file explorer** – navigate and edit files like a pro (<kbd>-</kbd> to open).
- 💾 **Session management** – save/restore sessions (`<leader>qs`, dashboard `s`/`S`).
- 🔍 **Telescope** – fuzzy finder for files, buffers, help tags, and more.
- 🐙 **Lazygit** – seamless Git integration via `<leader>gg`.
- 📊 **Dashboard** – beautiful start page with live clock, plugin stats, and quick actions.
- 📝 **Markdown preview** – render markdown in real time.
- 🔧 **LSP ready** – with Mason for language servers, conform.nvim for formatting, nvim-lint for diagnostics.

---

## 🗺️ Keymaps (Highlights)

| Key | Action |
|-----|--------|
| `<leader>gg` | Open Lazygit (floating) |
| `<leader>h` | Toggle Dashboard |
| `<leader>a` | Select all text |
| `<leader>d` | Delete without yanking |
| `<leader>sv` / `<leader>sh` | Vertical / Horizontal split |
| `<leader>tp` / `<leader>tn` | Previous / Next buffer |
| `<leader>1`-`<leader>9` | Go to buffer by number |
| `-` | Open Oil (file explorer) |
| `<M-i>` | Toggle floating PowerShell terminal |
| `<M-c>` | Toggle floating CMD terminal |
| `zh` / `zl` | Scroll horizontally by 6 columns |
| `Esc` (in terminal) | Exit terminal mode to Normal mode |

*For a full list, check `lua/config/keymaps.lua`.*

---

## 🚀 Installation

### Prerequisites
- [Neovim](https://neovim.io/) ≥ 0.10.0
- [Git](https://git-scm.com/)
- (Optional) [Lazygit](https://github.com/jesseduffield/lazygit) – for Git integration
- (Optional) [Nerd Font](https://www.nerdfonts.com/) – for icons

### Steps

1. **Backup your existing config** (if any):
   ```bash
   mv ~/AppData/Local/nvim ~/AppData/Local/nvim.bak
