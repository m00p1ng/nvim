local icons = require "utils.icons"

local bpad = {
  all = { " ", " ", " ", " ", " ", " ", " ", " " },
  top = { "", " ", "", "", "", "", "", "" },
  right = { "", "", "", " ", "", "", "", "" },
  bottom = { "", "", "", "", "", " ", "", "" },
  left = { "", "", "", "", "", "", "", " " },
}

local function get_ivy_preset()
  return function()
    return vim.o.columns >= 120 and "ivy_fixed" or "vertical_fixed"
  end
end

return {
  "folke/snacks.nvim",
  opts = {
    ---@type snacks.picker.Config
    picker = {
      prompt = " ",
      exclude = {
        "node_modules",
        ".DS_store",
        ".git",
      },
      sources = {
        files = {
          layout = "dropdown_fixed",
          hidden = true,
        },
        recent = {
          layout = "dropdown_fixed",
          filter = { cwd = true },
        },
        buffers = {
          layout = "dropdown_fixed",
          win = {
            input = {
              keys = {
                ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
                ["<c-x>"] = { "edit_split", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["<c-d>"] = "bufdelete",
                ["dd"] = false,
              },
            },
          },
        },
        smart = {
          layout = "dropdown_fixed",
          hidden = true,
          filter = { cwd = true },
          win = {
            input = {
              keys = {
                ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
                ["<c-x>"] = { "edit_split", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["<c-d>"] = "bufdelete",
                ["dd"] = false,
              },
            },
          },
        },
        commands = {
          layout = "dropdown_fixed",
        },
        command_history = {
          layout = "dropdown_fixed",
        },
        colorschemes = {
          layout = "vertical_fixed",
        },
        git_status = {
          layout = "dropdown_fixed",
        },
        git_branches = {
          layout = "dropdown_fixed",
        },
        icons = {
          layout = "dropdown_fixed",
        },
        help = {
          win = {
            preview = {
              minimal = true,
            },
          },
        },
        spelling = {
          layout = "dropdown_fixed",
        },
        pickers = {
          layout = "dropdown_fixed",
        },
      },
      focus = "input",
      layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = get_ivy_preset(),
      },
      layouts = {
        ivy_fixed = {
          layout = {
            box = "horizontal",
            backdrop = false,
            row = -1,
            width = 0,
            height = 25,
            border = "none",
            {
              box = "vertical",
              {
                win = "input",
                title = " {title} {live} {flags}",
                height = 1,
                border = { "", " ", "", "", "", "─", "", "" },
              },
              { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", width = 0.5, border = bpad.top },
          },
        },
        vertical_fixed = {
          layout = {
            backdrop = false,
            width = 0.5,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = "vertical",
            border = bpad.all,
            title = " {title} {live} {flags}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", height = 0.4, max_height = 15, border = "none" },
            { win = "preview", title = "{preview}", border = "top" },
          },
        },
        dropdown_fixed = {
          layout = {
            backdrop = false,
            width = 80,
            height = 14,
            border = "none",
            box = "vertical",
            {
              box = "vertical",
              border = bpad.all,
              title = " {title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
        select = {
          layout = {
            backdrop = false,
            width = 80,
            height = 14,
            min_height = 14,
            border = "none",
            box = "vertical",
            {
              box = "vertical",
              border = bpad.all,
              title = " {title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
      },
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        ignorecase = true, -- use ignorecase
        sort_empty = false, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true, -- support patterns like `file:line:col` and `file:line`
        -- the bonusses below, possibly require string concatenation and path normalization,
        -- so this can have a performance impact for large lists and increase memory usage
        cwd_bonus = false, -- give bonus for matching files in the cwd
        frecency = false, -- frecency bonus
        history_bonus = false, -- give more weight to chronological order
      },
      sort = {
        -- default sort is by score, text length and index
        fields = { "score:desc", "#text", "idx" },
      },
      ui_select = true, -- replace `vim.ui.select` with the snacks picker
      formatters = {
        text = {
          ft = nil, ---@type string? filetype for highlighting
        },
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 75, -- truncate the file path to (roughly) this length
          filename_only = false, -- only show the filename
          icon_width = 2, -- width of the icon (in characters)
        },
        selected = {
          show_always = false, -- only show the selected column when there are multiple selections
          unselected = true, -- use the unselected icon for unselected items
        },
        severity = {
          icons = true, -- show severity icons
          level = false, -- show severity level
          ---@type "left"|"right"
          pos = "left", -- position of the diagnostics
        },
      },
      previewers = {
        git = {
          native = false, -- use native (terminal) or Neovim for previewing git diffs and commits
        },
        file = {
          max_size = 1024 * 1024, -- 1MB
          max_line_length = 500, -- max line length
          ft = nil, ---@type string? filetype for highlighting. Use `nil` for auto detect
        },
        man_pager = nil, ---@type string? MANPAGER env to use for `man` preview
      },
      jump = {
        jumplist = true, -- save the current position in the jumplist
        tagstack = false, -- save the current position in the tagstack
        reuse_win = false, -- reuse an existing window if the buffer is already open
        close = true, -- close the picker when jumping/editing to a location (defaults to true)
        match = false, -- jump to the first match position. (useful for `lines`)
      },
      toggles = {
        follow = icons.ui.Tab,
        hidden = icons.ui.Hidden,
        ignored = icons.git.FileIgnored,
        modified = "m",
        regex = { icon = "R", value = false },
      },
      win = {
        -- input window
        input = {
          keys = {
            ["/"] = false,
            ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
            ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
            ["<C-c>"] = { "close", mode = "i" },
            ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
            ["<CR>"] = { "confirm", mode = { "n", "i" } },
            ["<Down>"] = { "list_down", mode = { "i", "n" } },
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
            ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
            ["<Up>"] = { "list_up", mode = { "i", "n" } },
            ["<a-a>"] = { "select_all", mode = { "n", "i" } },
            ["<a-d>"] = { "inspect", mode = { "n", "i" } },
            ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
            ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
            ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
            ["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
            ["<c-a>"] = { "<Home>", mode = { "i" }, expr = true, desc = "start line" },
            ["<c-e>"] = { "<End>", mode = { "i" }, expr = true, desc = "end line" },
            ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
            ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
            ["<c-j>"] = { "list_down", mode = { "i", "n" } },
            ["<c-k>"] = { "list_up", mode = { "i", "n" } },
            ["<c-n>"] = { "list_down", mode = { "i", "n" } },
            ["<c-p>"] = { "list_up", mode = { "i", "n" } },
            ["<c-q>"] = { "qflist", mode = { "i", "n" } },
            ["<c-s>"] = false,
            ["<c-x>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
            ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
            ["<c-_>"] = { "toggle_help_list", mode = { "i", "n" } },
            ["<c-z>h"] = { "layout_left", mode = { "i", "n" } },
            ["<c-z><c-h>"] = { "layout_left", mode = { "i", "n" } },
            ["<c-z>j"] = { "layout_bottom", mode = { "i", "n" } },
            ["<c-z><c-j>"] = { "layout_bottom", mode = { "i", "n" } },
            ["<c-z>k"] = { "layout_top", mode = { "i", "n" } },
            ["<c-z><c-k>"] = { "layout_top", mode = { "i", "n" } },
            ["<c-z>l"] = { "layout_right", mode = { "i", "n" } },
            ["<c-z><c-l>"] = { "layout_right", mode = { "i", "n" } },
            ["?"] = false,
            ["G"] = false,
            ["gg"] = false,
            ["j"] = false,
            ["k"] = false,
            ["q"] = false,
          },
          b = {
            minipairs_disable = true,
          },
        },
        -- result list window
        list = {
          keys = {
            ["/"] = "toggle_focus",
            ["<2-LeftMouse>"] = "confirm",
            ["<CR>"] = "confirm",
            ["<Down>"] = "list_down",
            ["<Esc>"] = "close",
            ["<S-CR>"] = { { "pick_win", "jump" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
            ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
            ["<Up>"] = "list_up",
            ["<a-d>"] = "inspect",
            ["<a-f>"] = "toggle_follow",
            ["<a-h>"] = "toggle_hidden",
            ["<a-i>"] = "toggle_ignored",
            ["<a-m>"] = "toggle_maximize",
            ["<a-p>"] = "toggle_preview",
            ["<a-w>"] = "cycle_win",
            ["<c-a>"] = "select_all",
            ["<c-b>"] = "preview_scroll_up",
            ["<c-d>"] = "list_scroll_down",
            ["<c-f>"] = "preview_scroll_down",
            ["<c-j>"] = "list_down",
            ["<c-k>"] = "list_up",
            ["<c-n>"] = "list_down",
            ["<c-p>"] = "list_up",
            ["<c-s>"] = false,
            ["<c-x>"] = "edit_split",
            ["<c-u>"] = "list_scroll_up",
            ["<c-v>"] = "edit_vsplit",
            ["<c-z>h"] = { "layout_left", mode = { "i", "n" } },
            ["<c-z><c-h>"] = { "layout_left", mode = { "i", "n" } },
            ["<c-z>j"] = { "layout_bottom", mode = { "i", "n" } },
            ["<c-z><c-j>"] = { "layout_bottom", mode = { "i", "n" } },
            ["<c-z>k"] = { "layout_top", mode = { "i", "n" } },
            ["<c-z><c-k>"] = { "layout_top", mode = { "i", "n" } },
            ["<c-z>l"] = { "layout_right", mode = { "i", "n" } },
            ["<c-z><c-l>"] = { "layout_right", mode = { "i", "n" } },
            ["?"] = "toggle_help_list",
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["i"] = "focus_input",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["q"] = "close",
            ["zb"] = "list_scroll_bottom",
            ["zt"] = "list_scroll_top",
            ["zz"] = "list_scroll_center",
          },
          wo = {
            conceallevel = 2,
            concealcursor = "nvc",
          },
        },
        -- preview window
        preview = {
          keys = {
            ["<Esc>"] = "close",
            ["q"] = "close",
            ["i"] = "focus_input",
            ["<ScrollWheelDown>"] = "list_scroll_wheel_down",
            ["<ScrollWheelUp>"] = "list_scroll_wheel_up",
            ["<a-w>"] = "cycle_win",
          },
          b = {
            winbar_enabled = false,
          },
        },
      },
      icons = {
        files = {
          enabled = true, -- show file icons
        },
        keymaps = {
          nowait = "󰓅 ",
        },
        tree = {
          vertical = "│ ",
          middle = "│ ",
          last = "└╴",
        },
        undo = {
          saved = icons.ui.Save,
        },
        ui = {
          live = "󰐰 ",
          hidden = "h",
          ignored = "i",
          follow = "f",
          selected = icons.ui.Circle .. " ",
          unselected = icons.ui.UnfilledCircle .. " ",
          -- selected = " ",
        },
        git = {
          enabled = true, -- show git icons
          commit = icons.git.Commit, -- used by git log
          staged = icons.git.FileStaged, -- staged changes. always overrides the type icons
          added = icons.git.FileUntracked,
          deleted = icons.git.FileDeleted,
          ignored = icons.git.FileIgnored,
          modified = icons.git.FileUnstaged,
          renamed = icons.git.FileRenamed,
          unmerged = icons.git.FileUnmerged,
          untracked = icons.git.FileUntracked,
        },
        diagnostics = {
          Error = icons.diagnostics.BoldError .. " ",
          Warn = icons.diagnostics.BoldWarning .. " ",
          Hint = icons.diagnostics.BoldHint .. " ",
          Info = icons.diagnostics.BoldHint .. " ",
        },
        kinds = {
          Array = icons.kind.Array .. " ",
          Boolean = icons.kind.Boolean .. " ",
          Class = icons.kind.Class .. " ",
          Color = icons.kind.Color .. " ",
          Control = icons.git.Branch .. " ",
          Collapsed = icons.ui.ChevronShortRight,
          Constant = icons.kind.Constant .. " ",
          Constructor = icons.kind.Constructor .. " ",
          Copilot = icons.misc.Copilot .. " ",
          Enum = icons.kind.Enum .. " ",
          EnumMember = icons.kind.EnumMember .. " ",
          Event = icons.kind.Event .. " ",
          Field = icons.kind.Field .. " ",
          File = icons.kind.File .. " ",
          Folder = icons.kind.Folder .. " ",
          Function = icons.kind.Function .. " ",
          Interface = icons.kind.Interface .. " ",
          Key = icons.kind.Key .. " ",
          Keyword = icons.kind.Keyword .. " ",
          Method = icons.kind.Method .. " ",
          Module = icons.kind.Module .. " ",
          Namespace = icons.kind.Namespace .. " ",
          Null = icons.kind.Null .. " ",
          Number = icons.kind.Number .. " ",
          Object = icons.kind.Object .. " ",
          Operator = icons.kind.Operator .. " ",
          Package = icons.kind.Package .. " ",
          Property = icons.kind.Property .. " ",
          Reference = icons.kind.Reference .. " ",
          Snippet = icons.kind.Snippet .. " ",
          String = icons.kind.String .. " ",
          Struct = icons.kind.Struct .. " ",
          Text = icons.kind.Text .. " ",
          TypeParameter = icons.kind.TypeParameter .. " ",
          Unit = icons.kind.Unit .. " ",
          Unknown = " ",
          Value = icons.kind.Value .. " ",
          Variable = icons.kind.Variable .. " ",
        },
      },
      db = {
        -- path to the sqlite3 library
        -- If not set, it will try to load the library by name.
        -- On Windows it will download the library from the internet.
        sqlite3_path = nil, ---@type string?
      },
      debug = {
        scores = false, -- show scores in the list
        leaks = false, -- show when pickers don't get garbage collected
        explorer = false, -- show explorer debug info
        files = false, -- show file debug info
        grep = false, -- show file debug info
        extmarks = false, -- show extmarks errors
      },
    },
  },
  keys = {
    { "z=", "<cmd>lua Snacks.picker.spelling()<cr>", desc = "Spell Suggestion" },

    -- Find --
    { "<leader>b", "<cmd>lua Snacks.picker.buffers()<cr>", desc = "Buffers" },
    { "<leader><leader>", "<cmd>lua Snacks.picker.smart()<cr>", desc = "Smart Open" },

    { "<leader>fp", "<cmd>lua Snacks.picker()<cr>", desc = "Command Palette" },
    { "<leader>ff", "<cmd>lua Snacks.picker.files()<cr>", desc = "Find files" },
    { "<leader>fS", "<cmd>lua Snacks.picker.colorschemes()<cr>", desc = "Colorscheme" },
    { "<leader>ft", "<cmd>lua Snacks.picker.grep()<cr>", desc = "Find Text" },
    { "<leader>fs", "<cmd>lua Snacks.picker.grep_word()<cr>", desc = "Find String" },
    { "<leader>fb", "<cmd>lua Snacks.picker.grep_buffers()<cr>", desc = "Find String (Buffer)" },
    { "<leader>fh", "<cmd>lua Snacks.picker.help()<cr>", desc = "Help" },
    { "<leader>fH", "<cmd>lua Snacks.picker.highlights()<cr>", desc = "Highlight" },
    { "<leader>fl", "<cmd>lua Snacks.picker.resume()<cr>", desc = "Last Search" },
    { "<leader>fm", "<cmd>lua Snacks.picker.marks()<cr>", desc = "Marks" },
    { "<leader>fM", "<cmd>lua Snacks.picker.man()<cr>", desc = "Man Pages" },
    { "<leader>fr", "<cmd>lua Snacks.picker.recent()<cr>", desc = "Recent File" },
    { "<leader>fR", "<cmd>lua Snacks.picker.registers()<cr>", desc = "Registers" },
    { "<leader>fk", "<cmd>lua Snacks.picker.keymaps()<cr>", desc = "Keymaps" },
    { "<leader>fC", "<cmd>lua Snacks.picker.commands()<cr>", desc = "Commands" },
    { "<leader>fc", "<cmd>lua Snacks.picker.command_history()<cr>", desc = "Command History" },
    { "<leader>fj", "<cmd>lua Snacks.picker.jumps()<cr>", desc = "Jump list" },
    { "<leader>fq", "<cmd>lua Snacks.picker.qflist()<cr>", desc = "Quick fix" },
    { "<leader>fu", "<cmd>lua Snacks.picker.undo()<cr>", desc = "Undo" },

    -- Find Visual --
    { "<leader>fs", "<cmd>lua Snacks.picker.grep_word()<cr>", desc = "Find String", mode = "v" },

    -- Git --
    { "<leader>go", "<cmd>lua Snacks.picker.git_status()<cr>", desc = "Open changed file" },
    { "<leader>gb", "<cmd>lua Snacks.picker.git_branches()<cr>", desc = "Checkout branch" },
    -- { "<leader>gB", "<cmd>lua Snacks.picker.git_branches()<cr>", desc = "Checkout branch" },
    { "<leader>gl", "<cmd>lua Snacks.picker.git_log_file()<cr>", desc = "Log (Buffer)" },
    { "<leader>gL", "<cmd>lua Snacks.picker.git_log()<cr>", desc = "Log" },

    -- LSP --
    { "<leader>ld", "<cmd>lua Snacks.picker.diagnostics_buffer()<cr>", desc = "Diagnostics" },
    { "<leader>lw", "<cmd>lua Snacks.picker.diagnostics()<cr>", desc = "Workspace Diagnostics" },
    { "<leader>ls", "<cmd>lua Snacks.picker.lsp_symbols()<cr>", desc = "Document Symbols" },
    { "<leader>lS", "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>", desc = "Workspace Symbols" },
  },
}

-- how to add new sources
-- ref: https://github.com/folke/snacks.nvim/discussions/498

-- cycle layout
-- ref: https://github.com/folke/snacks.nvim/discussions/458

-- switch mode
-- ref: https://github.com/folke/snacks.nvim/discussions/499
