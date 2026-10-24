return {
  "folke/snacks.nvim",
  opts = {
    bigfile = {
      enabled = true,
      size = 150 * 1024, -- Triggers on files larger than ~3,500 lines (approx 150KB)
      setup = function(ctx)
        -- 1. Strictly mark this specific buffer so global hooks recognize it
        vim.b[ctx.buf].large_file_isolated = true
        
        -- 2. Completely kill the autocomplete engine loop for this target buffer
        vim.b[ctx.buf].completion = false
        
        -- 3. Lock layout engines locally to this file only (never global)
        Snacks.util.wo(0, { 
          foldmethod = "manual", 
          statuscolumn = "", 
          conceallevel = 0,
          relativenumber = false,
          number = true,
          cursorline = false,
        })
        
        -- 4. Turn off bracket matching engines to prevent background tracking loops
        if vim.fn.exists(":NoMatchParen") ~= 0 then 
          vim.cmd([[NoMatchParen]]) 
        end
        
        -- 5. Isolate search loops inside this buffer
        vim.opt_local.hlsearch = false
        vim.opt_local.incsearch = false

        -- 6. Stop Tree-sitter and drop down to fast native regex syntax tokens
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(ctx.buf) then
            vim.bo[ctx.buf].syntax = ctx.ft 
          end
        end)
      end,
    },
  },
  init = function()
    -- Global Environment Safety Harness
    -- This triggers every time you exit any file to clean up residual cache leaks
    vim.api.nvim_create_autocmd({ "BufDelete", "BufLeave" }, {
      pattern = "*",
      callback = function(ev)
        -- If we are leaving or closing a large isolated file
        if vim.b[ev.buf].large_file_isolated then
          -- Restore default bracket matching safely
          if vim.fn.exists(":DoMatchParen") ~= 0 then 
            vim.cmd([[DoMatchParen]]) 
          end
          
          -- Reset core search parameters safely for standard workspace usage
          vim.opt.hlsearch = true
          vim.opt.incsearch = true
          
          -- CRITICAL PERFORMANCE FIX: Forcibly flush the Lua garbage collector
          -- This forcefully cleans up the indexed node memory left behind by search loops
          collectgarbage("collect")
        end
      end,
    })
  end,
}
