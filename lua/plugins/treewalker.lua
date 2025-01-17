return {
  "aaronik/treewalker.nvim",
  opts = {
    highlight = true, -- Whether to briefly highlight the node after jumping to it
  },
  keys = function()
    local function jump_neighbor(options)
      return function()
        require("demicolon.jump").repeatably_do(function(opts)
          local direction = (opts.forward == nil or opts.forward)
          if direction then
            require("treewalker").move_down()
          else
            require("treewalker").move_up()
          end
        end, options)
      end
    end

    local function jump_parent(options)
      return function()
        require("demicolon.jump").repeatably_do(function(opts)
          local direction = (opts.forward == nil or opts.forward)
          if direction then
            require("treewalker").move_out()
          else
            require("treewalker").move_in()
          end
        end, options)
      end
    end

    local function swap_vertical(options)
      return function()
        require("demicolon.jump").repeatably_do(function(opts)
          local direction = (opts.forward == nil or opts.forward)
          if direction then
            require("treewalker").swap_up()
          else
            require("treewalker").swap_down()
          end
        end, options)
      end
    end

    local function swap_horizontal(options)
      return function()
        require("demicolon.jump").repeatably_do(function(opts)
          local direction = (opts.forward == nil or opts.forward)
          if direction then
            require("treewalker").swap_right()
          else
            require("treewalker").swap_left()
          end
        end, options)
      end
    end

    return {
      { "[k", jump_neighbor { forward = false }, mode = { "n", "v" }, desc = "Move up node" },
      { "]k", jump_neighbor { forward = true }, mode = { "n", "v" }, desc = "Move down node" },
      { "]p", jump_parent { forward = false }, mode = { "n", "v" }, desc = "Move child node" },
      { "[p", jump_parent { forward = true }, mode = { "n", "v" }, desc = "Move parent node" },

      { "[K", swap_vertical { forward = false }, desc = "Swap node up" },
      { "]K", swap_vertical { forward = true }, desc = "Swap node down" },
      { "[P", swap_horizontal { forward = false }, desc = "Swap node left" },
      { "]P", swap_horizontal { forward = true }, desc = "Swap node right" },
    }
  end,
}
