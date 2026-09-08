return {
  "folke/sidekick.nvim",
  init = function()
    require("utils").add_ui_ft {
      "sidekick_terminal",
    }
  end,
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = "tmux",
        enabled = true,
      },
    },
  },
  keys = {
    -- {
    --   "<tab>",
    --   function()
    --     -- if there is a next edit, jump to it, otherwise apply it if any
    --     if not require("sidekick").nes_jump_or_apply() then
    --       return "<Tab>" -- fallback to normal tab
    --     end
    --   end,
    --   expr = true,
    --   desc = "Goto/Apply Next Edit Suggestion",
    -- },
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
