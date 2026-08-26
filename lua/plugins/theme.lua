return {
  {
    "diegoulloao/neofusion.nvim",
    priority = 1000,
    config = function()
      require("neofusion").setup({ transparent_mode = false })
      -- vim.cmd.colorscheme("neofusion")
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
        integrations = {}, -- disabled: silkcircuit's auto-integrations conflict with LazyVim's Snacks-based configs
      })
      vim.cmd.colorscheme("silkcircuit")
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
      -- vim.cmd.colorscheme("neon-cyberpunk-night") -- Choose your variant
    end,
  },

  {
    "ejfox/vulpes.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- The exact colorscheme name may vary, check the plugin's README.
      -- It might be "vulpes" or "vulpes-reddishnovember".
      -- vim.cmd.colorscheme("vulpes")
    end,
  },
}
