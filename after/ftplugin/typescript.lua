if vim.g.vscode then
  return
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("ts_eslint_fix", { clear = true }),
  pattern = { "*.ts" },
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

local wk = require "which-key"

wk.add {
  { "<leader>m", group = "Typescript" },
  { "<leader>mf", "<cmd>EslintFixAll<cr>", desc = "Fix All", buffer = true },
  {
    "<leader>mr",
    function()
      local cmd = "pnpm exec ts-node '" .. vim.fn.expand "%:~:." .. "'"
      require("utils.tmux").run_command(cmd)
    end,
    desc = "Run",
    buffer = true,
  },
}
