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
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "go", "gomod", "gowork", "gosum" } },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "delve" } },
  },
  { "leoluz/nvim-dap-go", ft = "go" },
  {
    "olexsmir/gopher.nvim",
    build = ":GoInstallDeps",
    ft = "go",
    opts = function()
      require("which-key").add {
        { "<leader>m", group = "Golang" },
      }
    end,
    keys = {
      { "<leader>mj", "<cmd>GoTagAdd json -transform camelcase<cr>", desc = "Tag Add (JSON)", buffer = true },
      { "<leader>mJ", "<cmd>GoTagRm json<cr>", desc = "Tag Remove (JSON)", buffer = true },
      { "<leader>mb", "<cmd>GoTagAdd bson -transform camelcase<cr>", desc = "Tag Add (BSON)", buffer = true },
      { "<leader>mB", "<cmd>GoTagRm bson<cr>", desc = "Tag Remove (BSON)", buffer = true },
      { "<leader>mm", "<cmd>GoMod tidy<cr>", desc = "Mod Tidy", buffer = true },
      { "<leader>mc", "<cmd>GoCmt<cr>", desc = "Comment", buffer = true },
    },
  },
}
