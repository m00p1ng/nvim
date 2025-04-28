local icons = require "utils.icons"

return {
  {
    "mfussenegger/nvim-dap",
    -- use `config` instead of `opts` or `init` to avoid bugs
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
    keys = {
      { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Breakpoint" },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end,
        desc = "Conditional breakpoint",
      },
      {
        "<leader>dL",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
        end,
        desc = "Log breakpoint",
      },
      { "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue" },
      { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "Into" },
      { "<leader>do", "<cmd>lua require('dap').step_over()<cr>", desc = "Over" },
      { "<leader>dO", "<cmd>lua require('dap').step_out()<cr>", desc = "Out" },
      { "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", desc = "Repl" },
      { "<leader>dl", "<cmd>lua require('dap').run_last()<cr>", desc = "Last" },
      { "<leader>dx", "<cmd>lua require('dap').terminate()<cr>", desc = "Exit" },
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    opts = {
      icons = {
        expanded = icons.ui.ChevronShortRight,
        collapsed = icons.ui.ChevronShortDown,
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
    keys = {
      { "<leader>de", "<cmd>lua require('dapui').eval()<cr>", desc = "Eval" },
      { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "UI" },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    init = function()
      local dap_icons = {
        dapui_breakpoints = icons.ui.Bug,
        dapui_stacks = icons.ui.Stacks,
        dapui_scopes = icons.ui.Scopes,
        dapui_watches = icons.ui.Watches,
        dapui_console = icons.ui.Terminal,
      }

      require("utils").add_ui_ft "dap-repl"
      require("utils.winbar").add_plugin "dap-repl"

      require("utils").add_ui_ft {
        "dapui_watches",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
        "dapui_hover",
        "dapui_console",
        "",
      }
      local winbar = require "utils.winbar"
      winbar.add_include_ft {
        "dapui_breakpoints",
        "dapui_scopes",
        "dapui_stacks",
        "dapui_watches",
        "dapui_console",
      }
      winbar.add_rename_cond(function(opts)
        if vim.startswith(opts.filename, "DAP") then
          return {
            file_icon = vim.tbl_get(dap_icons, opts.ft) or "",
            output_filename = vim.split(opts.filename, " ")[2],
          }
        end
      end)

      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        group = vim.api.nvim_create_augroup("dap_option_setup", { clear = true }),
        pattern = { "dap-repl", "dap*" },
        callback = function()
          vim.opt_local.cursorline = false

          local opts = { noremap = true, silent = true, buffer = true }
          vim.keymap.set("i", "<C-h>", "<esc><C-w>h", opts)
          vim.keymap.set("i", "<C-j>", "<esc><C-w>j", opts)
          vim.keymap.set("i", "<C-k>", "<esc><C-w>k", opts)
          vim.keymap.set("i", "<C-l>", "<esc><C-w>l", opts)
        end,
      })
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
    keys = {
      { "<leader>dv", "<cmd>lua require('nvim-dap-virtual-text').toggle()<cr>", desc = "Toggle Virtual" },
    },
  },
}
