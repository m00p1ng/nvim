vim.filetype.add {
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
