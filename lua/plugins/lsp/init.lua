local icons = require "utils.icons"

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      { "b0o/SchemaStore.nvim", lazy = true },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = true,
        -- virtual_text = { spacing = 4, prefix = "●" },
        virtual_text = true,
        severity_sort = true,
        float = {
          border = "rounded",
          -- wrap_at = 80,
          source = "always",
          header = "",
          -- prefix = "",
        },
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      ---@diagnostic disable-next-line: missing-fields
      servers = {
        lua_ls = require "plugins.lsp.lang.lua_ls",
        tailwindcss = require "plugins.lsp.lang.tailwindcss",
        yamlls = require "plugins.lsp.lang.yamlls",
        jsonls = require "plugins.lsp.lang.jsonls",
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(plugin, opts)
      local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      -- setup keymaps
      require("utils").on_attach(function(client, buffer)
        require("plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      -- diagnostics
      -- for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
      --   name = "DiagnosticSign" .. name
      --   vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      -- end
      vim.diagnostic.config(opts.diagnostics)

      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      --   border = "rounded",
      -- })

      -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      --   border = "rounded",
      -- })
      require("lspconfig.ui.windows").default_options.border = "rounded"
      require("lspconfig.ui.windows").default_opts {
        percentage = 0.8,
      }

      local servers = opts.servers
      local capabilities = require("plugins.lsp.keymaps").capabilities
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local mlsp = require "mason-lspconfig"
      local available = mlsp.get_available_servers()

      local ensure_installed = {
        "bashls",
        "cssls",
        "cssmodules_ls",
        "dockerls",
        "eslint",
        "golangci_lint_ls",
        "gopls",
        "graphql",
        "html",
        "jsonls",
        "pyright",
        "lua_ls",
        "tailwindcss",
        "tsserver",
        "volar",
        "yamlls",
      } ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require("mason-lspconfig").setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
      }
      require("mason-lspconfig").setup_handlers { setup }
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "black",
        "js-debug-adapter",
        "delve",
        "debugpy",
      },
      ui = {
        border = "rounded",
        icons = {
          package_installed = icons.ui.FilledCircle,
          package_pending = icons.ui.FilledCircle,
          package_uninstalled = icons.ui.FilledCircle,
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(plugin, opts)
      require("mason").setup(opts)
      local mr = require "mason-registry"
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },

  {
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
      format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_fallback = true,
        timeout_ms = 500,
      },
      -- If this is set, Conform will run the formatter asynchronously after save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      format_after_save = {
        lsp_fallback = true,
      },
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
  },

  {
    "aznhe21/actions-preview.nvim",
    enabled = false,
  },
}
