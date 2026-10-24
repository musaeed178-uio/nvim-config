return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {
      enabled = true,
      size = 1.5 * 1024 * 1024, -- Triggers on files larger than 1.5MB
      -- You can add custom setup logic here to handle your search rules!
    },
  },
}
