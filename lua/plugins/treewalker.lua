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

    return {
      { "]k", jump_neighbor { forward = true }, mode = { "n", "v" }, desc = "Move down to the next neighbor node" },
      { "[k", jump_neighbor { forward = false }, mode = { "n", "v" }, desc = "Move up to the next neighbor node" },
      { "[p", jump_parent { forward = true }, mode = { "n", "v" }, desc = "Finds the next good parent node" },
      { "]p", jump_parent { forward = false }, mode = { "n", "v" }, desc = "Finds the next good child node" },
    }
  end,
}
