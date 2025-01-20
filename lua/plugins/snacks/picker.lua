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
    if vim.o.columns >= 120 then
      return "ivy_fixed"
    else
      return "vertical_fixed"
    end
  end
end

return {
  "folke/snacks.nvim",
  opts = {
    ---@type snacks.picker.Config
    picker = {
      prompt = " ",
      hidden = true,
      exclude = {
        "node_modules",
        ".DS_store",
        ".git",
      },
      sources = {
        files = {
          layout = "dropdown_fixed",
        },
        recent = {
          layout = "dropdown_fixed",
          filter = { cwd = true },
        },
        buffers = {
          layout = "dropdown_fixed",
          win = {
            input = { keys = { ["<c-d>"] = { "bufdelete", mode = { "n", "i" } } } },
            list = { keys = { ["<c-d>"] = "bufdelete" } },
          },
        },
        smart = {
          layout = "dropdown_fixed",
          filter = { cwd = true },
        },
        commands = {
          layout = "dropdown_fixed",
        },
        command_history = {
          layout = "dropdown_fixed",
        },
        git_status = {
          layout = "dropdown_fixed",
        },
        git_branches = {
          layout = "dropdown_fixed",
        },
        spelling = {
          layout = "dropdown_fixed",
        },
      },
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
                title = " {title} {live}",
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
            title = "{title} {live}",
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
              title = "{title} {live}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
        select = {
          preview = false,
          layout = {
            backdrop = false,
            width = 80,
            height = 14,
            max_height = 14,
            box = "vertical",
            border = bpad.all,
            title = " Select ",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
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
      },
      sort = {
        -- default sort is by score, text length and index
        fields = { "score:desc", "#text", "idx" },
      },
      ui_select = true, -- replace `vim.ui.select` with the snacks picker
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
        },
        selected = {
          show_always = false, -- only show the selected column when there are multiple selections
          unselected = true, -- use the unselected icon for unselected items
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
      },
      win = {
        -- input window
        input = {
          keys = {
            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<Esc>"] = "close",
            ["<C-c>"] = { "close", mode = "i" },
            ["<CR>"] = { "confirm", mode = { "n", "i" } },
            ["-"] = { "close", mode = { "n" } },
            -- ["G"] = "list_bottom",
            -- ["gg"] = "list_top",
            -- ["j"] = "list_down",
            -- ["k"] = "list_up",
            -- ["/"] = "toggle_focus",
            -- ["q"] = "close",
            ["<C-_>"] = { "toggle_help", mode = { "n", "i" } },
            -- ["<m-d>"] = { "inspect", mode = { "n", "i" } },
            ["<M-a>"] = { "select_all", mode = { "n", "i" } },
            -- ["<m-m>"] = { "toggle_maximize", mode = { "i", "n" } },
            -- ["<m-p>"] = { "toggle_preview", mode = { "i", "n" } },
            -- ["<m-w>"] = { "cycle_win", mode = { "i", "n" } },
            ["<C-a>"] = { "<Home>", mode = { "i" }, expr = true },
            ["<C-e>"] = { "<End>", mode = { "i" }, expr = true },
            ["<C-w>"] = { "cycle_win", mode = { "n", "i" } },
            ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
            ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
            ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
            ["<Down>"] = { "list_down", mode = { "i", "n" } },
            ["<Up>"] = { "list_up", mode = { "i", "n" } },
            ["<C-j>"] = { "list_down", mode = { "i", "n" } },
            ["<C-k>"] = { "list_up", mode = { "i", "n" } },
            ["<C-n>"] = { "list_down", mode = { "i", "n" } },
            ["<C-p>"] = { "list_up", mode = { "i", "n" } },
            ["<C-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<C-d>"] = { "list_scroll_down", mode = { "i", "n" } },
            ["<C-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<C-g>"] = { "toggle_live", mode = { "i", "n" } },
            ["<C-u>"] = { "list_scroll_up", mode = { "i", "n" } },
            ["<ScrollWheelDown>"] = { "list_scroll_wheel_down", mode = { "i", "n" } },
            ["<ScrollWheelUp>"] = { "list_scroll_wheel_up", mode = { "i", "n" } },
            ["<C-v>"] = { "edit_vsplit", mode = { "i", "n" } },
            ["<C-s>"] = { "edit_split", mode = { "i", "n" } },
            ["<C-q>"] = { "qflist", mode = { "i", "n" } },
            -- ["<m-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            -- ["<m-h>"] = { "toggle_hidden", mode = { "i", "n" } },
          },
          b = {
            minipairs_disable = true,
          },
        },
        -- result list window
        list = {
          keys = {
            ["<CR>"] = "confirm",
            ["gg"] = "list_top",
            ["G"] = "list_bottom",
            ["i"] = "focus_input",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["q"] = "close",
            ["<Tab>"] = "select_and_next",
            ["<S-Tab>"] = "select_and_prev",
            ["<Down>"] = "list_down",
            ["<Up>"] = "list_up",
            ["<m-d>"] = "inspect",
            ["<C-d>"] = "list_scroll_down",
            ["<C-u>"] = "list_scroll_up",
            ["zt"] = "list_scroll_top",
            ["zb"] = "list_scroll_bottom",
            ["zz"] = "list_scroll_center",
            ["/"] = "toggle_focus",
            ["<ScrollWheelDown>"] = "list_scroll_wheel_down",
            ["<ScrollWheelUp>"] = "list_scroll_wheel_up",
            ["<C-a>"] = "select_all",
            ["<C-f>"] = "preview_scroll_down",
            ["<C-b>"] = "preview_scroll_up",
            ["<C-v>"] = "edit_vsplit",
            ["<C-s>"] = "edit_split",
            ["<C-j>"] = "list_down",
            ["<C-k>"] = "list_up",
            ["<C-n>"] = "list_down",
            ["<C-p>"] = "list_up",
            -- ["<m-w>"] = "cycle_win",
            ["<c-w>"] = "cycle_win",
            ["<Esc>"] = "close",
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
            -- ["<m-w>"] = "cycle_win",
            ["<C-w>"] = "cycle_win",
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
        indent = {
          vertical = "│ ",
          middle = "├╴",
          last = "└╴",
        },
        undo = {
          saved = " ",
        },
        ui = {
          live = "󰐰 ",
          hidden = "h",
          ignored = "i",
          follow = "f",
          selected = "● ",
          unselected = "○ ",
          -- selected = " ",
        },
        git = {
          commit = "󰜘 ",
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
      debug = {
        scores = false, -- show scores in the list
        leaks = false, -- show when pickers don't get garbage collected
      },
    },
  },
  keys = {
    { "z=", "<cmd>lua Snacks.picker.spelling()<cr>", desc = "Spell Suggestion" },

    -- Find --
    { "<leader>b", "<cmd>lua Snacks.picker.buffers()<cr>", desc = "Buffers" },
    { "<leader><leader>", "<cmd>lua Snacks.picker.smart()<cr>", desc = "Find files" },

    { "<leader>fS", "<cmd>lua Snacks.picker.colorschemes()<cr>", desc = "Colorscheme" },
    { "<leader>ft", "<cmd>lua Snacks.picker.grep()<cr>", desc = "Find Text" },
    { "<leader>fs", "<cmd>lua Snacks.picker.grep_word()<cr>", desc = "Find String" },
    { "<leader>fh", "<cmd>lua Snacks.picker.help()<cr>", desc = "Help" },
    { "<leader>fH", "<cmd>lua Snacks.picker.highlights()<cr>", desc = "Highlight" },
    { "<leader>fl", "<cmd>lua Snacks.picker.resume()<cr>", desc = "Last Search" },
    { "<leader>fm", "<cmd>lua Snacks.picker.marks()<cr>", desc = "Marks" },
    { "<leader>fM", "<cmd>lua Snacks.picker.man_pages()<cr>", desc = "Man Pages" },
    { "<leader>fr", "<cmd>lua Snacks.picker.recent()<cr>", desc = "Recent File" },
    { "<leader>fR", "<cmd>lua Snacks.picker.registers()<cr>", desc = "Registers" },
    { "<leader>fk", "<cmd>lua Snacks.picker.keymaps()<cr>", desc = "Keymaps" },
    { "<leader>fC", "<cmd>lua Snacks.picker.commands()<cr>", desc = "Commands" },
    { "<leader>fc", "<cmd>lua Snacks.picker.command_history()<cr>", desc = "Command History" },
    { "<leader>fj", "<cmd>lua Snacks.picker.jumps()<cr>", desc = "Jump list" },

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
