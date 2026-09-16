return {
  "folke/sidekick.nvim",
  init = function()
    require("utils").add_ui_ft {
      "sidekick_terminal",
    }
  end,
  ---@class sidekick.Config
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
      tools = {
        claude = {
          cmd = { "claude", "--dangerously-skip-permissions" },
        },
      },
      win = {
        keys = {
          buffers = { "<m-b>", "buffers", mode = "nt", desc = "open buffer picker" },
          files = { "<m-f>", "files", mode = "nt", desc = "open file picker" },
          hide_n = { "q", "hide", mode = "n", desc = "hide the terminal window" },
          hide_ctrl_q = { "<c-q>", "hide", mode = "n", desc = "hide the terminal window" },
          hide_ctrl_dot = { "<c-.>", "hide", mode = "nt", desc = "hide the terminal window" },
          hide_ctrl_z = {
            "<c-z>",
            "blur",
            mode = "nt",
            desc = "go back to the previous window without hiding the terminal",
          },
          prompt = { "<m-p>", "prompt", mode = "t", desc = "insert prompt or context" },
          stopinsert = { "<c-q>", "stopinsert", mode = "t", desc = "enter normal mode" },
          normal_cr = { "<cr>", "insert_cr", mode = "n", desc = "send <cr> to the terminal and enter normal mode" },
          -- Navigate windows in terminal mode. Only active when:
          -- * layout is not "float"
          -- * there is another window in the direction
          -- With the default layout of "right", only `<c-h>` will be mapped
          nav_left = { "<c-h>", "nav_left", expr = true, desc = "navigate to the left window" },
          nav_down = { "<c-j>", "nav_down", expr = true, desc = "navigate to the below window" },
          nav_up = { "<c-k>", "nav_up", expr = true, desc = "navigate to the above window" },
          nav_right = { "<c-l>", "nav_right", expr = true, desc = "navigate to the right window" },
        },
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Sidekick: Goto/Apply Next Edit Suggestion",
    },
    {
      "<c-.>",
      function()
        require("sidekick.cli").focus { filter = { installed = true } }
      end,
      desc = "Sidekick: Focus",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").send { msg = "{line}" }
      end,
      mode = { "n" },
      desc = "Sidekick: Send Line",
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").send { msg = "{selection}" }
      end,
      mode = { "x" },
      desc = "Sidekick: Send Selection",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select { filter = { installed = true } }
      end,
      desc = "Sidekick: Select CLI",
    },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Sidekick: Detach a CLI Session",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send { msg = "{this}" }
      end,
      mode = { "x", "n" },
      desc = "Sidekick: Send This",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send { msg = "{file}" }
      end,
      desc = "Sidekick: Send File",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Sidekick: Select Prompt",
    },
    -- Example of a keybinding to open Claude directly
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle { name = "claude", focus = true }
      end,
      desc = "Sidekick: Toggle Claude",
    },
    {
      "<leader>ax",
      function()
        require("sidekick.cli").toggle { name = "codex", focus = true }
      end,
      desc = "Sidekick: Toggle Codex",
    },
  },
}
