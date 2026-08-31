local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vim.fn.stdpath "data" .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
  languages = { "vue" },
  configNamespace = "typescript",
}

local typescriptSdk = vim.fn.isdirectory ".yarn/sdks/typescript" == 1 and "./.yarn/sdks/typescript/lib/tsserver.js"
  or nil

local inlay_hints = {
  includeInlayParameterNameHints = "literals",
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  workspace_required = true,
  init_options = {
    hostInfo = "neovim",
    plugins = {
      vue_plugin,
    },
    tsserver = {
      path = typescriptSdk,
    },
  },
  settings = {
    completions = {
      completeFunctionCalls = true,
    },
    typescript = {
      inlayHints = inlay_hints,
    },
    javascript = {
      inlayHints = inlay_hints,
    },
  },
}
