return {
  "3rd/image.nvim",
  build = false, -- or ' luarocks install magick' if needed
  opts = {
    backend = "kitty", -- or "ueberzug" / "sixel"
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
      },
    },
  },
}
