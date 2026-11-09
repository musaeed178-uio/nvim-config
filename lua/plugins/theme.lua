-- Theme management: persistence (last-used theme loads on startup) and
-- lazy cost reduction.
--
-- All theme plugins stay `lazy = false` so their colors/*.lua files remain
-- in the runtimepath -- this is what makes the telescope colorscheme picker
-- (leader + u + C) list and preview every installed theme. The win here is
-- that NO theme has a `config` or `opts` field, so no setup() function runs
-- at startup. Only the one theme actually applied via :colorscheme gets its
-- colors file sourced. The only exception is silkcircuit, which needs custom
-- highlight overrides; those are applied by a ColorScheme autocmd below, so
-- they only run when silkcircuit is the active theme.

local theme_applied = false
local persistence = require("custom.theme_persistence")

-- Silkcircuit's custom setup: glow variant, visible Visual selection,
-- LSP reference highlights, and search highlights. The integrations block
-- disables every plugin integration to avoid conflicts with LazyVim's
-- Snacks-based configs -- silkcircuit only paints its own colors.
local function setup_silkcircuit()
  pcall(function()
    require("silkcircuit").setup({
      variant = "glow",
      transparent = false,
      on_highlights = function(hl)
        hl.Visual = { bg = "#7c3aed" }
        hl.VisualNOS = { bg = "#5b3a8e" }
        hl.LspReferenceText = { bg = "#4a2066", underline = true }
        hl.LspReferenceRead = { bg = "#3a1850", underline = true }
        hl.LspReferenceWrite = { bg = "#5a2a77", bold = true }
        hl.IlluminatedWordText = { bg = "#4a2066", underline = true }
        hl.IlluminatedWordRead = { bg = "#3a1850", underline = true }
        hl.IlluminatedWordWrite = { bg = "#5a2a77", bold = true }
        hl.CurSearch = { fg = "#0a0816", bg = "#00ffff", bold = true }
        hl.Search = { fg = "#0a0816", bg = "#ffff00" }
        hl.IncSearch = { fg = "#0a0816", bg = "#ff8800" }
      end,
      integrations = {
        auto_detect = false,
        treesitter = false,
        lsp = false,
        native_lsp = false,
        telescope = false,
        nvimtree = false,
        neotree = false,
        gitsigns = false,
        gitgutter = false,
        diffview = false,
        indent_blankline = false,
        bufferline = false,
        lualine = false,
        dashboard = false,
        alpha = true,
        which_key = false,
        cmp = false,
        blink_cmp = false,
        notify = false,
        noice = false,
        hop = false,
        leap = false,
        flash = false,
        lazy = false,
        mason = false,
        mini = false,
        dap = false,
        nvim_dap = false,
        nvim_dap_ui = false,
        dap_ui = false,
        trouble = false,
        outline = false,
        symbols_outline = false,
        illuminate = false,
        aerial = false,
        rainbow_delimiters = false,
        ufo = false,
        window_picker = false,
        markdown = false,
        snacks = false,
        render_markdown = false,
        octo = false,
        avante = false,
      },
    })
  end)
end

-- Apply silkcircuit's custom highlights whenever it becomes the active
-- colorscheme -- both at startup (via apply_theme) and mid-session (when
-- the user picks it from the telescope colorscheme picker).
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "silkcircuit",
  callback = function()
    setup_silkcircuit()
  end,
})

--- Apply a colorscheme. Loads saved theme or falls back to habamax.
--- Called from VimEnter so it runs AFTER all plugins are loaded,
--- preventing any plugin from overriding the chosen theme.
local function apply_theme()
  if theme_applied then
    return
  end
  theme_applied = true
  persistence.setup_autosave()
  local saved = persistence.load()
  if saved and saved ~= "" and pcall(vim.cmd.colorscheme, saved) then
    return
  end
  -- No saved theme (fresh install): fall back to habamax, a safe built-in.
  pcall(vim.cmd.colorscheme, "habamax")
end

-- Apply theme AFTER all plugins have loaded (VimEnter fires last)
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    apply_theme()
  end,
})

return {
  -- Paint the persisted theme during LazyVim's own startup pass so there is
  -- no flash of a wrong colorscheme before VimEnter fires. Reads the saved
  -- theme directly from disk; falls back to habamax if none exists.
  {
    "LazyVim/LazyVim",
    opts = function()
      local saved = persistence.load()
      return { colorscheme = (saved and saved ~= "") and saved or "habamax" }
    end,
  },

  -- All themes: lazy = false (keeps them in rtp for the colorscheme picker),
  -- no config/opts (no setup() runs at startup).
  { "diegoulloao/neofusion.nvim", lazy = false },
  { "hyperb1iss/silkcircuit", lazy = false },
  { "ejfox/vulpes.nvim", lazy = false },
  { "rose-pine/neovim", name = "rose-pine", lazy = false },
  { "tiagovla/tokyodark.nvim", lazy = false },
  { "YedTheEmo/gore.nvim", lazy = false },
  { "takeshid/plum.nvim", lazy = false },
  { "thallada/farout.nvim", lazy = false },
  { "eldritch-theme/eldritch.nvim", lazy = false },
  -- night-owl: do NOT call setup() -- its setup() runs highlight clear and
  -- sets g:colors_name without applying highlights, wiping the active theme.
  -- :colorscheme night-owl already loads colors/night-owl.lua correctly.
  { "oxfist/night-owl.nvim", lazy = false },
  { "rockerBOO/boo-colorscheme-nvim", lazy = false },
  { "olivercederborg/poimandres.nvim", lazy = false },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false },
  { "morhetz/gruvbox", lazy = false },
  { "navarasu/onedark.nvim", lazy = false },
}
