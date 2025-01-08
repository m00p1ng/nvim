local icons = require "utils.icons"

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      width = 60,
      row = 8, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 4, -- empty columns between vertical panes
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
      -- These settings are used by some built-in sections
      preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        pick = nil,
        -- Used by the `keys` section to show keymaps.
        -- Set your custom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        keys = {
          -- {
          --   icon = icons.ui.File,
          --   key = "f",
          --   desc = "Find File",
          --   action = ":lua Snacks.dashboard.pick('files')",
          -- },
          {
            icon = icons.ui.NewFile,
            key = "n",
            desc = "New File",
            action = ":ene | startinsert",
          },
          {
            icon = icons.ui.History,
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = icons.ui.List,
            key = "t",
            desc = "Find Text",
            action = ":Telescope live_grep_args",
          },
          {
            icon = icons.ui.Gear,
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          {
            icon = icons.ui.CloudDownload,
            key = "u",
            desc = "Update",
            action = ":Lazy sync",
          },
          {
            icon = icons.diagnostics.Error,
            key = "q",
            desc = "Quit",
            action = ":qa",
          },
        },
        -- Used by the `header` section
        header = [[
░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░    ░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
▒▒  ▒   ▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
▒▒   ▒   ▒▒   ▒▒▒      ▒▒▒▒▒      ▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒            ▒▒▒
▓▓   ▓▓   ▓   ▓▓  ▓▓▓   ▓▓▓   ▓▓   ▓▓▓   ▓▓▓   ▓▓   ▓▓   ▓▓  ▓▓   ▓▓
▓▓   ▓▓▓  ▓   ▓         ▓▓   ▓▓▓▓   ▓▓▓   ▓   ▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓
▓▓   ▓▓▓▓  ▓  ▓  ▓▓▓▓▓▓▓▓▓▓   ▓▓   ▓▓▓▓▓     ▓▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓
██   ██████   ███      █████      ███████   █████   █    ██  ██   ██
████████████████████████████████████████████████████████████████████
]],
      },
      -- item field formatters
      formats = {
        icon = function(item)
          if item.file and item.icon == "file" or item.icon == "directory" then
            return M.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = "icon" }
        end,
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. "/…" .. file
            end
          end
          local dir, file = fname:match "^(.*)/(.+)$"
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          local v = vim.version()
          local version = string.format(icons.ui.Version .. " v%d.%d.%d", v.major, v.minor, v.patch)
          local plugins = icons.ui.Archive .. " " .. stats.count
          local times = ms .. "ms"

          return {
            align = "center",
            text = {
              { times .. "   " .. plugins .. "   " .. version, hl = "Type" },
            },
          }
        end,
      },
    },
  },
}
