vim.filetype.add {
  extension = {
    mdx = "markdown",
    http = "http",
  },
  filename = {
    ["Podfile"] = "ruby",
    ["terraform.tfstate"] = "json",
    ["terraform.tfstate.backup"] = "json",
  },
  pattern = {
    ["*Jenkinsfile*"] = "groovy",
    ["*.tpl"] = "yaml",
    [".env.*"] = "sh",
    ["*.env"] = "sh",
    ["Dockerfile.*"] = "Dockerfile",
  },
}
