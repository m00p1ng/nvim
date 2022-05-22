local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

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
  dashboard.button("f", "  Find file", "<cmd>lua require('user.function').project_files()<cr>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert<cr>"),
  dashboard.button("p", "  Find project", "<cmd>Telescope projects theme=dropdown<cr>"),
  dashboard.button("r", "  Recently used files", "<cmd>Telescope oldfiles<cr>"),
  dashboard.button("t", "  Find text", "<cmd>Telescope live_grep<cr>"),
  dashboard.button("c", "  Configuration", "<cmd>e ~/.config/nvim/init.lua<cr>"),
  dashboard.button("q", "  Quit Neovim", "<cmd>qa<CR>"),
}

local function footer()
  local plugins = #vim.fn.globpath(vim.fn.stdpath('data') .. '/site/pack/packer/start', '*', 0, 1)
  local v = vim.version()
  return string.format(" %d   v%d.%d.%d", plugins, v.major, v.minor, v.patch)
end
dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
