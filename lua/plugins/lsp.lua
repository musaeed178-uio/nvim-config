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
            "--query-driver=C:/msys64/mingw64/bin/gcc.exe,C:/msys64/mingw64/bin/g++.exe,gcc,g++",
          },
          init_options = {
            fallbackFlags = { "-std=c11", "-Wall", "-Wextra", "-isystem", "C:/msys64/mingw64/include" },
          },
        },
      },
    },
  },
}
