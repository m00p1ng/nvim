require "config.keymaps"

if vim.g.vscode == nil then
  require "config.options"
  require "config.autocmds"
end

require "config.lazy"
