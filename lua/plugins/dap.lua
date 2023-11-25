local icons = require "utils.icons"

return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    cond = vim.g.vscode == nil,
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      { "mxsdev/nvim-dap-vscode-js", ft = { "javascript", "typescript" } },
      { "mfussenegger/nvim-dap-python", ft = "python" },
      { "leoluz/nvim-dap-go", ft = "go" },
    },
    config = function()
      vim.api.nvim_set_hl(0, "DapStopped", { bg = "#4B4B18" })
      vim.api.nvim_set_hl(0, "DapStoppedText", { fg = "yellow" })

      vim.fn.sign_define("DapBreakpoint", {
        text = icons.ui.Circle,
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      })
      vim.fn.sign_define("DapBreakpointCondition", {
        text = icons.ui.Circle,
        texthl = "DiagnosticSignWarning",
        linehl = "",
        numhl = "",
      })
      vim.fn.sign_define("DapStopped", {
        text = icons.ui.ChevronRight,
        texthl = "DapStoppedText",
        linehl = "DapStopped",
        numhl = "",
      })
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    cond = vim.g.vscode == nil,
    opts = {
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
        {
          elements = {
            { id = "repl", size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
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
    },
  },
}
