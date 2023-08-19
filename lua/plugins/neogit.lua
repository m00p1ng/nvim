local icons = require "utils.icons"

return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  opts = {
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = true,
    auto_refresh = true,
    sort_branches = "-committerdate",
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    kind = "tab",
    console_timeout = 2000,
    auto_show_console = true,
    remember_settings = true,
    use_per_project_settings = true,
    ignored_settings = {},
    commit_popup = {
      kind = "split",
    },
    preview_buffer = {
      kind = "split",
    },
    popup = {
      kind = "split",
    },
    signs = {
      -- { CLOSED, OPENED }
      section = { icons.ui.ArrowClosed, icons.ui.ArrowOpen },
      item = { icons.ui.ArrowClosed, icons.ui.ArrowOpen },
      hunk = { "", "" },
    },
    integrations = {
      diffview = true,
    },
    sections = {
      untracked = {
        folded = false,
        hidden = false,
      },
      unstaged = {
        folded = false,
        hidden = false,
      },
      staged = {
        folded = false,
        hidden = false,
      },
      stashes = {
        folded = true,
        hidden = false,
      },
      unpulled = {
        folded = true,
        hidden = false,
      },
      unmerged = {
        folded = false,
        hidden = false,
      },
      recent = {
        folded = true,
        hidden = false,
      },
    },
    mappings = {
      status = {
        ["<enter>"] = "Toggle",
        ["<tab>"] = "GoToFile",
      },
    },
  },
}
