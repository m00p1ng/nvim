if vim.g.vscode then
  return
end

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
    name = "Flutter",
    t = { "<cmd>Telescope flutter commands<cr>", "Menu" },
    f = { "<cmd>Telescope flutter fvm<cr>", "FVM" },
  },
}

which_key.register(mappings, opts)
