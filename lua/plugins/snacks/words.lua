return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    words = {
      debounce = 200, -- time in ms to wait before updating
      notify_jump = false, -- show a notification when jumping
      notify_end = true, -- show a notification when reaching the end
      foldopen = true, -- open folds after jumping
      jumplist = true, -- set jump point before jumping
      modes = { "n", "i", "c" }, -- modes to show references
    },
  },
  keys = {
    {
      "]r",
      function()
        require("snacks").words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
    },
    {
      "[r",
      function()
        require("snacks").words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
    },
  },
}
