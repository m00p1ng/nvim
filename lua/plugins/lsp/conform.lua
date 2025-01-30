return {
  "stevearc/conform.nvim",
  event = "BufReadPost",
  opts = {
    -- Map of filetype to formatters
    formatters_by_ft = {},
    -- Set this to change the default values when calling conform.format()
    -- This will also affect the default values for format_on_save/format_after_save
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- If this is set, Conform will run the formatter on save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    format_on_save = nil,
    -- If this is set, Conform will run the formatter asynchronously after save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    format_after_save = function(bufnr)
      if not vim.g.autoformat or (vim.b[bufnr].autoformat ~= nil and not vim.b[bufnr].autoformat) then
        return
      end

      if vim.tbl_contains(vim.g.autoformat_ignore_filetypes, vim.bo[bufnr].ft) then
        return
      end

      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match "/node_modules/" then
        return
      end

      -- ...additional logic...
      return {}
    end,
    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
    log_level = vim.log.levels.ERROR,
    -- Conform will notify you when a formatter errors
    notify_on_error = true,
    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,
    -- Custom formatters and overrides for built-in formatters
    formatters = {},
  },
  init = function()
    local function snack_toggle(buf)
      return require("snacks").toggle {
        name = "Auto Format (" .. (buf and "Buffer" or "Global") .. ")",
        get = function()
          if vim.b.autoformat == nil then
            vim.b.autoformat = vim.g.autoformat
          end

          if buf then
            return vim.b.autoformat
          else
            return vim.g.autoformat
          end
        end,
        set = function(state)
          if buf then
            vim.b.autoformat = state
          else
            vim.g.autoformat = state
          end
        end,
      }
    end

    snack_toggle(true):map "<leader>of"
    snack_toggle(false):map "<leader>oF"

    -- vim.api.nvim_create_user_command("FormatToggle", function(args)
    --   if args.bang then
    --     if vim.b.autoformat == nil then
    --       vim.b.autoformat = true
    --     end
    --
    --     vim.b.autoformat = not vim.b.autoformat
    --   else
    --     vim.g.autoformat = not vim.g.autoformat
    --   end
    -- end, { desc = "Toggle autoformat", bang = true })
  end,
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = { "n", "v" },
      desc = "Format",
    },
    -- { "<leader>lk", "<cmd>FormatToggle<cr>", desc = "Toggle Format" },
    -- { "<leader>lK", "<cmd>FormatToggle!<cr>", desc = "Toggle Format (Buffer)" },
  },
}
