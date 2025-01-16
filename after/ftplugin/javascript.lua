if vim.g.vscode then
  return
end

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
