local icons = require "utils.icons"

local border = {
  rounded = { " ", " ", " ", " ", " ", " ", " ", " " },
  top = { "", " ", "", "", "", "", "", "" },
}

return {
  "folke/snacks.nvim",
  opts = {
    ---@type snacks.picker.Config
    picker = {
      prompt = " ",
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
        },
        smart = {
          layout = "dropdown_fixed",
          filter = { cwd = true },
        },
        colorschemes = {
          layout = "dropdown_preview",
        },
        grep = {
          layout = "ivy_fixed",
        },
        grep_word = {
          layout = "ivy_fixed",
        },
        help = {
          layout = "dropdown_preview",
        },
        highlights = {
          layout = "dropdown_preview",
        },
        marks = {
          layout = "dropdown_preview",
        },
        git_status = {
          layout = "dropdown_fixed",
        },
        jumps = {
          layout = "dropdown_preview",
        },
        lsp_definitions = {
          layout = "ivy_fixed",
        },
        lsp_implementations = {
          layout = "ivy_fixed",
        },
        lsp_references = {
          layout = "ivy_fixed",
        },
        lsp_symbols = {
          layout = "ivy_fixed",
        },
        diagnostics = {
          layout = "ivy_fixed",
        },
        diagnostics_buffer = {
          layout = "ivy_fixed",
        },
      },
      layout = {
        cycle = true,
        --- Use the default layout or vertical if the window is too narrow
        preset = function()
          return vim.o.columns >= 120 and "default" or "vertical"
        end,
      },
      layouts = {
        ivy_fixed = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 25,
            border = "none",
            {
              box = "horizontal",
              {
                box = "vertical",
                {
                  win = "input",
                  border = { "", " ", "", "", "", "─", "", "" },
                  title = " {source} {live} {flags}",
                  title_pos = "center",
                  height = 1,
                },
                {
                  win = "list",
                  border = "hpad",
                },
              },
              {
                win = "preview",
                title = "{preview}",
                title_pos = "center",
                width = 0.5,
                border = border.top,
              },
            },
          },
        },
        dropdown_fixed = {
          layout = {
            backdrop = false,
            -- row = 0.5,
            width = 0.4,
            min_width = 80,
            max_width = 80,
            height = 14,
            border = "none",
            box = "vertical",
            {
              box = "vertical",
              border = border.rounded,
              title = "{source} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
        dropdown_preview = {
          layout = {
            backdrop = false,
            -- row = 0.5,
            width = 0.4,
            min_width = 80,
            max_width = 80,
            height = 34,
            border = "none",
            box = "vertical",
            {
              box = "vertical",
              border = border.rounded,
              title = "{source} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", height = 10, border = "none" },
              {
                win = "preview",
                title = "{preview}",
                title_pos = "center",
                border = "top",
              },
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
            ["<c-c>"] = { "close", mode = "i" },
            ["<CR>"] = { "confirm", mode = { "n", "i" } },
            ["G"] = "list_bottom",
            ["gg"] = "list_top",
            ["j"] = "list_down",
            ["k"] = "list_up",
            ["/"] = "toggle_focus",
            ["q"] = "close",
            ["<c-_>"] = { "toggle_help", mode = { "n", "i" } },
            -- ["<m-d>"] = { "inspect", mode = { "n", "i" } },
            ["<c-a>"] = { "select_all", mode = { "n", "i" } },
            -- ["<m-m>"] = { "toggle_maximize", mode = { "i", "n" } },
            -- ["<m-p>"] = { "toggle_preview", mode = { "i", "n" } },
            -- ["<m-w>"] = { "cycle_win", mode = { "i", "n" } },
            ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
            ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
            ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
            ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
            ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
            ["<Down>"] = { "list_down", mode = { "i", "n" } },
            ["<Up>"] = { "list_up", mode = { "i", "n" } },
            ["<c-j>"] = { "list_down", mode = { "i", "n" } },
            ["<c-k>"] = { "list_up", mode = { "i", "n" } },
            ["<c-n>"] = { "list_down", mode = { "i", "n" } },
            ["<c-p>"] = { "list_up", mode = { "i", "n" } },
            ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
            ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
            ["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
            ["<ScrollWheelDown>"] = { "list_scroll_wheel_down", mode = { "i", "n" } },
            ["<ScrollWheelUp>"] = { "list_scroll_wheel_up", mode = { "i", "n" } },
            ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
            ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-q>"] = { "qflist", mode = { "i", "n" } },
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
            ["<a-d>"] = "inspect",
            ["<c-d>"] = "list_scroll_down",
            ["<c-u>"] = "list_scroll_up",
            ["zt"] = "list_scroll_top",
            ["zb"] = "list_scroll_bottom",
            ["zz"] = "list_scroll_center",
            ["/"] = "toggle_focus",
            ["<ScrollWheelDown>"] = "list_scroll_wheel_down",
            ["<ScrollWheelUp>"] = "list_scroll_wheel_up",
            ["<c-a>"] = "select_all",
            ["<c-f>"] = "preview_scroll_down",
            ["<c-b>"] = "preview_scroll_up",
            ["<c-v>"] = "edit_vsplit",
            ["<c-s>"] = "edit_split",
            ["<c-j>"] = "list_down",
            ["<c-k>"] = "list_up",
            ["<c-n>"] = "list_down",
            ["<c-p>"] = "list_up",
            -- ["<m-w>"] = "cycle_win",
            ["<Esc>"] = "close",
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
        ui = {
          live = "󰐰 ",
          hidden = "h",
          ignored = "i",
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
      },
    },
  },
  keys = {
    -- { "z=", "<cmd>lua Snacks.picker.spell_suggests()<cr>", desc = "Spell Suggestion" },

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
    { "<leader>fr", "<cmd>lua Snacks.picker.recent({ filter = { cwd = true } })<cr>", desc = "Recent File" },
    { "<leader>fR", "<cmd>lua Snacks.picker.registers()<cr>", desc = "Registers" },
    { "<leader>fk", "<cmd>lua Snacks.picker.keymaps()<cr>", desc = "Keymaps" },
    { "<leader>fC", "<cmd>lua Snacks.picker.commands()<cr>", desc = "Commands" },
    { "<leader>fc", "<cmd>lua Snacks.picker.command_history()<cr>", desc = "Command History" },
    -- { "<leader>fV", "<cmd>lua Snacks.picker.vim_options()<cr>", desc = "Vim Options" },
    { "<leader>fj", "<cmd>lua Snacks.picker.jumps()<cr>", desc = "Jump list" },

    -- Find Visual --
    { "<leader>fs", "<cmd>lua Snacks.picker.grep_word()<cr>", desc = "Find String", mode = "v" },

    -- Git --
    { "<leader>go", "<cmd>lua Snacks.picker.git_status()<cr>", desc = "Open changed file" },
    -- {
    --   "<leader>gb",
    --   "<cmd>lua Snacks.picker.git_branches show_remote_tracking_branches=false()<cr>",
    --   desc = "Checkout branch",
    -- },
    -- { "<leader>gB", "<cmd>lua Snacks.picker.git_branches()<cr>", desc = "Checkout branch" },
    { "<leader>gl", "<cmd>lua Snacks.picker.git_log_file()<cr>", desc = "Log (Buffer)" },
    { "<leader>gL", "<cmd>lua Snacks.picker.git_log()<cr>", desc = "Log" },

    -- LSP --
    { "<leader>ld", "<cmd>lua Snacks.picker.diagnostics_buffer()<cr>", desc = "Diagnostics" },
    { "<leader>lw", "<cmd>lua Snacks.picker.diagnostics()<cr>", desc = "Workspace Diagnostics" },
    { "<leader>ls", "<cmd>lua Snacks.picker.lsp_symbols()<cr>", desc = "Document Symbols" },
    -- { "<leader>lS", "<cmd>lua Snacks.picker.lsp_dynamic_workspace_symbols()<cr>", desc = "Workspace Symbols" },
  },
}
