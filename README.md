🧠 DopaVim

    A Blade Runner–inspired Neovim distribution
    Built on LazyVim, fueled by Dopamine.

https://img.shields.io/badge/Neovim-0.9+-57A143?style=flat&logo=neovim&logoColor=white
https://img.shields.io/badge/LazyVim-11.0-ff69b4?style=flat&logo=lazyvim
https://img.shields.io/github/license/musaeed178-uio/nvim-config?style=flat
📖 About

DopaVim is my personal Neovim configuration – a carefully crafted environment that combines the rock‑solid foundation of LazyVim with my own flavour of cyberpunk aesthetics, ergonomic keymaps, and a dash of dopamine.

It’s not just a config; it’s a daily driver that makes editing feel fluid, intuitive, and – dare I say – joyful.
✨ Features

    🚀 LazyVim Core – modular, fast, and extensible.

    🎨 Neofusion Theme – a dark, vibrant colourscheme with a neon vibe.

    🖥️ Floating Terminals – quick access to PowerShell (<M-i>) and CMD (<M-c>), both with titles, smooth borders, and Esc to normal mode.

    📂 Oil.nvim – file explorer in a floating window (-).

    🔍 Telescope – fuzzy finder for files, buffers, plugins, and sessions.

    💾 Session Management – restore last session (s) or choose from saved sessions (S) right from the dashboard.

    ⚡ Blink.cmp – super‑fast completion.

    🧠 Lazy Extras – easily toggle features with the x button.

    🔧 Custom Keymaps – buffer navigation, split management, delete‑without‑yank, and more.

    📊 Live Dashboard – shows time, date, plugin count, and startup time.

🖼️ Screenshots

https://via.placeholder.com/800x400?text=Dashboard+Preview
Replace with an actual screenshot of your Alpha dashboard.

https://via.placeholder.com/800x400?text=Terminals+Preview
PowerShell (left) and CMD (right) floating windows.
📦 Installation
Prerequisites

    Neovim >= 0.9.0

    Git

    A Nerd Font (e.g., JetBrains Mono Nerd Font)

Steps

    Backup your existing config (if any):
    mv ~/AppData/Local/nvim ~/AppData/Local/nvim.bak
    mv ~/AppData/Local/nvim-data ~/AppData/Local/nvim-data.bak

    Clone this repository:
    git clone https://github.com/musaeed178-uio/nvim-config.git ~/AppData/Local/nvim

    Start Neovim:
    nvim

    Lazy will automatically install all plugins. Wait for it to finish.

    (Optional) Run :Lazy sync to ensure everything is up‑to‑date.

🛠️ Customization

    Keymaps: edit lua/config/keymaps.lua.

    Options: tweak lua/config/options.lua.

    Plugins: add or override in lua/plugins/.

    Dashboard: modify lua/plugins/dashboard.lua to change buttons, header, or footer.

    Terminals: adjust size, title, or shell in lua/custom/terminal.lua and lua/custom/cmd_terminal.lua.

🙏 Credits

    LazyVim – the brilliant foundation that makes all this possible.

    Neofusion – the theme that gives DopaVim its soul.

    All the amazing plugin authors whose work I’ve built upon.

📄 License

This configuration is released under the GNU Affero General Public License v3.0 – because sharing is caring, and freedom matters.
💬 Feedback & Contributions

If you find a bug or have a suggestion, feel free to open an issue or submit a pull request.
I’m always open to learning new tricks!

Made with ☕, 🧠, and a lot of Dopamine.
— musaeed178-uio
