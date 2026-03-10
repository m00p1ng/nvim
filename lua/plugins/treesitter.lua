local f = require "utils"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- commit = "35a60f093fa15a303874975f963428a5cd24e4a0",
      },
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts_extend = { "ensure_installed" },
    opts = {
      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
      ensure_installed = { "regex" },
    },
    config = function(_, opts)
      if vim.fn.executable "tree-sitter" == 0 then
        vim.notify("**treesitter-main** requires the `tree-sitter` executable to be installed", "error")
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

          if not vim.tbl_contains(installed, ft) then
            TS.install({ ft }, { summary = true }):wait()
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
                buffer = buf,
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
            vim.keymap.set({ "n", "x", "o" }, key, function()
              if vim.wo.diff and key:find "[cC]" then
                return vim.cmd("normal! " .. key)
              end
              require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
            end, {
              buffer = buf,
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
}
