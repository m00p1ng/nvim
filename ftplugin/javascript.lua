vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("_js_eslint_fix", { clear = true }),
  pattern = { "*.js" },
  command = "silent! EslintFixAll",
})

local dap = require "dap"
local dap_vscode_js = require "dap-vscode-js"

local installation_path = vim.fn.stdpath "data" .. "/mason/packages"

dap_vscode_js.setup {
  adapters = { "pwa-node" },
  debugger_path = installation_path .. "/js-debug-adapter",
}

dap.configurations.javascript = {
  {
    name = "Attach",
    type = "pwa-node",
    request = "attach",
    port = 9229,
    cwd = "${workspaceFolder}",
  },
  {
    name = "Launch",
    type = "pwa-node",
    request = "launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

local which_key = require "which-key"

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  m = {
    name = "Javascript",
    f = { "<cmd>EslintFixAll<Cr>", "FixAll" },
  },
}

which_key.register(mappings, opts)
