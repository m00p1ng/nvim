local capabilities = require("plugins.lsp.keymaps").capabilities
return {
  capabilities = vim.deepcopy(capabilities),
}
