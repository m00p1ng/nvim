local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      -- You can change the order of elements in the sidebar
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = "left", -- Can be "left", "right", "top", "bottom"
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "rounded", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

vim.cmd [[
  highlight DapStopped guibg=#4B4B18
  highlight DapStoppedText guifg=yellow
]]

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '●', texthl = 'DiagnosticSignWarning', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStoppedText', linehl = 'DapStopped', numhl = '' })

-- Setup
require("dap-vscode-js").setup({
  adapters = { 'pwa-node' },
})

local installation_path = vim.fn.stdpath("data") .. "/mason"

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { installation_path .. '/packages/node-debug2-adapter/out/src/nodeDebug.js' },
}

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      name = 'Launch (node2)',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Attach (node2)',
      type = 'node2',
      request = 'attach',
      processId = require 'dap.utils'.pick_process,
    },
  }
end
