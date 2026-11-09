return {
  "DaanHessen/nvim-docx",
  cmd = "Docx",
  config = function()
    require("nvim-docx").setup({
      auto_cleanup = true, -- Removes temporary markdown files upon closing
    })
  end,
}
