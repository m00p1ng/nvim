return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    opts = {
      virtualtext = {
        -- Specify the filetypes to enable automatic virtual text completion,
        -- e.g., { 'python', 'lua' }. Note that you can still invoke manual
        -- completion even if the filetype is not on your auto_trigger_ft list.
        auto_trigger_ft = { "*" },
        -- specify file types where automatic virtual text completion should be
        -- disabled. This option is useful when auto-completion is enabled for
        -- all file types i.e., when auto_trigger_ft = { '*' }
        auto_trigger_ignore_ft = require("utils").ui_filetypes,
        keymap = {
          -- accept whole completion
          accept = "<c-f>",
          -- accept one line
          accept_line = "<a-a>",
          -- accept n lines (prompts for number)
          -- e.g. "A-z 2 CR" will accept 2 lines
          accept_n_lines = "<a-z>",
          -- Cycle to prev completion item, or manually invoke completion
          prev = "<a-[>",
          -- Cycle to next completion item, or manually invoke completion
          next = "<a-]>",
          dismiss = "<c-]>",
        },
        -- Whether show virtual text suggestion when the completion menu
        -- (nvim-cmp or blink-cmp) is visible.
        show_on_completion_menu = true,
      },
    },
  },

  {
    "blink.cmp",
    optional = true,
    opts_extend = { "sources.default" },
    opts = {
      keymap = {
        -- Manually invoke minuet completion.
        ["<a-y>"] = {
          function(cmp)
            cmp.show { providers = { "minuet" } }
          end,
        },
      },
      sources = {
        -- Enable minuet for autocomplete
        default = { "minuet" },
        -- For manual completion only, remove 'minuet' from default
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            async = true,
            -- Should match minuet.config.request_timeout * 1000,
            -- since minuet.config.request_timeout is in seconds
            timeout_ms = 3000,
            score_offset = 50, -- Gives minuet higher priority among suggestions
          },
        },
      },
      completion = { trigger = { prefetch_on_insert = false } },
    },
  },
  {
    "blink.cmp",
    optional = true,
    opts = function(_, opts)
      local text_func = opts.completion.menu.draw.components.kind_icon.text

      opts.completion.menu.draw.components.kind_icon.text = function(ctx)
        if ctx.source_id == "minuet" then
          return require("utils.icons").ai.Stars
        end
        return text_func and text_func(ctx) or ctx.kind_icon
      end
    end,
  },
}
