return {
  "ckolkey/ts-node-action",
  lazy = true,
  opts = {},
  keys = {
    { "s", ":lua require('ts-node-action').node_action()<cr>", noremap = true, silent = true, desc = "Trigger Node Action" }
  }
}