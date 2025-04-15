local handle_codecompanion = function(buf, wins)
  local markview = require "markview"

  local ft = vim.bo[buf].ft
  if ft == "codecompanion" then
    vim.opt_local.fillchars = { eob = " " }
    markview.actions.hybridDisable(buf)

    for _, win in ipairs(wins) do
      vim.api.nvim_set_option_value(
        "winhl",
        "Normal:CodeCompanionChatNormal,Winbar:CodeCompanionChatNormal",
        { win = win }
      )
    end
  end
end

return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    opts = {
      display = {
        chat = {
          window = {
            width = 0.3,
            opts = {
              number = false,
            },
          },
        },
      },
    },
    init = function()
      local icons = require "utils.icons"
      require("utils").add_ui_ft "codecompanion"

      local winbar = require "utils.winbar"
      winbar.add_show_cond(function(opts)
        if vim.startswith(opts.full_filename, "[CodeCompanion]") then
          return true
        end
      end)
      winbar.add_rename_cond(function(opts)
        if opts.ft == "codecompanion" then
          return {
            file_icon = icons.misc.Copilot .. " ",
            output_filename = "Code Companion: Chat",
          }
        end
      end)

      vim.cmd.cab { "cc", "CodeCompanion" }
    end,
    keys = {
      { "<leader>ao", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion: Chat" },
      { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", desc = "CodeCompanion: Add", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion: Action", mode = { "n", "v" } },
      { "<leader>ae", "<cmd>CodeCompanion /explain<cr>", desc = "CodeCompanion: Explain", mode = { "n", "v" } },
      { "<leader>at", "<cmd>CodeCompanion /tests<cr>", desc = "CodeCompanion: Unit test", mode = { "n", "v" } },
      { "<leader>af", "<cmd>CodeCompanion /fix<cr>", desc = "CodeCompanion: Fix", mode = { "n", "v" } },
      { "<leader>al", "<cmd>CodeCompanion /lsp<cr>", desc = "CodeCompanion: LSP", mode = { "n", "v" } },
      { "i", "Gi", remap = false, ft = "codecompanion" },
    },
  },

  {
    "OXY2DEV/markview.nvim",
    optional = true,
    opts_extend = {
      "preview.filetypes",
      "preview.modes",
      "preview.hybrid_modes",
    },
    opts = {
      preview = {
        filetypes = { "codecompanion" },
        ignore_buftypes = {},
        modes = { "i" },
        hybrid_modes = { "i" },
        callbacks = {
          on_enable = function(buf, wins)
            for _, win in ipairs(wins) do
              vim.wo[win].conceallevel = 3
            end

            handle_codecompanion(buf, wins)
          end,
          on_mode_change = function(buf, wins, current_mode)
            local markview = require "markview"

            local ft = vim.bo[buf].ft
            if ft == "markdown" then
              markview.actions.disable(buf)
            end

            handle_codecompanion(buf, wins)
          end,
        },
      },
    },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    },
  },
}
