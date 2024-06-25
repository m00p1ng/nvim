require "config.keymaps"
require "config.lazy"

if vim.g.vscode == nil then
  require "config.options"
  require "config.autocmds"
end
