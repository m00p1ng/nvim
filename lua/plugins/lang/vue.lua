return {
  -- depends on the typescript extra
  { import = "plugins.lang.typescript" },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          filetypes = {
            "typescript",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "vue",
          },
          init_options = {
            vue = {
              -- disable hybrid mode
              hybridMode = false,
            },
          },
          settings = {
            html = {
              format = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
  -- Configure tsserver plugin
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local vue_version = vim.g.vue_version
      opts.servers.volar.enabled = vue_version == 3
      opts.servers.vtsls.enabled = vue_version == nil or vue_version == 2

      if vue_version == 2 then
        table.insert(opts.servers.vtsls.filetypes, "vue")
        require("utils").extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
          {
            name = "@vue/typescript-plugin",
            location = vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          },
        })
      end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "vue", "css", "scss" } },
  },
}
