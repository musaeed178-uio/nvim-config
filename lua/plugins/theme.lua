return {
  {
    "diegoulloao/neofusion.nvim",
    priority = 1000, -- Load this first before other UI plugins
    config = function()
      require("neofusion").setup({
        transparent_mode = false, -- Set to true if you want a transparent background
      })
      vim.cmd("colorscheme neofusion")
    end,
  },
}
