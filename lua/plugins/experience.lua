return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      dashboard = {
        preset = {
          header = [[
     ...     ...           ..      .             ....                                  .....     .      ...     ..      ..     
  .=*8888n.."%888:      x88f` `..x88. .>     .x~X88888Hx.                            .d88888Neu. 'L   x*8888x.:*8888: -"888:   
 X    ?8888f '8888    :8888   xf`*8888%     H8X 888888888h.        ...     ..        F""""*8888888F  X   48888X `8888H  8888   
 88x. '8888X  8888>  :8888f .888  `"`      8888:`*888888888:    :~""888h.:^"888:    *      `"*88*"  X8x.  8888X  8888X  !888>  
'8888k 8888X  '"*8h. 88888' X8888. >"8x    88888:        `%8   8X   `8888X  8888>    -....    ue=:. X8888 X8888  88888   "*8%- 
 "8888 X888X .xH8    88888  ?88888< 888> . `88888          ?> X888n. 8888X  ?888>           :88N  ` '*888!X8888> X8888  xH8>   
   `8" X888!:888X    88888   "88888 "8%  `. ?888%           X '88888 8888X   ?**h.          9888L     `?8 `8888  X888X X888>   
  =~`  X888 X888X    88888 '  `8888>       ~*??.            >   `*88 8888~ x88x.     uzu.   `8888L    -^  '888"  X888  8888>   
   :h. X8*` !888X    `8888> %  X88!       .x88888h.        <   ..<"  88*`  88888X  ,""888i   ?8888     dx '88~x. !88~  8888>   
  X888xX"   '8888..:  `888X  `~""`   :   :"""8888888x..  .x       ..XC.    `*8888k 4  9888L   %888>  .8888Xf.888x:!    X888X.: 
:~`888f     '*888*"     "88k.      .~    `    `*888888888"      :888888H.    `%88> '  '8888   '88%  :""888":~"888"     `888*"  
    ""        `"`         `""*==~~`              ""***""       <  `"888888:    X"       "*8Nu.z*"       "~'    "~        ""    
                                                                     %888888x.-`                                               
                                                                       ""**""                                                  
                                                                                                                               
      ]],
        },
      },
      -- bigfile = {
      -- 	enabled = true,
      -- 	size = 10 * 1024 * 1024, -- 1.5MB
      -- },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    {
      {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
          routes = {
            {
              filter = {
                event = "msg_show",
                any = {
                  { find = "Agent service not initialized" },
                },
              },
              opts = { skip = true },
            },
          },
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
            hover = {
              enabled = true,
              silent = true, -- set to true to not show a message if hover is not available
              view = nil, -- when nil, use defaults from documentation
              ---@type NoiceViewOptions
              opts = {}, -- merged with defaults from documentation
            },
            signature = {
              enabled = true,
              auto_open = {
                enabled = true,
                trigger = false, -- Automatically show signature help when typing a trigger character from the LSP
                luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                throttle = 50, -- Debounce lsp signature help request by 50ms
              },
              view = nil, -- when nil, use defaults from documentation
              ---@type NoiceViewOptions
              opts = {}, -- merged with defaults from documentation
            },
            documentation = {
              view = "hover",
              ---@type NoiceViewOptions
              opts = {
                lang = "markdown",
                replace = true,
                render = "plain",
                format = { "{message}" },
                win_options = { concealcursor = "n", conceallevel = 3 },
              },
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = true, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
          },
        },
  -- stylua: ignore
  keys = {
    { "<leader>sn", "", desc = "+noice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
        config = function(_, opts)
          -- HACK: noice shows messages from before it was enabled,
          -- but this is not ideal when Lazy is installing plugins,
          -- so clear the messages in this case.
          if vim.o.filetype == "lazy" then
            vim.cmd([[messages clear]])
          end
          require("noice").setup(opts)
        end,
      },
    },
    {
      "folke/todo-comments.nvim",
      lazy = true,
      event = "User IceLoad",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { "<leader>c", "", desc = "Trouble" },
      { "<leader>x", "", desc = "Trouble" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a list of adapter names,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {},
      -- Example for loading neotest-golang with a custom config
      -- adapters = {
      --   ["neotest-golang"] = {
      --     go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
      --     dap_go_enabled = true,
      --   },
      -- },
      status = { virtual_text = true },
      output = { open_on_run = true },
      quickfix = {
        open = function()
          require("trouble").open({ mode = "quickfix", focus = false })
        end,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      opts.consumers = opts.consumers or {}
      -- Refresh and auto close trouble after running tests
      ---@type neotest.Consumer
      opts.consumers.trouble = function(client)
        client.listeners.results = function(adapter_id, results, partial)
          if partial then
            return
          end
          local tree = assert(client:get_position(nil, { adapter = adapter_id }))

          local failed = 0
          for pos_id, result in pairs(results) do
            if result.status == "failed" and tree:get_key(pos_id) then
              failed = failed + 1
            end
          end
          vim.schedule(function()
            local trouble = require("trouble")
            if trouble.is_open() then
              trouble.refresh()
              if failed == 0 then
                trouble.close()
              end
            end
          end)
          return {}
        end
      end

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif adapter.adapter then
                adapter.adapter(config)
                adapter = adapter.adapter
              elseif meta and meta.__call then
                adapter = adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
  -- stylua: ignore
  keys = {
    {"<leader>t", "", desc = "+test"},
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
    { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
    { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
  },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      plugins = {
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = true })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = true,
    ft = { "markdown", "Avante*" },
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      vim.opt.termguicolors = true
      require("colorizer").setup({
        "css",
        "javascript",
        html = { mode = "background" },
      }, {
        mode = "background",
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
      })
    end,
  },
  {
    "max397574/colortils.nvim",
    event = "VeryLazy",
    cmd = "Colortils",
    opts = {
      -- Register in which color codes will be copied
      register = "+",
      -- Preview for colors, if it contains `%s` this will be replaced with a hex color code of the color
      color_preview = "█ %s",
      -- The default in which colors should be saved
      -- This can be hex, hsl or rgb
      default_format = "hex",
      -- String: default color if no color is found
      default_color = "#000000",
      -- Border for the float
      border = "rounded",
      -- Some mappings which are used inside the tools
      mappings = {
        -- increment values
        increment = "i",
        -- decrement values
        decrement = "n",
        -- increment values with bigger steps
        increment_big = "I",
        -- decrement values with bigger steps
        decrement_big = "N",
        -- set values to the minimum
        min_value = "0",
        -- set values to the maximum
        max_value = "$",
        -- save the current color in the register specified above with the format specified above
        set_register_default_format = "<cr>",
        -- save the current color in the register specified above with a format you can choose
        set_register_choose_format = "g<cr>",
        -- replace the color under the cursor with the current color in the format specified above
        replace_default_format = "<m-cr>",
        -- replace the color under the cursor with the current color in a format you can choose
        replace_choose_format = "g<m-cr>",
        -- export the current color to a different tool
        export = "E",
        -- set the value to a certain number (done by just entering numbers)
        set_value = "c",
        -- toggle transparency
        transparency = "T",
        -- choose the background (for transparent colors)
        choose_background = "B",
        -- quit window
        quit_window = { "q", "<esc>" },
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = true,
    event = "User IceLoad",
    config = function()
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = "rainbow-delimiters.strategy.global",
          vim = "rainbow-delimiters.strategy.local",
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },
}
