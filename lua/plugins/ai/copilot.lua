return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = false,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
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
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
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
      },
      auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
      logger = {
        file = vim.fn.stdpath "log" .. "/copilot-lua.log",
        file_log_level = vim.log.levels.OFF,
        print_log_level = vim.log.levels.WARN,
        trace_lsp = "off", -- "off" | "messages" | "verbose"
        trace_lsp_progress = false,
        log_lsp_messages = false,
      },
      copilot_node_command = "node", -- Node.js version must be > 20
      workspace_folders = {},
      copilot_model = "",
      disable_limit_reached_message = false, -- Set to `true` to suppress completion limit reached popup
      root_dir = function()
        return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
      end,
      -- should_attach = function(_, _)
      --   if not vim.bo.buflisted then
      --     logger.debug "not attaching, buffer is not 'buflisted'"
      --     return false
      --   end
      --
      --   if vim.bo.buftype ~= "" then
      --     logger.debug("not attaching, buffer 'buftype' is " .. vim.bo.buftype)
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
    "saghen/blink.cmp",
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
    "saghen/blink.cmp",
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
}
