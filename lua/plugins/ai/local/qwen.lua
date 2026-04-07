local qwen = {
  model = "qwen3-coder-30b-a3b-instruct-mlx",
  host = "http://localhost:11434",
  api_key = "TERM",
}

return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    opts = function()
      return {
        provider = "openai_compatible",
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 512,
        provider_options = {
          openai_compatible = {
            model = qwen.model,
            system = require("minuet.config").default_system,
            few_shots = require("minuet.config").default_few_shots,
            chat_input = require("minuet.config").default_chat_input,
            stream = true,
            end_point = qwen.host .. "/v1/chat/completions",
            api_key = qwen.api_key,
            name = "Qwen3 Coder",
          },
        },
      }
    end,
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
            score_offset = 8, -- Gives minuet higher priority among suggestions
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
        if ctx.source_id == "minuet" then
          return require("utils.icons").misc.Stars
        end
        return text_func and text_func(ctx) or ctx.kind_icon
      end
    end,
  },

  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    opts = {
      interactions = {
        chat = { adapter = "qwen3_local" },
        inline = { adapter = "qwen3_local" },
      },
      adapters = {
        http = {
          qwen3_local = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              schema = {
                model = {
                  default = qwen.model,
                },
              },
              env = {
                url = qwen.host,
                api_key = qwen.api_key,
                chat_url = "/v1/chat/completions",
              },
            })
          end,
        },
      },
    },
  },
}
