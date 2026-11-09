return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- Removes Enter (<CR>) from blink entirely so it always drops to a new line
        ["<CR>"] = { "fallback" },
        -- Use Tab or Ctrl+Y to accept suggestions instead
        ["<Tab>"] = { "select_and_accept", "fallback" },
      },
    },
  },
}
