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
      end
    )
  end,
})

return {
  -- depends on the TypeScript extra
  { import = "plugins.lang.typescript" },

  {
    "nvim-lspconfig",
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
    "nvim-lspconfig",
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
    "nvim-treesitter",
    opts = { ensure_installed = { "vue", "css", "scss" } },
  },
}
