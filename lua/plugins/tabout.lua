-- Tab out of brackets, quotes, and similar contexts with <Tab> without
-- leaving insert mode. Lazy-loaded on InsertCharPre so it costs nothing
-- until you actually enter insert mode.
--
-- completion is set to false because LazyVim uses blink.cmp, not nvim-cmp;
-- tabout should not interfere with the completion popup's own Tab handling.
-- Requires a tree-sitter parser for each language you use it with (already
-- installed via nvim-treesitter's ensure_installed list).
return {
  "abecodes/tabout.nvim",
  event = "InsertCharPre",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    tabkey = "<Tab>",
    backwards_tabkey = "<S-Tab>",
    act_as_tab = true,
    act_as_shift_tab = false,
    default_tab = "<C-t>",
    default_shift_tab = "<C-d>",
    enable_backwards = true,
    completion = false,
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
    },
    ignore_beginning = true,
    exclude = {},
  },
}
