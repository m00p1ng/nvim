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
    color = "#FFCC66",
    name = "TSSPec",
  },
  ["test.ts"] = {
    icon = "",
    color = "#FFCC66",
    name = "TSTest",
  },
  ["spec.js"] = {
    icon = "",
    color = "#FFCC66",
    name = "JSSpec",
  },
  ["test.js"] = {
    icon = "",
    color = "#FFCC66",
    name = "JSTest",
  },
  ["dockerignore"] = {
    icon = "",
    color = "#384d54",
    name = "DockerIgnore",
  },
  ["docker-compose.yml"] = {
    icon = "",
    color = "#384d54",
    name = "DockerCompoose",
  },
}
