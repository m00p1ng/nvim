local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local icons = require "user.icons"

local tree_cb = require 'nvim-tree.config'.nvim_tree_callback

nvim_tree.setup {
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "alpha",
  },
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Information,
      warning = icons.diagnostics.Warning,
      error = icons.diagnostics.Error,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  filters = {
    dotfiles = false,
    custom = {
      '\\.git$',
      '\\.DS_Store',
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    number = false,
    relativenumber = false,
    mappings = {
      custom_only = false,
      list = {
        { key = "1", cb = tree_cb "next_git_item" },
        { key = "2", cb = tree_cb "prev_git_item" },
      },
    },
  },
  renderer = {
    highlight_git = true,
    root_folder_modifier = ":t",
    indent_markers = {
      enable = true,
    },
    icons = {
      webdev_colors = true,
      git_placement = "after",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}
