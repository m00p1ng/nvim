return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              hints = {
                -- assignVariableTypes = true,
                -- compositeLiteralFields = true,
                -- compositeLiteralTypes = true,
                -- constantValues = true,
                -- functionTypeParameters = true,
                parameterNames = true,
                -- rangeVariableTypes = true,
              },
            },
          },
        },
        golangci_lint_ls = {},
      },
      setup = {
        gopls = function(_, opts)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          require("utils.lsp").on_attach(function(client, _)
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end, "gopls")
          -- end workaround
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "go", "gomod", "gowork", "gosum" } },
  },
  {
    "williamboman/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "delve" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
      },
    },
  },
  { "leoluz/nvim-dap-go", ft = "go" },
  {
    "olexsmir/gopher.nvim",
    build = ":GoInstallDeps",
    ft = "go",
    opts = function()
      require("which-key").add {
        { "<leader>m", group = "Golang" },
        { "<leader>mj", "<cmd>GoTagAdd json -transform camelcase<cr>", desc = "Tag Add (JSON)", buffer = true },
        { "<leader>mJ", "<cmd>GoTagRm json<cr>", desc = "Tag Remove (JSON)", buffer = true },
        { "<leader>mb", "<cmd>GoTagAdd bson -transform camelcase<cr>", desc = "Tag Add (BSON)", buffer = true },
        { "<leader>mB", "<cmd>GoTagRm bson<cr>", desc = "Tag Remove (BSON)", buffer = true },
        { "<leader>mm", "<cmd>GoMod tidy<cr>", desc = "Mod Tidy", buffer = true },
        { "<leader>mc", "<cmd>GoCmt<cr>", desc = "Comment", buffer = true },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("set_tab_instead_space", { clear = true }),
        pattern = "go",
        callback = function()
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.softtabstop = 4
          vim.opt_local.expandtab = false
        end,
      })
    end,
  },
}
