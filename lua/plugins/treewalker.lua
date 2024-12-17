return {
  "aaronik/treewalker.nvim",
  opts = {
    highlight = true, -- Whether to briefly highlight the node after jumping to it
  },
  keys = {
    { "<leader><leader>j", "<cmd>Treewalker Down<cr>", desc = "Move down to the next neighbor node" },
    { "<leader><leader>k", "<cmd>Treewalker Up<cr>", desc = "Move up to the next neighbor node" },
    { "<leader><leader>h", "<cmd>Treewalker Left<cr>", desc = "Finds the next good parent node" },
    { "<leader><leader>l", "<cmd>Treewalker Right<cr>", desc = "Finds the next good child node" },
  },
}
