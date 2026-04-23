local config = require "plugins.ai.provider.config"
local local_llm = config.local_llm

return {
  "codecompanion.nvim",
  optional = true,
  opts = {
    adapters = {
      http = {
        local_llm = function()
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
}
