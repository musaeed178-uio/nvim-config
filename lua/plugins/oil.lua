return {

  {

    "stevearc/oil.nvim",

    cmd = "Oil",

    -- dependencies = {
    --   "echasnovski/mini.icons",
    -- },

    opts = {

      default_file_explorer = true,

      delete_to_trash = true,

      skip_confirm_for_simple_edits = true,

      watch_for_changes = true,

      columns = {
        "icon",
      },

      view_options = {
        show_hidden = true,
        natural_order = true,
      },

      float = {
        padding = 4,
        max_width = 100,
        max_height = 35,
        border = "rounded",
      },

      keymaps = {

        ["<CR>"] = "actions.select",

        ["-"] = "actions.parent",

        ["q"] = "actions.close",

        ["<C-h>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["<C-l>"] = false,
      },
    },

    config = function(_, opts)
      require("oil").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {

        pattern = "oil",

        callback = function(ev)
          local map = function(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, {
              buffer = ev.buf,
              silent = true,
            })
          end

          map("<C-h>", "<C-w>h")
          map("<C-j>", "<C-w>j")
          map("<C-k>", "<C-w>k")
          map("<C-l>", "<C-w>l")
        end,
      })
    end,
  },
}
