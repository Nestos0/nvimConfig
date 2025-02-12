-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir

-- Color table for highlights
vim.o.laststatus = 3
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#c0caf5',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    disabled_filetypes = {
      statusline = { "neo-tree", "neo-tree-popup", "notify", "dashboard", "alpha", "ministarter", "snacks_dashboard" },
      winbar = {},
    },
    theme = "auto",
    globalstatus = vim.o.laststatus == 3,
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {
      {
        function()
          return "▊"
        end,
        color = { fg = colors.blue, bg = "" }, -- Sets highlighting of component
        padding = { left = 0, right = 1 }, -- We don't need space before this
      },
      {
        function()
          return ""
        end,
        color = function()
          -- auto change color according to neovims mode
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            ["␖"] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            ["␓"] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()], bg = "" }
        end,
        padding = { right = 1 },
      },
    },
    lualine_b = {
      --[[  "branch"  ]]
      {
        -- filesize component
        "filesize",
        cond = conditions.buffer_not_empty,
        color = { fg = "#c0caf5", bg = "" }, -- Sets highlighting of component
      },
      {
        "filename",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, bg = "", gui = "bold" },
      },
      {
        "location",
        color = { fg = colors.fg, bg = "" }, -- Sets highlighting of component
      },
      { "progress", color = { fg = colors.fg, bg = "", gui = "bold" } },
    },
    lualine_c = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.cyan },
        },
      },
      {
        -- Lsp server name .
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
          local clients = vim.lsp.get_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            ---@diagnostic disable-next-line: undefined-field
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = " LSP:",
        color = { fg = "#ffffff", gui = "bold" },
        padding = { left = vim.api.nvim_win_get_width(0) / 2 - 45 },
      },
    },
    lualine_x = {
      {
        "o:encoding", -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = "bold" },
      },
      {
        "fileformat",
        fmt = string.upper,
        icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
        color = { fg = colors.green, gui = "bold" },
      },
      {
        "branch",
        icon = "",
        color = { fg = colors.violet, gui = "bold" },
      },
    },
    lualine_y = {
      {
        "diff",
        -- Is it me or the symbol for modified us really weird
        symbols = { added = " ", modified = "󰝤 ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
        color = { bg = "" },
      },
    },
    lualine_z = {
      {
        function()
          return "▊"
        end,
        color = { fg = colors.blue, bg = "" },
        padding = { left = 1 },
      },
    },
    -- These will be filled later
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {
      {
        function()
          return "▊"
        end,
        color = { fg = colors.blue, bg = "" }, -- Sets highlighting of component
        padding = { left = 0, right = 1 }, -- We don't need space before this
      },
      {
        "filename",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, bg = "", gui = "bold" },
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      {
        "o:encoding", -- option component same as &encoding in viml
        fmt = string.upper, -- I'm not sure why it's upper case either ;)
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = "bold" },
      },
      {
        "fileformat",
        fmt = string.upper,
        icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
        color = { fg = colors.green, gui = "bold" },
      },
      {
        "branch",
        icon = "",
        color = { fg = colors.violet, gui = "bold" },
      },
    },
  },
  extensions = { "neo-tree", "lazy", "fzf" },
}

return config
