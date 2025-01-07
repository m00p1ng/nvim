if vim.g.vscode then
  return
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("js_eslint_fix", { clear = true }),
  pattern = { "*.js" },
  command = "silent! EslintFixAll",
})

local dap = require "dap"
local installation_path = vim.fn.stdpath "data" .. "/mason/packages"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = "${port}",
  executable = {
    command = "node",
    args = { installation_path .. "/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
  },
}

dap.configurations.javascript = {
  {
    name = "Launch",
    type = "pwa-node",
    request = "launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

require("which-key").add {
  { "<leader>m", group = "Javascript" },
  { "<leader>mf", "<cmd>EslintFixAll<cr>", desc = "Fix All", buffer = true },
}
