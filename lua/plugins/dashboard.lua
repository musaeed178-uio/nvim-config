return {
  {
    "goolord/alpha-nvim",

    lazy = false,

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      --------------------------------------------------
      -- Timer
      --------------------------------------------------

      local timer

      --------------------------------------------------
      -- Header
      --------------------------------------------------

      dashboard.section.header.val = {

        "",
        "",
        "",
        "",

        [[  /█▀▀█   /░     /█▀▀█  /░░░   /█▀▀▀/       /░░░░  /░/░  /░ /░  /░ /░  /█▀▀▀/  /░░░░  ]],
        [[ │ ▓▓▓▓▓ │ ▒    │ ▓▓▓▓ │-▒_/▒ │ ▓▓▓        │_▒ /▒ │ ▒ ▒ │ ▒▒ ▒ │ ▒▒ ▒ │ ▓▓▓   │_▒ /▒ ]],
        [[ │_▒__/▒ │ ▓    │_▒_/▒ │ ▓│ ▓ │_▒_/        │ ▓▓▓/ │ ▓ ▓ │ ▓│▓▓ │ ▓│▓▓ │_▒_/   │ ▓▓▓/ ]],
        [[ │ ░░░░░ │ ███  │ ░│ ░ │ ███/ │ ░░░░       │ █_/█ │ ███ │ █│ █ │ █│ █ │ ░░░░  │ █_/█ ]],
        [[ │/____/ │/__/  │//│// │/__/  │/___/       │// // │/__/ │//│// │//│// │/___/  │// // ]],

        -- [[     ███████╗███████╗███╗   ██╗████████╗██╗███╗   ██╗███████╗██╗     ]],
        -- [[     ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║████╗  ██║██╔════╝██║     ]],
        -- [[     ███████╗█████╗  ██╔██╗ ██║   ██║   ██║██╔██╗ ██║█████╗  ██║     ]],
        -- [[     ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║██║╚██╗██║██╔══╝  ██║     ]],
        -- [[     ███████║███████╗██║ ╚████║   ██║   ██║██║ ╚████║███████╗███████╗]],
        -- [[     ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝]],

        "",
        "",

        "                               Powered by Dopamine",
      }

      dashboard.section.header.opts = {
        position = "center",
        hl = "Type",
      }

      --------------------------------------------------
      -- Buttons
      --------------------------------------------------

      dashboard.section.buttons.opts = {
        spacing = 1,
      }

      dashboard.section.buttons.val = {

        dashboard.button("f", "󰱼  Browse Files - Telescope", function()
          LazyVim.pick("files")()
        end),

        dashboard.button("o", "󰉋  Browse Files - Oil", "<cmd>Oil<CR>"),

        dashboard.button("r", "󱋡  Recent Files", function()
          LazyVim.pick("oldfiles")()
        end),

        dashboard.button("c", "  Configuration", function()
          local config_dir = vim.fn.stdpath("config")
          vim.cmd("Oil " .. config_dir)
        end),

        dashboard.button("l", "󰏓  Lazy", "<cmd>Lazy<CR>"),

        dashboard.button("m", "󱌣  Mason", "<cmd>Mason<CR>"),

        -- 👇 Session restore (last session)
        dashboard.button("s", "󰧄  Restore Session", function()
          require("persistence").load()
        end),

        -- 👇 Session picker (choose from list)
        dashboard.button("S", "󰧄  Sessions", function()
          require("persistence").select()
        end),

        dashboard.button("x", "󱋦  Extras", "<cmd>LazyExtras<CR>"),

        dashboard.button("h", "󰋼  Health", "<cmd>checkhealth<CR>"),

        -- dashboard.button(
        --     "a",
        --     "󱙺  Chat",
        --     "<cmd>CodeCompanionChat Toggle<CR>"
        -- ),

        dashboard.button("q", "󰗼  Quit", "<cmd>qa<CR>"),
      }
      --------------------------------------------------
      -- Footer
      --------------------------------------------------

      local function make_footer()
        local version = vim.version()
        local stats = require("lazy").stats()
        local cwd = vim.fn.getcwd()

        return {

          "",

          "────────────────────────────────────────────────────",

          os.date("  %A, %d %B %Y"),

          os.date("󰥔  %H:%M:%S"),

          "  " .. cwd,

          string.format(
            "Neovim %d.%d.%d     •     %d Plugins     •     %.0f ms",
            version.major,
            version.minor,
            version.patch,
            stats.count,
            stats.startuptime
          ),

          "",

          -- "Sentinel Boot Menu",
        }
      end

      dashboard.section.footer.val = make_footer()

      dashboard.section.footer.opts = {
        position = "center",
        hl = "Comment",
      }

      --------------------------------------------------
      -- Layout
      --------------------------------------------------

      dashboard.config.layout = {

        {
          type = "padding",
          val = 2,
        },

        dashboard.section.header,

        {
          type = "padding",
          val = 2,
        },

        dashboard.section.buttons,

        {
          type = "padding",
          val = 2,
        },

        dashboard.section.footer,
      }

      dashboard.config.opts = {
        margin = 5,
      }

      --------------------------------------------------
      -- Setup
      --------------------------------------------------

      alpha.setup(dashboard.config)

      --------------------------------------------------
      -- Start Live Clock
      --------------------------------------------------

      local function start_timer()
        if timer then
          return
        end

        timer = vim.uv.new_timer()

        timer:start(

          1000,

          1000,

          vim.schedule_wrap(function()
            if vim.bo.filetype ~= "alpha" then
              return
            end

            dashboard.section.footer.val = make_footer()

            pcall(function()
              require("alpha").redraw()
            end)
          end)
        )
      end
      --------------------------------------------------
      -- Stop Live Clock
      --------------------------------------------------

      local function stop_timer()
        if not timer then
          return
        end

        if not timer:is_closing() then
          timer:stop()
          timer:close()
        end

        timer = nil
      end

      --------------------------------------------------
      -- Dashboard Events
      --------------------------------------------------

      vim.api.nvim_create_autocmd("User", {

        pattern = "AlphaReady",

        callback = function()
          start_timer()
        end,
      })

      vim.api.nvim_create_autocmd({

        "BufLeave",
        "BufHidden",
        "BufDelete",
        "BufWipeout",
      }, {

        callback = function(args)
          if vim.bo[args.buf].filetype ~= "alpha" then
            return
          end

          stop_timer()
        end,
      })

      --------------------------------------------------
      -- Restart timer when returning to dashboard
      --------------------------------------------------

      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function(args)
          if vim.bo[args.buf].filetype == "alpha" then
            start_timer()
          end
        end,
      })

      --------------------------------------------------
      -- Better dashboard behavior
      --------------------------------------------------

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function(ev)
          vim.bo[ev.buf].buflisted = false

          vim.keymap.set("n", "q", "<cmd>qa<CR>", {
            buffer = ev.buf,
            silent = true,
          })
        end,
      })

      --------------------------------------------------
      -- Prevent Alpha from stealing Telescope windows
      --------------------------------------------------

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopePrompt",
        callback = function()
          stop_timer()
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function()
          stop_timer()
        end,
      })

      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft == "TelescopePrompt" or ft == "TelescopeResults" then
            stop_timer()
          end
        end,
      })

      --------------------------------------------------
      -- Cleanup timer on exit
      --------------------------------------------------

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          stop_timer()
        end,
      })
    end,
  },
}

