local config = {
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
}

-- Configure tsserver plugin
if vim.g.vue_version == 2 then
  table.insert(config.filetypes, "vue")
  require("utils").extend(config, "settings.vtsls.tsserver.globalPlugins", {
    {
      name = "@vue/typescript-plugin",
      location = vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
      languages = { "vue" },
      configNamespace = "typescript",
      enableForWorkspaceTypeScriptVersions = true,
    },
  })
end

return config
