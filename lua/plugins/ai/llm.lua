local ollama_config = {
  model = "qwen2.5-coder:7b",
  host = "http://localhost:11434",
  completion_host = "http://localhost:11434/v1/completions",
  api_key = "TERM",
}

local config = {
  model = ollama_config.model,
  host = ollama_config.host,
  completion_host = ollama_config.completion_host,
  api_key = ollama_config.api_key,
}

return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    opts = {
      provider = "openai_fim_compatible",
      n_completions = 1, -- recommend for local model for resource saving
      -- I recommend beginning with a small context window size and incrementally
      -- expanding it, depending on your local computing power. A context window
      -- of 512, serves as an good starting point to estimate your computing
      -- power. Once you have a reliable estimate of your local computing power,
      -- you should adjust the context window to a larger value.
      context_window = 512,
      provider_options = {
        openai_fim_compatible = {
          api_key = config.api_key,
          name = "Ollama",
          end_point = config.completion_host,
          model = config.model,
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },
    },
  },

  {
    "saghen/blink.cmp",
    optional = true,
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
    opts_extend = { "sources.default" },
  },
  {
    "saghen/blink.cmp",
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
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = config.model,
              },
            },
            env = {
              url = config.host,
              api_key = config.api_key,
            },
            headers = {
              ["Content-Type"] = "application/json",
            },
            parameters = {
              sync = true,
            },
          })
        end,
      },
    },
  },
}
