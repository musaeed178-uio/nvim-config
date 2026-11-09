return {
  "indium114/smudge.nvim",
  event = "VeryLazy",
  opts = {
    char = "░",
    hl = "SmudgeCursor",
    max_age = 150,  -- ms before smear disappears (higher = trail stays longer, more like smear-cursor)
    length = 6,     -- max trail length (higher = longer trail, closer to smear's look)
  },
}
