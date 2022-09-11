local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
  return
end

illuminate.configure {
  providers = {
    "lsp",
    "treesitter",
    "regex",
  },
  delay = 120,
  filetypes_denylist = {
    "alpha",
    "NvimTree",
    "packer",
    "NeogitStatus",
    "qf",
    "Outline",
    "toggleterm",
    "TelescopePrompt",
    "DiffviewFiles",
  },
  filetypes_allowlist = {},
  modes_denylist = {},
  modes_allowlist = {},
  providers_regex_syntax_denylist = {},
  providers_regex_syntax_allowlist = {},
  under_cursor = true,
}
