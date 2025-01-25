require("utils").add_ui_ft(
  "neo-tree",
  "neo-tree-popup"
)

local icons = require "utils.icons"

return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  cmd = "Neotree",
  dependencies = {
    {
      "s1n7ax/nvim-window-picker",
      opts = {
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          bo = {
            filetype = { "neo-tree", "neo-tree-popup", "snacks_notif" },
            buftype = { "terminal", "quickfix" },
          },
        },
      },
    },
  },
  opts = {
    sources = { "filesystem" },
    add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
    auto_clean_after_session_restore = false, -- Automatically clean up broken neo-tree buffers saved in sessions
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    default_source = "filesystem", -- you can choose a specific source `last` here which indicates the last used source
    enable_diagnostics = true,
    enable_git_status = true,
    enable_modified_markers = true, -- Show markers for files with unsaved changes.
    enable_opened_markers = true,   -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
    enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
    enable_cursor_hijack = false, -- If enabled neotree will keep the cursor on the first letter of the filename when moving in the tree.
    git_status_async = true,
    -- These options are for people with VERY large git repos
    git_status_async_options = {
      batch_size = 1000, -- how many lines of git status results to process at a time
      batch_delay = 10,  -- delay in ms between batches. Spreads out the workload to let other processes run.
      max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
                         -- Anything before this will be used. The last items to be processed are the untracked files.
    },
    hide_root_node = false, -- Hide the root node.
    retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
                                       -- This is needed if you use expanders because they render in the indent.
    open_files_in_last_window = true, -- false = open files in top left window
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" }, -- when opening files, do not use windows containing these filetypes or buftypes
    -- popup_border_style is for input and confirmation dialogs.
    -- Configurtaion of floating window is done in the individual source sections.
    -- "NC" is a special style that works well with NormalNC set
    popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid"
    resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
                                 -- set to -1 to disable the resize timer entirely
    --                           -- NOTE: this will speed up to 50 ms for 1 second following a resize
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil , -- uses a custom function for sorting files and directories in the tree
    use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
    use_default_mappings = false,
    default_component_configs = {
      container = {
        enable_character_fade = true,
        width = "100%",
        right_padding = 0,
      },
      diagnostics = {
        symbols = {
          hint = icons.diagnostics.Hint,
          info = icons.diagnostics.Information,
          warn = icons.diagnostics.Warning,
          error = icons.diagnostics.Error,
        },
      },
      icon = {
        folder_closed = icons.ui.Folder,
        folder_open = icons.ui.FolderOpen,
        folder_empty = icons.ui.EmptyFolder,
        folder_empty_open = icons.ui.EmptyFolderOpen,
        default = icons.ui.File,
      },
      modified = {
        symbol = "[+] ",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
                                        -- Take values in { false (no highlight), true (only loaded),
                                        -- "all" (both loaded and unloaded)}. For more information,
                                        -- see the `show_unloaded` config of the `buffers` source.
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          -- Change type
          added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
          deleted   = "✖",
          modified  = "",
          renamed   = icons.git.FileRenamed,
          -- Status type
          untracked = icons.git.FileUntracked,
          ignored   = icons.git.FileIgnored,
          unstaged  = icons.git.FileUnstaged,
          staged    = icons.git.FileStaged,
          conflict  = icons.git.FileUnmerged,
        },
        align = "right",
      },
      -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
      file_size = {
        enabled = false,
      },
      type = {
        enabled = false,
      },
      last_modified = {
        enabled = false,
      },
      created = {
        enabled = false,
      },
      symlink_target = {
        enabled = true,
        text_format = " ➛ %s", -- %s will be replaced with the symlink target's path.
      },
    },
    renderers = {
      directory = {
        { "indent" },
        { "icon" },
        { "current_filter" },
        {
          "container",
          content = {
            { "name", zindex = 10 },
            {
              "symlink_target",
              zindex = 10,
              highlight = "NeoTreeSymbolicLinkTarget",
            },
            { "clipboard", zindex = 10 },
            { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
            { "git_status", zindex = 10, align = "right", hide_when_expanded = true },
          },
        },
      },
      file = {
        { "indent" },
        { "icon" },
        {
          "container",
          content = {
            {
              "name",
              zindex = 10,
            },
            {
              "symlink_target",
              zindex = 10,
              highlight = "NeoTreeSymbolicLinkTarget",
            },
            { "clipboard", zindex = 10 },
            { "bufnr", zindex = 10 },
            { "modified", zindex = 20, align = "right" },
            { "diagnostics", zindex = 20, align = "right" },
            { "git_status", zindex = 10, align = "right" },
          },
        },
      },
      message = {
        { "indent", with_markers = false },
        { "name", highlight = "NeoTreeMessage" },
      },
    },
    nesting_rules = {},
    commands = {
      system_open = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        -- macOs: open file in default application in the background.
        vim.fn.jobstart({ "codium", ".", path }, { detach = true })
      end,
    }, -- A list of functions

    window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
               -- possible options. These can also be functions that return these options.
      position = "left", -- left, right, top, bottom, float, current
      width = 35, -- applies to left and right positions
      height = 15, -- applies to top and bottom positions
      auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
      popup = { -- settings that apply to float position only
        size = {
          height = "80%",
          width = "50%",
        },
        position = "50%", -- 50% means center it
        title = function(state) -- format the text that appears at the top of a popup window
          return "Neo-tree " .. state.name:gsub("^%l", string.upper)
        end,
        -- you can also specify border here, if you want a different setting from
        -- the global popup_border_style.
      },
      same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
      insert_as = "child", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
                          -- "child":   Insert nodes as children of the directory under cursor.
                          -- "sibling": Insert nodes  as siblings of the directory under cursor.
      -- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
      -- You can also create your own commands by providing a function instead of a string.
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "cancel", -- close preview or floating neo-tree window
        ["<tab>"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
        -- ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
        -- ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
        -- ["l"] = "focus_preview",
        ["<C-x>"] = "open_split",
        -- -- ["S"] = "split_with_window_picker",
        ["<C-v>"] = "open_vsplit",
        -- -- ["sr"] = "open_rightbelow_vs",
        -- -- ["sl"] = "open_leftabove_vs",
        -- -- ["s"] = "vsplit_with_window_picker",
        -- ["t"] = "open_tabnew",
        -- -- ["<cr>"] = "open_drop",
        -- -- ["t"] = "open_tab_drop",
        -- ["w"] = "open_with_window_picker",
        -- ["C"] = "close_node",
        -- ["z"] = "close_all_nodes",
        -- --["Z"] = "expand_all_nodes",
        ["R"] = "refresh",
        ["a"] = {
          "add",
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "none", -- "none", "relative", "absolute"
          },
        },
        ["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
        ["d"] = "delete",
        ["r"] = "rename",
        ["e"] = "rename_basename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = { "move", config = { show_path = "relative" } },
        -- ["e"] = "toggle_auto_expand_width",
        ["q"] = "close_window",
        ["?"] = "show_help",
      },
    },
    filesystem = {
      window = {
        mappings = {
          ["s"] = "system_open",
          ["H"] = "toggle_hidden",
          -- ["/"] = "fuzzy_finder",
          -- ["D"] = "fuzzy_finder_directory",
          -- --["/"] = "filter_as_you_type", -- this was the default until v1.28
          -- ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
          -- -- ["D"] = "fuzzy_sorter_directory",
          -- ["f"] = "filter_on_submit",
          -- ["<C-x>"] = "clear_filter",
          -- ["<bs>"] = "navigate_up",
          -- ["."] = "set_root",
          ["[c"] = "prev_git_modified",
          ["]c"] = "next_git_modified",
          -- ["i"] = "show_file_details",
          -- ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" }},
          -- ["oc"] = { "order_by_created", nowait = false },
          -- ["od"] = { "order_by_diagnostics", nowait = false },
          -- ["og"] = { "order_by_git_status", nowait = false },
          -- ["om"] = { "order_by_modified", nowait = false },
          -- ["on"] = { "order_by_name", nowait = false },
          -- ["os"] = { "order_by_size", nowait = false },
          -- ["ot"] = { "order_by_type", nowait = false },
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          -- ["<down>"] = "move_cursor_down",
          -- ["<C-n>"] = "move_cursor_down",
          -- ["<up>"] = "move_cursor_up",
          -- ["<C-p>"] = "move_cursor_up",
        },
      },
      async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
                                     -- "always" means directory scans are always async.
                                     -- "never"  means directory scans are never async.
      scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
                             -- "deep": Scan into directories to detect empty or grouped empty directories a priori.
      bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
      cwd_target = {
        sidebar = "tab",   -- sidebar is when position = left or right
        current = "window",-- current is when position = current
      },
      check_gitignore_in_search = true, -- check gitignore status for files/directories when searching
                                        -- setting this to false will speed up searches, but gitignored
                                        -- items won't be marked if they are visible.
      -- The renderer section provides the renderers that will be used to render the tree.
      --   The first level is the node type.
      --   For each node type, you can specify a list of components to render.
      --       Components are rendered in the order they are specified.
      --         The first field in each component is the name of the function to call.
      --         The rest of the fields are passed to the function as the "config" argument.
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
        show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          -- ".DS_Store",
          --"node_modules",
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json"
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        always_show_by_pattern = { -- uses glob style patterns
          --".env*",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          ".git",
          ".DS_Store",
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
      find_by_full_path_words = false,  -- `false` means it only searches the tail of a path.
                                        -- `true` will change the filter into a full path
                                        -- search with space as an implicit ".*", so
                                        -- `fi init`
                                        -- will match: `./sources/filesystem/init.lua
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      search_limit = 50, -- max number of search results when using filters
      follow_current_file = {
        enabled = true,  -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                              -- in whatever position is specified in window.position
                            -- "open_current",-- netrw disabled, opening a directory opens within the
                                              -- window like netrw would, regardless of window.position
                            -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
                                     -- instead of relying on nvim autocmd events.
    },
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
  },
}
