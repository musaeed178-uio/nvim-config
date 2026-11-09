return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--pch-storage=disk",
            "--all-scopes-completion=true",
            "--pretty",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--query-driver=C:/Users/musae/scoop/apps/mingw-mstorsjo-llvm-ucrt/*/bin/clang*",
          },
          init_options = {
            fallbackFlags = {},
          },
        },
      },
    },
  },
}
