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
}
