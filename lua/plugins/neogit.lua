local icons = require "utils.icons"

return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  opts = {
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = true,
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    commit_popup = {
      kind = "split",
    },
    kind = "tab",
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
      },
      unstaged = {
        folded = false,
      },
      staged = {
        folded = false,
      },
      stashes = {
        folded = true,
      },
      unpulled = {
        folded = true,
      },
      unmerged = {
        folded = false,
      },
      recent = {
        folded = true,
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
