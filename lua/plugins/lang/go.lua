return {
  {
    "mason-lspconfig.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "gopls", "golangci_lint_ls" },
    },
  },
  {
    "nvim-treesitter",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "go", "gomod", "gowork", "gosum" } },
  },
  {
    "mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "delve" } },
  },
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
      },
    },
  },

  -- Other extensions
  { "leoluz/nvim-dap-go", ft = "go" },
  {
    "olexsmir/gopher.nvim",
    build = ":GoInstallDeps",
    ft = "go",
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
  },
}
