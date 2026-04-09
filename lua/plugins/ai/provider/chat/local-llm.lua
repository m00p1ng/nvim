local config = require "plugins.ai.provider.config"
local local_llm = config.local_llm

return {
  { import = "plugins.ai.codecompanion" },
  {
    "codecompanion.nvim",
    optional = true,
    opts = {
      interactions = {
        chat = {
          adapter = "opencode",
          model = local_llm.model,
        },
        inline = {
          adapter = local_llm.name,
        },
      },
      adapters = {
        http = {
          [local_llm.name] = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              schema = {
                model = {
                  default = local_llm.model,
                  name = local_llm.name,
                },
              },
              env = {
                url = local_llm.host,
                api_key = local_llm.api_key,
                chat_url = "/v1/chat/completions",
              },
            })
          end,
        },
      },
    },
  },
}
