return {
  "y3owk1n/undo-glow.nvim",
  event = { "VeryLazy" },
  init = function()
    vim.api.nvim_create_autocmd("TextYankPost", {
      desc = "Highlight when yanking (copying) text",
      callback = function()
        require("undo-glow").yank()
      end,
    })

    vim.api.nvim_create_autocmd("CmdLineLeave", {
      pattern = { "/", "?" },
      desc = "Highlight when search cmdline leave",
      callback = function()
        require("undo-glow").search_cmd {
          animation = {
            animation_type = "fade",
          },
        }
      end,
    })
  end,
  ---@type UndoGlow.Config
  opts = {
    animation = {
      enabled = true,
      duration = 300,
      animation_type = "zoom",
      window_scoped = true,
    },
    highlights = {
      undo = {
        hl_color = { bg = "#693232" }, -- Dark muted red
      },
      redo = {
        hl_color = { bg = "#2F4640" }, -- Dark muted green
      },
      yank = {
        hl_color = { bg = "#7A683A" }, -- Dark muted yellow
      },
      paste = {
        hl_color = { bg = "#325B5B" }, -- Dark muted cyan
      },
      search = {
        hl_color = { bg = "#5C475C" }, -- Dark muted purple
      },
      comment = {
        hl_color = { bg = "#7A5A3D" }, -- Dark muted orange
      },
      cursor = {
        hl_color = { bg = "#793D54" }, -- Dark muted pink
      },
    },
    priority = 2048 * 3,
  },
  keys = {
    {
      "u",
      function()
        require("undo-glow").undo()
      end,
      mode = "n",
      desc = "Undo with highlight",
      noremap = true,
    },
    {
      "<c-r>",
      function()
        require("undo-glow").redo()
      end,
      mode = "n",
      desc = "Redo with highlight",
      noremap = true,
    },
    {
      "p",
      function()
        require("undo-glow").paste_below()
      end,
      mode = "n",
      desc = "Paste below with highlight",
      noremap = true,
    },
    {
      "P",
      function()
        require("undo-glow").paste_above()
      end,
      mode = "n",
      desc = "Paste above with highlight",
      noremap = true,
    },
    {
      "gc",
      function()
        -- This is an implementation to preserve the cursor position
        local pos = vim.fn.getpos "."
        vim.schedule(function()
          vim.fn.setpos(".", pos)
        end)
        return require("undo-glow").comment()
      end,
      mode = { "n", "x" },
      desc = "Toggle comment with highlight",
      expr = true,
      noremap = true,
    },
    {
      "gc",
      function()
        require("undo-glow").comment_textobject()
      end,
      mode = "o",
      desc = "Comment textobject with highlight",
      noremap = true,
    },
    {
      "gcc",
      function()
        return require("undo-glow").comment_line()
      end,
      mode = "n",
      desc = "Toggle comment line with highlight",
      expr = true,
      noremap = true,
    },
  },
}
