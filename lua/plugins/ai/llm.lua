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
          api_key = "TERM",
          name = "Ollama",
          end_point = "http://localhost:11434/v1/completions",
          model = "qwen2.5-coder:7b",
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
}
