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

    local function jump_child(options)
      return function()
        require("demicolon.jump").repeatably_do(function(opts)
          local direction = (opts.forward == nil or opts.forward)
          if direction then
            require("treewalker").move_in()
          else
            require("treewalker").move_out()
          end
        end, options)
      end
    end

    local mode = { "n", "x", "o" }

    return {
      { "<leader><leader>j", jump_neighbor { forward = true }, mode = mode, desc = "Move down to the next neighbor node" },
      { "<leader><leader>k", jump_neighbor { forward = false }, mode = mode, desc = "Move up to the next neighbor node" },
      { "<leader><leader>h", jump_parent { forward = true }, mode = mode, desc = "Finds the next good parent node" },
      { "<leader><leader>l", jump_child { forward = true }, mode = mode, desc = "Finds the next good child node" },
    }
  end,
}
