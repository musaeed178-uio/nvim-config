return {
  "nvim-mini/mini.animate",
  event = "VeryLazy",
  opts = function()
    local animate = require("mini.animate")
    return {
      cursor = {
        enable = true,
        -- Smooth linear movement path when jumping long distances
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
      },
      scroll = { enable = false }, -- Keep scrolling raw and instantaneous 
      resize = { enable = false },
      open = { enable = false },
      close = { enable = false },
    }
  end,
}
