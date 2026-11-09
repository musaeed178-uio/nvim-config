-- Smear cursor trail animation. Replaces smear-cursor.nvim (known open bug:
-- GitHub issue #156, 100% CPU freeze on fast scroll) and whisk.nvim (too
-- plain visually). smudge.nvim draws a short fading trail behind the cursor
-- using a single extmark per frame, so it stays cheap.
--
-- Lazy-loaded on VeryLazy so it does not add startup cost; it only animates
-- cursor movement after Neovim has fully settled.
return {
  "indium114/smudge.nvim",
  event = "VeryLazy",
  opts = {},
}
