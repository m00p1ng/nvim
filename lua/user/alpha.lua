local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require "user.icons"

local dashboard = require("alpha.themes.dashboard")

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl_shortcut = "Macro"
  return b
end

dashboard.section.header.val = {
  [[░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]],
  [[░░    ░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]],
  [[▒▒  ▒   ▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒]],
  [[▒▒   ▒   ▒▒   ▒▒▒      ▒▒▒▒▒      ▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒            ▒▒▒]],
  [[▓▓   ▓▓   ▓   ▓▓  ▓▓▓   ▓▓▓   ▓▓   ▓▓▓   ▓▓▓   ▓▓   ▓▓   ▓▓  ▓▓   ▓▓]],
  [[▓▓   ▓▓▓  ▓   ▓         ▓▓   ▓▓▓▓   ▓▓▓   ▓   ▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓]],
  [[▓▓   ▓▓▓▓  ▓  ▓  ▓▓▓▓▓▓▓▓▓▓   ▓▓   ▓▓▓▓▓     ▓▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓]],
  [[██   ██████   ███      █████      ███████   █████   █    ██  ██   ██]],
  [[████████████████████████████████████████████████████████████████████]],
}
dashboard.section.buttons.val = {
  button("f", icons.documents.Files ..          "  Find file",    "<cmd>lua require('user.function').project_files()<cr>"),
  button("e", icons.documents.NewFile ..        "  New file",     ":ene <BAR> startinsert<cr>"),
  button("r", icons.ui.History ..               "  Recent files", "<cmd>Telescope oldfiles<cr>"),
  button("t", icons.ui.List ..                  "  Find text",    "<cmd>Telescope live_grep<cr>"),
  button("c", icons.ui.Gear ..                  "  Config",       "<cmd>e ~/.config/nvim/init.lua<cr>"),
  button("u", icons.ui.CloudDownload ..         "  Update",       "<cmd>PackerSync<cr>"),
  button("q", icons.diagnostics.ErrorOutline .. "  Quit",         "<cmd>qa<cr>"),
}

local function footer()
  local plugins = #vim.fn.globpath(vim.fn.stdpath('data') .. '/site/pack/packer/start', '*', 0, 1)
  local v = vim.version()
  return string.format(icons.documents.Archive .. " %d  " .. icons.ui.Version .. " v%d.%d.%d", plugins, v.major, v.minor, v.patch)
end

dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Macro"
dashboard.section.footer.opts.hl = "Type"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
