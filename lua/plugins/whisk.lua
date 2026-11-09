-- Smooth 60fps cursor and scroll animations. Replaces smear-cursor.nvim,
-- which had a known open bug (GitHub issue #156) where it could spike to
-- 100% CPU after fast scrolling and freeze Neovim for seconds to minutes.
-- whisk.nvim is purpose-built for performance and targets 60fps.
--
-- Lazy-loaded on VeryLazy so it does not add startup cost; it only animates
-- cursor movement after Neovim has fully settled.
return {
  "josstei/whisk.nvim",
  event = "VeryLazy",
  opts = {},
}
