local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require "user.icons"

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[                               __]],
  [[  ___     ___    ___   __  __ /\_\    ___ ___]],
  [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
  [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
  [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
  dashboard.button("f", icons.documents.Files .. "  Find file", "<cmd>lua require('user.function').project_files()<cr>"),
  dashboard.button("e", icons.ui.NewFile .. "  New file", ":ene <BAR> startinsert<cr>"),
  dashboard.button("p", icons.git.Repo .. "  Find project", "<cmd>Telescope projects theme=dropdown<cr>"),
  dashboard.button("r", icons.ui.History .. "  Recent files", "<cmd>Telescope oldfiles<cr>"),
  dashboard.button("t", icons.ui.List .. "  Find text", "<cmd>Telescope live_grep<cr>"),
  dashboard.button("c", icons.ui.Gear .. "  Config", "<cmd>e ~/.config/nvim/init.lua<cr>"),
  dashboard.button("u", icons.ui.CloudDownload .. "  Update", "<cmd>PackerSync<cr>"),
  dashboard.button("q", icons.diagnostics.Error .. "  Quit", "<cmd>qa<cr>"),
}

local function footer()
  local plugins = #vim.fn.globpath(vim.fn.stdpath('data') .. '/site/pack/packer/start', '*', 0, 1)
  local v = vim.version()
  return string.format(icons.ui.Package .. " %d  " .. icons.diagnostics.Information .. " v%d.%d.%d", plugins, v.major, v.minor, v.patch)
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
