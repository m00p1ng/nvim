local function get_current_path()
  local oil = require "oil"
  local dir = oil.get_current_dir()
  local entry = oil.get_cursor_entry()
  if not dir or not entry then
    return ""
  end
  return dir .. entry.parsed_name
end

return {
  "stevearc/oil.nvim",
  init = function()
    require("utils").add_ui_ft("oil", "oil_preview")
    require("utils.winbar").add_plugin "oil"

    function _G.get_oil_winbar()
      local dir = require("oil").get_current_dir()
      local name = ""
      if dir then
        local cwd = vim.fn.getcwd()
        if vim.startswith(dir, cwd) then
          local p = vim.split(cwd, "/")
          local project = p[#p]
          name = "@" .. project .. string.sub(dir, #cwd + 1, #dir - 1)
        else
          name = vim.fn.fnamemodify(dir, ":~")
        end
      end

      local title = "%#WinbarText#" .. " " .. require("utils.icons").ui.FindFile .. " " .. "File Explorer"
      if name ~= "" then
        title = title .. " (" .. name .. ")"
      end

      return title
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function(event)
        vim.b[event.buf].completion = false
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        for _, action in pairs(event.data.actions) do
          if action.type == "move" then
            local src_url = action.src_url:gsub("^oil://", "")
            local dest_url = action.dest_url:gsub("^oil://", "")

            Snacks.rename.on_rename_file(src_url, dest_url)
          end
        end
      end,
    })
  end,
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
    default_file_explorer = true,
    -- Id is automatically added at the beginning, and name at the end
    -- See :help oil-columns
    columns = {
      "icon",
      -- "permissions",
      -- "size",
      -- "mtime",
    },
    -- Buffer-local options to use for oil buffers
    buf_options = {
      buflisted = false,
      bufhidden = "hide",
    },
    -- Window-local options to use for oil buffers
    win_options = {
      wrap = false,
      signcolumn = "yes",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
      relativenumber = true,
      winbar = "%!v:lua.get_oil_winbar()",
    },
    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = false,
    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    skip_confirm_for_simple_edits = false,
    -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
    -- (:help prompt_save_on_select_new_entry)
    prompt_save_on_select_new_entry = true,
    -- Oil will automatically delete hidden buffers after this delay
    -- You can set the delay to false to disable cleanup entirely
    -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
    cleanup_delay_ms = 2000,
    lsp_file_methods = {
      -- Enable or disable LSP file operations
      enabled = false,
      -- Time to wait for LSP file operations to complete before skipping
      timeout_ms = 1000,
      -- Set to true to autosave buffers that are updated with LSP willRenameFiles
      -- Set to "unmodified" to only save unmodified buffers
      autosave_changes = false,
    },
    -- Constrain the cursor to the editable parts of the oil buffer
    -- Set to `false` to disable, or "name" to keep it on the file names
    constrain_cursor = "editable",
    -- Set to true to watch the filesystem for changes and reload oil
    watch_for_changes = false,
    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
    -- Additionally, if it is a string that matches "actions.<name>",
    -- it will use the mapping at require("oil.actions").<name>
    -- Set to `false` to remove a keymap
    -- See :help oil-actions for a list of all available actions
    keymaps = {
      ["?"] = { "actions.show_help", mode = "n" },
      ["<cr>"] = function()
        require("oil").select({}, function()
          vim.cmd "noh"
        end)
      end,
      -- ["<C-v>"] = { "actions.select", opts = { vertical = true } },
      -- ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
      -- ["<C-t>"] = { "actions.select", opts = { tab = true } },
      ["<C-p>"] = "actions.preview",
      ["q"] = { "actions.close", mode = "n" },
      ["R"] = "actions.refresh",
      ["gt"] = {
        function()
          local path = get_current_path()
          ---@diagnostic disable-next-line: missing-fields
          Snacks.picker.grep {
            dirs = { path },
          }
        end,
        mode = "n",
        desc = "Find files in the current directory",
      },
      ["-"] = { "actions.parent", mode = "n" },
      ["_"] = { "actions.open_cwd", mode = "n" },
      ["`"] = { "actions.cd", mode = "n" },
      ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = {
        function()
          local editor = { "codium", "code" }

          local path = get_current_path()
          local cmd = { "open ", path }
          for _, v in ipairs(editor) do
            if vim.fn.executable(v) == 1 then
              cmd = { v, " . ", path }
              break
            end
          end

          vim.system(cmd)
        end,
        desc = "Open the entry under the cursor in an external program",
        mode = "n",
      },
      ["H"] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
    -- Set to false to disable all of the above keymaps
    use_default_keymaps = false,
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name, bufnr)
        local m = name:match "^%."
        return m ~= nil
      end,
      -- This function defines what will never be shown, even when `show_hidden` is set
      is_always_hidden = function(name, bufnr)
        local hidden_list = {
          ".DS_Store",
        }

        if vim.tbl_contains(hidden_list, name) then
          return true
        end

        return false
      end,
      -- Sort file names with numbers in a more intuitive order for humans.
      -- Can be "fast", true, or false. "fast" will turn it off for large directories.
      natural_order = "fast",
      -- Sort file and directory names case insensitive
      case_insensitive = false,
      sort = {
        -- sort order can be "asc" or "desc"
        -- see :help oil-columns to see which columns are sortable
        { "type", "asc" },
        { "name", "asc" },
      },
      -- Customize the highlight group for the file name
      highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
        return nil
      end,
    },
    -- Extra arguments to pass to SCP when moving/copying files over SSH
    extra_scp_args = {},
    -- EXPERIMENTAL support for performing file operations with git
    git = {
      -- Return true to automatically git add/mv/rm files
      add = function(path)
        return false
      end,
      mv = function(src_path, dest_path)
        return false
      end,
      rm = function(path)
        return false
      end,
    },
    -- Configuration for the floating window in oil.open_float
    float = {
      -- Padding around the floating window
      padding = 2,
      max_width = 0,
      max_height = 0,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
      get_win_title = nil,
      -- preview_split: Split direction: "auto", "left", "right", "above", "below".
      preview_split = "auto",
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      override = function(conf)
        return conf
      end,
    },
    -- Configuration for the file preview window
    preview_win = {
      -- Whether the preview window is automatically updated when the cursor is moved
      update_on_cursor_moved = true,
      -- How to open the preview window "load"|"scratch"|"fast_scratch"
      preview_method = "fast_scratch",
      -- A function that returns true to disable preview on a file e.g. to avoid lag
      disable_preview = function(filename)
        return false
      end,
      -- Window-local options to use for preview window buffers
      win_options = {},
    },
    -- Configuration for the floating action confirmation window
    confirmation = {
      -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_width and max_width can be a single value or a list of mixed integer/float types.
      -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
      max_width = 0.9,
      -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
      min_width = { 40, 0.4 },
      -- optionally define an integer/float for the exact width of the preview window
      width = nil,
      -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_height and max_height can be a single value or a list of mixed integer/float types.
      -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
      max_height = 0.9,
      -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
      min_height = { 5, 0.1 },
      -- optionally define an integer/float for the exact height of the preview window
      height = nil,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    -- Configuration for the floating progress window
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      minimized_border = "none",
      win_options = {
        winblend = 0,
      },
    },
    -- Configuration for the floating SSH window
    ssh = {
      border = "rounded",
    },
    -- Configuration for the floating keymaps help window
    keymaps_help = {
      border = "rounded",
    },
  },
  keys = {
    {
      "-",
      function()
        if require("utils").is_ui_filetype(vim.bo.ft, { exclude = { "snacks_dashboard" } }) then
          return
        end
        vim.cmd "Oil"
      end,
      desc = "Open parent directory",
    },
  },
}
