local handle_codecompanion = function(buf, wins)
  local markview = require "markview"

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

local chat_title = function()
  local bufnr = vim.api.nvim_get_current_buf()
  ---@diagnostic disable-next-line: undefined-field
  local meta = _G.codecompanion_chat_metadata[bufnr]
  local adapter = meta.adapter
  local name = "Chat: " .. (adapter.name or "LLM")
  local model = adapter.model or "default"

  local mode = meta.mode

  if model ~= "default" then
    name = name .. " %#Comment#(" .. model .. ")%*"
  end

  if mode ~= nil and mode.name ~= "Default" then
    name = name .. " %#SnacksPickerPreviewTitle# " .. mode.name .. " %*"
  end

  return name
end

local llm_title = function()
  local bufnr = vim.api.nvim_get_current_buf()
  ---@diagnostic disable-next-line: undefined-field
  local meta = _G.codecompanion_chat_metadata[bufnr]
  local adapter = meta.adapter
  local name = adapter.name or "LLM"
  local model = adapter.model or "default"

  if model ~= "default" then
    name = name .. " (" .. model .. ")"
  end

  return name
end

return {
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    init = function()
      local icons = require "utils.icons"
      require("utils").add_ui_ft {
        "codecompanion",
        "codecompanion_cli",
      }

      local winbar = require "utils.winbar"
      winbar.add_show_cond(function(opts)
        if vim.startswith(opts.full_filename, "[CodeCompanion]") then
          return true
        end
      end)
      winbar.add_rename_cond(function(opts)
        if opts.ft == "codecompanion" then
          return {
            file_icon = icons.ai.Chat .. " ",
            output_filename = chat_title(),
          }
        end
      end)

      vim.cmd.cab { "cc", "CodeCompanion" }
    end,
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
      interactions = {
        chat = {
          roles = {
            ---The header name for the LLM's messages
            llm = function()
              return llm_title()
            end,

            ---The header name for your messages
            user = vim.env.USER or "Me",
          },
        },
        inline = {
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              opts = { nowait = true },
              description = "Reject the suggested change",
            },
            stop = {
              modes = { n = "q" },
              index = 4,
              callback = "keymaps.stop",
              description = "Stop request",
            },
          },
        },
        shared = {
          keymaps = {
            always_accept = {
              callback = "keymaps.always_accept",
              modes = { n = "gA" },
            },
            accept_change = {
              callback = "keymaps.accept_change",
              modes = { n = "ga" },
            },
            reject_change = {
              callback = "keymaps.reject_change",
              modes = { n = "gr" },
            },
            next_hunk = {
              callback = "keymaps.next_hunk",
              modes = { n = "}" },
            },
            cancel = {
              description = "Cancel all pending tool calls",
              modes = { n = "gR" },
              opts = { nowait = true },
            },
            previous_hunk = {
              callback = "keymaps.previous_hunk",
              modes = { n = "{" },
            },
          },
        },
      },
    },
    keys = {
      { "<leader>ao", "<cmd>lua require('codecompanion').toggle()<cr>", desc = "CodeCompanion: Chat" },
      { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", desc = "CodeCompanion: Add", mode = "v" },
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion: Action", mode = { "n", "v" } },
      { "<leader>ae", "<cmd>CodeCompanion /explain<cr>", desc = "CodeCompanion: Explain", mode = "v" },
      { "<leader>at", "<cmd>CodeCompanion /tests<cr>", desc = "CodeCompanion: Unit test", mode = "v" },
      { "<leader>af", "<cmd>CodeCompanion /fix<cr>", desc = "CodeCompanion: Fix", mode = "v" },
      { "<leader>al", "<cmd>CodeCompanion /lsp<cr>", desc = "CodeCompanion: LSP", mode = "v" },
      {
        "<leader>ap",
        function()
          local prompt = vim.fn.input "Prompt: "
          if prompt ~= "" then
            vim.cmd.CodeCompanion(prompt)
          end
        end,
        desc = "CodeCompanion: Prompt",
        mode = { "n", "v" },
      },
      { "i", "Gi", remap = false, ft = "codecompanion" },
    },
  },

  {
    "markview.nvim",
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

            local ft = vim.bo[buf].ft
            if ft == "codecompanion" then
              handle_codecompanion(buf, wins)
            end
          end,
          on_mode_change = function(buf, wins, current_mode)
            local markview = require "markview"

            local ft = vim.bo[buf].ft
            if ft == "markdown" then
              markview.actions.disable(buf)
            end

            if ft == "codecompanion" then
              handle_codecompanion(buf, wins)
            end
          end,
        },
      },
    },
  },

  {
    "blink.cmp",
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
