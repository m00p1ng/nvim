if vim.g.vscode then
  return
end

local dap_python = require "dap-python"

local installation_path = vim.fn.stdpath "data" .. "/mason/packages"

dap_python.setup(installation_path .. "/debugpy/venv/bin/python")

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
      function()
        local cmd = "python3 '" .. vim.fn.expand "%:~:." .. "'"
        require("utils.tmux").run_command(cmd)
      end,
      "Run",
    },
    t = {
      function()
        local cmd = "python3 '" .. vim.fn.expand "%:~:." .. "'"
        cmd = cmd .. " " .. require("utils.treesitter").get_ref()
        require("utils.tmux").run_command(cmd)
      end,
      "Run Cursor",
    },
    l = {
      function()
        local cmd = "python3 '" .. vim.fn.expand "%:~:." .. "'"
        cmd = cmd .. " " .. require("utils.treesitter").last_ref
        require("utils.tmux").run_command(cmd)
      end,
      "Run Last",
    },
  },
}

which_key.register(mappings, opts)
