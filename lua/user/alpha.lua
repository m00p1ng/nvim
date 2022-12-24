local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require "user.icons"

local header = {
  type = "text",
  val = {
    [[░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]],
    [[░░    ░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]],
    [[▒▒  ▒   ▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒]],
    [[▒▒   ▒   ▒▒   ▒▒▒      ▒▒▒▒▒      ▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒            ▒▒▒]],
    [[▓▓   ▓▓   ▓   ▓▓  ▓▓▓   ▓▓▓   ▓▓   ▓▓▓   ▓▓▓   ▓▓   ▓▓   ▓▓  ▓▓   ▓▓]],
    [[▓▓   ▓▓▓  ▓   ▓         ▓▓   ▓▓▓▓   ▓▓▓   ▓   ▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓]],
    [[▓▓   ▓▓▓▓  ▓  ▓  ▓▓▓▓▓▓▓▓▓▓   ▓▓   ▓▓▓▓▓     ▓▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓]],
    [[██   ██████   ███      █████      ███████   █████   █    ██  ██   ██]],
    [[████████████████████████████████████████████████████████████████████]],
  },
  opts = {
    position = "center",
    hl = "Include",
  },
}

local function gen_footer()
  local plugins = require("lazy").stats().count
  local v = vim.version()
  local version = string.format(icons.ui.Version .. " v%d.%d.%d", v.major, v.minor, v.patch)
  local plugin = icons.documents.Archive .. " " .. plugins

  return version .. "   " .. plugin
end

local footer = {
  type = "text",
  val = gen_footer(),
  opts = {
    position = "center",
    hl = "Type",
  },
}

local function button(sc, txt, keybind)
  return {
    type = "button",
    val = txt,
    opts = {
      position = "center",
      shortcut = sc,
      cursor = 5,
      width = 50,
      align_shortcut = "right",
      hl_shortcut = "Macro",
      keymap = {
        "n", sc, keybind, { noremap = true, silent = true, nowait = true }
      }
    },
  }
end

local buttons = {
  type = "group",
  val = {
    button("f", icons.documents.Files ..          "  Find file",    "<cmd>lua require('user.function').project_files()<cr>"),
    button("e", icons.documents.NewFile ..        "  New file",     ":ene <BAR> startinsert<cr>"),
    button("r", icons.ui.History ..               "  Recent files", "<cmd>Telescope oldfiles<cr>"),
    button("t", icons.ui.List ..                  "  Find text",    "<cmd>Telescope live_grep<cr>"),
    button("c", icons.ui.Gear ..                  "  Config",       "<cmd>e ~/.config/nvim/init.lua<cr>"),
    button("u", icons.ui.CloudDownload ..         "  Update",       "<cmd>Lazy sync<cr>"),
    button("q", icons.diagnostics.ErrorOutline .. "  Quit",         "<cmd>qa<cr>"),
  },
  opts = {
    spacing = 1,
  },
}

local marginTopPercent = 0.15
local headerPadding = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * marginTopPercent) })
local config = {
  layout = {
    { type = "padding", val = headerPadding },
    header,
    { type = "padding", val = 2 },
    buttons,
    footer,
  },
  opts = {
    margin = 5,
    noautocmd = true,
  },
}

alpha.setup(config)
