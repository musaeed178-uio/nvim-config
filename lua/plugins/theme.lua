local theme_applied = false
local default_theme = "silkcircuit"
local persistence = require("custom.theme_persistence")

--- Apply a colorscheme if one hasn't been applied yet this session.
--- On first call: loads saved theme or falls back to default.
--- On subsequent calls: no-op.
local function apply_theme(fallback)
  if theme_applied then
    return
  end
  theme_applied = true
  persistence.setup_autosave()
  local saved = persistence.load()
  if saved and pcall(vim.cmd.colorscheme, saved) then
    return
  end
  vim.cmd.colorscheme(fallback or default_theme)
end

return {
  {
    "diegoulloao/neofusion.nvim",
    priority = 1000,
    config = function()
      require("neofusion").setup({ transparent_mode = false })
    end,
  },

  {
    "hyperb1iss/silkcircuit",
    lazy = false,
    priority = 1000,
    config = function()
      require("silkcircuit").setup({
        variant = "neon", -- Options: "neon", "vibrant", "soft", "glow", "dawn"
        transparent = false,
        integrations = {
          -- All integrations disabled to prevent conflicts with LazyVim's Snacks-based plugin configs.
          -- silkcircuit still applies its colorscheme and highlights; it just won't modify other plugin specs.
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
          alpha = false,
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
      -- Suppress silkcircuit's "loaded in Xms" notification
      local real_notify = vim.notify
      vim.notify = function(msg, level, opts)
        if type(msg) == "string" and msg:find("SilkCircuit") then
          return
        end
        return real_notify(msg, level, opts)
      end
      apply_theme("silkcircuit")
      vim.notify = real_notify
    end,
  },

  {
    "Zeioth/neon.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dim_inactive = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
    config = function()
      apply_theme("neon-cyberpunk-night")
    end,
  },

  {
    "ejfox/vulpes.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      apply_theme("vulpes")
    end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    -- config = function()
    --   vim.cmd("colorscheme rose-pine")
    -- end,
  },

  {
    "EdenEast/nightfox.nvim",
  },

  {
    "nanotech/jellybeans.vim",
  },

  {
    "sjl/badwolf",
  },

  {
    "tiagovla/tokyodark.nvim",
  },

  {
    "ray-x/aurora",
    -- init = function()
    --   vim.g.aurora_italic = 1
    --   vim.g.aurora_transparent = 1
    --   vim.g.aurora_bold = 1
    -- end,
    -- config = function()
    --   vim.cmd.colorscheme("aurora")
    --   -- override defaults
    --   vim.api.nvim_set_hl(0, "@number", { fg = "#e933e3" })
    -- end,
  },

  {
    "YedTheEmo/gore.nvim",
  },

  {
    "mitander/flume.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      require("flume").setup({ schema = "dusk" })
    end,
  },

  {
    "takeshid/plum.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("plum").setup({
        variant = "dark",
      })
      vim.cmd("colorscheme plum")
    end,
  },

  {
    "thallada/farout.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").setup({
        -- optional configuration here
      })
      require("bamboo").load()
    end,
  },

  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    "maxmx03/fluoromachine.nvim",
  },

  {
    "oxfist/night-owl.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      require("night-owl").setup()
      vim.cmd.colorscheme("night-owl")
    end,
  },

  {
    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme miasma")
    end,
  },

  {
    "uloco/bluloco.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    opts = {},
  },

  {
    "dgox16/oldworld.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "luisiacc/gruvbox-baby",
  },

  {
    "shaunsingh/moonlight.nvim",
  },

  {
    "samharju/synthweave.nvim",
  },

  {
    "datsfilipe/vesper.nvim",
  },

  {
    "blazkowolf/gruber-darker.nvim",
  },

  {
    "rockerBOO/boo-colorscheme-nvim",
  },

  {
    "Tsuzat/NeoSolarized.nvim",
  },

  {
    "embark-theme/vim",
    lazy = false,
    priority = 1000,
    name = "embark",
  },

  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("poimandres").setup({
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
      })
    end,

    -- optionally set the colorscheme within lazy config
    init = function()
      vim.cmd("colorscheme poimandres")
    end,
  },

  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
  },

  {
    "morhetz/gruvbox",
  },

  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "darker",
      })
      require("onedark").load()
    end,
  },
}
