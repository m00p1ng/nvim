return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = {
    -- Map of filetype to formatters
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      -- javascript = { { "prettierd", "prettier" } },
      -- Use the "*" filetype to run formatters on all filetypes.
      -- Note that if you use this, you may want to set lsp_fallback = "always"
      -- (see :help conform.format)
      -- ["*"] = { "codespell" },
      -- Use the "_" filetype to run formatters on all filetypes
      -- that don't have other formatters configured. Again, you may want to
      -- set lsp_fallback = "always" when using this value.
      -- ["_"] = { "trim_whitespace" },
    },
    -- If this is set, Conform will run the formatter on save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      local ignore_filetypes = {}
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end

      -- I recommend these options. See :help conform.format for details.
      return { lsp_fallback = true, timeout_ms = 500 }
    end,
    -- If this is set, Conform will run the formatter asynchronously after save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    format_after_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- ...additional logic...
      return { lsp_fallback = true }
    end,
    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
    log_level = vim.log.levels.ERROR,
    -- Conform will notify you when a formatter errors
    notify_on_error = true,
    -- Define custom formatters here
    formatters = {
      -- my_formatter = {
      --   -- This can be a string or a function that returns a string
      --   command = "my_cmd",
      --   -- OPTIONAL - all fields below this are optional
      --   -- A list of strings, or a function that returns a list of strings
      --   -- Return a single string instead to run the command in a shell
      --   args = { "--stdin-from-filename", "$FILENAME" },
      --   -- If the formatter supports range formatting, create the range arguments here
      --   range_args = function(ctx)
      --     return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
      --   end,
      --   -- Send file contents to stdin, read new contents from stdout (default true)
      --   -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
      --   -- file is assumed to be modified in-place by the format command.
      --   stdin = true,
      --   -- A function that calculates the directory to run the command in
      --   cwd = require("conform.util").root_file { ".editorconfig", "package.json" },
      --   -- When cwd is not found, don't run the formatter (default false)
      --   require_cwd = true,
      --   -- When returns false, the formatter will not be used
      --   condition = function(ctx)
      --     return vim.fs.basename(ctx.filename) ~= "README.md"
      --   end,
      --   -- Exit codes that indicate success (default {0})
      --   exit_codes = { 0, 1 },
      --   -- Environment variables. This can also be a function that returns a table.
      --   env = {
      --     VAR = "value",
      --   },
      -- },
      -- These can also be a function that returns the formatter
      -- other_formatter = function()
      --   return {
      --     command = "my_cmd",
      --   }
      -- end,
    },
  },
  init = function()
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}
