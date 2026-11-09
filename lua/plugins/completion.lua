return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- Removes Enter (<CR>) from blink entirely so it always drops to a new line
        ["<CR>"] = { "fallback" },
        -- Tab: accept completion if the popup is open, otherwise tab out of
        -- brackets/quotes via tabout.nvim's <Plug>(Tabout) mapping.
        -- blink.cmp's keymap system runs each entry in the list; a command
        -- that returns nil/false lets the next entry run, so select_and_accept
        -- silently passes through when no completion is visible.
        ["<Tab>"] = {
          "select_and_accept",
          function()
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes("<Plug>(Tabout)", true, true, false),
              "n",
              false
            )
            return true
          end,
        },
        ["<S-Tab>"] = {
          "select_prev",
          function()
            vim.api.nvim_feedkeys(
              vim.api.nvim_replace_termcodes("<Plug>(TaboutBack)", true, true, false),
              "n",
              false
            )
            return true
          end,
        },
      },
    },
  },
}
