local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

local icons = require("user.icons")

dapui.setup {
  icons = {
    expanded = icons.ui.ArrowOpen,
    collapsed = icons.ui.ArrowClosed,
  },
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
    controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = icons.debug.Pause,
      play = icons.debug.Start,
      step_into = icons.debug.StepInto,
      step_over = icons.debug.StepOver,
      step_out = icons.debug.StepOut,
      step_back = icons.debug.StepBack,
      run_last = icons.debug.Restart,
      terminate = icons.debug.Stop,
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

vim.api.nvim_set_hl(0, "DapStopped", { bg = "#4B4B18" })
vim.api.nvim_set_hl(0, "DapStoppedText", { fg = 'yellow' })

vim.fn.sign_define('DapBreakpoint', { text = icons.ui.Circle, texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = icons.ui.Circle, texthl = 'DiagnosticSignWarning', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = icons.ui.ChevronRight, texthl = 'DapStoppedText', linehl = 'DapStopped', numhl = '' })

-- Setup
local installation_path = vim.fn.stdpath("data") .. "/mason/packages"

-- Javascript / Typescript
require("dap-vscode-js").setup({
  adapters = { 'pwa-node' },
  debugger_path = installation_path .. '/js-debug-adapter'
})

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      name = 'Attach',
      type = 'pwa-node',
      request = 'attach',
      port = 9229,
      cwd = '${workspaceFolder}',
    },
    {
      name = 'Launch',
      type = 'pwa-node',
      request = 'launch',
      program = '${file}',
      cwd = '${workspaceFolder}',
    },
  }
end

-- Python
dap.adapters.python = {
  type = 'executable',
  command = installation_path .. '/debugpy/venv/bin/python3',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python3') == 1 then
        return cwd .. '/venv/bin/python3'
      elseif vim.fn.executable(cwd .. '/.venv/bin/pytho3') == 1 then
        return cwd .. '/.venv/bin/python3'
      else
        return '/usr/bin/python3'
      end
    end;
  },
}
