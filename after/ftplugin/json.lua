if vim.g.vscode then
  return
end

local filename = vim.fn.expand "%:t"

if filename == "package.json" then
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
      name = "Package.json",
      t = { "<cmd>lua require('package-info').toggle()<cr>", "Toggle" },
      u = { "<cmd>lua require('package-info').update()<cr>", "Update" },
      d = { "<cmd>lua require('package-info').delete()<cr>", "Delete" },
      i = { "<cmd>lua require('package-info').install()<cr>", "Install" },
      c = { "<cmd>lua require('package-info').change_version()<cr>", "Change" },
    },
  }

  which_key.register(mappings, opts)
end
