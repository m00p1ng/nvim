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

local model_title = function(model, thought_level, mode)
  local output = ""
  if model ~= nil and model:lower() ~= "default" then
    output = output .. "%#CodeCompanionChatWinbarModel#(" .. model .. ")%*%="

    if thought_level ~= nil and thought_level:lower() ~= "default" then
      output = output .. "%#CodeCompanionChatWinbarThoughtLevel# " .. thought_level .. " %* "
    end
  end

  if mode ~= nil and mode:lower() ~= "default" then
    output = output .. "%#CodeCompanionChatWinbarMode# " .. mode .. " %*"
  end

  return output
end

local parse_opencode_string = function(input)
  local provider, model, thought_level = input:match "^([^/]+)/([^%(]+)%s*%(([^)]+)%)%s*$"
  if not provider then
    provider, model = input:match "^([^/]+)/(.+)$"
  end
  return {
    provider = provider,
    model = model and vim.trim(model),
    thought_level = thought_level,
  }
end

local chat_title = function()
  local bufnr = vim.api.nvim_get_current_buf()
  ---@diagnostic disable-next-line: undefined-field
  local meta = _G.codecompanion_chat_metadata[bufnr] or {}
  local adapter = meta.adapter or {}
  local options = meta.config_options or {}
  local name = adapter.name or "LLM"

  local title = model_title(
    options.model and options.model.name,
    options.thought_level and options.thought_level.name,
    options.mode and options.mode.name
  )

  if adapter.name == "OpenCode" and options.model then
    local parsed = parse_opencode_string(options.model.name)
    if parsed then
      title = "%#CodeCompanionChatWinbarSeparator#" .. parsed.provider .. "%* "
      title = title .. model_title(parsed.model, parsed.thought_level, options.mode and options.mode.name)
    end
  end

  name = name .. " " .. title

  return name
end

local llm_title = function()
  local bufnr = vim.api.nvim_get_current_buf()
  ---@diagnostic disable-next-line: undefined-field
  local meta = _G.codecompanion_chat_metadata[bufnr] or {}
  local adapter = meta.adapter or {}
  local options = meta.config_options or {}
  local name = adapter.name or "LLM"
  local model = options.model

  if model ~= nil and model.name ~= "Default" then
    name = name .. " (" .. model.name .. ")"
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
        if opts.ft == "codecompanion" then
          return true
        end
      end)
      winbar.add_rename_cond(function(opts)
        if opts.ft == "codecompanion" then
          return {
            file_icon = " " .. icons.ai.Chat .. " ",
            hl_icon = "CodeCompanionChatWinbarIcon",
            output_filename = chat_title(),
          }
        end
      end)

      vim.cmd.cab { "cc", "CodeCompanion" }
    end,
    opts = {
      display = {
        action_palette = {
          provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
        },
        chat = {
          window = {
            width = 0.3,
            opts = {
              number = false,
            },
          },
        },
      },
      adapters = {
        acp = {
          opts = {
            show_presets = false,
          },
        },
        http = {
          opts = {
            show_presets = false,
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
          slash_commands = {
            ["acp_session_options"] = {
              keymaps = {
                modes = {
                  n = "<Tab>",
                },
              },
            },
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
        "<leader>am",
        function()
          local chat = require("codecompanion").buf_get_chat(0)
          require("codecompanion.interactions.chat.keymaps.change_adapter").select_model(chat)
        end,
        noremap = true,
        ft = "codecompanion",
        desc = "CodeCompanion: Change model",
        mode = "n",
      },
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
      -- { "i", "Gi", remap = false, ft = "codecompanion" },
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
    opts = function(_, opts)
      local preselect = opts.completion.list.selection.preselect
      vim.list_extend(opts.sources.default or {}, { "fuzzy-path" })

      return vim.tbl_deep_extend("force", opts, {
        sources = {
          per_filetype = {
            codecompanion = { "fuzzy-path", "codecompanion" },
          },
          providers = {
            ["fuzzy-path"] = {
              name = "Fuzzy Path",
              module = "blink-cmp-fuzzy-path",
              score_offset = 0,
              opts = {
                filetypes = { "markdown", "codecompanion" },
                trigger_char = "@",
                max_results = 5,
              },
            },
          },
        },
        completion = {
          list = {
            selection = {
              preselect = function()
                if vim.bo.filetype == "codecompanion" then
                  return true
                end

                return preselect
              end,
            },
          },
        },
      })
    end,
  },
  {
    "newtoallofthis123/blink-cmp-fuzzy-path",
    dependencies = { "saghen/blink.cmp" },
    opts = {},
  },
}
