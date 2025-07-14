local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
  languages = { "vue" },
  configNamespace = "typescript",
  enableForWorkspaceTypeScriptVersions = true,
}

local typescriptSdk = vim.fn.isdirectory ".yarn/sdks/typescript" and "./.yarn/sdks/typescript/lib" or ""

return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  workspace_required = true,
  settings = {
    complete_function_calls = true,
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      tsdk = typescriptSdk,
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
