if vim.g.vscode then
  return
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("tsx_eslint_fix", { clear = true }),
  pattern = { "*.tsx" },
  command = "silent! EslintFixAll",
})

local dap = require "dap"
local dap_vscode_js = require "dap-vscode-js"
vim.keymap.set("n", "<leader>dl", function()
  require("dap.ext.vscode").load_launchjs(nil, {
    ["pwa-chrome"] = {
      "typescriptreact",
    },
  })
end, { noremap = true, silent = true, buffer = true })

local installation_path = vim.fn.stdpath "data" .. "/mason/packages"

dap_vscode_js.setup {
  adapters = { "pwa-chrome" },
  debugger_path = installation_path .. "/js-debug-adapter",
}

dap.configurations.typescriptreact = {
  {
    name = "Attach chrome",
    type = "pwa-chrome",
    request = "attach",
    port = 9229,
    cwd = "${workspaceFolder}",
  },
  {
    name = "Launch chrome",
    type = "pwa-chrome",
    request = "launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

local wk = require "which-key"

wk.add {
  { "<leader>m", group = "Typescript" },
  { "<leader>mf", "<cmd>EslintFixAll<cr>", desc = "Fix All", buffer = true },
}
