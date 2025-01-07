if vim.g.vscode then
  return
end

local filename = vim.fn.expand "%:t"

if filename == "package.json" then
  require("which-key").add {
    { "<leader>m", group = "Package.json" },
    { "<leader>mt", "<cmd>lua require('package-info').toggle()<cr>", desc = "Toggle", buffer = true },
    { "<leader>mu", "<cmd>lua require('package-info').update()<cr>", desc = "Update", buffer = true },
    { "<leader>md", "<cmd>lua require('package-info').delete()<cr>", desc = "Delete", buffer = true },
    { "<leader>mi", "<cmd>lua require('package-info').install()<cr>", desc = "Install", buffer = true },
    { "<leader>mc", "<cmd>lua require('package-info').change_version()<cr>", desc = "Change", buffer = true },
  }
end
