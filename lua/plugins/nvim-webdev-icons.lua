return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  cond = vim.g.vscode == nil,
  config = function()
    require("nvim-web-devicons").set_icon {
      sh = {
        icon = "",
        color = "#1DC123",
        name = "Sh",
      },
      ["tsx"] = {
        icon = "",
        color = "#519aba",
        cterm_color = "74",
        name = "Tsx",
      },
      [".dockerignore"] = {
        icon = "",
        color = "#43a5f5",
        name = "Docker",
      },
      ["dockerfile"] = {
        icon = "",
        color = "#43a5f5",
        name = "Docker",
      },
      ["Dockerfile"] = {
        icon = "",
        color = "#43a5f5",
        name = "Docker",
      },
      ["Dockerfile.dev"] = {
        icon = "",
        color = "#43a5f5",
        name = "Docker",
      },
      ["Dockerfile.develop"] = {
        icon = "",
        color = "#43a5f5",
        name = "Docker",
      },
      ["Dockerfile.prod"] = {
        icon = "",
        color = "#43a5f5",
        name = "Docker",
      },
      ["Dockerfile.production"] = {
        icon = "",
        color = "#43a5f5",
        name = "Docker",
      },
      ["docker-compose.yml"] = {
        icon = "",
        color = "#43a5f5",
        name = "Docker",
      },
      ["docker-compose.yaml"] = {
        icon = "",
        color = "#43a5f5",
        name = "Docker",
      },
      ["json"] = {
        icon = "",
        color = "#fbc234",
        name = "JSON",
      },
      ["yaml"] = {
        icon = "",
        color = "#f44336",
        name = "YAML",
      },
      ["yml"] = {
        icon = "",
        color = "#f44336",
        name = "YAML",
      },
      ["md"] = {
        icon = "",
        color = "#42a5f5",
        name = "Markdown",
      },
      ["LICENSE"] = {
        icon = "󰄤",
        color = "#d0bf41",
        name = "License",
      },
      ["secrets"] = {
        icon = "󰟵",
        color = "#d0bf41",
        name = "Secret",
      },
      [".nvmrc"] = {
        icon = "󰎙",
        color = "#8bc34a",
        name = "NodeJS",
      },
      ["js"] = {
        icon = "",
        color = "#f1df5a",
        name = "Js",
      },
      ["csv"] = {
        icon = "󰈛",
        color = "#89e051",
        cterm_color = "113",
        name = "Csv",
      },
      ["tf"] = {
        icon = "󱁢",
        color = "#5F43E9",
        cterm_color = "57",
        name = "Terraform",
      },
      ["tfvars"] = {
        icon = "󱁢",
        color = "#5F43E9",
        cterm_color = "57",
        name = "TFVars",
      },
    }
  end,
}
