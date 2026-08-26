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
        integrations = {
          -- All integrations disabled to prevent conflicts with LazyVim's Snacks-based plugin configs.
          -- silkcircuit still applies its colorscheme and highlights; it just won't modify other plugin specs.
          auto_detect = false,
          treesitter = false, lsp = false, native_lsp = false,
          telescope = false, nvimtree = false, neotree = false,
          gitsigns = false, gitgutter = false, diffview = false,
          indent_blankline = false, bufferline = false, lualine = false,
          dashboard = false, alpha = false, which_key = false,
          cmp = false, blink_cmp = false, notify = false, noice = false,
          hop = false, leap = false, flash = false,
          lazy = false, mason = false, mini = false,
          dap = false, nvim_dap = false, nvim_dap_ui = false, dap_ui = false,
          trouble = false, outline = false, symbols_outline = false,
          illuminate = false, aerial = false,
          rainbow_delimiters = false, ufo = false,
          window_picker = false, markdown = false,
          snacks = false, render_markdown = false, octo = false, avante = false,
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
      vim.cmd.colorscheme("silkcircuit")
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
