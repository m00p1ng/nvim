local status_ok, flutter_tools = pcall(require, "flutter-tools")
if not status_ok then
  return
end

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

flutter_tools.setup {
  lsp = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  },
  closing_tags = {
    highlight = "GitBlame"
  },
  dev_log = {
    open_cmd = "e"
  }
}

telescope.load_extension("flutter")
