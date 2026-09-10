return {
  "DaanHessen/nvim-docx",
  config = function()
    require("nvim-docx").setup({
      auto_cleanup = true, -- Removes temporary markdown files upon closing
    })
  end,
}
