return {
  "linrongbin16/gitlinker.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cond = vim.g.vscode == nil,
  opts = function()
    return {
      -- print message in command line
      message = true,

      -- highlights the linked line(s) by the time in ms
      -- disable highlight by setting a value equal or less than 0
      highlight_duration = 500,

      -- user command
      command = {
        -- to copy link to clipboard, use: 'GitLink'
        -- to open link in browser, use bang: 'GitLink!'
        -- to use blame router, use: 'GitLink blame' and 'GitLink! blame'
        name = "GitLink",
        desc = "Generate git permanent link",
      },

      -- router bindings
      router = {
        browse = {
          -- example: https://github.com/linrongbin16/gitlinker.nvim/blob/9679445c7a24783d27063cd65f525f02def5f128/lua/gitlinker.lua#L3-L4
          ["^github%.com"] = "https://github.com/"
            .. "{_A.USER}/"
            .. "{_A.REPO}/blob/"
            .. "{_A.REV}/"
            .. "{_A.FILE}?plain=1" -- '?plain=1'
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
          -- example: https://gitlab.com/linrongbin16/gitlinker.nvim/blob/9679445c7a24783d27063cd65f525f02def5f128/lua/gitlinker.lua#L3-L4
          ["^gitlab%.com"] = "https://gitlab.com/"
            .. "{_A.USER}/"
            .. "{_A.REPO}/blob/"
            .. "{_A.REV}/"
            .. "{_A.FILE}"
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
          -- example: https://bitbucket.org/linrongbin16/gitlinker.nvim/src/9679445c7a24783d27063cd65f525f02def5f128/lua/gitlinker.lua#lines-3:4
          ["^bitbucket%.org"] = "https://bitbucket.org/"
            .. "{_A.USER}/"
            .. "{_A.REPO}/src/"
            .. "{_A.REV}/"
            .. "{_A.FILE}"
            .. "#lines-{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and (':' .. _A.LEND) or '')}",
        },
        blame = {
          -- example: https://github.com/linrongbin16/gitlinker.nvim/blame/9679445c7a24783d27063cd65f525f02def5f128/lua/gitlinker.lua#L3-L4
          ["^github%.com"] = "https://github.com/"
            .. "{_A.USER}/"
            .. "{_A.REPO}/blame/"
            .. "{_A.REV}/"
            .. "{_A.FILE}?plain=1" -- '?plain=1'
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
          -- example: https://gitlab.com/linrongbin16/gitlinker.nvim/blame/9679445c7a24783d27063cd65f525f02def5f128/lua/gitlinker.lua#L3-L4
          ["^gitlab%.com"] = "https://gitlab.com/"
            .. "{_A.USER}/"
            .. "{_A.REPO}/blame/"
            .. "{_A.REV}/"
            .. "{_A.FILE}"
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
          -- example: https://bitbucket.org/linrongbin16/gitlinker.nvim/annotate/9679445c7a24783d27063cd65f525f02def5f128/lua/gitlinker.lua#lines-3:4
          ["^bitbucket%.org"] = "https://bitbucket.org/"
            .. "{_A.USER}/"
            .. "{_A.REPO}/annotate/"
            .. "{_A.REV}/"
            .. "{_A.FILE}"
            .. "#lines-{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and (':' .. _A.LEND) or '')}",
        },
        default_branch = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.USER}/"
            .. "{_A.REPO}/blob/"
            .. "{_A.DEFAULT_BRANCH}/" -- always 'master'/'main' branch
            .. "{_A.FILE}?plain=1" -- '?plain=1'
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
        },
        current_branch = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.USER}/"
            .. "{_A.REPO}/blob/"
            .. "{_A.CURRENT_BRANCH}/" -- always current branch
            .. "{_A.FILE}?plain=1" -- '?plain=1'
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
        },
      },

      -- enable debug
      debug = false,

      -- write logs to console(command line)
      console_log = true,

      -- write logs to file
      file_log = false,
    }
  end,
}
