local icons = require "utils.icons"

return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/lazydev.nvim", ft = "lua", opts = {} },
      { "b0o/SchemaStore.nvim", lazy = true },
      { "hinell/lsp-timeout.nvim", enabled = false },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "ray-x/lsp_signature.nvim",
      { "antosha417/nvim-lsp-file-operations", event = "LspAttach", opts = {} },
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
        gopls = require "plugins.lsp.lang.gopls",
        ts_ls = require "plugins.lsp.lang.ts_ls",
        nixd = require "plugins.lsp.lang.nixd",
        volar = require "plugins.lsp.lang.volar",
        vtsls = require "plugins.lsp.lang.vtsls",
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
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf ---@type number
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("plugins.lsp.keymaps").on_attach(client, buffer)
        end,
      })

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
      require("lspconfig.ui.windows").default_options.percentage = 0.8

      local function should_skip_setup(server)
        if vim.g.vue_version == nil and vim.tbl_contains({ "volar", "vtsls" }, server) then
          return true
        end

        if vim.g.vue_version == 3 and vim.tbl_contains({ "ts_ls", "vtsls" }, server) then
          return true
        end

        if vim.g.vue_version == 2 and vim.tbl_contains({ "ts_ls", "volar" }, server) then
          return true
        end

        return false
      end

      local servers = opts.servers
      local capabilities = require("plugins.lsp.keymaps").capabilities
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if should_skip_setup(server) then
          return
        end

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
        "ts_ls",
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
    keys = {
      -- https://github.com/neovim/nvim-lspconfig/pull/3339
      { "<leader>li", "<cmd>check lspconfig<cr>", desc = "Info" },
      { "<leader>lR", "<cmd>LspRestart<cr>", desc = "Restart" },
    },
  },

  { import = "plugins.lsp.conform" },
  { import = "plugins.lsp.mason" },
  { import = "plugins.lsp.lsp_signature" },
}
