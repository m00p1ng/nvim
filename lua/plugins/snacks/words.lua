return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    words = {
      debounce = 500, -- time in ms to wait before updating
      notify_jump = false, -- show a notification when jumping
      notify_end = true, -- show a notification when reaching the end
      foldopen = true, -- open folds after jumping
      jumplist = true, -- set jump point before jumping
      modes = { "n", "i", "c" }, -- modes to show references
    },
  },
  keys = {
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1, true)
      end,
      desc = "Next Reference",
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1, true)
      end,
      desc = "Prev Reference",
    },
  },
}
