return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    words = {
      debounce = 300, -- time in ms to wait before updating
      notify_jump = false, -- show a notification when jumping
      notify_end = true, -- show a notification when reaching the end
      foldopen = true, -- open folds after jumping
      jumplist = true, -- set jump point before jumping
      modes = { "n", "i", "c" }, -- modes to show references
    },
  },
  keys = function(_, keys)
    local function jump_reference(options)
      return function()
        require("demicolon.jump").repeatably_do(function(opts)
          local direction = (opts.forward == nil or opts.forward)
          if direction then
            Snacks.words.jump(vim.v.count1, true)
          else
            Snacks.words.jump(-vim.v.count1, true)
          end
        end, options)
      end
    end

    local k = {
      { "]]", jump_reference { forward = true }, desc = "Next Reference" },
      { "[[", jump_reference { forward = false }, desc = "Prev Reference" },
    }

    for _, val in ipairs(k) do
      keys[#keys + 1] = val
    end

    return keys
  end,
}
