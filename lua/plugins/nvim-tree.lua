local icons = require "utils.icons"
local f = require "utils"

return {
  "nvim-tree/nvim-tree.lua",
  -- cmd = "NvimTreeToggle",
  cond = vim.g.vscode == nil,
  opts = {
    on_attach = "default",
    hijack_cursor = false,
    auto_reload_on_write = true,
    disable_netrw = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = false,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    select_prompts = false,
    sort = {
      sorter = "name",
      folders_first = true,
      files_first = false,
    },
    view = {
      centralize_selection = false,
      cursorline = true,
      debounce_delay = 15,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      width = 35,
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      full_name = false,
      root_folder_label = ":t",
      indent_width = 2,
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
      symlink_destination = true,
      highlight_git = true,
      highlight_diagnostics = false,
      highlight_opened_files = "none",
      highlight_modified = "none",
      highlight_bookmarks = "none",
      highlight_clipboard = "name",
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
      icons = {
        web_devicons = {
          file = {
            enable = true,
            color = true,
          },
          folder = {
            enable = false,
            color = true,
          },
        },
        git_placement = "after",
        modified_placement = "after",
        diagnostics_placement = "signcolumn",
        bookmarks_placement = "signcolumn",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = true,
          modified = false,
          diagnostics = true,
          bookmarks = true,
        },
        glyphs = {
          default = icons.ui.Text,
          symlink = icons.ui.FileSymlink,
          bookmark = icons.ui.Fire,
          modified = icons.ui.Circle,
          folder = {
            arrow_closed = icons.ui.ChevronShortRight,
            arrow_open = icons.ui.ChevronShortDown,
            default = icons.ui.Folder,
            open = icons.ui.FolderOpen,
            empty = icons.ui.EmptyFolder,
            empty_open = icons.ui.EmptyFolderOpen,
            symlink = icons.ui.FolderSymlink,
            symlink_open = icons.ui.FolderOpen,
          },
          git = {
            unstaged = icons.git.FileUnstaged,
            staged = icons.git.FileStaged,
            unmerged = icons.git.FileUnmerged,
            renamed = icons.git.FileRenamed,
            untracked = icons.git.FileUntracked,
            deleted = icons.git.FileDeleted,
            ignored = icons.git.FileIgnored,
          },
        },
      },
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      update_root = false,
      ignore_list = {
        "/nix/store",
        "~/.config",
      },
    },
    system_open = {
      cmd = "codium",
      args = { "." },
    },
    git = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      disable_for_dirs = {},
      timeout = 400,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = {
        min = vim.diagnostic.severity.HINT,
        max = vim.diagnostic.severity.ERROR,
      },
      icons = {
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Information,
        warning = icons.diagnostics.Warning,
        error = icons.diagnostics.Error,
      },
    },
    modified = {
      enable = false,
      show_on_dirs = true,
      show_on_open_dirs = true,
    },
    filters = {
      git_ignored = false,
      dotfiles = false,
      git_clean = false,
      no_buffer = false,
      custom = {
        "\\.git$",
        "\\.DS_Store",
      },
      exclude = {},
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true,
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
      ignore_dirs = {},
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      expand_all = {
        max_folder_discovery = 300,
        exclude = {},
      },
      file_popup = {
        open_win_config = {
          col = 1,
          row = 1,
          relative = "cursor",
          border = "shadow",
          style = "minimal",
        },
      },
      open_file = {
        quit_on_open = false,
        eject = true,
        resize_window = false,
        window_picker = {
          enable = true,
          picker = "default",
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = {
              "notify",
              "lazy",
              "qf",
              "diff",
              "fugitive",
              "fugitiveblame",
              "dap-repl",
            },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    trash = {
      -- cmd = "gio trash",
    },
    tab = {
      sync = {
        open = false,
        close = false,
        ignore = {},
      },
    },
    notify = {
      threshold = vim.log.levels.INFO,
      absolute_path = true,
    },
    ui = {
      confirm = {
        remove = true,
        trash = true,
      },
    },
    experimental = {},
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
  },
  config = function(_, config_opts)
    config_opts.on_attach = function(bufnr)
      local api = require "nvim-tree.api"

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set("n", "t", f.grep_at_current_tree_node, opts "Search in folder")
    end

    require("nvim-tree").setup(config_opts)
  end,
}
