local status_ok, diffview = pcall(require, "diffview")
if not status_ok then
  return
end

local actions = require("diffview.actions")
local icons = require("user.icons")

diffview.setup {
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = true,  -- See ':h diffview-config-enhanced_diff_hl'
  use_icons = true,         -- Requires nvim-web-devicons
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = icons.documents.Folder,
    folder_open = icons.documents.OpenFolder,
  },
  signs = {
    fold_closed = icons.ui.ArrowClosed,
    fold_open = icons.ui.ArrowOpen,
  },
  view = {
    -- Configure the layout and behavior of different types of views.
    -- Available layouts:
    --  'diff1_plain'
    --    |'diff2_horizontal'
    --    |'diff2_vertical'
    --    |'diff3_horizontal'
    --    |'diff3_vertical'
    --    |'diff3_mixed'
    --    |'diff4_mixed'
    -- For more info, see |diffview-config-view.x.layout|.
    default = {
      -- Config for changed files, and staged files in diff views.
      layout = "diff2_horizontal",
    },
    merge_tool = {
      -- Config for conflicted files in diff views during a merge or rebase.
      layout = "diff3_horizontal",
      disable_diagnostics = true,   -- Temporarily disable diagnostics for conflict buffers while in the view.
    },
    file_history = {
      -- Config for changed files in file history views.
      layout = "diff2_horizontal",
    },
  },
  file_panel = {
    listing_style = "list",             -- One of 'list' or 'tree'
    tree_options = {                    -- Only applies when listing_style is 'tree'
      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
    },
    win_config = {
      position = "left",                  -- One of 'left', 'right', 'top', 'bottom'
      width = 30,                         -- Only applies when position is 'left' or 'right'
    },
  },
  file_history_panel = {
    log_options = {},
    win_config = {
      position = "bottom",
      height = 16,
    },
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {},         -- See ':h diffview-config-hooks'
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]      = actions.select_next_entry,         -- Open the diff for the next file
      ["<s-tab>"]    = actions.select_prev_entry,         -- Open the diff for the previous file
      ["gf"]         = actions.goto_file_edit,            -- Open the file in a new split in the previous tabpage
      ["<C-w><C-f>"] = actions.goto_file_split,           -- Open the file in a new split
      ["<C-w>gf"]    = actions.goto_file_tab,             -- Open the file in a new tabpage
      ["<leader>e"]  = actions.focus_files,               -- Bring focus to the file panel
      ["<leader>b"]  = actions.toggle_files,              -- Toggle the file panel.
      ["g<C-x>"]     = actions.cycle_layout,              -- Cycle through available layouts.
      ["[x"]         = actions.prev_conflict,             -- In the merge_tool: jump to the previous conflict
      ["]x"]         = actions.next_conflict,             -- In the merge_tool: jump to the next conflict
      ["co"]         = actions.conflict_choose("ours"),   -- Choose the OURS version of a conflict
      ["ct"]         = actions.conflict_choose("theirs"), -- Choose the THEIRS version of a conflict
      ["ca"]         = actions.conflict_choose("base"),   -- Choose the BASE version of a conflict
      ["cb"]         = actions.conflict_choose("all"),    -- Choose all the versions of a conflict
      ["dx"]         = actions.conflict_choose("none"),   -- Delete the conflict region
      ["q"]          = actions.close,
      ["N"]          = "<cmd>Neogit<cr>",
    },
    file_panel = {
      ["j"]             = actions.next_entry,           -- Bring the cursor to the next file entry
      ["<down>"]        = actions.next_entry,
      ["k"]             = actions.prev_entry,           -- Bring the cursor to the previous file entry.
      ["<up>"]          = actions.prev_entry,
      ["<cr>"]          = actions.select_entry,         -- Open the diff for the selected entry.
      ["o"]             = actions.select_entry,
      ["<2-LeftMouse>"] = actions.select_entry,
      ["-"]             = actions.toggle_stage_entry,   -- Stage / unstage the selected entry.
      ["S"]             = actions.stage_all,            -- Stage all entries.
      ["U"]             = actions.unstage_all,          -- Unstage all entries.
      ["X"]             = actions.restore_entry,        -- Restore entry to the state on the left side.
      ["R"]             = actions.refresh_files,        -- Update stats and entries in the file list.
      ["L"]             = actions.open_commit_log,      -- Open the commit log panel.
      ["<c-b>"]         = actions.scroll_view(-0.25), -- Scroll the view up
      ["<c-f>"]         = actions.scroll_view(0.25),  -- Scroll the view down
      ["<tab>"]         = actions.select_next_entry,
      ["<s-tab>"]       = actions.select_prev_entry,
      ["gf"]            = actions.goto_file_edit,
      ["<C-w><C-f>"]    = actions.goto_file_split,
      ["<C-w>gf"]       = actions.goto_file_tab,
      ["i"]             = actions.listing_style,        -- Toggle between 'list' and 'tree' views
      ["f"]             = actions.toggle_flatten_dirs,  -- Flatten empty subdirectories in tree listing style.
      ["<leader>e"]     = actions.focus_files,
      ["<leader>b"]     = actions.toggle_files,
      ["g<C-x>"]        = actions.cycle_layout,
      ["[x"]            = actions.prev_conflict,
      ["]x"]            = actions.next_conflict,
      ["q"]             = "<cmd>DiffviewClose<cr>",
      ["N"]             = "<cmd>Neogit<cr>",
    },
    file_history_panel = {
      ["g!"]            = actions.options,            -- Open the option panel
      ["<C-A-d>"]       = actions.open_in_diffview,   -- Open the entry under the cursor in a diffview
      ["y"]             = actions.copy_hash,          -- Copy the commit hash of the entry under the cursor
      ["L"]             = actions.open_commit_log,
      ["zR"]            = actions.open_all_folds,
      ["zM"]            = actions.close_all_folds,
      ["j"]             = actions.next_entry,
      ["<down>"]        = actions.next_entry,
      ["k"]             = actions.prev_entry,
      ["<up>"]          = actions.prev_entry,
      ["<cr>"]          = actions.select_entry,
      ["o"]             = actions.select_entry,
      ["<2-LeftMouse>"] = actions.select_entry,
      ["<c-b>"]         = actions.scroll_view(-0.25),
      ["<c-f>"]         = actions.scroll_view(0.25),
      ["<tab>"]         = actions.select_next_entry,
      ["<s-tab>"]       = actions.select_prev_entry,
      ["gf"]            = actions.goto_file_edit,
      ["<C-w><C-f>"]    = actions.goto_file_split,
      ["<C-w>gf"]       = actions.goto_file_tab,
      ["<leader>e"]     = actions.focus_files,
      ["<leader>b"]     = actions.toggle_files,
      ["g<C-x>"]        = actions.cycle_layout,
      ["q"]             = "<cmd>DiffviewClose<cr>",
      ["N"]             = "<cmd>Neogit<cr>",
    },
    option_panel = {
      ["<tab>"] = actions.select_entry,
      ["q"]     = actions.close,
      ["N"]     = "<cmd>Neogit<cr>",
    },
  },
}
