return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>gw",
      function()
        Snacks.gitbrowse.open { commit = require("utils.git").get_commit_hash() }
      end,
      desc = "Open Commit on Web",
    },
    {
      "<leader>gy",
      function()
        Snacks.gitbrowse.open()
      end,
      desc = "Open Line on Web",
      mode = { "n", "v" },
    },
    {
      "<leader>gO",
      function()
        Snacks.gitbrowse.open { what = "repo" }
      end,
      desc = "Open Project on Web",
    },
  },
}
