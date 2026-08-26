# 🧠 DopaVim

> **A Blade Runner--inspired Neovim distribution for people who actually
> want to enjoy using their editor.**\
> *Built on LazyVim. Personalized from the ground up. Fueled by
> Dopamine.*

[![Neovim](https://img.shields.io/badge/Neovim-0.12.4-57A143?style=flat&logo=neovim&logoColor=white)](https://neovim.io/)
[![LazyVim](https://img.shields.io/badge/LazyVim-11.0-ff69b4?style=flat&logo=lazyvim)](https://www.lazyvim.org/)
[![License](https://img.shields.io/github/license/musaeed178-uio/nvim-config?style=flat)](https://github.com/musaeed178-uio/nvim-config/blob/main/LICENSE)

```
  ██████╗  ██████╗ ██████╗  █████╗ ██╗   ██╗██╗███╗   ███╗
  ██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██║   ██║██║████╗ ████║
  ██║  ██║██║   ██║██████╔╝███████║██║   ██║██║██╔████╔██║
  ██║  ██║██║   ██║██╔═══╝ ██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██████╔╝╚██████╔╝██║     ██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═════╝  ╚═════╝ ╚═╝     ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
                          Powered by Dopamine
```

------------------------------------------------------------------------

## 📖 What is DopaVim?

**DopaVim** is my personal Neovim environment, built on top of
**LazyVim** and shaped through a lot of experimentation, debugging,
rebuilding, and customization.

The goal was never to create another "minimal Neovim config."

The goal was to build an editor that feels **mine**.

DopaVim combines:

-   a solid LazyVim foundation
-   a dark cyberpunk / Blade Runner-inspired aesthetic
-   fast navigation and fuzzy finding
-   floating terminals
-   a practical file-management workflow
-   custom dashboard and session workflows
-   project management with project.nvim
-   theme persistence across sessions
-   carefully chosen plugins
-   personalized keymaps
-   a setup optimized around my actual day-to-day development

I use Neovim as more than a text editor. It is the place where I work on
university projects, programming experiments, AI/ML learning,
system-level experiments, and larger personal projects.

So DopaVim is intentionally opinionated.

It is not designed to satisfy everyone.

**It is designed to make me want to open Neovim.**

------------------------------------------------------------------------

## ⚡ Philosophy

DopaVim follows a few simple principles:

### 1. Build on a strong foundation

There is no reason to reinvent everything.

LazyVim already solves a huge amount of the difficult infrastructure:
plugin management, sensible defaults, LSP integration, completion,
Treesitter, Git tooling, and much more.

DopaVim builds **on top of that foundation** instead of replacing it.

### 2. Customize what actually matters

Not every option needs to be changed.

The configuration focuses on things that affect everyday interaction:

-   navigation
-   terminals
-   files
-   dashboards
-   sessions
-   appearance
-   keymaps
-   workflow shortcuts

### 3. Function first, aesthetics second

The cyberpunk aesthetic is important because the editor should be
enjoyable to look at.

But aesthetics never replace usability.

Every customization has to earn its place.

### 4. Keep the workflow fast

The ideal workflow is:

> **think → type → navigate → run → inspect → repeat**

The editor should stay out of the way.

------------------------------------------------------------------------

# ✨ Features

## 🚀 LazyVim Foundation

DopaVim uses **LazyVim** as its core.

This provides a mature base for:

-   lazy-loaded plugins
-   LSP
-   Treesitter
-   completion
-   formatting
-   Git integration
-   Telescope
-   diagnostics
-   sensible defaults
-   plugin management

The custom configuration only overrides or extends what I actually want
to change.

------------------------------------------------------------------------

## 🎨 Themes

DopaVim comes with several dark, cyberpunk-inspired colorschemes
pre-installed and ready to use:

-   **SilkCircuit** (default) — a vibrant cyberpunk theme with five
    intensity variants (neon, vibrant, soft, glow, dawn)
-   **Neofusion** — a rich, gradient-based dark theme
-   **Neon** — a neon cyberpunk night aesthetic
-   **Vulpes** — a warm, fox-inspired palette

Switching themes is built into LazyVim. Open the extras picker with:

``` text
<leader> + u + C
```

This opens the **LazyVim Colorscheme** selector, where you can browse
and preview all available themes in real time.

**Theme persistence** is enabled by default. Your last chosen theme is
automatically saved and restored on the next startup — no need to
re-select it every time.

The visual direction across all themes is intentionally dark, vibrant,
and slightly futuristic — inspired by Blade Runner, cyberpunk
interfaces, terminal environments, neon-lit cityscapes, and dark
developer tooling.

------------------------------------------------------------------------

## 🖥️ Floating Terminals

DopaVim provides quick floating terminal access for Windows shells.

Two independent terminal sessions are available:

-   **Alt+i** — PowerShell (floating, 70% width)
-   **Alt+c** — CMD (floating, 65% width)

Both terminals automatically `cd` to the current buffer's directory.
Terminal shortcuts are intended to make running commands, checking
builds, testing scripts, and interacting with projects require almost no
friction.

The setup also keeps terminal behavior visually consistent with the rest
of the editor.

------------------------------------------------------------------------

## 📂 Oil.nvim

**Oil.nvim** provides the file-management workflow.

The parent directory can be opened directly with:

``` text
-
```

Oil is used instead of relying exclusively on a traditional tree-based
file explorer.

This keeps filesystem operations closer to the actual editing workflow.

------------------------------------------------------------------------

## 🔍 Telescope

Telescope is used throughout DopaVim for fast fuzzy searching.

It provides quick access to things such as:

-   files
-   buffers
-   recent files
-   live grep
-   Git information
-   plugins
-   sessions
-   projects
-   project content

The intention is simple:

> **If I know roughly what I'm looking for, I shouldn't have to manually
> navigate to it.**

------------------------------------------------------------------------

## 📁 Projects

DopaVim integrates **project.nvim** for tracking recent project
directories.

Projects are accessible from:

-   the **dashboard** (Projects button)
-   **Telescope** via the projects extension

To register a project, open any project folder and run `:ProjectRoot`.
That directory will appear in the projects picker for quick access in
future sessions.

------------------------------------------------------------------------

## 💾 Session Management

DopaVim makes project/session restoration part of the dashboard
workflow.

The dashboard provides quick access to:

-   restoring the previous session
-   selecting from saved sessions
-   starting a fresh editing environment

This is particularly useful when switching between multiple university
and personal projects.

------------------------------------------------------------------------

## ⚡ Blink.cmp

DopaVim uses **Blink.cmp** for completion.

The goal is fast, unobtrusive completion without turning the editor into
a giant autocomplete interface.

------------------------------------------------------------------------

## 🧠 Lazy Extras

LazyVim's extras system is retained.

This means additional functionality can be enabled when needed without
permanently bloating the core configuration.

The philosophy is:

> **Use what is useful. Disable what isn't.**

------------------------------------------------------------------------

## 🛠️ Custom Keymaps

The default keymaps are extended with mappings designed around my own
workflow.

Examples include shortcuts for:

-   file navigation
-   dashboard toggle (`<leader>h`)
-   terminal access (`Alt+i`, `Alt+c`)
-   buffer navigation (`<leader>1-9`)
-   splits (`<leader>sv`, `<leader>sh`)
-   searching
-   deleting without polluting the yank register
-   common editor actions

The configuration intentionally favors muscle memory and short command
sequences over memorizing long command names.

------------------------------------------------------------------------

## 🏠 Custom Dashboard

The dashboard is one of the most visible parts of DopaVim.

It acts as the editor's starting point rather than simply displaying an
empty buffer.

The dashboard features:

-   a custom **block-character ASCII logo** with per-line gradient
    highlighting (pink → purple → blue)
-   a **live clock** that updates every second
-   CWD display showing the current working directory
-   Neovim version, plugin count, and startup time

**Dashboard buttons:**

| Key | Action                       |
| --- | ---------------------------- |
| `f` | Browse Files (Telescope)     |
| `o` | Browse Files (Oil)           |
| `p` | Projects (project.nvim)      |
| `r` | Recent Files                 |
| `c` | Configuration (Oil)          |
| `l` | Lazy (plugin manager)        |
| `m` | Mason (LSP installer)        |
| `s` | Restore Session              |
| `S` | Sessions picker              |
| `x` | LazyVim Extras               |
| `h` | Health check                 |
| `q` | Quit                         |

The dashboard is meant to feel like a **control panel for the editor**.

------------------------------------------------------------------------

# 🧰 Tech Stack

DopaVim currently revolves around:

  Component            Role
  -------------------- -----------------------------
  **Neovim**           Editor
  **LazyVim**          Base distribution
  **lazy.nvim**        Plugin manager
  **SilkCircuit**      Colorscheme (default, 5 variants)
  **Blink.cmp**        Completion
  **Telescope**        Fuzzy finding
  **Oil.nvim**         File management
  **project.nvim**     Project management
  **alpha-nvim**       Dashboard
  **Treesitter**       Syntax parsing/highlighting
  **LSP**              Language intelligence
  **Conform.nvim**     Formatting
  **Git tooling**      Version-control workflow

The exact plugin set can evolve as the configuration evolves.

------------------------------------------------------------------------

# 🗂️ Configuration Structure

The configuration follows LazyVim's modular structure.

``` text
nvim/
├── init.lua
├── lazy-lock.json
│
├── lua/
│   ├── config/
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   │
│   ├── custom/
│   │   ├── terminal.lua          -- PowerShell floating terminal
│   │   ├── cmd_terminal.lua      -- CMD floating terminal
│   │   └── theme_persistence.lua -- Save/restore last theme
│   │
│   └── plugins/
│       ├── browse-telescope.lua
│       ├── dashboard.lua
│       ├── lsp.lua
│       ├── lint.lua
│       ├── oil.lua
│       ├── project.lua           -- project.nvim integration
│       ├── theme.lua
│       └── treesitter.lua
│
└── README.md
```

The important distinction is that DopaVim does **not** replace LazyVim's
architecture.

It extends it.

That makes the configuration easier to maintain while still allowing
extensive personalization.

------------------------------------------------------------------------

# ⌨️ Workflow

DopaVim is built around a keyboard-first workflow.

The general interaction model is:

``` text
Dashboard
   │
   ├── Browse Files ──────> Telescope / Oil
   ├── Projects ──────────> project.nvim
   ├── Recent files ──────> Telescope
   ├── Sessions ──────────> Session manager
   ├── Terminal ──────────> PowerShell / CMD
   └── Configuration ─────> Neovim config
```

The objective is to minimize context switching between:

-   editor
-   file manager
-   terminal
-   project search
-   Git
-   configuration

Everything should be reachable from the keyboard.

------------------------------------------------------------------------

# 📦 Installation

## Prerequisites

-   **Neovim 0.12.4** or newer
-   **Git**
-   A **Nerd Font**
-   Windows environment with PowerShell if the terminal configuration is
    to be reproduced exactly

A Nerd Font such as **JetBrains Mono Nerd Font** is recommended.

------------------------------------------------------------------------

## Windows Installation

### 1. Back up an existing configuration

If Neovim is already configured:

``` powershell
Rename-Item "$env:LOCALAPPDATA\nvim" "$env:LOCALAPPDATA\nvim.bak"
Rename-Item "$env:LOCALAPPDATA\nvim-data" "$env:LOCALAPPDATA\nvim-data.bak"
```

> Back up anything you want to keep before running these commands.

### 2. Clone DopaVim

``` powershell
git clone https://github.com/musaeed178-uio/nvim-config.git "$env:LOCALAPPDATA\nvim"
```

### 3. Start Neovim

``` powershell
nvim
```

Lazy.nvim should bootstrap the required plugins automatically.

Allow the initial installation to finish.

### 4. Synchronize plugins if necessary

Inside Neovim:

``` vim
:Lazy sync
```

------------------------------------------------------------------------

# ⚙️ Customization

DopaVim is meant to be customized.

### Keymaps

Edit:

``` text
lua/config/keymaps.lua
```

This is where personal keyboard behavior lives.

### Options

Edit:

``` text
lua/config/options.lua
```

Use this for editor-level options and behavior.

### Plugins

Add or override plugins inside:

``` text
lua/plugins/
```

LazyVim's plugin-spec architecture makes it possible to modify existing
plugins without rewriting their entire configuration.

### Custom Modules

The `lua/custom/` directory contains hand-built modules:

-   `terminal.lua` — PowerShell floating terminal with smart CWD
-   `cmd_terminal.lua` — CMD floating terminal with smart CWD
-   `theme_persistence.lua` — Saves and restores the last used
    colorscheme across sessions

### Dashboard

Dashboard behavior and appearance can be modified through the relevant
plugin configuration under:

``` text
lua/plugins/dashboard.lua
```

### Terminal configuration

Terminal behavior can be customized through the terminal-related
configuration under:

``` text
lua/custom/
```

The exact implementation may evolve as the configuration changes.

------------------------------------------------------------------------

# 🧪 Development Philosophy

DopaVim is not intended to be a frozen configuration.

It is a living environment.

New plugins may be added.

Old plugins may be removed.

Keymaps may change.

Themes may change.

Parts of the configuration may be rewritten when a better approach is
found.

The important thing is that the configuration remains understandable and
useful.

This is also a learning project.

Working on DopaVim has been a practical way to understand:

-   Lua
-   Neovim's architecture
-   plugin specifications
-   lazy loading
-   LSP
-   Treesitter
-   terminal integration
-   keymap systems
-   Git workflows
-   editor automation

Rather than treating Neovim as a black box, the goal is to gradually
understand the machinery underneath it.

------------------------------------------------------------------------

# 🧠 Why "DopaVim"?

The name comes from the idea behind the entire setup:

> **The editor should make you want to use it.**

Good tooling creates a feedback loop.

A command feels satisfying.

Navigation is immediate.

The interface looks good.

The terminal is one shortcut away.

A file appears exactly when expected.

A project opens exactly where it was left.

Small improvements compound.

That feeling is the point.

Hence:

**DopaVim.**

------------------------------------------------------------------------

# 🎬 Inspiration

The visual identity is heavily influenced by the atmosphere of **Blade
Runner** and cyberpunk computing:

-   dark environments
-   neon accents
-   terminal interfaces
-   futuristic workstations
-   dense information displays
-   minimal but deliberate visual noise

The aim isn't to reproduce a movie interface literally.

It is to capture the feeling of sitting in a futuristic workstation and
actually getting work done.

------------------------------------------------------------------------

# 🧑‍💻 About the Author

**Muhammad Umar Saeed**

Computer Science student and developer interested in:

-   software engineering
-   AI engineering
-   Python
-   C++
-   Java
-   databases
-   MongoDB and NoSQL systems
-   systems programming
-   Linux and Windows tooling
-   Neovim
-   developer tooling
-   automation
-   open-source software

Projects and experiments range from university software systems to AI/ML
learning projects, POS/inventory systems, routing simulations, and
system-level experimentation.

DopaVim is one of those projects where the tooling itself becomes part
of the learning process.

------------------------------------------------------------------------

# 🙏 Credits

DopaVim stands on the work of many open-source developers.

Special thanks to:

-   [**LazyVim**](https://github.com/LazyVim/LazyVim) --- the foundation
    of the configuration.
-   [**Neovim**](https://github.com/neovim/neovim) --- the editor that
    makes this entire ecosystem possible.
-   [**SilkCircuit**](https://github.com/hyperb1iss/silkcircuit) ---
    the default colorscheme with multiple variants.
-   [**Neofusion**](https://github.com/diegoulloao/neofusion.nvim) ---
    an alternative colorscheme.
-   [**Oil.nvim**](https://github.com/stevearc/oil.nvim) --- filesystem
    editing.
-   [**Telescope.nvim**](https://github.com/nvim-telescope/telescope.nvim)
    --- fuzzy finding.
-   [**project.nvim**](https://github.com/ahmedkhalf/project.nvim) ---
    project management.
-   [**alpha-nvim**](https://github.com/goolord/alpha-nvim) ---
    dashboard.
-   [**Blink.cmp**](https://github.com/saghen/blink.cmp) --- completion.
-   The developers and maintainers of every plugin used by this
    configuration.

Open-source tooling is what makes projects like this possible.

------------------------------------------------------------------------

# 📄 License

This configuration is released under the **GNU Affero General Public
License v3.0**.

See:

``` text
LICENSE
```

for the complete license text.

------------------------------------------------------------------------

# 💬 Feedback & Contributions

DopaVim is primarily a personal configuration, but feedback, ideas, bug
reports, and improvements are welcome.

If you find something broken or have an idea that genuinely improves the
workflow:

-   open an issue
-   submit a pull request
-   or simply share the idea

The configuration is constantly evolving.

------------------------------------------------------------------------

# ⚠️ Disclaimer

DopaVim is a **personal Neovim configuration**, not a general-purpose
Neovim distribution.

Some decisions are intentionally opinionated and may reflect:

-   Windows-specific workflows
-   PowerShell
-   personal keymaps
-   personal aesthetics
-   personal plugin preferences
-   my own development habits

If you clone it, expect to modify it.

That is part of the point.

------------------------------------------------------------------------

::: {align="center"}
**Made with ☕, 🧠, Lua, Git, and a frankly unnecessary amount of
customization.**

### *Built on LazyVim. Fueled by Dopamine.*

**--- Muhammad Umar Saeed**
:::
