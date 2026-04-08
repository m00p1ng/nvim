return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    init = function()
      local has_snacks, snacks = pcall(require, "snacks")
      if not has_snacks then
        return
      end
      local c = require "copilot.client"
      local cmd = require "copilot.command"

      snacks
        .toggle({
          name = "GitHub Copilot",
          get = function()
            return not c.is_disabled()
          end,
          set = function(state)
            if state then
              cmd.enable()
            else
              cmd.disable()
            end
          end,
        })
        :map "<leader>oa"
    end,
    opts = {
      panel = {
        enabled = false,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<cr>",
          refresh = "gr",
          open = "<a-cr>",
        },
        layout = {
          position = "bottom", -- | top | left | right | bottom |
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        trigger_on_accept = true,
        keymap = {
          accept = "<c-f>",
          accept_word = false,
          accept_line = false,
          next = "<a-]>",
          prev = "<a-[>",
          dismiss = "<c-]>",
          toggle_auto_trigger = false,
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
        env = false,
      },
      nes = {
        enabled = false, -- requires copilot-lsp as a dependency
        auto_trigger = false,
        keymap = {
          accept_and_goto = false,
          accept = false,
          dismiss = false,
        },
      },
      auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
      logger = {
        file = vim.fn.stdpath "log" .. "/copilot-lua.log",
        file_log_level = vim.log.levels.OFF,
        print_log_level = vim.log.levels.WARN,
        trace_lsp = "off", -- "off" | "debug" | "verbose"
        trace_lsp_progress = false,
        log_lsp_messages = false,
      },
      copilot_node_command = "node", -- Node.js version must be > 22
      workspace_folders = {},
      copilot_model = "",
      disable_limit_reached_message = false, -- Set to `true` to suppress completion limit reached popup
      root_dir = function()
        return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
      end,
      -- should_attach = function(buf_id, _)
      --   if not vim.bo[buf_id].buflisted then
      --     -- logger.debug "not attaching, buffer is not 'buflisted'"
      --     return false
      --   end
      --
      --   if vim.bo[buf_id].buftype ~= "" then
      --     -- logger.debug("not attaching, buffer 'buftype' is " .. vim.bo[buf_id].buftype)
      --     return false
      --   end
      --
      --   return true
      -- end,
      server = {
        type = "nodejs", -- "nodejs" | "binary"
        custom_server_filepath = nil,
      },
      server_opts_overrides = {},
    },
  },

  {
    "blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    opts_extend = { "sources.default" },
    opts = {
      keymap = {
        ["<a-y>"] = {
          function(cmp)
            cmp.show { providers = { "copilot" } }
          end,
        },
      },
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
  {
    "blink.cmp",
    optional = true,
    opts = function(_, opts)
      local text_func = opts.completion.menu.draw.components.kind_icon.text

      opts.completion.menu.draw.components.kind_icon.text = function(ctx)
        if ctx.source_id == "copilot" then
          return require("utils.icons").misc.Stars
        end
        return text_func and text_func(ctx) or ctx.kind_icon
      end
    end,
  },

  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    optional = true,
    opts = {
      adapters = {
        acp = {
          -- NOTE: https://github.com/olimorris/codecompanion.nvim/issues/2969#issuecomment-4185096133
          copilot_acp = function()
            return require("codecompanion.adapters").extend("copilot_acp", {
              defaults = {
                model = "gpt-5-mini",
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "copilot_acp",
          model = "gpt-5-mini",
        },
        inline = {
          adapter = "copilot",
          model = "claude-sonnet-4.6",
        },
        cli = {
          agent = "copilot",
          agents = {
            copilot = {
              cmd = "copilot",
              args = {},
              description = "GitHub Copilot CLI",
              provider = "terminal",
            },
          },
        },
      },
    },
  },
}
