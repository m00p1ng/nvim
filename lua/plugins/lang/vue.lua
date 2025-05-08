return {
  -- depends on the TypeScript extra
  { import = "plugins.lang.typescript" },

  {
    "mason-lspconfig.nvim",
    init = function()
      vim.api.nvim_create_autocmd("UIEnter", {
        group = vim.api.nvim_create_augroup("set_vue_version", { clear = true }),
        callback = function()
          if vim.g.vscode or vim.g.vue_version then
            return
          end

          if vim.fn.filereadable "package.json" == 0 then
            return
          end

          vim.system(
            { "rg", '"vue": "[^\\w\\d]*(\\d+\\.\\d+\\.\\d+)"', "-or", "$1", "package.json" },
            { text = true },
            function(out)
              if out.code ~= 0 then
                return
              end

              local version = vim.trim(out.stdout)

              print("Detected vue.js v" .. version)
              if vim.version.ge(version, "2.7.0") then
                vim.g.vue_version = 3
              else
                vim.g.vue_version = 2
              end

              vim.lsp.config("volar", {
                enabled = vim.g.vue_version == 3,
              })
              vim.lsp.config("vtsls", {
                enabled = vim.g.vue_version == nil or vim.g.vue_version == 2,
              })
            end
          )
        end,
      })
    end,
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "volar" },
    },
  },

  {
    "nvim-treesitter",
    opts = { ensure_installed = { "vue", "css", "scss" } },
  },
}
