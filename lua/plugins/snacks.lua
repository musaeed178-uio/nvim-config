return {
  "folke/snacks.nvim",
  opts = {
    bigfile = {
      enabled = true,
      size = 200 * 1024, -- Triggers on files larger than 200KB (~5,000+ lines)
      -- Custom hook: strips down the buffer exactly to your specifications
      setup = function(ctx)
        -- 1. Disable the auto-complete engine entirely for this target buffer
        vim.b.completion = false
        
        -- 2. Force manual folding so it doesn't parse structural loops on cursor moves
        Snacks.util.wo(0, { 
          foldmethod = "manual", 
          statuscolumn = "", 
          conceallevel = 0,
          relativenumber = false,
          number = true,
        })
        
        -- 3. Turn off bracket matching to prevent background loops during search
        if vim.fn.exists(":NoMatchParen") ~= 0 then 
          vim.cmd([[NoMatchParen]]) 
        end
        
        -- 4. Turn off heavy UI search routing (Noice/Flash) for this buffer
        vim.opt_local.hlsearch = false
        vim.opt_local.incsearch = false
        vim.opt_local.lazyredraw = true

        -- 5. THE MAGIC TRICK: Turn off Treesitter parsing but KEEP native regex syntax highlighting 
        -- so your code doesn't look like ugly, solid white plain text.
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(ctx.buf) then
            -- Fallback to lightweight, lightning-fast native Vim syntax rules
            vim.bo[ctx.buf].syntax = ctx.ft 
          end
        end)
      end,
    },
  },
}
