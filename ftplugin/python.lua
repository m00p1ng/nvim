local dap_python = require "dap-python"

dap_python.setup()

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
    name = "Python",
    r = {
      "<cmd>lua require('utils.tmux').run_command(\"python3 '\" .. vim.fn.expand('%:~:.') .. \"'\")<cr>",
      "Run Tmux",
    },
  },
}

which_key.register(mappings, opts)
