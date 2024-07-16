if vim.g.vscode then
  return
end

local wk = require "which-key"

wk.add {
  { "<leader>m", group = "Flutter" },
  { "<leader>mt", "<cmd>Telescope flutter commands<cr>", desc = "Menu" },
  { "<leader>mf", "<cmd>Telescope flutter fvm<cr>", desc = "FVM" },
}
