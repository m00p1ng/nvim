return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      yamlls = {
        yaml = {
          schemaStore = {
            enable = true,
          },
        },
      },
    },
  },
}
