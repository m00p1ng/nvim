local icons = require "utils.icons"

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require "alpha.themes.dashboard"
    local logo = [[
    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    ░░    ░░░░░   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    ▒▒  ▒   ▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ▒▒   ▒   ▒▒   ▒▒▒      ▒▒▒▒▒      ▒▒▒   ▒▒▒▒▒   ▒▒▒▒▒            ▒▒▒
    ▓▓   ▓▓   ▓   ▓▓  ▓▓▓   ▓▓▓   ▓▓   ▓▓▓   ▓▓▓   ▓▓   ▓▓   ▓▓  ▓▓   ▓▓
    ▓▓   ▓▓▓  ▓   ▓         ▓▓   ▓▓▓▓   ▓▓▓   ▓   ▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓
    ▓▓   ▓▓▓▓  ▓  ▓  ▓▓▓▓▓▓▓▓▓▓   ▓▓   ▓▓▓▓▓     ▓▓▓▓   ▓▓   ▓▓  ▓▓   ▓▓
    ██   ██████   ███      █████      ███████   █████   █    ██  ██   ██
    ████████████████████████████████████████████████████████████████████
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      dashboard.button("f", icons.documents.Files .. "  Find file", "<cmd>lua require('utils').project_files()<cr>"),
      dashboard.button("e", icons.documents.NewFile .. "  New file", ":ene <BAR> startinsert<cr>"),
      dashboard.button("r", icons.ui.History .. "  Recent files", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button("t", icons.ui.List .. "  Find text", "<cmd>Telescope live_grep<cr>"),
      dashboard.button("c", icons.ui.Gear .. "  Config", "<cmd>e ~/.config/nvim/init.lua<cr>"),
      dashboard.button("u", icons.ui.CloudDownload .. "  Update", "<cmd>Lazy sync<cr>"),
      dashboard.button("q", icons.diagnostics.ErrorOutline .. "  Quit", "<cmd>qa<cr>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl_shortcut = "Macro"
    end
    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        local v = vim.version()
        local version = string.format(icons.ui.Version .. " v%d.%d.%d", v.major, v.minor, v.patch)
        local plugins = icons.documents.Archive .. " " .. stats.count
        local times = ms .. "ms"

        dashboard.section.footer.val = times .. "   " .. plugins .. "   " .. version
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}


