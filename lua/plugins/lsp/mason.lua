local icons = require "utils.icons"

return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  opts = {
    ensure_installed = {
      "stylua",
      "shellcheck",
      "shfmt",
      "flake8",
      "black",
      "js-debug-adapter",
      "delve",
    },
    ui = {
      border = "rounded",
      icons = {
        package_installed = icons.ui.FilledCircle,
        package_pending = icons.ui.FilledCircle,
        package_uninstalled = icons.ui.FilledCircle,
      },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  },
  ---@param opts MasonSettings | {ensure_installed: string[]}
  config = function(plugin, opts)
    require("mason").setup(opts)
    local mr = require "mason-registry"
    for _, tool in ipairs(opts.ensure_installed) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end,
}
