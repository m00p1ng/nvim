if vim.g.vscode then
  return
end

local filename = vim.fn.expand "%:t"

if filename == "package.json" then
  local wk = require "which-key"

  wk.add {
    { "<leader>m", group = "Package.json" },
    { "<leader>mt", "<cmd>lua require('package-info').toggle()<cr>", desc = "Toggle" },
    { "<leader>mu", "<cmd>lua require('package-info').update()<cr>", desc = "Update" },
    { "<leader>md", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete" },
    { "<leader>mi", "<cmd>lua require('package-info').install()<cr>", desc = "Install" },
    { "<leader>mc", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change" },
  }
end
