return {
  "stevearc/conform.nvim",
  event = "BufReadPost",
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
      if not vim.g.autoformat or (vim.b[bufnr].autoformat ~= nil and not vim.b[bufnr].autoformat) then
        return
      end

      if vim.tbl_contains(vim.g.autoformat_ignore_filetypes, vim.bo[bufnr].ft) then
        return
      end

      -- I recommend these options. See :help conform.format for details.
      return { lsp_fallback = true, timeout_ms = 500 }
    end,
    -- If this is set, Conform will run the formatter asynchronously after save.
    -- It will pass the table to conform.format().
    -- This can also be a function that returns the table.
    format_after_save = function(bufnr)
      if not vim.g.autoformat or (vim.b[bufnr].autoformat ~= nil and not vim.b[bufnr].autoformat) then
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
      black = {
        prepend_args = { "--fast", "--line-length", "120" },
      },
    },
  },
  init = function()
    vim.g.autoformat = true
    vim.g.autoformat_ignore_filetypes = {}

    vim.api.nvim_create_user_command("FormatToggle", function(args)
      if args.bang then
        if vim.b.autoformat == nil then
          vim.b.autoformat = true
        end

        vim.b.autoformat = not vim.b.autoformat
      else
        vim.g.autoformat = not vim.g.autoformat
      end
    end, { desc = "Toggle autoformat", bang = true })
  end,
  keys = {
    { "<leader>lf", "<cmd>lua require('conform').format({async = true, lsp_fallback = true})<cr>", desc = "Format" },
    { "<leader>lk", "<cmd>FormatToggle<cr>", desc = "Toggle Format" },
    { "<leader>lK", "<cmd>FormatToggle!<cr>", desc = "Toggle Format (Buffer)" },
  },
}
