return {
  "aaronik/treewalker.nvim",
  opts = {
    highlight = true, -- Whether to briefly highlight the node after jumping to it
  },
  keys = {
    {
      "[k",
      function()
        require("treewalker").move_up()
      end,
      mode = { "n", "v" },
      desc = "Move up node",
    },
    {
      "]k",
      function()
        require("treewalker").move_down()
      end,
      mode = { "n", "v" },
      desc = "Move down node",
    },
    {
      "]p",
      function()
        require("treewalker").move_in()
      end,
      mode = { "n", "v" },
      desc = "Move child node",
    },
    {
      "[p",
      function()
        require("treewalker").move_out()
      end,
      mode = { "n", "v" },
      desc = "Move parent node",
    },

    {
      "[K",
      function()
        require("treewalker").swap_up()
      end,
      desc = "Swap node up",
    },
    {
      "]K",
      function()
        require("treewalker").swap_down()
      end,
      desc = "Swap node down",
    },
    {
      "[P",
      function()
        require("treewalker").swap_left()
      end,
      desc = "Swap node left",
    },
    {
      "]P",
      function()
        require("treewalker").swap_right()
      end,
      desc = "Swap node right",
    },
  },
}
