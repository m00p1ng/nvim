local f = require "utils"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts_extend = { "ensure_installed" },
    opts = {
      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
      ensure_installed = { "regex" },
    },
    config = function(_, opts)
      if vim.fn.executable "tree-sitter" == 0 then
        vim.notify("**treesitter-main** requires the `tree-sitter` executable to be installed", vim.log.levels.ERROR)
        return
      end

      local TS = require "nvim-treesitter"
      TS.setup(opts)

      local needed = opts.ensure_installed
      local installed = TS.get_installed "parsers"

      local install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, needed)

      if #install > 0 then
        TS.install(install, { summary = true })
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
        callback = function(ev)
          local ft = ev.match

          if f.is_ui_filetype(ft) then
            return
          end

          local parser_name = vim.treesitter.language.get_lang(ft)
          if not parser_name then
            vim.notify(vim.inspect("No treesitter parser found for filetype: " .. ft), vim.log.levels.WARN)
            return
          end

          -- Try to get existing parser
          local parser_configs = require "nvim-treesitter.parsers"
          if not parser_configs[parser_name] then
            return -- Parser not available, skip silently
          end

          local parser_exists = pcall(vim.treesitter.get_parser, ev.buf, parser_name)
          if not parser_exists and not vim.tbl_contains(installed, parser_name) then
            TS.install({ parser_name }, { summary = true }):wait()
          end

          -- highlighting
          pcall(vim.treesitter.start, ev.buf)
          -- https://github.com/akinsho/flutter-tools.nvim/issues/267#issuecomment-1616728174
          -- NOTE: enabling indentation significantly slows down editing in Dart files
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["is"] = "@statement.inner",
          ["as"] = "@statement.outer",
          ["ad"] = "@comment.outer",
          ["am"] = "@call.outer",
          ["im"] = "@call.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        keys = {
          goto_next_start = {
            ["]m"] = "@function.outer",
            -- ["]]"] = "@class.outer",
            ["]a"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            -- ["]["] = "@class.outer",
            ["]A"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            -- ["[["] = "@class.outer",
            ["[a"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            -- ["[]"] = "@class.outer",
            ["[A"] = "@parameter.inner",
          },
        },
      },
    },
    config = function(_, opts)
      local TS = require "nvim-treesitter-textobjects"
      TS.setup(opts)

      local function description(key, query, direction)
        local queries = type(query) == "table" and query or { query }
        local parts = {}
        for _, q in ipairs(queries) do
          local part = q:gsub("@", ""):gsub("%..*", "")
          part = part:sub(1, 1):upper() .. part:sub(2)
          table.insert(parts, part)
        end
        local desc = table.concat(parts, " or ")
        if direction then
          desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
          desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
        end
        return desc
      end

      local function attach(buf)
        if vim.tbl_get(opts, "move", "enable") then
          ---@type table<string, table<string, string>>
          local moves = vim.tbl_get(opts, "move", "keys") or {}

          for method, keymaps in pairs(moves) do
            for key, query in pairs(keymaps) do
              vim.keymap.set({ "n", "x", "o" }, key, function()
                if vim.wo.diff and key:find "[cC]" then
                  return vim.cmd("normal! " .. key)
                end
                require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
              end, {
                -- buffer = buf,
                desc = description(key, query, true),
                silent = true,
              })
            end
          end
        end

        if vim.tbl_get(opts, "select", "enable") then
          ---@type table<string, string>
          local selects = vim.tbl_get(opts, "select", "keymaps") or {}

          for key, query in pairs(selects) do
            vim.keymap.set({ "x", "o" }, key, function()
              if vim.wo.diff and key:find "[cC]" then
                return vim.cmd("normal! " .. key)
              end
              require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
            end, {
              -- buffer = buf,
              desc = description(key, query, false),
              silent = true,
            })
          end
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
        callback = function(ev)
          attach(ev.buf)
        end,
      })
      vim.tbl_map(attach, vim.api.nvim_list_bufs())
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    enabled = false,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "codecompanion" },
        command = "TSContext disable",
      })
    end,
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = false, -- Enable multiwindow support.
      max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
  },
}
