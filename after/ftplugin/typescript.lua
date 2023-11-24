if vim.g.vscode then
  return
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("ts_eslint_fix", { clear = true }),
  pattern = { "*.ts" },
  command = "silent! EslintFixAll",
})

local dap = require "dap"
local dap_vscode_js = require "dap-vscode-js"
vim.keymap.set("n", "<leader>dl", function()
  require("dap.ext.vscode").load_launchjs(nil, {
    ["pwa-node"] = {
      "typescript",
    },
    ["pwa-chrome"] = {
      "typescript",
    },
  })
end, { noremap = true, silent = true })

local installation_path = vim.fn.stdpath "data" .. "/mason/packages"

dap_vscode_js.setup {
  adapters = { "pwa-node", "pwa-chrome" },
  debugger_path = installation_path .. "/js-debug-adapter",
}

dap.configurations.typescript = {
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
    name = "Typescript",
    f = { "<cmd>EslintFixAll<Cr>", "FixAll" },
    r = {
      function()
        local cmd = "pnpm exec ts-node '" .. vim.fn.expand "%:~:." .. "'"
        require("utils.tmux").run_command(cmd)
      end,
      "Run",
    },
  },
}

which_key.register(mappings, opts)
