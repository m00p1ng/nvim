return {
  "linrongbin16/gitlinker.nvim",
  lazy = true,
  opts = function()
    return {
      -- print message in command line
      message = true,

      -- key mapping
      mapping = false,

      -- regex pattern based rules
      pattern_rules = {
        {
          ["^git@github%.([_%.%-%w]+):([%.%-%w]+)/([_%.%-%w]+)%.git$"] = "https://github.%1/%2/%3/blob/",
          ["^https?://github%.([_%.%-%w]+)/([%.%-%w]+)/([_%.%-%w]+)%.git$"] = "https://github.%1/%2/%3/blob/",
          ["^git@gitlab%.([_%.%-%w]+):([%.%-%w]+)/([_%.%-%w]+)%.git$"] = "https://gitlab.%1/%2/%3/blob/",
          ["^https?://gitlab%.([_%.%-%w]+)/([%.%-%w]+)/([_%.%-%w]+)%.git$"] = "https://gitlab.%1/%2/%3/blob/",
        },
        {
          ["^git@github%.([_%.%-%w]+):([%.%-%w]+)/([_%.%-%w]+)$"] = "https://github.%1/%2/%3/blob/",
          ["^https?://github%.([_%.%-%w]+)/([%.%-%w]+)/([_%.%-%w]+)$"] = "https://github.%1/%2/%3/blob/",
          ["^git@gitlab%.([_%.%-%w]+):([%.%-%w]+)/([_%.%-%w]+)$"] = "https://gitlab.%1/%2/%3/blob/",
          ["^https?://gitlab%.([_%.%-%w]+)/([%.%-%w]+)/([_%.%-%w]+)$"] = "https://gitlab.%1/%2/%3/blob/",
        },
      },

      -- function based rules: function(remote_url) => host_url.
      -- this function will override the `pattern_rules`.
      -- here's an example of custom_rules:
      --
      -- ```
      -- custom_rules = function(remote_url)
      --   local pattern_rules = {
      --     {
      --       ["^git@github%.([_%.%-%w]+):([%.%-%w]+)/([%.%-%w]+)%.git$"] = "https://github.%1/%2/%3/blob/",
      --       ["^https://github%.([_%.%-%w]+)/([%.%-%w]+)/([%.%-%w]+)%.git$"] = "https://github.%1/%2/%3/blob/",
      --     },
      --     -- http(s)://github.(com|*)/linrongbin16/gitlinker.nvim(.git)? -> https://github.com/linrongbin16/gitlinker.nvim(.git)?
      --     {
      --       ["^git@github%.([_%.%-%w]+):([%.%-%w]+)/([%.%-%w]+)$"] = "https://github.%1/%2/%3/blob/",
      --       ["^https://github%.([_%.%-%w]+)/([%.%-%w]+)/([%.%-%w]+)$"] = "https://github.%1/%2/%3/blob/",
      --     },
      --   }
      --   for _, group in ipairs(pattern_rules) do
      --     for pattern, replace in pairs(group) do
      --       if string.match(remote_url, pattern) then
      --         local result = string.gsub(remote_url, pattern, replace)
      --         return result
      --       end
      --     end
      --   end
      --   return nil
      -- end,
      -- ```
      --
      --- @overload fun(remote_url:string):string|nil
      custom_rules = nil,


      -- enable debug
      debug = false,

      -- write logs to console(command line)
      console_log = true,

      -- write logs to file
      file_log = false,
    }
  end,
}
