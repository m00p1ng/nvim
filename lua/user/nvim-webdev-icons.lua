local status_ok, nvim_web_devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
  return
end

nvim_web_devicons.set_icon {
  sh = {
    icon = "",
    color = "#1DC123",
    name = "Sh",
  },
  [".gitattributes"] = {
    icon = "",
    color = "#e24329",
    name = "GitAttributes",
  },
  [".gitconfig"] = {
    icon = "",
    color = "#e24329",
    name = "GitConfig",
  },
  [".gitignore"] = {
    icon = "",
    color = "#e24329",
    name = "GitIgnore",
  },
  [".gitlab-ci.yml"] = {
    icon = "",
    color = "#e24329",
    name = "GitlabCI",
  },
  [".gitmodules"] = {
    icon = "",
    color = "#e24329",
    name = "GitModules",
  },
  ["spec.ts"] = {
    icon = "",
    color = "#0277bd",
    name = "TSTest",
  },
  ["test.ts"] = {
    icon = "",
    color = "#0277bd",
    name = "TSTest",
  },
  ["spec.js"] = {
    icon = "",
    color = "#0277bd",
    name = "JSTest",
  },
  ["test.js"] = {
    icon = "",
    color = "#0277bd",
    name = "JSTest",
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
    icon = "",
    color = "#d0bf41",
    cterm_color = "179",
    name = "License",
  },
}
