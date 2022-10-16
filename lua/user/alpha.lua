local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require "user.icons"

local if_nil = vim.F.if_nil

local default_terminal = {
  type = "terminal",
  command = nil,
  width = 69,
  height = 8,
  opts = {
    redraw = true,
    window_config = {},
  },
}

local default_header = {
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
  local plugins = #vim.fn.globpath(vim.fn.stdpath('data') .. '/site/pack/packer/start', '*', 0, 1)
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

local leader = "SPC"

local function button(sc, txt, keybind, keybind_opts)
  local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

  local opts = {
    position = "center",
    shortcut = sc,
    cursor = 5,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "Macro",
  }
  if keybind then
    keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { "n", sc_, keybind, keybind_opts }
  end

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
    vim.api.nvim_feedkeys(key, "t", false)
  end

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
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
    button("u", icons.ui.CloudDownload ..         "  Update",       "<cmd>PackerSync<cr>"),
    button("q", icons.diagnostics.ErrorOutline .. "  Quit",         "<cmd>qa<cr>"),
  },
  opts = {
    spacing = 1,
  },
}

local section = {
  terminal = default_terminal,
  header = default_header,
  buttons = buttons,
  footer = footer,
}

local marginTopPercent = 0.15
local headerPadding = vim.fn.max({2, vim.fn.floor(vim.fn.winheight(0) * marginTopPercent) })
local config = {
  layout = {
    { type = "padding", val = headerPadding },
    section.header,
    { type = "padding", val = 2 },
    section.buttons,
    section.footer,
  },
  opts = {
    margin = 5,
    noautocmd = true,
  },
}

alpha.setup(config)
