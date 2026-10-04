-- Jupyter notebooks (.ipynb).
--
-- ipynb.nvim edits a notebook as a notebook: one display buffer, isolated
-- cell buffers for editing, outputs rendered as virtual lines, LSP proxied
-- through a shadow buffer, and kernel execution over jupyter_client.
--
-- Deliberately NOT lazy-loaded. Two things force it: ipynb.nvim takes the
-- file over with a BufReadCmd registered inside setup(), so the autocmd has
-- to exist before the first .ipynb is read; and Neovim's own filetype.lua
-- maps *.ipynb to `json`, so waiting for an `ipynb` FileType event would
-- wait forever. Everything it binds lives in the buffers it owns rather than
-- in your global keymaps, so loading it costs setup() and nothing else.
return {
  {
    "ajbucci/ipynb.nvim",
    -- Runs before the plugin loads.
    init = function()
      -- tree-sitter CLI hard-codes cl.exe on Windows, so a MinGW-only box
      -- dies with "program not found" while compiling the bundled ipynb
      -- parser. Point it at a compiler that actually exists.
      if not vim.env.CC and vim.fn.has("win32") == 1 and vim.fn.executable("cl") ~= 1 then
        for _, cc in ipairs({ "gcc", "cc", "clang" }) do
          if vim.fn.executable(cc) == 1 then
            vim.env.CC = cc
            break
          end
        end
      end
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- ipynb parser + injected code/markdown highlighting
      "neovim/nvim-lspconfig", -- completion and diagnostics in the shadow buffer
      "nvim-tree/nvim-web-devicons", -- language icon in the cell border
      "folke/snacks.nvim", -- inline image output (needs a kitty-graphics terminal)
    },
    opts = {},
  },
}
