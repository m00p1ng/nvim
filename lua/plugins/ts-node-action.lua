return {
  "CKolkey/ts-node-action",
  lazy = true,
  cond = vim.g.vscode == nil,
  opts = {},
  keys = {
    {
      "s",
      ":lua require('ts-node-action').node_action()<cr>",
      noremap = true,
      silent = true,
      desc = "Trigger Node Action",
    },
  },
}
