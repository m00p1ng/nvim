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

dap.configurations.typescript = {
  -- https://github.com/mfussenegger/nvim-dap/discussions/659
  {
    name = "Launch",
    type = "pwa-node",
    request = "launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
    runtimeArgs = { "-r", "ts-node/register" },
    runtimeExecutable = "node",
  },
}

require("which-key").add {
  { "<leader>m", group = "Typescript" },
  { "<leader>mf", "<cmd>EslintFixAll<cr>", desc = "Fix All", buffer = true },
  {
    "<leader>mr",
    function()
      local cmd = "pnpm exec ts-node '" .. vim.fn.expand "%:~:." .. "'"
      require("utils.tmux").run(cmd)
    end,
    desc = "Run",
    buffer = true,
  },
}
